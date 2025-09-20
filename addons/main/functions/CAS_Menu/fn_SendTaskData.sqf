/*
	NAME : BCE_fnc_SendTaskData

	Send Data

	PARAMS :
		"_taskUnit" 		- Data will be sent to this Unit
		"_cate" 				- Task Category Index (0,1,2...)
		"_type"					- Task Type Index (0,1,2...)
		"_customInfos"	- Custom Infos which will be send for further data customization

	Return : BOOL
*/
params [
	"_taskUnit",
  ["_index", []],
  "_customInfos"
];

_index params [
	["_type", -1],
	["_cate",["Cate"] call BCE_fnc_get_TaskCurSetup]
];

if (_type < 0) then {
	_type = [_cate] call BCE_fnc_get_TaskCurType;
};

private _cateName = _cate call BCE_fnc_get_BCE_TaskCateClass;

if (isNil{_taskUnit}) then {
	_taskUnit = [nil, [_type,_cate]] call BCE_fnc_get_TaskCurUnit;
};


["BCE_TaskBuilding_SendData", [
	_taskUnit,		//- Data will be sent to this Unit
	_cateName,		//- Task Cate Name ("AIR", "ADJ"...)
	_type,				//- Index of the "Task Type"
	_customInfos	//- custom Infos
]] call CBA_fnc_localEvent;

//- Return
	true

//-H-60
/*[
	"TESTMESSAGE",//TITLE
	"IMAGINARYJTAC",//SENDER
	"ALL",//RECIPIENTS
	1,//MSGTYPE
	[
		"TYPE2,USEROCKETS",
		"500MNORTHOFAGIAMARINA",
		"AGIAMARINA-123123/12m",
		"2xBTR-80APARKEDONROAD",//description
		"",
		"ATTACKWESTTOEAST",//restrictions
		"",
		"",
		"",
		""
	],//MSGTEXT
	[],//MSGDATA
	[
		[
			"12:00",
			"System",
			"SENT"
		]
	]//REPLIES
] */
