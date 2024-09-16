class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class Edit;					// Default edit box (i.e. text input field)
			class Combo;				// Default combo box (i.e. drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};

		class ModuleDescription {
			class AnyBrain;
		};
	};

	class DTA_Module: Module_F {
		category = "DTA";
	};

	class GVAR(createLoadout): DTA_Module {
		scope = 2;							// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = CSTRING(CreateLoadout_Module_DisplayName);
		//icon = "\TAG_addonName\data\icon_Nuke_ca.paa";	// Map icon. Delete this entry to use the default icon.

		function = QFUNC(createLoadout);	// Name of function triggered once conditions are met
		functionPriority = 1;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;				// 1 for module waiting until all synced triggers are activated
		isDisposable = 1;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
		is3DEN = 0;							// 1 to run init function in Eden Editor as well
		curatorCanAttach = 0;				// 1 to allow Zeus to attach the module to an entity

		// 3DEN Attributes Menu Options
		canSetArea = 0;						// Allows for setting the area values in the Attributes menu in 3DEN

		// Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
		class Attributes: AttributesBase {
			// Arguments shared by specific module type (have to be mentioned in order to be present):
			class Units: Units {
				defaultValue = "'0'";
			};

			class ModuleDescription: ModuleDescription {}; // Module description should be shown last
		};

		// Module description (must inherit from base class, otherwise pre-defined entities won't be available)
		class ModuleDescription: ModuleDescription {
			description = CSTRING(CreateLoadout_Module_ShortDescription);
			sync[] = { "CAManBase", QGVAR(applyLoadout) };

			class CAManBase {
				description[] = { };
				position = 0;	// position is taken into effect
				direction = 0;	// direction is taken into effect
				optional = 0;	// synced entity is optional
				duplicate = 0;	// multiple entities of this type can be synced
				synced[] = { "AnyAI" };	// pre-defined entities like "anybrain" can be used (see the table below)
			};

			class GVAR(applyLoadout) {
				description[] = { };
				position = 0;	// position is taken into effect
				direction = 0;	// direction is taken into effect
				optional = 0;	// synced entity is optional
				duplicate = 0;	// multiple entities of this type can be synced
				synced[] = { "Anything" };	// pre-defined entities like "anybrain" can be used (see the table below)
			};
		};
	};

	class GVAR(applyLoadout): DTA_Module {
		scope = 2;							// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = CSTRING(ApplyLoadout_Module_DisplayName);
		//icon = "\TAG_addonName\data\icon_Nuke_ca.paa";	// Map icon. Delete this entry to use the default icon.

		function = QFUNC(applyLoadout);	// Name of function triggered once conditions are met
		functionPriority = 10;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;				// 1 for module waiting until all synced triggers are activated
		isDisposable = 1;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
		is3DEN = 0;							// 1 to run init function in Eden Editor as well
		curatorCanAttach = 0;				// 1 to allow Zeus to attach the module to an entity

		// 3DEN Attributes Menu Options
		canSetArea = 0;						// Allows for setting the area values in the Attributes menu in 3DEN

		// Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
		class Attributes: AttributesBase {
			// Arguments shared by specific module type (have to be mentioned in order to be present):
			class Units: Units {
				defaultValue = "'0'";
			};

			class ModuleDescription: ModuleDescription {}; // Module description should be shown last
		};

		// Module description (must inherit from base class, otherwise pre-defined entities won't be available)
		class ModuleDescription: ModuleDescription {
			description = CSTRING(ApplyLoadout_Module_ShortDescription);
			sync[] = { "CAManBase", QGVAR(createLoadout) };

			class CAManBase {
				description[] = { };
				position = 0;	// position is taken into effect
				direction = 0;	// direction is taken into effect
				optional = 0;	// synced entity is optional
				duplicate = 1;	// multiple entities of this type can be synced
				synced[] = { "AnyPlayer" };	// pre-defined entities like "anybrain" can be used (see the table below)
			};

			class GVAR(createLoadout) {
				description[] = { };
				position = 0;	// position is taken into effect
				direction = 0;	// direction is taken into effect
				optional = 0;	// synced entity is optional
				duplicate = 0;	// multiple entities of this type can be synced
				synced[] = { "Anything" };	// pre-defined entities like "anybrain" can be used (see the table below)
			};
		};
	};
};