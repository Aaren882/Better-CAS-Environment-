/* 
  NAME : BCE_fnc_get_FireAdjustValues

  ["_key","_default","_replace"]
  
  Get "BCE_Fire_Adjust" Values
	[
		#NOTE - "CURRENT" should be pointed to the any hashMap value below
		"CURRENT" : [] <ARRAY>

		"POLAR" : [ <ARRAY>
			"Adjust", : "0,0"
			"Meter" 	: 1
		],
		"IMPACT" : [ <ARRAY>
			"Adjust", : "MIL,DIST"
			"HEIGHT" 	: 0
		],
		"GUNLINE" : [ <ARRAY>
			"Adjust", : "0,0"
			"Meter" 	: 1
		]
	]
*/
params [["_key",""],["_default",[]],["_replace",false]];

private _map = localNamespace getVariable ["BCE_Fire_Adjust",createHashMap];

//- if _key is "" replace _key with "CURRENT" key
if (_key == "") then {
	_key = _map get "CURRENT";
};
_map getOrDefault [_key, _default, _replace];
