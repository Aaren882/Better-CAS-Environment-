/*
	NAME : BCE_fnc_Send_MSN_CFF

	Save Locally + Send the value over the Network

	Params : 
		[
			<OBJECT> "_taskUnit"
			<ARRAY> "_value"
		]
	
	Return : nil
*/
params ["_taskUnit", "_value"];

//- Save locally
	[
		"BCE_Send_Mission",
		[
			"CFF",	//: _type
			_value,	//: _value
			true    //: _isLocal
		]
	] call CBA_fnc_LocalEvent;

	//- Send over
	if !(local _taskUnit) then {
		[
			"BCE_Send_Mission",
			[
				"CFF",		//: _type
				_value,		//: _value
				false    	//: _isLocal
			], _taskUnit
		] call CBA_fnc_targetEvent;
	};

nil