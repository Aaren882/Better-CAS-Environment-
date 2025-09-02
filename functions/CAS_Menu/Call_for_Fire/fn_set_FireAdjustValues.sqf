/* 
  NAME : BCE_fnc_set_FireAdjustValues

  ["_key","_value"]
  
  Set "BCE_Fire_Adjust" Values
	[
		#NOTE - "CURRENT" should be pointed to the any hashMap value below
		"CURRENT" : [] <ARRAY>
		
		"POLAR" : [ <ARRAY>
			"Adjust", : "0,0"
			"Meter" 	: 1
		],
		"IMPACT" : [ <ARRAY>
			"MIL", : "0000"
			"DIST" 	: 0
		],
		"GUNLINE" : [ <ARRAY>
			"Adjust", : "0,0"
			"Meter" 	: 1
		]
	]
*/
params ["_key","_value"];

private _map = localNamespace getVariable ["BCE_Fire_Adjust",createHashMap];

if (_key != "CURRENT" && !("CURRENT" in _map)) then {
	//- Make sure "CURRENT" exist
	_map set ["CURRENT", _key];
};

_map set [_key, _value];

localNamespace setVariable ["BCE_Fire_Adjust", _map];