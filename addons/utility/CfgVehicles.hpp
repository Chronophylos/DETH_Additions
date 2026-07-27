
class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
            // ref: https://community.bohemia.net/wiki/Eden_Editor:_Configuring_Attributes:_Controls#List
            class Edit;
			class ModuleDescription;	// Module description
		};

		class ModuleDescription {
			class AnyStaticObject;
		};
	};

	class DTA_Module: Module_F {
		category = "DTA";
	};

	class GVAR(OnewayTeleporter): DTA_Module {
		scope = 2;							// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = CSTRING(OnewayTeleporter_Module_DisplayName);
		//icon = "\TAG_addonName\data\icon_Nuke_ca.paa";	// Map icon. Delete this entry to use the default icon.

		function = QFUNC(onewayTeleporter);	// Name of function triggered once conditions are met
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
			class ModuleDescription: ModuleDescription {}; // Module description should be shown last
		};

		// Module description (must inherit from base class, otherwise pre-defined entities won't be available)
		class ModuleDescription: ModuleDescription {
			description = CSTRING(OnewayTeleporter_Module_ShortDescription);
			sync[] = {"StaticObject"};

			class StaticObject {
				description[] = {
                    "Any Static Object"
                };
				position = 1;	// position is taken into effect
				direction = 1;	// direction is taken into effect
				optional = 0;	// synced entity is optional
				duplicate = 0;	// multiple entities of this type can be synced
				synced[] = {"AnyStaticObject"};	// pre-defined entities like "anybrain" can be used (see the table below)
			};
		};
	};
};
