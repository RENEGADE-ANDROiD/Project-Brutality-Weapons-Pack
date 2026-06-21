// AchievementHandler.zs
// Core StaticEventHandler for Vortex's Universal Achievement System (VUAS)
//
// StaticEventHandler persists across map transitions for the entire game session.
// Data does NOT serialize with savegames (all fields treated as transient on save/load).
// Completion state is backed by nosave CVars. In-progress counters are mirrored
// to VUAS_PersistentTracker (EventHandler) for save/load serialization.
//
// Mirrors VUOS_ObjectiveHandler pattern: static API, CVar helpers, callbacks.
// Uses BoA dual-handler pattern for save/load of in-progress counters.

class VUAS_AchievementHandler : StaticEventHandler
{
    // ====================================================================
    // ACHIEVEMENT REGISTRY
    // Stored on the StaticEventHandler instance. Persists across map
    // transitions but NOT across save/load (StaticEventHandler limitation).
    // Completion state is backed by nosave CVars in the player's INI file.
    // In-progress counters are mirrored to VUAS_PersistentTracker.
    // ====================================================================
    Array<VUAS_AchievementData> achievements;

    // Cached CVar references for persistence (transient, re-cached on OnRegister)
    // 4 CVars x 15 achievements each = 60 capacity (BoA pattern)
    transient CVar recordCVar[4];   // Unlock timestamps (encoded)
    transient CVar mapsCVar[4];     // Unlock map names (plain pipe-delimited)

    // Cached CVar references for hot-path lookups (avoids CVar.FindCVar every tic)
    transient CVar cachedDebugCVar;
    transient CVar cachedCheatCVar;
    transient CVar cachedEncodeCVar;

    // SystemTime relay: received from RenderOverlay via SendNetworkEvent
    // Used for achievement unlock timestamps
    int currentTime;

    // Cached Setup reference: set by Setup.WorldLoaded so GetSetup() works with subclasses.
    // StaticEventHandler.Find() requires the exact registered class name, so if a modder
    // registers "MyAchievements" (extending VUAS_AchievementSetup), Find("VUAS_AchievementSetup")
    // would fail. Caching the reference avoids this problem entirely.
    VUAS_AchievementSetup cachedSetup;

    // Cheat detection state
    bool cheatsDetectedThisSession;

    // Per-event-hook cached values, refreshed once at the top of each event hook
    // (WorldThingDied, WorldThingDamaged, WorldTick) so that IncrementProgressByIndex
    // and UnlockByIndex can read them without repeated GetHandler()/Find() calls.
    // Transient: not meaningful across save/load, only within a single tic.
    private transient bool cachedDebugOn;
    private transient VUAS_AchievementSetup cachedSetupRef;

    // Secret tracking: previous secret count per player for change detection
    // GZDoom has no dedicated secret discovery event, so we poll player.secretcount
    // in WorldTick and detect increments (verified via ZDoom wiki + forums)
    int lastSecretCount[MAXPLAYERS];

    // Item tracking: previous item count per player for change detection
    // GZDoom has no dedicated item pickup event, so we poll player.itemcount
    // in WorldTick and detect increments (same pattern as secret tracking)
    int lastItemCount[MAXPLAYERS];

    // Pending damage pooled per tic (avoids scanning all achievements on every hitscan pellet).
    transient int pendingDamageDealt;
    transient int pendingDamageTaken;

    // Deferred CVar persistence: unlock no longer blocks on BuildCVarString + Base64 + SetString.
    transient int dirtyRecordCvarMask;
    transient int dirtyMapsCvarMask;

    // Indices of locked achievements still tracking each hook type (rebuilt on load; trimmed on unlock).
    transient Array<int> trackKillAnyIndices;
    transient Array<int> trackKillClassIndices;
    transient Array<int> trackDamageDealtIndices;
    transient Array<int> trackDamageTakenIndices;
    transient Array<int> trackSecretIndices;
    transient Array<int> trackItemIndices;
    transient Array<String> trackCustomEventIds;
    transient Array<int> trackCustomEventIndices;

    transient CVar cachedPbAchCVar;
    transient bool cachedSessionActive;

    // ====================================================================
    // HANDLER ORDERING
    // Order = 10 so VUAS runs after VUOS (default 0) without conflicts
    // ====================================================================
    override void OnRegister()
    {
        SetOrder(10);

        // Cache CVar references for persistence layer
        recordCVar[0] = CVar.FindCVar("vuas_record0");
        recordCVar[1] = CVar.FindCVar("vuas_record1");
        recordCVar[2] = CVar.FindCVar("vuas_record2");
        recordCVar[3] = CVar.FindCVar("vuas_record3");
        mapsCVar[0] = CVar.FindCVar("vuas_maps0");
        mapsCVar[1] = CVar.FindCVar("vuas_maps1");
        mapsCVar[2] = CVar.FindCVar("vuas_maps2");
        mapsCVar[3] = CVar.FindCVar("vuas_maps3");

        // Cache frequently-accessed CVars for hot-path performance
        cachedDebugCVar = CVar.FindCVar('vuas_debug');
        cachedCheatCVar = CVar.FindCVar('vuas_cheat_detection');
        cachedEncodeCVar = CVar.FindCVar('vuas_encode_data');
        cachedPbAchCVar = CVar.FindCVar('pb_achievements');

        // NOTE: DeserializeAll is NOT called here because achievements may not be
        // defined yet (Setup.DefineAchievements hasn't run). State restoration is
        // centralized in Setup.WorldLoaded to guarantee correct ordering.

        if (IsDebugEnabled())
            Console.Printf("VUAS: OnRegister complete, CVar refs cached");
    }

    // ====================================================================
    // CVAR HELPER METHODS (mirrors VUOS pattern exactly)
    // clearscope so they work from both play and UI contexts.
    // ====================================================================
    clearscope static int GetCVarInt(string cvarName, PlayerInfo p, int defaultVal = 0)
    {
        let cv = CVar.GetCVar(cvarName, p);
        return cv ? cv.GetInt() : defaultVal;
    }

