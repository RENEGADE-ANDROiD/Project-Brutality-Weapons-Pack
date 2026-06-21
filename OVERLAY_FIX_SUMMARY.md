# Ghost Weapon Fix Summary

## What Was Happening

After doing a melee attack, a second copy of your weapon would appear stuck at its idle frame. You'd see it during reload, firing, ADS — any action that moves the weapon on screen. One gun animates normally, the other just stands still. Switching weapons was the only way to make it go away.

## Why It Was Happening

When you press the melee button, PB Staging creates a hidden overlay layer (-998) to run the melee animation. The problem is that **this overlay was never cleaned up** after the melee ended. It kept running in the background, permanently drawing your weapon's idle sprite on top of the real one. During reload, your real weapon moves through its animation while the ghost layer stays frozen in place — hence the "two guns" effect.

## What Was Changed

Three files were modified:

### BaseWeapon_MeleeSystem.zs

- **Melee now runs on the main weapon layer.** Instead of letting the melee animation play on the hidden -998 layer (where it would get stuck), it's redirected to the main weapon display layer. The -998 layer is immediately destroyed after the redirect.
- **GoingToReady cleans up -998.** An override of the `GoingToReady` state now clears the -998 layer as part of its normal cleanup. This catches a few weapons (Demonic Exterminator, Beam Katana, Battle Axe and Shield, Argent Sith) that have their own custom melee and still use the old -998 path.

### BaseWeapon_Functions.zsc

- **Weapon select clears stale overlays.** When you switch to a weapon, `PB_WeaponRaise` now clears overlays -999 through -997 (previously only -999), catching any leftover melee layer from a previous weapon.
- **Leg overlay flags set immediately.** The first-person legs overlay now gets its positioning flags set right away instead of waiting one frame, preventing a brief visual pop on weapon select.

## Weapons With Custom Melee

Four weapons define their own melee behavior and don't use the base class redirect. They are still covered by the `GoingToReady` cleanup — the ghost layer is destroyed when the melee ends and the weapon returns to its ready state:

- Demonic Exterminator (ZScript)
- Beam Katana (DECORATE)
- Battle Axe and Shield (DECORATE)
- Argent Sith (DECORATE)

## Kicks

Kicks were not changed. They use a different overlay layer (-999) that is already properly destroyed at the end of the kick animation. The expanded cleanup ranges in `GoingToReady` and `PB_WeaponRaise` serve as an additional safety net.
