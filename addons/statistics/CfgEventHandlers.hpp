class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_Killed_EventHandlers {
    class CAManBase {
        class GVAR(killed) {
            killed = QUOTE(_this call FUNC(killed));
        };
    };
};

class Extended_Respawn_EventHandlers {
    class CAManBase {
        class GVAR(respawned) {
            respawn = QUOTE(_this call FUNC(respawned));
        };
    };
};