    clearscope static bool GetCVarBool(string cvarName, PlayerInfo p, bool defaultVal = false)
    {
        let cv = CVar.GetCVar(cvarName, p);
        return cv ? cv.GetBool() : defaultVal;
    }

    clearscope static double GetCVarFloat(string cvarName, PlayerInfo p, double defaultVal = 0.0)
    {
        let cv = CVar.GetCVar(cvarName, p);
        return cv ? cv.GetFloat() : defaultVal;
    }

    // ====================================================================
    // UTILITY METHODS
    // ====================================================================

    // Check if debug output is enabled via the cached vuas_debug CVar
    static bool IsDebugEnabled()
    {
        let handler = GetHandler();
        if (handler && handler.cachedDebugCVar)
            return handler.cachedDebugCVar.GetBool();
        // Fallback if called before OnRegister
        CVar dbg = CVar.FindCVar('vuas_debug');
        return dbg && dbg.GetBool();
    }

    // Get the first valid player (multiplayer-safe alternative to consoleplayer)
    static PlayerInfo GetFirstPlayer()
    {
        for (int i = 0; i < MAXPLAYERS; i++)
        {
            if (playeringame[i] && players[i].mo)
                return players[i];
        }
        return null;
    }

    // Play a sound on ALL active players' pawns (multiplayer-safe)
    static void PlaySoundAllPlayers(Sound snd)
    {
        for (int i = 0; i < MAXPLAYERS; i++)
        {
            if (!playeringame[i] || !players[i].mo) continue;
            players[i].mo.A_StartSound(snd, CHAN_AUTO, CHANF_DEFAULT, 0.45, ATTN_NONE);
        }
    }

    // Refresh per-tic cached values. Called once at the top of each event hook
    // so IncrementProgressByIndex/UnlockByIndex can read
    // them without repeated GetHandler()+Find() calls during the same tic.
    private void RefreshTickCache()
    {
        cachedDebugOn = cachedDebugCVar && cachedDebugCVar.GetBool();
        cachedSetupRef = cachedSetup;
        cachedSessionActive = !netgame && (!cachedPbAchCVar || cachedPbAchCVar.GetBool());
    }

    clearscope static bool SessionActive()
    {
        if (netgame)
            return false;
        let cv = CVar.FindCVar('pb_achievements');
        return !cv || cv.GetBool();
    }

    void RebuildTrackingIndices()
    {
        trackKillAnyIndices.Clear();
        trackKillClassIndices.Clear();
        trackDamageDealtIndices.Clear();
        trackDamageTakenIndices.Clear();
        trackSecretIndices.Clear();
        trackItemIndices.Clear();
        trackCustomEventIds.Clear();
        trackCustomEventIndices.Clear();

        for (int i = 0; i < achievements.Size(); i++)
        {
            let ach = achievements[i];
            if (ach.isUnlocked)
                continue;

            switch (ach.trackingType)
            {
            case TRACK_KILLS:
                if (ach.targetClass == '')
                    trackKillAnyIndices.Push(i);
                else
                    trackKillClassIndices.Push(i);
                break;
            case TRACK_DAMAGE_DEALT:
                trackDamageDealtIndices.Push(i);
                break;
            case TRACK_DAMAGE_TAKEN:
                trackDamageTakenIndices.Push(i);
                break;
            case TRACK_SECRETS:
                trackSecretIndices.Push(i);
                break;
            case TRACK_ITEMS:
                trackItemIndices.Push(i);
                break;
            case TRACK_CUSTOM_EVENT:
                trackCustomEventIds.Push(ach.achievementID);
                trackCustomEventIndices.Push(i);
                break;
            }
        }
    }

    private void RemoveIndexFromArray(Array<int> arr, int idx)
    {
        for (int i = arr.Size() - 1; i >= 0; i--)
        {
            if (arr[i] == idx)
            {
                arr.Delete(i);
                return;
            }
        }
    }

    private void RemoveFromTrackingIndices(int achIndex)
    {
        RemoveIndexFromArray(trackKillAnyIndices, achIndex);
        RemoveIndexFromArray(trackKillClassIndices, achIndex);
        RemoveIndexFromArray(trackDamageDealtIndices, achIndex);
        RemoveIndexFromArray(trackDamageTakenIndices, achIndex);
        RemoveIndexFromArray(trackSecretIndices, achIndex);
        RemoveIndexFromArray(trackItemIndices, achIndex);
        for (int i = trackCustomEventIndices.Size() - 1; i >= 0; i--)
        {
            if (trackCustomEventIndices[i] == achIndex)
            {
                trackCustomEventIndices.Delete(i);
                trackCustomEventIds.Delete(i);
                break;
            }
        }
    }

    private void FlushPendingDamage()
    {
        if (pendingDamageDealt > 0 && trackDamageDealtIndices.Size() > 0)
        {
            int amt = pendingDamageDealt;
            pendingDamageDealt = 0;
            for (int i = 0; i < trackDamageDealtIndices.Size(); i++)
            {
                int idx = trackDamageDealtIndices[i];
                let ach = achievements[idx];
                if (ach.cheatProtected && ach.invalidated)
                    continue;
                if (!ach.IsValidForCurrentSkill())
                    continue;
                IncrementProgressByIndex(idx, amt);
            }
        }
        else
            pendingDamageDealt = 0;

        if (pendingDamageTaken > 0 && trackDamageTakenIndices.Size() > 0)
        {
            int amt = pendingDamageTaken;
            pendingDamageTaken = 0;
            for (int i = 0; i < trackDamageTakenIndices.Size(); i++)
            {
                int idx = trackDamageTakenIndices[i];
                let ach = achievements[idx];
                if (ach.cheatProtected && ach.invalidated)
                    continue;
                if (!ach.IsValidForCurrentSkill())
                    continue;
                IncrementProgressByIndex(idx, amt);
            }
        }
        else
            pendingDamageTaken = 0;
    }

    private int FindCustomEventIndex(String eventID)
    {
        for (int i = 0; i < trackCustomEventIds.Size(); i++)
        {
            if (trackCustomEventIds[i] ~== eventID)
                return trackCustomEventIndices[i];
        }
        return -1;
    }

