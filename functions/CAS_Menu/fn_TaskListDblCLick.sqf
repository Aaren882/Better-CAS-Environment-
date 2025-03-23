params ["_control", "_curLine"];
// private ["_display","_title","_Task_Type","_curType","_list_result","_Expression_class","_desc_show","_extend_desc","_description","_sendData","_clearbut","_checklist","_desc","_descriptionPOS","_TaskListPOS","_titlePOS","_Expression_Ctrls","_shownCtrls"];
privateAll;

_display = ctrlParent _control;
_title = _display displayctrl 2003;
_Task_Type = _display displayCtrl 2107;
_curType = [] call BCE_fnc_get_TaskCurType;
_taskVar = ([] call BCE_fnc_getTaskVar) # 0;

_TaskList = switch _curType do {
	//-5 line
	case 1: {
		_display displayCtrl 2005;
	};
	//-9 line
	default {
		_display displayCtrl 2002;
	};
};

_Expression_class = "true" configClasses (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >> "items");

//-Description
_desc_show = _display displayctrl 20042;
_extend_desc = (_Expression_class apply {getNumber(_x >> "multi_options") == 1}) # _curLine;
_desc_show ctrlshow _extend_desc;

_description = _display displayctrl ([2004,20041] select _extend_desc);

//-Extended Description
if (_extend_desc) then {
	private ["_vehicle","_unit_info","_squad_title","_squad_pic","_squad_list","_Button_Racks","_text","_turret_optics","_current_optic","_turrets"];
	_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];

	//-Display info
	_squad_title = _display displayctrl 20114;
	_squad_pic = _display displayctrl 20115;
	_squad_list = _display displayctrl 20116;
	_squad_list ctrlSetPositionH call compile (getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _squad_list >> "H"));
	_squad_list ctrlCommit 0;

	lbClear _squad_list;

	//-Check turrets
	_turret_optics = [_vehicle,0] call BCE_fnc_Check_Optics;
	_Selected_Optic = player getVariable ["TGP_View_Selected_Optic",[[],objNull]];
	_current_optic = _turret_optics find (_Selected_Optic # 0);
	_turrets = _turret_optics apply {((_x # 1) # 0) + 1};

	#if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
		_Button_Racks = _display displayctrl 201141;
		_List_Racks = _display displayctrl 201142;
		_radio_Racks = _vehicle getVariable ["acre_sys_rack_vehicleRacks", []];
		_Button_Racks ctrlshow ({isplayer _x} count (crew _vehicle) > 0);
	#else
		_Button_Racks = controlNull;
		_List_Racks = controlNull;
	#endif

	{_x ctrlshow true} forEach [_squad_title,_squad_pic,_squad_list,_List_Racks];

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

		#if __has_include("\z\tfar\addons\core\script_component.hpp")
			_freq = _unit_x call BCE_fnc_getFreq_TFAR;
			_squad_list lbSetTextRight [_add, "LR-" + ([_freq,"“NA”"] select (isnil {_freq}))];
		#else
			_squad_list lbSetTextRight [_add, _unit_info # 1];
		#endif

		_squad_list lbSetData [_add, str _unit_info];

	} forEach flatten ((crew _vehicle) select {(_vehicle unitTurret _x) in ([[-1]] + allTurrets _vehicle)});

	//-set selected Turret Unit
	private _isEmpty = ((player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) or (_vehicle isNotEqualTo (_Selected_Optic # 1));
	if (_isEmpty or ((lbCurSel _squad_list) < 0)) then {
		if (lbsize _squad_list > 0) then {
			_squad_list lbSetCurSel ([0,_current_optic] select (count _turrets > 0));
		} else {
			(_display displayctrl 20114) ctrlSetStructuredText parseText "NA";
		};
	} else {
		private _unit = (call compile (_squad_list lbData (lbCurSel _squad_list))) # 1;
		(_display displayctrl 20114) ctrlSetStructuredText parseText format ["[%1]",_unit];
	};

	//-position Extended Description
	if ((ctrlText _desc_show) == "<") then {
		_description ctrlSetPositionH 0;
		_description ctrlCommit 0;
	};
};

_sendData = _display displayCtrl 2105;
_clearbut = _display displayCtrl 2106;
_checklist = _display displayCtrl 2100;
_TaskList ctrlshow false;

//-Write down description
_desc = format ["%1<br/>%2", localize "STR_BCE_Description", (_TaskList lbData _curLine)];
_description ctrlSetStructuredText parseText _desc;
_sendData ctrlSetText localize "STR_BCE_Enter";

_descriptionPOS = ctrlPosition _description;
_TaskListPOS = ctrlPosition _TaskList;
_titlePOS = ctrlPosition _title;

_title ctrlSetText (_control lbtext _curLine);

//-check current Control
_shownCtrls = [_display,_curLine,0] call BCE_fnc_Show_CurTaskCtrls;

//-Show Needed Controls
{_x ctrlshow true} count [_title,_description];

switch _curType do {
	//-9 line
	case 0: {
		if (_curLine in [2,3,4]) then {_clearbut ctrlShow false};
	};
};
private _fnc = ["BCE_fnc_DblClick9line","BCE_fnc_DblClick5line"] # _curType;
call uiNamespace getVariable _fnc;
_description ctrlCommit 0;
