/*
	NAME : BCE_fnc_Record_Task_Event
	
	Use for CBA "targetEvent" => "BCE_Record_Task_Event"
	which can save more Network loads in this way
	rather than send globally.
	
	Params : 
		[
			<STRING> "_type"
			<ARRAY> "_value"
			<BOOL> "_isLocal" : for checking it's triggered by localEvent
		]
	
	Return : nil
*/

params ["_type","_value","_isLocal"];

//- #NOTE - it will be saved on Local first so skip on LocalEvent
if (_isLocal) exitWith {};

switch (_type) do {
	/* case "AIR": { //- #TODO - Add this function
		
	}; */
	case "CFF": {
		_value call BCE_fnc_CFF_Mission_Set_RAT_Values;
	};
};

//- Return
nil