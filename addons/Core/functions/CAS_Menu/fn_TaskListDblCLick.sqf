// #TODO - Implement the new framework

params ["_control", "_curLine"];

private _display = ctrlParent _control;
private _title = _display displayctrl 2003;
private _Task_Type = _display displayCtrl 2107;

private _curType = [0] call BCE_fnc_get_TaskCurType;
private _typeIndex = "AIR" call BCE_fnc_get_TaskCateIndex;
private _taskVar = (_typeIndex call BCE_fnc_getTaskVar) # 0;

private _TaskList = switch _curType do {
	//-5 line
	case 1: {
		_display displayCtrl 2005;
	};
	//-9 line
	default {
		_display displayCtrl 2002;
	};
};

private _Expression_class = "true" configClasses (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >> "items");

//-Description
private _desc_show = _display displayctrl 20042;
private _extend_desc = (_Expression_class apply {getNumber(_x >> "multi_options") == 1}) # _curLine;
_desc_show ctrlshow _extend_desc;

private _description = _display displayctrl ([2004,20041] select _extend_desc);

//-check current Control
private _shownCtrls = [_display,_curLine,0] call BCE_fnc_Show_CurTaskCtrls;

//- Fire OPENED EH
["BCE_TaskBuilding_Opened", [_curLine]] call CBA_fnc_localEvent;

//-Extended Description
if (_extend_desc) then {
	private _vehicle = [nil,"AIR" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

	//-Display info
	private _squad_title = _display displayctrl 20114;
	private _squad_pic = _display displayctrl 20115;
	private _squad_list = _display displayctrl 20116;
	_squad_list ctrlSetPositionH call compile (getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _squad_list >> "H"));
	_squad_list ctrlCommit 0;

	lbClear _squad_list;

	//-Check turrets
	private _turret_optics = [_vehicle,0] call BCE_fnc_Check_Optics;
	private _Selected_Optic = player getVariable ["TGP_View_Selected_Optic",[[],objNull]];
	private _current_optic = _turret_optics find (_Selected_Optic # 0);
	private _turrets = _turret_optics apply {((_x # 1) # 0) + 1};

	//- #FIXME - Add ACRE Compat
	// #if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
		private _Button_Racks = _display displayctrl 201141;
		private _List_Racks = _display displayctrl 201142;
		private _radio_Racks = _vehicle getVariable ["acre_sys_rack_vehicleRacks", []];
		_Button_Racks ctrlshow ({isplayer _x} count (crew _vehicle) > 0);
		_List_Racks ctrlshow true;
	// #endif

	{_x ctrlshow true} forEach [_squad_title,_squad_pic,_squad_list];

	//-get crew Info
	{
		private ["_unit_x","_seat","_turret_c","_turret_Index","_name","_freq","_radioInfo","_add","_turret_info","_unit_info","_title","_Racks_info","_i","_i_List"];
		_unit_x = _x;
		_turret_c = _vehicle unitTurret _unit_x;
		_turret_Index = _turret_optics findIf {_turret_c in _x};
		_seat = getText ([_vehicle, _turret_c] call BIS_fnc_turretConfig >> "gunnerName");
		_name = ((name _unit_x) splitString " ") # 0;
		_add = _squad_list lbAdd format ["%1 - %2",[_seat,localize "STR_DRIVER"] select (_seat == ""),_name];

		_turret_info = if (((_turret_Index > -1) && (count _turrets > 0))) then {
			_turret_optics # _turret_Index
		} else {
			nil
		};

		//-if it's a pilot -> "yellow Color"
		if (_seat == "") then {
			_squad_list lbSetSelectColor [_add,[1, 1, 0, 1]];
			_squad_list lbSetSelectColorRight [_add,[1, 1, 0, 1]];
		};

		//-get UNIT info
		_unit_info = [_unit_x,_turret_info] call BCE_fnc_getUnitParams;

		//- #FIXME - Add TFAR Compat
		/* #if __has_include("\z\tfar\addons\core\script_component.hpp")
			_freq = _unit_x call BCE_fnc_getFreq_TFAR;
			_squad_list lbSetTextRight [_add, "LR-" + ([_freq,"“NA”"] select (isnil {_freq}))];
		#else */
			_squad_list lbSetTextRight [_add, _unit_info # 1]; //- Default
		// #endif

		_squad_list lbSetData [_add, str _unit_info];

	} forEach flatten ((crew _vehicle) select {(_vehicle unitTurret _x) in ([[-1]] + allTurrets _vehicle)});

	//-set selected Turret Unit
	private _isEmpty = ((player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) or (_vehicle isNotEqualTo (_Selected_Optic # 1));
	if (_isEmpty or ((lbCurSel _squad_list) < 0)) then {
		if (lbsize _squad_list > 0) then {
			_squad_list lbSetCurSel ([0,_current_optic] select (count _turrets > 0));
		} else {
			_squad_title ctrlSetStructuredText parseText "NA";
		};
	} else {
		private _unit = (call compile (_squad_list lbData (lbCurSel _squad_list))) # 1;
		_squad_title ctrlSetStructuredText parseText format ["[%1]",_unit];
	};

	//-position Extended Description
	if ((ctrlText _desc_show) == "<") then {
		_description ctrlSetPositionH 0;
		_description ctrlCommit 0;
	};
} else {
	//- if it's not extended description
	// A simple duplication from #LINK - functions/CAS_Menu/Fire_Mission/Events/fn_TaskEvent_Opened.sqf
	private _TaskListPOS = ctrlPosition _TaskList;
	private _titlePOS = ctrlPosition _title;

	//- Layout
		private _posH = _TaskListPOS # 3;
		private _posY = (_TaskListPOS # 1) + (_titlePOS # 3);
		private _ctrlH = 0;

		{
			(ctrlPosition _x) params ["","_ctrlPOSY","","_ctrlPOSH"];
			//- Find the lowest Control
				if (_ctrlPOSY >= _posY) then {
					_posY = _ctrlPOSY;
					_ctrlH = _ctrlPOSH;
				};
			//- Get Control Height
				// if (!isnull _x && _ctrlH == 0) then {
				// };
		} forEach _shownCtrls;

		_posY = _posY + _ctrlH;

		_description ctrlSetPositionY _posY;
		_description ctrlSetPositionH (_posH - abs(_posY - (_TaskListPOS # 1)));
		_description ctrlCommit 0;
};

private _sendData = _display displayCtrl 2105;
private _clearbut = _display displayCtrl 2106;
private _checklist = _display displayCtrl 2100;
_TaskList ctrlshow false;

//-Write down description
private _desc = format ["%1<br/>%2", localize "STR_BCE_Description", (_TaskList lbData _curLine)];
_description ctrlSetStructuredText parseText _desc;
_sendData ctrlSetText localize "STR_BCE_Enter";
_title ctrlSetText (_control lbtext _curLine);

//-Show Needed Controls
{_x ctrlshow true} count [_title,_description];
_clearbut ctrlShow (0 < count _shownCtrls);
/* switch _curType do {
	//-9 line
	case 0: {
		if (_curLine in [2,3,4]) then {_clearbut ctrlShow false};
	};
}; */


/* private _fnc = ["BCE_fnc_DblClick9line","BCE_fnc_DblClick5line"] # _curType;
call (uiNamespace getVariable _fnc);
_description ctrlCommit 0;*/
