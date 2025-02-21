#define MACRO_FLAG_ACTIONS \
    class ACE_Actions { \
        class ACE_MainActions { \
            class GVAR(FlagMenu) { \
                displayName = CSTRING(DisplayName); \
                class GVAR(AddFlag) { \
                    displayName = CSTRING(AddFlag); \
                    condition = QUOTE(!(_this call FUNC(hasFlag))); \
                    statement = QUOTE(_this call FUNC(applyFlag)); \
                }; \
                class GVAR(ResetFlag) { \
                    displayName = CSTRING(ResetFlag); \
                    condition = QUOTE(_this call FUNC(hasFlag)); \
                    statement = QUOTE(_this call FUNC(resetFlag)); \
                }; \
                class GVAR(ApplyTexture) { \
                    displayName = CSTRING(ApplyTexture); \
                    condition = QUOTE(!(_this call FUNC(hasTexture))); \
                    statement = QUOTE(_this call FUNC(applyTexture)); \
                }; \
                class GVAR(ResetTexture) { \
                    displayName = CSTRING(ResetTexture); \
                    condition = QUOTE(_this call FUNC(hasTexture)); \
                    statement = QUOTE(_this call FUNC(resetTexture)); \
                }; \
            }; \
        }; \
    };

class CBA_Extended_EventHandlers;

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
        MACRO_FLAG_ACTIONS
    };

    class Tank: LandVehicle {
        MACRO_FLAG_ACTIONS
    };

    class Air;
    class Helicopter: Air {
        MACRO_FLAG_ACTIONS
    };

    class Plane: Air {
        MACRO_FLAG_ACTIONS
    };

    class Ship;
    class Ship_F: Ship {
        MACRO_FLAG_ACTIONS
    };
};
