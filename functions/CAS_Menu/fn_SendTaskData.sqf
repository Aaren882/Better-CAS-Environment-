#define CHECK_TASK(TASK) ((TASK select 0) != "NA")
/* private ["_drawT","_taskVar"];
_drawT = {
	private ["_HDG","_POSs","_dis"];
	_HDG = _FRPOS getDirVisual _TGPOS;
	_POSs = [-90,90] apply {
		_TGPOS getPos [
			3000,
			_HDG + _x
		]
	};
	_dis = _POSs apply {_from distance2D _x};

	(_POSs select ((_from distance (_POSs # 0)) > (_from distance (_POSs # 1))))
}; */

// _taskVar = ([] call BCE_fnc_getTaskVar) # 0;
/* _return = switch _curType do {
	//-5 line
	case 1: {
		
	};
	//-9 line
	default {
		
	};
}; */

private _return = ["BCE_TaskBuilding_SendData", []] call CBA_fnc_localEvent;
_return
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