    // ====================================================================
    // HANDLER LOOKUPS (centralized Find() calls)
    // GetHandler() is clearscope because VUAS_AchievementBrowseMenu (UI scope)
    // needs it. GetTracker/GetSetup are play-scope only and don't need it.
    // This matches VUOS where lookups are only clearscope when UI callers exist.
    // ====================================================================
    clearscope static VUAS_AchievementHandler GetHandler()
    {
        return VUAS_AchievementHandler(StaticEventHandler.Find("VUAS_AchievementHandler"));
    }

    static VUAS_PersistentTracker GetTracker()
    {
        return VUAS_PersistentTracker(EventHandler.Find("VUAS_PersistentTracker"));
    }

    static VUAS_AchievementSetup GetSetup()
    {
        let handler = GetHandler();
        if (handler && handler.cachedSetup)
            return handler.cachedSetup;
        // Fallback: direct Find (works only if the base class itself is registered)
        return VUAS_AchievementSetup(StaticEventHandler.Find("VUAS_AchievementSetup"));
    }

    // ====================================================================
    // STATIC API - CREATION
    // Called from VUAS_AchievementSetup.WorldLoaded() to define achievements.
    // ====================================================================

    // Internal helper: initialize shared fields on a new achievement (DRY)
    // Used by AddAchievement to create and populate a new VUAS_AchievementData
    private static VUAS_AchievementData InitAchievementFields(
        String id, String title, String desc, String category,
        int targetCount, int trackingType, name targetClass,
        String icon, bool isHidden, bool isCumulative,
        bool cheatProtected, int minSkill, int maxSkill)
    {
        let handler = GetHandler();
        if (!handler) return null;

        // Check for duplicate ID
        for (int i = 0; i < handler.achievements.Size(); i++)
        {
            if (handler.achievements[i].achievementID ~== id)
            {
                if (IsDebugEnabled())
                    Console.Printf("VUAS: Achievement '%s' already exists, skipping", id);
                return null;
            }
        }

        // Warn if exceeding persistence capacity (4 CVars x 15 each = 60 max)
        if (handler.achievements.Size() >= ACHIEVEMENTS_PER_CVAR * NUM_CVARS)
        {
            Console.Printf("\c[Red]VUAS WARNING: Achievement '%s' exceeds persistence capacity (%d max). "
                .. "Its completion state will NOT be saved to CVars.\c-",
                id, ACHIEVEMENTS_PER_CVAR * NUM_CVARS);
        }

        let ach = new("VUAS_AchievementData");
        ach.achievementID = id;
        ach.title = title;
        ach.description = desc;
        ach.category = category;
        ach.targetCount = targetCount;
        ach.currentCount = 0;
        ach.trackingType = trackingType;
        ach.targetClass = targetClass;
        ach.isHidden = isHidden;
        ach.isCumulative = isCumulative;
        ach.cheatProtected = cheatProtected;
        ach.icon = icon;
        ach.minSkillLevel = minSkill;
        ach.maxSkillLevel = maxSkill;
        ach.isUnlocked = false;
        ach.invalidated = false;
        ach.unlockTime = 0;
        ach.unlockMap = "";

        return ach;
    }

    // Add a standard achievement (threshold or binary based on targetCount)
    static void AddAchievement(
        String id,
        String title,
        String desc,
        String category,
        int targetCount,
        int trackingType = TRACK_MANUAL,
        name targetClass = '',
        String icon = "ACHVMT00",
        bool isHidden = false,
        bool isCumulative = true,
        bool cheatProtected = true,
        int minSkill = 0,
        int maxSkill = 4
    )
    {
        let ach = InitAchievementFields(id, title, desc, category, targetCount,
            trackingType, targetClass, icon, isHidden, isCumulative,
            cheatProtected, minSkill, maxSkill);
        if (!ach) return;

        ach.achievementType = (targetCount <= 1) ? ACH_TYPE_BINARY : ACH_TYPE_THRESHOLD;

        let handler = GetHandler();
        handler.achievements.Push(ach);

        if (IsDebugEnabled())
            Console.Printf("VUAS: Added achievement '%s' (%s) target=%d tracking=%d skill=%d-%d",
                id, title, targetCount, trackingType, minSkill, maxSkill);
    }

    // ====================================================================
    // STATIC API - PROGRESS
    // ====================================================================

    // Immediately unlock an achievement by ID (public API)
    static void Unlock(String id)
    {
        let handler = GetHandler();
        if (!handler) return;

        int idx = handler.FindIndexByID(id);
        if (idx < 0) return;

        handler.RefreshTickCache();
        handler.UnlockByIndex(idx);
    }

    // Internal: unlock by array index (avoids redundant FindByID when index is already known)
    // Used by IncrementProgressByIndex for auto-tracking and by Unlock() for public API
    private void UnlockByIndex(int achIndex)
    {
        if (achIndex < 0 || achIndex >= achievements.Size()) return;

        let ach = achievements[achIndex];
        if (ach.isUnlocked) return;

        // Check cheat protection
        if (ach.cheatProtected && ach.invalidated)
        {
            if (cachedDebugOn)
                Console.Printf("VUAS: Cannot unlock '%s' - invalidated by cheats", ach.achievementID);
            return;
        }

        ach.isUnlocked = true;
        ach.currentCount = ach.targetCount;
        ach.unlockTime = currentTime;
        ach.unlockMap = level.MapName;

        RemoveFromTrackingIndices(achIndex);

        MarkPersistenceDirty(achIndex);

        // Play unlock sound (uses GetCVarBool with player ref for multiplayer determinism)
        if (GetCVarBool('ach_sound_enabled', GetFirstPlayer(), true))
        {
            int sndChoice = GetCVarInt('ach_sound_choice', GetFirstPlayer(), 0);
            Sound snd;
            switch (sndChoice)
            {
            case 1:  snd = "vuas/unlock2"; break;
            case 2:  snd = "vuas/unlock3"; break;
            case 3:  snd = "vuas/unlock4"; break;
            default: snd = "vuas/unlock1"; break;
            }
            PlaySoundAllPlayers(snd);
        }

        // Queue toast notification via the renderer
        EventHandler.SendNetworkEvent("vuas_achievement_unlocked", achIndex);

        // Also print to console for players who disable toasts
        Console.Printf("\c[Green]Achievement Unlocked: %s\c- - %s", ach.title, ach.description);

        if (cachedDebugOn)
            Console.Printf("VUAS: Unlocked '%s' at time=%d map=%s", ach.achievementID, ach.unlockTime, ach.unlockMap);

        // Fire callback (uses per-tic cached setup reference)
        if (cachedSetupRef) cachedSetupRef.OnAchievementUnlocked(ach);
    }

