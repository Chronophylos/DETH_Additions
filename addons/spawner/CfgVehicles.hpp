
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

	class GVAR(waveSpawner): DTA_Module {
		scope = 2;							// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = CSTRING(WaveSpawner_Module_DisplayName);
		//icon = "\TAG_addonName\data\icon_Nuke_ca.paa";	// Map icon. Delete this entry to use the default icon.

		function = QFUNC(waveSpawner);	// Name of function triggered once conditions are met
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
                displayName = CSTRING(WaveSpawner_WaveInterval_DisplayName);
                tooltip = CSTRING(WaveSpawner_WaveInterval_Tooltip);
                property = QGVAR(interval);
                control = "Timeout";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(interval),_value,true)]);
                defaultValue = "[10,15,20]";

                typeName = "ARRAY";
            };

            class GVAR(size) {
                displayName = CSTRING(WaveSpawner_WaveSize_DisplayName);
                tooltip = CSTRING(WaveSpawner_WaveSize_Tooltip);
                property = QGVAR(size);
                control = "Timeout";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(size),_value,true)]);
                defaultValue = "[3,4,6]";

                typeName = "ARRAY";
            };

            //class WaveSizeModifier: Edit {
            //    property = QGVAR(WaveSpawner_SizeModifier);
            //    displayName = CSTRING(WaveSpawner_WaveSizeModifier_DisplayName);
            //    tooltip = CSTRING(WaveSpawner_WaveSizeModifier_Tooltip);
            //    defaultValue = """_size""";
            //};

            class GVAR(Init) {
				displayName = CSTRING(WaveSpawner_WaveInit_DisplayName);
				tooltip = CSTRING(WaveSpawner_WaveInit_ToolTip);
				property = QGVAR(Init);
				control = "EditCodeMulti5";

                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(Init),_value,true)]);
                defaultValue = "''";

				validate = "none";
                typeName = "STRING";
			};

			class ModuleDescription: ModuleDescription {}; // Module description should be shown last
		};

		// Module description (must inherit from base class, otherwise pre-defined entities won't be available)
		class ModuleDescription: ModuleDescription {
			description = CSTRING(WaveSpawner_Module_ShortDescription);
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
