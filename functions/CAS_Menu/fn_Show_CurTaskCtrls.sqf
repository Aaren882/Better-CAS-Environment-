params ["_display","_curLine","_curInterface",["_type_changed",false],["_skip",false],["_getTextR",false]];
private ["_is_Display","_Info_list","_curType","_IDCs_list","_TypeCtrls","_shownCtrls","_return"];

_is_Display	= displayNull isEqualType _display;
_Info_list = switch _curInterface do {
	//-AVT
	case 0: {missionNamespace getVariable "AVT_Task_TaskItems"};
	//-cTab
	case 1: {missionNamespace getVariable "cTab_Task_TaskItems"};
};

if (isNil {_Info_list}) exitWith {["Error variable not Exist"] call BIS_fnc_error};

_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;

_IDCs_list = _Info_list # 0;
_TypeCtrls = if (_is_Display) then {
	(_IDCs_list # _curType) apply {
		_x apply {_display displayctrl _x}
	}
} else {
	(_IDCs_list # _curType) apply {
		_x apply {_display controlsGroupCtrl _x}
	}
};

_shownCtrls = _TypeCtrls # _curLine;

if !(_skip) then {
	if (_type_changed) then {
		
		if (_is_Display) then {
			(flatten _IDCs_list) apply {
				(_display displayctrl _x) ctrlshow false;
			};
		} else {
			(flatten _IDCs_list) apply {
				(_display controlsGroupCtrl _x) ctrlshow false;
			};
		};

	} else {
		(flatten _TypeCtrls) apply {
			_x ctrlshow false;
		};
	};
	
	//-Show ctrls from selected task list
	_shownCtrls apply {
		_x ctrlshow true;
	};
};

_return = [
	_shownCtrls,
	[_shownCtrls,_Info_list # 1 # _curType]
] select _getTextR;

_return