    // Increment progress by amount (auto-checks for unlock)
    // Public API: called by modders and ACS bridge via string ID
    static void IncrementProgress(String id, int amount = 1)
    {
        let handler = GetHandler();
        if (!handler) return;

        int idx = handler.FindIndexByID(id);
        if (idx < 0) return;

        handler.RefreshTickCache();
        handler.IncrementProgressByIndex(idx, amount);
    }

    // Internal: increment progress by array index (avoids redundant FindByID)
    // Used by auto-tracking hooks that already have the index from their loop
    void IncrementProgressByIndex(int achIndex, int amount)
    {
        if (achIndex < 0 || achIndex >= achievements.Size()) return;

        let ach = achievements[achIndex];
        if (ach.isUnlocked) return;

        // Check cheat protection
        if (ach.cheatProtected && ach.invalidated) return;

        int oldCount = ach.currentCount;
        ach.currentCount += amount;

        // Clamp to targetCount to prevent over-counting before unlock
        if (ach.currentCount > ach.targetCount)
            ach.currentCount = ach.targetCount;

        if (cachedDebugOn)
            Console.Printf("VUAS: Progress '%s' %d -> %d / %d",
                ach.achievementID, oldCount, ach.currentCount, ach.targetCount);

        // Fire progress callback (uses per-tic cached setup reference)
        if (cachedSetupRef) cachedSetupRef.OnProgressUpdated(ach, oldCount, ach.currentCount);

        // Check for unlock (uses index directly to avoid redundant FindByID)
        if (ach.HasReachedTarget())
        {
            UnlockByIndex(achIndex);
        }
    }

    // Set progress to an exact value (useful for polling-based tracking)
    static void UpdateProgress(String id, int newValue)
    {
        let handler = GetHandler();
        if (!handler) return;

        int idx = handler.FindIndexByID(id);
        if (idx < 0) return;

        let ach = handler.achievements[idx];
        if (ach.isUnlocked) return;

        if (ach.cheatProtected && ach.invalidated) return;

        int oldCount = ach.currentCount;
        if (newValue == oldCount) return; // No change

        handler.RefreshTickCache();

        // Clamp to targetCount to prevent over-counting before unlock
        ach.currentCount = min(newValue, ach.targetCount);

        if (handler.cachedDebugOn)
            Console.Printf("VUAS: UpdateProgress '%s' %d -> %d / %d",
                id, oldCount, ach.currentCount, ach.targetCount);

        if (handler.cachedSetupRef) handler.cachedSetupRef.OnProgressUpdated(ach, oldCount, ach.currentCount);

        if (ach.HasReachedTarget())
        {
            handler.UnlockByIndex(idx);
        }
    }

    // ====================================================================
    // STATIC API - QUERIES
    // ====================================================================

    // Find achievement data by ID (returns null if not found)
    static VUAS_AchievementData FindByID(String id)
    {
        let handler = GetHandler();
        if (!handler) return null;

        for (int i = 0; i < handler.achievements.Size(); i++)
        {
            if (handler.achievements[i].achievementID ~== id)
                return handler.achievements[i];
        }
        return null;
    }

    // Find achievement index by ID (returns -1 if not found)
    // Private: array indices are unstable if achievement definitions change.
    // External callers should use FindByID() which returns the data object.
    private int FindIndexByID(String id)
    {
        for (int i = 0; i < achievements.Size(); i++)
        {
            if (achievements[i].achievementID ~== id)
                return i;
        }
        return -1;
    }

    static bool IsUnlocked(String id)
    {
        let ach = FindByID(id);
        return ach ? ach.isUnlocked : false;
    }

    static int GetProgress(String id)
    {
        let ach = FindByID(id);
        return ach ? ach.currentCount : 0;
    }

    static int GetTargetCount(String id)
    {
        let ach = FindByID(id);
        return ach ? ach.targetCount : 0;
    }

    static int GetUnlockedCount()
    {
        let handler = GetHandler();
        if (!handler) return 0;

        int count = 0;
        for (int i = 0; i < handler.achievements.Size(); i++)
        {
            if (handler.achievements[i].isUnlocked)
                count++;
        }
        return count;
    }

    static int GetTotalCount()
    {
        let handler = GetHandler();
        if (!handler) return 0;
        return handler.achievements.Size();
    }

    // ====================================================================
    // STATIC API - MANAGEMENT (debug)
    // ====================================================================

    static void ClearAchievement(String id)
    {
        let handler = GetHandler();
        if (!handler) return;

        int idx = handler.FindIndexByID(id);
        if (idx < 0) return;

        let ach = handler.achievements[idx];
        ach.isUnlocked = false;
        ach.currentCount = 0;
        ach.unlockTime = 0;
        ach.unlockMap = "";
        ach.invalidated = false;

        handler.MarkPersistenceDirty(idx);

        if (IsDebugEnabled())
            Console.Printf("VUAS: Cleared achievement '%s'", id);
    }

    // Use to reveal hidden achievements later (e.g. after a story event)
    // or re-hide them. Mirrors VUOS SetHidden pattern.
    static void SetHidden(String id, bool hidden)
    {
        let handler = GetHandler();
        if (!handler) return;

        let ach = handler.FindByID(id);
        if (!ach) return;

        ach.isHidden = hidden;

        if (IsDebugEnabled())
            Console.Printf("VUAS: SetHidden '%s' = %s", id, hidden ? "true" : "false");
    }

