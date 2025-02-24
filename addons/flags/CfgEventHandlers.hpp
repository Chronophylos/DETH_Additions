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
    class Car {
        class GVAR(vehicleFlags) {
            killed = QUOTE(_this call FUNC(handleVehicleKilled));
        };
    };
    class Tank {
        class GVAR(vehicleFlags) {
            killed = QUOTE(_this call FUNC(handleVehicleKilled));
        };
    };
    class Helicopter {
        class GVAR(vehicleFlags) {
            killed = QUOTE(_this call FUNC(handleVehicleKilled));
        };
    };
    class Plane {
        class GVAR(vehicleFlags) {
            killed = QUOTE(_this call FUNC(handleVehicleKilled));
        };
    };
    class Ship_F {
        class GVAR(vehicleFlags) {
            killed = QUOTE(_this call FUNC(handleVehicleKilled));
        };
    };
};
