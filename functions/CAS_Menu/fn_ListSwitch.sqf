params["_display",["_period",1],["_preload",false],["_vehicle",objNull]];

if ((lbcursel (_display displayCtrl 2102)) != 0) exitWith {};
/*private [
	"_BG_grp","_MainList","_list_Title","_Task_Type",
	"_list_result","_config","_Expression_class",
	"_Task_title","_desc_show","_squad_title","_squad_pic","_squad_list",
	"_Button_Racks","_List_Racks","_extend_desc","_Task_Description",
	"_clearbut","_Expression_TextR","_Expression_Ctrls",
	"_createTask","_lastPage","_sendData","_Task_Type_POS","_BG_grp_POS","_MainList_POS","_createTask_POS","_sendData_POS"
];*/
privateAll;
_BG_grp = _display displayCtrl 2000;

_MainList = _display displayCtrl 2100;
_list_Title = _display displayCtrl 2001;
_Task_Type = _display displayCtrl 2107;

_curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
_taskVar = (["9Line","5Line"] # _curType) call BCE_fnc_getTaskVar;

_TaskList = switch (_curType) do {
	//-5 line
	case 1: {
		_TaskList = _display displayCtrl 2005;
		_TaskList lbSetText [0, format ["1: “%1”/“%2” :", groupId group _vehicle, groupId group player]];

		_TaskList
	};
	//-9 line
	default {
		_display displayCtrl 2002;
	};
};

_config = configFile >> "RscDisplayAVTerminal" >> "controls";
_Expression_class = "true" configClasses (_config >> ctrlClassName _TaskList >>"items");
_Task_title = _display displayctrl 2003;
_desc_show = _display displayctrl 20042;
_squad_title = _display displayctrl 20114;
_squad_pic = _display displayctrl 20115;
_squad_list = _display displayctrl 20116;

#if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
	_Button_Racks = _display displayctrl 201141;
	_List_Racks = _display displayctrl 201142;
#else
	_Button_Racks = controlNull;
	_List_Racks = controlNull;
#endif

//-Description
_extend_desc = (_Expression_class apply {getNumber(_x >> "multi_options") == 1}) # (lbCurSel _TaskList);
_Task_Description = _display displayctrl ([2004,20041] select _extend_desc);

_clearbut = _display displayCtrl 2106;

//-Get Expression
_Expression_TextR = _Expression_class apply {
	getText (_x >> "textRight")
};

_Expression_Ctrls = (_Expression_class apply {
		getArray (_x >> "Expression_idc")
	}) apply {
	[
		_x apply {_display displayctrl _x},[]
	] select (_x isEqualTo []);
};

//-Task Status
{
	if ((_x # 0) != "NA") then {
		_TaskList lbSetTextRight [_forEachIndex, [(_x # 0),"Y"] select (_forEachIndex == 0)];
		_TaskList lbSetPictureRight [_forEachIndex,"\a3\ui_f\data\Map\Diary\Icons\diaryAssignTask_ca.paa"];
		_TaskList lbSetPictureRightColor [_forEachIndex, [0, 1, 0, 1]];
		_TaskList lbSetPictureRightColorSelected [_forEachIndex, [0, 1, 0, 1]];
	} else {
		_TaskList lbSetPictureRight [_forEachIndex,"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"];
		_TaskList lbSetPictureRightColor [_forEachIndex, [0, 0, 0, 0]];
		_TaskList lbSetPictureRightColorSelected [_forEachIndex, [0, 0, 0, 0]];
		_TaskList lbSetTextRight [_forEachIndex, _Expression_TextR # _forEachIndex];
	};
} forEach _taskVar;

//-from the Last page (Break)
if (ctrlShown _Task_title) exitWith {
	{_x ctrlShow false} forEach ([_Task_title,_Task_Description,_desc_show,_squad_title,_squad_pic,_squad_list,_Button_Racks,_List_Racks] + (flatten _Expression_Ctrls));
	(_display displayCtrl 2105) ctrlSetText localize "STR_BCE_SendData";
	_TaskList ctrlShow true;

	//-Back to check list
	[_display,1,true,_vehicle] call BCE_fnc_ListSwitch;
};

//-Switch Pages
if !(_preload) then {
	private _status = uiNameSpace getVariable ["BCE_CAS_ListSwtich", false];
	uiNameSpace setVariable ['BCE_CAS_ListSwtich', !_status];
};

_createTask = _display displayCtrl 2103;
_lastPage = _display displayCtrl 2104;
_sendData = _display displayCtrl 2105;

_Task_Type_POS = ctrlPosition _Task_Type;
_BG_grp_POS = ctrlPosition _BG_grp;
_MainList_POS = ctrlPosition _MainList;
_createTask_POS = ctrlPosition _createTask;
_sendData_POS = ctrlPosition _sendData;

_list_Title ctrlSetText ([localize "STR_BCE_TL_Check_List", format["%1 (%2)",localize "STR_BCE_TL_Create_Task", localize "STR_BCE_DoubleClick"]] select (uiNameSpace getVariable ["BCE_CAS_ListSwtich", false]));


_sendData ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select ((_vehicle getVariable ["BCE_Task_Receiver",""]) != ""));

if (uiNameSpace getVariable ["BCE_CAS_ListSwtich", false]) then {
	private _To_BottomH = 1 - (((_MainList_POS # 1) - safezoneY) / safezoneH);

	_BG_grp ctrlSetPositionH (_To_BottomH * SafeZoneH);

	_createTask ctrlSetPosition
	[
		_BG_grp_POS # 0,
		SafeZoneY + SafeZoneH,
		_createTask_POS # 2,
		_createTask_POS # 3
	];
	_Task_Type ctrlSetPosition
	[
		_BG_grp_POS # 0,
		SafeZoneY + SafeZoneH + (_createTask_POS # 3),
		_Task_Type_POS # 2,
		_Task_Type_POS # 3
	];
	_lastPage ctrlSetPosition
	[
		_BG_grp_POS # 0,
		SafeZoneY + SafeZoneH - (_createTask_POS # 3),
		_sendData_POS # 2,
		_sendData_POS # 3
	];
	_sendData ctrlSetPosition
	[
		_sendData_POS # 0,
		SafeZoneY + SafeZoneH - (_createTask_POS # 3),
		_sendData_POS # 2,
		_sendData_POS # 3
	];

	//- Squad List
	_squad_list ctrlSetPositionH 0;
	_squad_list ctrlCommit 0;

	//-hide MainList
	_MainList ctrlSetFade 1;
	_MainList ctrlEnable false;
	_TaskList ctrlSetFade 0;
	_TaskList ctrlShow true;

	_clearbut ctrlShow true;
	_lastPage ctrlEnable true;
	_sendData ctrlEnable true;

	_createTask ctrlSetFade 1;
	_Task_Type ctrlSetFade 1;

	_lastPage ctrlSetFade 0;
	_sendData ctrlSetFade 0;

	if !(isnull _vehicle) then {
		private _checklist = _display displayCtrl 2020;
		_checklist lbSetCurSel 0;
		[_display,_checklist,_vehicle,true] call BCE_fnc_checkList;
	};

} else {
	_BG_grp ctrlSetPositionH (call compile getText (_config >> ctrlClassName _BG_grp >> "H"));

	_createTask ctrlSetPosition
	[
		_BG_grp_POS # 0,
		(_MainList_POS # 1) + (_MainList_POS # 3),
		_createTask_POS # 2,
		_createTask_POS # 3
	];
	_Task_Type ctrlSetPosition
	[
		_BG_grp_POS # 0,
		(_MainList_POS # 1) + (_MainList_POS # 3) + (_createTask_POS # 3),
		_Task_Type_POS # 2,
		_Task_Type_POS # 3
	];
	_lastPage ctrlSetPosition
	[
		_BG_grp_POS # 0,
		(_MainList_POS # 1) + (_MainList_POS # 3) - (_createTask_POS # 3),
		_sendData_POS # 2,
		_sendData_POS # 3
	];
	_sendData ctrlSetPosition
	[
		_sendData_POS # 0,
		(_MainList_POS # 1) + (_MainList_POS # 3) - (_createTask_POS # 3),
		_sendData_POS # 2,
		_sendData_POS # 3
	];

	//-show MainList
	_MainList ctrlSetFade 0;
	_MainList ctrlEnable true;
	_TaskList ctrlSetFade 1;
	_TaskList ctrlShow false;

	_clearbut ctrlShow false;
	_lastPage ctrlEnable false;
	_sendData ctrlEnable false;

	_createTask ctrlSetFade 0;
	_Task_Type ctrlSetFade 0;

	_lastPage ctrlSetFade 1;
	_sendData ctrlSetFade 1;

	if !(isNull _vehicle) then {
		private _checklist = _display displayCtrl 2100;
		[_display,_checklist,_vehicle,false] call BCE_fnc_checkList;
	};
};

_MainList ctrlCommit (_period/2);
{_x ctrlCommit _period} foreach [_BG_grp,_createTask,_lastPage,_sendData,_TaskList,_Task_Type];