    static void ClearAll()
    {
        let handler = GetHandler();
        if (!handler) return;

        for (int i = 0; i < handler.achievements.Size(); i++)
        {
            handler.achievements[i].isUnlocked = false;
            handler.achievements[i].currentCount = 0;
            handler.achievements[i].unlockTime = 0;
            handler.achievements[i].unlockMap = "";
            handler.achievements[i].invalidated = false;
        }

        // Save all CVars
        handler.SerializeAll();

        Console.Printf("VUAS: All achievements cleared");
    }

    static void UnlockAll()
    {
        let handler = GetHandler();
        if (!handler) return;

        // Sound and toast notifications are intentionally skipped here to avoid
        // spamming dozens of overlapping sounds and minutes of queued toasts.
        // Callbacks still fire so modder hooks run for each unlock.
        let setup = GetSetup();
        int unlockCount = 0;

        for (int i = 0; i < handler.achievements.Size(); i++)
        {
            let ach = handler.achievements[i];
            if (!ach.isUnlocked)
            {
                ach.isUnlocked = true;
                ach.currentCount = ach.targetCount;
                ach.unlockTime = handler.currentTime;
                ach.unlockMap = level.MapName;
                unlockCount++;

                // Fire callback so modder hooks run for each unlock
                if (setup) setup.OnAchievementUnlocked(ach);
            }
        }

        // Save all CVars
        handler.SerializeAll();

        Console.Printf("\c[Green]VUAS: All achievements unlocked (%d newly unlocked)\c-", unlockCount);
    }

    // ====================================================================
    // PERSISTENCE - Encode/Decode/Serialize (BoA pattern: methods on handler)
    // Adapted from BoA Tracker.zs lines 877-981.
    // ZScript scope rules require these to live on the StaticEventHandler
    // (play scope) rather than a standalone utility class (data scope).
    // ====================================================================
    const ACHIEVEMENTS_PER_CVAR = 15;
    const NUM_CVARS = 4;
    const ROT_OFFSET = 7;

    void MarkPersistenceDirty(int achIndex)
    {
        int cvarIdx = achIndex / ACHIEVEMENTS_PER_CVAR;
        if (cvarIdx < 0 || cvarIdx >= NUM_CVARS)
            return;
        int bit = 1 << cvarIdx;
        dirtyRecordCvarMask |= bit;
        dirtyMapsCvarMask |= bit;
    }

    // Spread persistence work across tics (one write per WorldTick: record OR maps slot).
    void FlushOneDirtyPersistenceSlot()
    {
        for (int cvarIdx = 0; cvarIdx < NUM_CVARS; cvarIdx++)
        {
            int bit = 1 << cvarIdx;
            if (dirtyRecordCvarMask & bit)
            {
                SaveRecordCvarSlot(cvarIdx);
                dirtyRecordCvarMask &= ~bit;
                return;
            }
            if (dirtyMapsCvarMask & bit)
            {
                SaveMapsCvarSlot(cvarIdx);
                dirtyMapsCvarMask &= ~bit;
                return;
            }
        }
    }

    void FlushAllPendingPersistence()
    {
        for (int cvarIdx = 0; cvarIdx < NUM_CVARS; cvarIdx++)
        {
            int bit = 1 << cvarIdx;
            if (dirtyRecordCvarMask & bit)
            {
                SaveRecordCvarSlot(cvarIdx);
                dirtyRecordCvarMask &= ~bit;
            }
            if (dirtyMapsCvarMask & bit)
            {
                SaveMapsCvarSlot(cvarIdx);
                dirtyMapsCvarMask &= ~bit;
            }
        }
    }

    // Build the pipe-delimited map name string for a single CVar slot (DRY helper)
    // Map names are stored plain (no encoding) in separate CVars from timestamps
    private String BuildMapsCVarString(int cvarIdx)
    {
        int startIdx = cvarIdx * ACHIEVEMENTS_PER_CVAR;
        int endIdx = startIdx + ACHIEVEMENTS_PER_CVAR;

        String bits = "";
        for (int i = startIdx; i < endIdx; i++)
        {
            if (i > startIdx)
                bits.AppendFormat("|");

            if (i < achievements.Size() && achievements[i].isUnlocked)
                bits.AppendFormat("%s", achievements[i].unlockMap);
        }
        return bits;
    }

    // Build the pipe-delimited data string for a single CVar slot (DRY helper)
    private String BuildCVarString(int cvarIdx)
    {
        int startIdx = cvarIdx * ACHIEVEMENTS_PER_CVAR;
        int endIdx = startIdx + ACHIEVEMENTS_PER_CVAR;

        String bits = "";
        for (int i = startIdx; i < endIdx; i++)
        {
            if (i > startIdx)
                bits.AppendFormat("|");

            if (i < achievements.Size())
            {
                let ach = achievements[i];
                bits.AppendFormat("%d", ach.isUnlocked ? ach.unlockTime : 0);
            }
            else
                bits.AppendFormat("0");
        }
        return bits;
    }

    // Write all achievement completion state to CVars
    void SerializeAll()
    {
        bool doEncode = !cachedEncodeCVar || cachedEncodeCVar.GetBool();
        bool debugOn = cachedDebugCVar && cachedDebugCVar.GetBool();

        for (int cvarIdx = 0; cvarIdx < NUM_CVARS; cvarIdx++)
        {
            // Serialize unlock timestamps
            if (recordCVar[cvarIdx])
            {
                String bits = BuildCVarString(cvarIdx);
                if (doEncode)
                    bits = Encode(bits, ROT_OFFSET);
                recordCVar[cvarIdx].SetString(bits);
            }

            // Serialize map names (plain, no encoding needed)
            if (mapsCVar[cvarIdx])
            {
                mapsCVar[cvarIdx].SetString(BuildMapsCVarString(cvarIdx));
            }

            if (debugOn)
            {
                int startIdx = cvarIdx * ACHIEVEMENTS_PER_CVAR;
                Console.Printf("VUAS: Serialized CVar %d (%d-%d)", cvarIdx, startIdx, startIdx + ACHIEVEMENTS_PER_CVAR - 1);
            }
        }
    }

