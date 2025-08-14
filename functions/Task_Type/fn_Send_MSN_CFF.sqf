/*
	NAME : BCE_fnc_Send_MSN_CFF

	Save Locally + Send the value over the Network

	Params : 
		[
			<STRING> "_type" : ex. Send, Record
			<OBJECT> "_taskUnit"
			<ARRAY> "_value"
		]
	
	Return : nil
*/
params ["_type","_taskUnit","_value"];

private _event = format ["BCE_%1_Mission",_type];

//- Save locally
	[
		_event,
		[
			"CFF",	//: _type
			_value,	//: _value
			true    //: _isLocal
		]
	] call CBA_fnc_LocalEvent;

	//- Send over
	if !(local _taskUnit) then {
		[
			_event,
			[
				"CFF",		//: _type
				_value,		//: _value
				false    	//: _isLocal
			], _taskUnit
		] call CBA_fnc_targetEvent;
	};

nil