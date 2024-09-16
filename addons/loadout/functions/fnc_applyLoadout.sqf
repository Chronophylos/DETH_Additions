params [
	["_mode", "", [""]],
	["_input", [], [[]]]
];

switch _mode do
{
	// default object init
	case "init":
	{
		_input params [
			["_logic", objNull, [objNull]], // Module logic
			["_isActivated", true, [true]], // true when the module was activated, false when it is deactivated
			["_isCuratorPlaced", false, [true]]// true if the module was placed by Zeus
		];
		// ... code here...
	};
	// When some attributes were changed (including position and rotation)
	case "attributesChanged3DEN": {
		_input params [
			["_logic", objNull, [objNull]]
		];
		// ... code here...
	};
	// When added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
		_input params [
			["_logic", objNull, [objNull]]
		];
		// ... code here...
	};
	// When removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN": {
		_input params [
			["_logic", objNull, [objNull]]
		];
		// ... code here...
	};
	// When connection to object changes (i.e., new one is added or existing one removed)
	case "connectionChanged3DEN": {
		_input params [
			["_logic", objNull, [objNull]]
		];
		// ... code here...
	};
	// When object is being dragged
	case "dragged3DEN": {
		_input params [
			["_logic", objNull, [objNull]]
		];
		// ...code here...
	};
};
true;