    // Immediate save (debug/clear-all); gameplay unlocks use MarkPersistenceDirty.
    void SaveSingleCVar(int achIndex)
    {
        int cvarIdx = achIndex / ACHIEVEMENTS_PER_CVAR;
        if (cvarIdx < 0 || cvarIdx >= NUM_CVARS)
            return;
        SaveRecordCvarSlot(cvarIdx);
        SaveMapsCvarSlot(cvarIdx);
    }

    private void SaveRecordCvarSlot(int cvarIdx)
    {
        if (cvarIdx < 0 || cvarIdx >= NUM_CVARS || !recordCVar[cvarIdx])
            return;

        bool doEncode = !cachedEncodeCVar || cachedEncodeCVar.GetBool();
        String bits = BuildCVarString(cvarIdx);
        if (doEncode)
            bits = Encode(bits, ROT_OFFSET);
        recordCVar[cvarIdx].SetString(bits);
    }

    private void SaveMapsCvarSlot(int cvarIdx)
    {
        if (cvarIdx < 0 || cvarIdx >= NUM_CVARS || !mapsCVar[cvarIdx])
            return;
        mapsCVar[cvarIdx].SetString(BuildMapsCVarString(cvarIdx));
    }

    // Read achievement completion state from CVars
    void DeserializeAll()
    {
        // Reuse a single array across iterations to avoid per-CVar allocation.
        // String.Split() appends to the array, so Clear() is required each iteration.
        Array<String> parse;
        bool debugOn = cachedDebugCVar && cachedDebugCVar.GetBool();

        for (int cvarIdx = 0; cvarIdx < NUM_CVARS; cvarIdx++)
        {
            // Restore unlock timestamps
            if (recordCVar[cvarIdx])
            {
                String value = recordCVar[cvarIdx].GetString();
                if (value.Length() > 0)
                {
                    // Auto-detect encoding: unencoded data always contains pipe delimiters,
                    // Base64 encoded data never does. This prevents corruption if vuas_encode_data
                    // is toggled between a serialize and deserialize call.
                    if (value.IndexOf("|") < 0)
                        value = Decode(value, ROT_OFFSET);

                    parse.Clear();
                    value.Split(parse, "|");

                    for (int a = 0; a < parse.Size(); a++)
                    {
                        int achIdx = cvarIdx * ACHIEVEMENTS_PER_CVAR + a;
                        if (achIdx >= achievements.Size()) break;

                        int storedValue = parse[a].ToInt();
                        if (storedValue > 0)
                        {
                            achievements[achIdx].isUnlocked = true;
                            achievements[achIdx].unlockTime = storedValue;
                            achievements[achIdx].currentCount = achievements[achIdx].targetCount;
                        }
                    }
                }
            }

            // Restore unlock map names (stored plain, no encoding)
            if (mapsCVar[cvarIdx])
            {
                String mapsValue = mapsCVar[cvarIdx].GetString();
                if (mapsValue.Length() > 0)
                {
                    parse.Clear();
                    mapsValue.Split(parse, "|");

                    for (int a = 0; a < parse.Size(); a++)
                    {
                        int achIdx = cvarIdx * ACHIEVEMENTS_PER_CVAR + a;
                        if (achIdx >= achievements.Size()) break;

                        if (parse[a].Length() > 0)
                            achievements[achIdx].unlockMap = parse[a];
                    }
                }
            }

            if (debugOn)
                Console.Printf("VUAS: Deserialized CVar %d", cvarIdx);
        }
    }

    // Base64 encode with ROT offset (BoA Tracker.zs lines 935-958)
    static String Encode(String s, int v = 0)
    {
        String base64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        String r = "";
        String p = "";
        int c = s.Length() % 3;

        if (c)
        {
            for (; c < 3; c++)
            {
                p.AppendFormat("=");
                s = s .. "\0";
            }
        }

        for (int i = 0; i < int(s.Length()); i += 3)
        {
            int m = (s.ByteAt(i) + v << 16) + (s.ByteAt(i + 1) + v << 8) + s.ByteAt(i + 2) + v;
            int n0 = (m >>> 18) & 63;
            int n1 = (m >>> 12) & 63;
            int n2 = (m >>> 6) & 63;
            int n3 = m & 63;
            r.AppendFormat("%c%c%c%c",
                base64chars.ByteAt(n0), base64chars.ByteAt(n1),
                base64chars.ByteAt(n2), base64chars.ByteAt(n3));
        }

        return r.Mid(0, r.Length() - p.Length()) .. p;
    }

    // Base64 decode with ROT offset (BoA Tracker.zs lines 961-981)
    static String Decode(String s, int v = 0)
    {
        String base64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

        String p = (s.ByteAt(s.Length() - 1) == 0x3D ? (s.ByteAt(s.Length() - 2) == 0x3D ? "AA" : "A") : "");
        String r = "";
        s = s.Mid(0, s.Length() - p.Length()) .. p;

		for (int c = 0; c < int(s.Length()); c += 4)
        {
            int c1 = base64chars.IndexOf(String.Format("%c", s.ByteAt(c))) << 18;
            int c2 = base64chars.IndexOf(String.Format("%c", s.ByteAt(c + 1))) << 12;
            int c3 = base64chars.IndexOf(String.Format("%c", s.ByteAt(c + 2))) << 6;
            int c4 = base64chars.IndexOf(String.Format("%c", s.ByteAt(c + 3)));

            int n = (c1 + c2 + c3 + c4);
            r = r .. String.Format("%c%c%c", ((n >>> 16) - v) & 127, ((n >>> 8) - v) & 127, (n - v) & 127);
        }

        return r.Mid(0, r.Length() - p.Length());
    }

    // ====================================================================
    // EVENT HOOKS
    // ====================================================================

