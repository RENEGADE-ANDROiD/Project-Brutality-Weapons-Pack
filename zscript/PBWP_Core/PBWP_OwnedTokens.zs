// Owned-token Inventory stubs for PBWP equipment and melee wheel filtering.
// A card only appears in the wheel if the player holds the corresponding token.
// PB-base equipment tokens (PB_GrenadeToken, etc.) are granted by PB itself;
// these cover PBWP-exclusive items whose pickups must call A_GiveInventory.

// ── Equipment owned tokens ──────────────────────────────────────────────────

// Slot 0 — Misc
class PBWP_HookToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }

// Slot 1 — Damage
class PBWP_VoidGrenadeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_FreezeGrenadeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }

// Slot 2 — Utility
class PBWP_PipeBombToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_CaltropsToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ElecPodToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ShieldGrenadeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }

// Slot 3 — Remote Charges
class PBWP_SwarmerToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_LaserChargeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_AcidChargeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }

// Slot 4 — Friendlies
class PBWP_BeaconToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_FreezeBotToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }

// Slot 5 — Throwables
class PBWP_AxeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ShurikenToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ShieldSawToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }

// ── Melee owned tokens ──────────────────────────────────────────────────────
// DefaultMeleeCard uses "" (always visible) — no token needed.

class PBWP_BladeMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_MacheteMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_MeleeAxeMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ImpactorMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_KatanaMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_PickAxeMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_SentinelHammerMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ClawMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_JohnnyHandsMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_CrowbarMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_WrenchMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_ChainsawMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_BatonMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
class PBWP_SledgeHammerMeleeToken : Inventory { default { inventory.maxamount 1; +INVENTORY.UNDROPPABLE } }
