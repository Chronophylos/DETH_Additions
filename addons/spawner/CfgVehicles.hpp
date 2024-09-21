
class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
            // ref: https://community.bohemia.net/wiki/Eden_Editor:_Configuring_Attributes:_Controls#List
            class Edit;
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};

		class ModuleDescription {
			class AnyAI;
		};
	};

	class DTA_Module: Module_F {
		category = "DTA";
	};

	class GVAR(SpawnEnemy): DTA_Module {
		scope = 2;							// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = CSTRING(SpawnEnemy_Module_DisplayName);
		//icon = "\TAG_addonName\data\icon_Nuke_ca.paa";	// Map icon. Delete this entry to use the default icon.

		function = QFUNC(SpawnEnemy);	    // Name of function triggered once conditions are met
		functionPriority = 1;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;				// 1 for module waiting until all synced triggers are activated
		isDisposable = 0;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
		is3DEN = 0;							// 1 to run init function in Eden Editor as well
		curatorCanAttach = 0;				// 1 to allow Zeus to attach the module to an entity

		// 3DEN Attributes Menu Options
		canSetArea = 0;						// Allows for setting the area values in the Attributes menu in 3DEN

		// Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
		class Attributes: AttributesBase {
			// Arguments shared by specific module type (have to be mentioned in order to be present):
			class GVAR(units): Units {
                property = QGVAR(units);
			};

            class GVAR(interval) {
                displayName = CSTRING(SpawnEnemy_WaveInterval_DisplayName);
                tooltip = CSTRING(SpawnEnemy_WaveInterval_Tooltip);
                property = QGVAR(interval);
                control = "EditShort";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(interval),_value,true)]);
                defaultValue = "30";

                typeName = "NUMBER";
            };

            class GVAR(size) {
                displayName = CSTRING(SpawnEnemy_WaveSize_DisplayName);
                tooltip = CSTRING(SpawnEnemy_WaveSize_Tooltip);
                property = QGVAR(size);
                control = "EditShort";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(size),_value,true)]);
                defaultValue = "10";

                typeName = "NUMBER";
            };

            class GVAR(side) {
                displayName = CSTRING(SpawnEnemy_Side_DisplayName);
                tooltip = CSTRING(SpawnEnemy_Side_Tooltip);
                property = QGVAR(side);
                control = "EditShort";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(side),_value,true)]);
                defaultValue = "opfor";

                validate = "side";
                typeName = "SIDE";
            };

            class GVAR(init) {
				displayName = CSTRING(SpawnEnemy_WaveInit_DisplayName);
				tooltip = CSTRING(SpawnEnemy_WaveInit_ToolTip);
				property = QGVAR(init);
				control = "EditCodeMulti5";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(init),_value,true)]);
                defaultValue = "''";

				validate = "none";
                typeName = "STRING";
			};

			class ModuleDescription: ModuleDescription {}; // Module description should be shown last
		};

		// Module description (must inherit from base class, otherwise pre-defined entities won't be available)
		class ModuleDescription: ModuleDescription {
			description = CSTRING(SpawnEnemy_Module_ShortDescription);
			sync[] = {"CAManBase"};

			class CAManBase {
				description[] = {};
				position = 0;	// position is taken into effect
				direction = 0;	// direction is taken into effect
				optional = 0;	// synced entity is optional
				duplicate = 0;	// multiple entities of this type can be synced
				synced[] = {"AnyAI"};	// pre-defined entities like "anybrain" can be used (see the table below)
			};
		};
	};
};