    override void WorldLoaded(WorldEvent e)
    {
        if (IsDebugEnabled())
            Console.Printf("VUAS: WorldLoaded (isSaveGame=%s, isReopen=%s)",
                e.IsSaveGame ? "true" : "false",
                e.IsReopen ? "true" : "false");

        // NOTE: DeserializeAll and RestoreFromTracker are called from Setup.WorldLoaded
        // to guarantee they run AFTER DefineAchievements. Do not duplicate here.

        // Initialize secret and item tracking baselines for all active players
        for (int p = 0; p < MAXPLAYERS; p++)
        {
            if (playeringame[p])
            {
                lastSecretCount[p] = players[p].secretcount;
                lastItemCount[p] = players[p].itemcount;
            }
            else
            {
                lastSecretCount[p] = 0;
                lastItemCount[p] = 0;
            }
        }

        // Reset non-cumulative achievement progress on new map (not save loads)
        if (!e.IsSaveGame && !e.IsReopen)
        {
            for (int i = 0; i < achievements.Size(); i++)
            {
                if (!achievements[i].isCumulative && !achievements[i].isUnlocked)
                {
                    achievements[i].currentCount = 0;
                }
            }
        }
    }

    override void WorldUnloaded(WorldEvent e)
    {
        // Save in-progress counters to PersistentTracker before map transition
        SaveToTracker();

        FlushAllPendingPersistence();

        if (IsDebugEnabled())
            Console.Printf("VUAS: WorldUnloaded - saved state to tracker and CVars");
    }

    // ====================================================================
    // REPLACEMENT-AWARE CLASS MATCHING
    // Checks if an actor matches a target class name via three methods:
    // 1. Direct class name match (e.g. actor IS a DoomImp)
    // 2. Replacement chain (e.g. actor replaces DoomImp via 'replaces' keyword)
    // 3. Class inheritance (e.g. actor extends DoomImp)
    // This allows achievements targeting 'DoomImp' to work even when enemy
    // replacement mods swap DoomImp for a custom class. Follows the Stupid
    // Achievements pattern (ImpAchievements.zs line 71-75).
    // ====================================================================
    private bool MatchesTargetClass(Actor thing, Name targetClass, Name cachedClassName)
    {
        // Direct class name match (most common, cheapest check)
        if (cachedClassName == targetClass) return true;

        // Replacement chain: check if this actor's class replaces the target class.
        // GetReplacee returns the class that this actor replaced, or itself if no replacement.
        // e.g. CyberImp replaces DoomImp -> GetReplacee(CyberImp) returns DoomImp.
        class<Actor> thingClass = thing.GetClass();
        class<Actor> replaceeClass = Actor.GetReplacee(thingClass);
        if (replaceeClass && replaceeClass.GetClassName() == targetClass) return true;

        // Inheritance: check if this actor extends the target class.
        // e.g. SuperImp extends DoomImp -> (superImp is "DoomImp") returns true.
        if (thing is targetClass) return true;

        return false;
    }

    override void WorldThingDied(WorldEvent e)
    {
        if (!e.Thing) return;
        RefreshTickCache();
        if (!cachedSessionActive)
            return;
        if (trackKillAnyIndices.Size() == 0 && trackKillClassIndices.Size() == 0)
            return;

        // Only count player kills (not infighting or environmental deaths).
        // WorldThingDied fires for ALL deaths in the game. Without this check,
        // monster-vs-monster infighting kills would count toward player achievements.
        // Uses e.Thing.target (BoA pattern) - the dead actor's target field points to
        // whoever last attacked it. For player kills this is the player pawn.
        // NOTE: e.DamageSource.player does NOT work here (always null in WorldThingDied).
        if (!e.Thing.target || !e.Thing.target.player) return;

        // Cache class name and monster flag outside the loop (actor doesn't change across iterations)
        Name victimClass = e.Thing.GetClassName();
        bool isMonster = e.Thing.bIsMonster;

        if (isMonster && trackKillAnyIndices.Size() > 0)
        {
            for (int i = 0; i < trackKillAnyIndices.Size(); i++)
            {
                int idx = trackKillAnyIndices[i];
                let ach = achievements[idx];
                if (ach.cheatProtected && ach.invalidated)
                    continue;
                if (!ach.IsValidForCurrentSkill())
                    continue;
                IncrementProgressByIndex(idx, 1);
            }
        }

        for (int i = 0; i < trackKillClassIndices.Size(); i++)
        {
            int idx = trackKillClassIndices[i];
            let ach = achievements[idx];
            if (ach.cheatProtected && ach.invalidated)
                continue;
            if (!ach.IsValidForCurrentSkill())
                continue;
            if (MatchesTargetClass(e.Thing, ach.targetClass, victimClass))
                IncrementProgressByIndex(idx, 1);
        }
    }

    // Modders: override WorldThingDestroyed in your Setup subclass if you need
    // to track actor destruction (e.g. breakable props, barrels). This hook fires
    // when an actor is removed from the world, not just when it dies.
    override void WorldThingDestroyed(WorldEvent e)
    {
        if (!e.Thing) return;

        // Could add TRACK_DESTROYS here if needed in future
    }

    override void WorldThingDamaged(WorldEvent e)
    {
        if (!e.Thing || e.Damage <= 0) return;
        RefreshTickCache();
        if (!cachedSessionActive)
            return;
        if (trackDamageDealtIndices.Size() == 0 && trackDamageTakenIndices.Size() == 0)
            return;

        // NOTE: Self-damage (e.g. rocket splash) triggers BOTH damage dealt and damage taken,
        // since the player is both the attacker and the victim. This is intentional behavior.
        // Damage is accumulated per tic and applied in WorldTick (FlushPendingDamage).

        if (e.DamageSource && e.DamageSource.player)
            pendingDamageDealt += e.Damage;
        if (e.Thing.player)
            pendingDamageTaken += e.Damage;
    }

