class CfgVehicles
{
	class Logic;
	class Module_F : Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e. text input field)
			class Combo;				// Default combo box (i.e. drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};

		// Description base classes (for more information see below):
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

	class dta_Module_CreateLoadout : Module_F
	{
		// Standard object definitions:
		scope = 2;										// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Create Module";				// Name displayed in the menu
		//icon = "\TAG_addonName\data\icon_Nuke_ca.paa";	// Map icon. Delete this entry to use the default icon.
		category = "dta_loadouts";

		function = "dta_fnc_moduleCreateLoadout";	// Name of function triggered once conditions are met
		functionPriority = 1;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 1;				// 1 for module waiting until all synced triggers are activated
		isDisposable = 1;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
		is3DEN = 1;							// 1 to run init function in Eden Editor as well
		curatorCanAttach = 0;				// 1 to allow Zeus to attach the module to an entity

		// 3DEN Attributes Menu Options
		canSetArea = 0;						// Allows for setting the area values in the Attributes menu in 3DEN

		// Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
		class Attributes : AttributesBase
		{
			// Arguments shared by specific module type (have to be mentioned in order to be present):
			class Units : Units
			{
				property = "dta_Module_CreateLoadout_Units";
			};

			class Name : Edit
			{
				displayName = "Name";
				tooltip = "Name of the loadout";
				property = "dta_Module_CreateLoadout_Name";
				// Default text for the input box:
				defaultValue = """"""; // Because this is an expression, one must have a string within a string to return a string
			};

			class ModuleDescription : ModuleDescription {}; // Module description should be shown last
		};

		// Module description (must inherit from base class, otherwise pre-defined entities won't be available)
		class ModuleDescription : ModuleDescription
		{
			description = "Short module description";	// Short description, will be formatted as structured text
			sync[] = { "LocationArea_F" };				// Array of synced entities (can contain base classes)

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 0;	// Position is taken into effect
				direction = 0;	// Direction is taken into effect
				optional = 0;	// Synced entity is optional
				duplicate = 1;	// Multiple entities of this type can be synced
				synced[] = { "AnyPerson" };	// Pre-defined entities like "AnyBrain" can be used (see the table below)
			};
		};
	};
};