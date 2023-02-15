params["_display",["_skip",1],["_preload",false],["_vehicle",objNull]];

_BG_grp = _display displayCtrl 2000;

_MainList = _display displayCtrl 2100;
_list_Title = _display displayCtrl 2001;
_Task_Type = _display displayCtrl 2107;

_list_result = switch (_Task_Type lbValue (lbCurSel _Task_Type)) do {
  //-5 line
  case 1: {
    _TaskList = _display displayCtrl 2005;
    _vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
    _TaskList lbSetText [0, format ["1: “%1”/“%2” :", groupId group _vehicle, groupId group player]];

    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]]];
    [_TaskList,_taskVar]
  };
  //-9 line
  default {
    _TaskList = _display displayCtrl 2002;
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",[]]]];
    [_TaskList,_taskVar]
  };
};
_list_result params ["_TaskList","_taskVar"];

_Task_title = _display displayctrl 2003;
_Task_Description = _display displayctrl 2004;
_clearbut = _display displayCtrl 2106;

//-Get Expression
_Expression_class = "true" configClasses (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >>"items");

_Expression_TextR = _Expression_class apply {
  getText (_x >> "textRight")
};

_Expression_Ctrls = (_Expression_class apply {
    getArray (_x >> "Expression_idc")
  }) apply {
  if !(_x isEqualTo []) then {
    _x apply {
      _display displayctrl _x
    };
  } else {
    []
  };
};

//-Task Status
{
  if ((_x # 0) != "NA") then {
    _TaskList lbSetTextRight [_forEachIndex, (_x # 0)];
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
  {_x ctrlShow false} forEach ([_Task_title,_Task_Description] + (flatten _Expression_Ctrls));
  (_display displayCtrl 2105) ctrlSetText "Send Data";
  _TaskList ctrlShow true;

  //-Back to check list
  [_display,1,true] call BCE_fnc_ListSwitch;
};

//-Switch Pages
if !(_preload) then {
  if (uiNameSpace getVariable ["BCE_CAS_ListSwtich", false]) then {
    uiNameSpace setVariable ['BCE_CAS_ListSwtich', false];
  } else {
    uiNameSpace setVariable ['BCE_CAS_ListSwtich', true];
  };
};

_createTask = _display displayCtrl 2103;
_lastPage = _display displayCtrl 2104;
_sendData = _display displayCtrl 2105;

_Task_Type_POS = ctrlPosition _Task_Type;
_BG_grp_POS = ctrlPosition _BG_grp;
_MainList_POS = ctrlPosition _MainList;
_list_Title_POS = ctrlPosition _list_Title;
_createTask_POS = ctrlPosition _createTask;
_sendData_POS = ctrlPosition _sendData;

if (uiNameSpace getVariable ["BCE_CAS_ListSwtich", false]) then {
  _list_Title ctrlSetText "Create Task: (DoubleClick)";
  _To_BottomH = 1 - (((_MainList_POS # 1) - safezoneY) / safezoneH);

  _BG_grp ctrlSetPosition
  [
    _BG_grp_POS # 0,
    _BG_grp_POS # 1,
    _BG_grp_POS # 2,
    _To_BottomH * SafeZoneH
  ];
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

  if !(_vehicle isEqualTo objNull) then {
    _checklist = _display displayCtrl 2020;
    _checklist lbSetCurSel 0;
    [_display,_checklist,_vehicle,true] call BCE_fnc_checkList;
  };

} else {
  _list_Title ctrlSetText "Check List:";
  _BG_grp ctrlSetPosition
  [
    _BG_grp_POS # 0,
    _BG_grp_POS # 1,
    _BG_grp_POS # 2,
    _MainList_POS # 3
  ];
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

  if !(_vehicle isEqualTo objNull) then {
    _checklist = _display displayCtrl 2100;
    [_display,_checklist,_vehicle,false] call BCE_fnc_checkList;
  };
};

_MainList ctrlCommit (_skip/2);
{_x ctrlCommit _skip} foreach [_BG_grp,_createTask,_lastPage,_sendData,_TaskList,_Task_Type];