    override void WorldTick()
    {
        RefreshTickCache();

        if (dirtyRecordCvarMask || dirtyMapsCvarMask)
            FlushOneDirtyPersistenceSlot();

        if (cachedSessionActive)
            FlushPendingDamage();

        if (!cachedSessionActive)
            return;

        // Cheat detection (BoA pattern: Tracker.zs line 527-528)
        // Uses cached CVar reference to avoid FindCVar every tic
        if (cachedCheatCVar && cachedCheatCVar.GetBool())
        {
            CheckCheats();
        }

        // Secret and item tracking: poll player counters for changes
        // GZDoom has no EventHandler override for secret discovery or item pickup,
        // so we detect increments in the engine-managed counters
        // Combined into a single player loop for efficiency
        for (int p = 0; p < MAXPLAYERS; p++)
        {
            if (!playeringame[p]) continue;

            // Secret tracking
            int currentSecrets = players[p].secretcount;
            if (currentSecrets > lastSecretCount[p])
            {
                int newSecrets = currentSecrets - lastSecretCount[p];
                lastSecretCount[p] = currentSecrets;

                if (cachedDebugOn)
                    Console.Printf("VUAS: Player %d found %d secret(s) (total: %d)", p, newSecrets, currentSecrets);

                for (int i = 0; i < trackSecretIndices.Size(); i++)
                {
                    int idx = trackSecretIndices[i];
                    let ach = achievements[idx];
                    if (ach.cheatProtected && ach.invalidated)
                        continue;
                    if (!ach.IsValidForCurrentSkill())
                        continue;
                    IncrementProgressByIndex(idx, newSecrets);
                }
            }

            // Item tracking
            int currentItems = players[p].itemcount;
            if (currentItems > lastItemCount[p])
            {
                int newItems = currentItems - lastItemCount[p];
                lastItemCount[p] = currentItems;

                if (cachedDebugOn)
                    Console.Printf("VUAS: Player %d picked up %d item(s) (total: %d)", p, newItems, currentItems);

                // General item count only - for class-specific item tracking,
                // modders should use TRACK_MANUAL or TRACK_CUSTOM_EVENT
                // from their item's Pickup() override
                for (int i = 0; i < trackItemIndices.Size(); i++)
                {
                    int idx = trackItemIndices[i];
                    let ach = achievements[idx];
                    if (ach.cheatProtected && ach.invalidated)
                        continue;
                    if (!ach.IsValidForCurrentSkill())
                        continue;
                    IncrementProgressByIndex(idx, newItems);
                }
            }
        }
    }

    override void NetworkProcess(ConsoleEvent e)
    {
        // SystemTime relay from RenderOverlay (BoA pattern: Tracker.zs line 1040)
        // Use e.Player == 0 instead of consoleplayer to avoid multiplayer desync
        // (consoleplayer differs per client in play scope)
        if (!e.IsManual && e.Name == "vuas_time" && e.Player == 0)
        {
            currentTime = e.Args[0];
            return;
        }

        // Custom event tracking (TRACK_CUSTOM_EVENT)
        if (e.Name.Left(11) == "vuas_event:")
        {
            RefreshTickCache();
            if (!cachedSessionActive)
                return;
            String eventID = e.Name.Mid(11);
            int idx = FindCustomEventIndex(eventID);
            if (idx < 0)
                return;
            let ach = achievements[idx];
            if (ach.cheatProtected && ach.invalidated)
                return;
            if (!ach.IsValidForCurrentSkill())
                return;
            int amount = (e.Args[0] > 0) ? e.Args[0] : 1;
            IncrementProgressByIndex(idx, amount);
            return;
        }
    }

    // ====================================================================
    // CHEAT DETECTION (BoA pattern: Tracker.zs line 527-528)
    // ====================================================================
    void CheckCheats()
    {
        // Once cheats have been detected and all achievements invalidated,
        // skip the per-tic player loop entirely. The only edge case is if
        // achievements are added mid-session after detection, but that's not
        // a supported use case (DefineAchievements runs once on first WorldLoaded).
        if (cheatsDetectedThisSession) return;

        for (int p = 0; p < MAXPLAYERS; p++)
        {
            if (!playeringame[p]) continue;

            let cheats = players[p].cheats;
            if (cheats & (CF_NOCLIP | CF_NOCLIP2 | CF_GODMODE | CF_GODMODE2 | CF_BUDDHA | CF_BUDDHA2))
            {
                cheatsDetectedThisSession = true;
                if (IsDebugEnabled())
                    Console.Printf("VUAS: Cheats detected for player %d - invalidating protected achievements", p);

                // Fire callback
                let setup = GetSetup();
                if (setup) setup.OnCheatDetected(p);

                // Invalidate all cheat-protected in-progress achievements
                for (int i = 0; i < achievements.Size(); i++)
                {
                    if (achievements[i].cheatProtected && !achievements[i].isUnlocked)
                    {
                        achievements[i].invalidated = true;
                    }
                }

                // All protected achievements invalidated, no need to check more players
                return;
            }
        }
    }

    // ====================================================================
    // PERSISTENT TRACKER SYNC (BoA dual-handler pattern)
    // ====================================================================
    void SaveToTracker()
    {
        let tracker = GetTracker();
        if (!tracker) return;

        // Copy current counts to the persistent tracker for save serialization
        tracker.achievementCounts.Clear();
        tracker.achievementInvalidated.Clear();

        for (int i = 0; i < achievements.Size(); i++)
        {
            tracker.achievementCounts.Push(achievements[i].currentCount);
            tracker.achievementInvalidated.Push(achievements[i].invalidated ? 1 : 0);
        }

        if (IsDebugEnabled())
            Console.Printf("VUAS: Saved %d achievement counters to PersistentTracker", achievements.Size());
    }

    void RestoreFromTracker()
    {
        let tracker = GetTracker();
        if (!tracker) return;

        for (int i = 0; i < achievements.Size() && i < tracker.achievementCounts.Size(); i++)
        {
            achievements[i].currentCount = tracker.achievementCounts[i];
        }
        for (int i = 0; i < achievements.Size() && i < tracker.achievementInvalidated.Size(); i++)
        {
            achievements[i].invalidated = (tracker.achievementInvalidated[i] != 0);
        }

        if (IsDebugEnabled())
            Console.Printf("VUAS: Restored %d achievement counters from PersistentTracker",
                min(achievements.Size(), tracker.achievementCounts.Size()));
    }
}
