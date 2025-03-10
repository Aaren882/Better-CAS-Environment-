#define CHECK_TASK(TASK) ((TASK select 0) != "NA")
private ["_drawT","_taskVar"];
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
};

_taskVar = (["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar;
_return = switch _curType do {
	//-5 line
	case 1: {
		_taskVar params ["_taskVar_0","_taskVar_1","_taskVar_2","_taskVar_3","_taskVar_4"];

		if !(CHECK_TASK(_taskVar_0) && CHECK_TASK(_taskVar_1) && CHECK_TASK(_taskVar_2)) exitwith {
			//-if isn't AV Terminal
			if (_NotAVT) then {
				//-cTab
				["Task_Builder",localize "STR_BCE_Error_Task5",5] call cTab_fnc_addNotification;
			} else {
				hint localize "STR_BCE_Error_Task5";
			};

			false
		};

		//-Processing
		(_taskVar_0 # 3) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range","_ATK_height"];

		_FAD_NA = (_taskVar_4 # 1) == -1;

		//-FAD/H
		_FRPOS = _taskVar_1 # 2;
		_TGPOS = _taskVar_2 # 2;

		_POS = if (_FAD_NA) then {
			_from = _vehicle;
			call _drawT
		} else {
			(_TGPOS getPos [
				3000,
				_taskVar_4 # 1
			])
		};
		_EGRS = round ((_taskVar_2 # 2) getDirVisual _POS);
		[_vehicle, [], _POS, _TGPOS, _EGRS, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],_taskVar,5] call BCE_fnc_Plane_CASEvent;

		true
	};
	//-9 line
	default {
		_taskVar params ["_taskVar_0",["_taskVar_1",["NA","",[]]],"","","","",["_taskVar_6",["NA","111222"]],"","_taskVar_8",["_taskVar_9",["NA",0,[],nil,nil]],"_taskVar_10"];

		if !(!(isnull _vehicle) && CHECK_TASK(_taskVar_0) && CHECK_TASK(_taskVar_6) && CHECK_TASK(_taskVar_8) && CHECK_TASK(_taskVar_9)) exitwith {
			//-if isn't AV Terminal
			if (_NotAVT) then {
				//-cTab
				["Task_Builder",localize "STR_BCE_Error_Task9",5] call cTab_fnc_addNotification;
			} else {
				hint localize "STR_BCE_Error_Task9";
			};

			false
		};

		//-Processing
		(_taskVar_0 # 3) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range","_ATK_height"];

		_IP_NA = "NA" in _taskVar_1;
		_FAD_NA = (_taskVar_10 # 1) == -1;

		//-FAD/H
		_from = [_taskVar_1 # 2,_vehicle] select _IP_NA;
		_TGPOS = _taskVar_6 # 2;
		_FRPOS = _taskVar_8 # 2;

		//-Dont have both
		_POS = if (_FAD_NA && _IP_NA) then {
			call _drawT;
		} else {
			//-have FAD
			if !(_FAD_NA) then {
				(_TGPOS getPos [
					[_from distance2D _TGPOS, 3000] select _IP_NA,
					_taskVar_10 # 1
				])
			} else {
				//-No FAD have IP
				if !(_IP_NA) then {
					call _drawT;
				};
			};
		};
		[_vehicle, _taskVar_1 # 2, _POS, _taskVar_6 # 2, _taskVar_9 # 1, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range,_ATK_height],_taskVar,9] call BCE_fnc_Plane_CASEvent;

		true
	};
};

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
