#pragma hemtt flag pe23_ignore_has_include

params ["_control", "_selectedIndex",["_ismenu",false],["_IDC_offset",0],["_DisplayName",""]];
private ["_display","_Task_Type","_curInterface","_ListInfo","_curLine","_shownCtrls","_TypeChanged","_MenuChanged"];

_display = ctrlParent _control;
_Task_Type = uiNameSpace getVariable ["BCE_Current_TaskType",0];

_curInterface = switch _IDC_offset do {
  case 17000: {1};
  default {0};
};

//-get Which interface should be applied
if (_DisplayName == "cTab_Android_dlg") then {
  private _showMenu = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;

  _ListInfo = switch _Task_Type do {
    //-5 line
    case 1: {[controlNull,4]};
    //-9 line
    default {[controlNull,10]};
  };

  _curLine = _showMenu # 2;
} else {

  private _IDCs = [2002,2005] apply {_x + _IDC_offset};
  _ListInfo = switch _Task_Type do {
    //-5 line
    case 1: {[_display displayCtrl (_IDCs # 1),4]};
    //-9 line
    default {[_display displayCtrl (_IDCs # 0),10]};
  };
  _curLine = lbCurSel (_ListInfo # 0);
};

_ListInfo params ["_taskList","_remarks"];

//-Correcting _curline if it's greater than the Task has counted
_curLine = _remarks min _curLine;
_shownCtrls = [_display,_curLine,_curInterface,false,_ismenu] call BCE_fnc_Show_CurTaskCtrls;

_TypeChanged = {
  switch _curLine do {
    //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth), Marker(combo)]
    case 9:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];

      if (_selectedIndex == 0) then {
        _ctrl4 ctrlShow true;

        _ctrl2 ctrlShow false;
        _ctrl5 ctrlShow false;
      } else {
        //-Map Markers
        if (_selectedIndex == 2) then {
          _ctrl5 ctrlShow true;
          _ctrl5 call BCE_fnc_IPMarkers;

          _ctrl2 ctrlShow false;
          _ctrl4 ctrlShow false;
        } else {
          if (_selectedIndex == 3) then {
            _ctrl2 ctrlShow false;
            _ctrl4 ctrlShow false;
            _ctrl5 ctrlShow false;
          } else {
            _ctrl2 ctrlShow true;
            _ctrl4 ctrlShow false;
            _ctrl5 ctrlShow false;
          };
        };
      };
    };
    //-FAD/H [Toolbox, EditBox, output, Toolbox(Azimuth)]
    case _remarks:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

      if (_selectedIndex == 2) then {
        _ctrl4 ctrlShow false;
        _ctrl2 ctrlShow false;
      } else {
        //-FA D/H
        if (_selectedIndex == 0) then {
          _ctrl2 ctrlShow false;
          _ctrl4 ctrlShow true;
        } else {
          _ctrl2 ctrlShow true;
          _ctrl4 ctrlShow false;
        };
      };
    };
    default {
      if (_selectedIndex == 0) then {
        _shownCtrls params ["_toolBox","_combo"];
        _combo ctrlShow true;
        _combo call BCE_fnc_IPMarkers;
      } else {
        _shownCtrls params ["_toolBox","_combo","_textBox"];
        _combo ctrlShow false;
      };
    };
  };
};

_MenuChanged = {
  private [
    "_BG_grp","_clearbut","_Task_Type","_list_Title","_task_title","_desc",
    "_desc_ex","_desc_show","_squad_title","_squad_pic","_squad_list","_Button_Racks","_List_Racks",
    "_ctrlList","_MainList","_To_BottomH"
  ];
  _BG_grp = _display displayCtrl 2000;
  _clearbut = _display displayCtrl 2106;
  _Task_Type = _display displayCtrl 2107;
  _list_Title = _display displayCtrl 2001;
  _task_title = _display displayCtrl 2003;
  _desc = _display displayCtrl 2004;

  _desc_ex = _display displayctrl 20041;
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

  _ctrlList = [_taskList,_Task_Type,_task_title];
  _ListState = uiNameSpace getVariable ["BCE_CAS_ListSwtich", false];
  _ctrlList = switch _selectedIndex do {
    case 0: {
      _desc ctrlshow false;
      _ctrlList = if !(_ListState) then {
        [_display,0.2,true,player getVariable ["TGP_View_Selected_Vehicle",objNull]] call BCE_fnc_ListSwitch;

        _ctrlList + (
          ([2100,2103,2104,2105]) apply {
            _display displayCtrl _x
          }
        );
      } else {
        //-when inputting Info
        if (ctrlText (_display displayCtrl 2105) == localize "STR_BCE_Enter") then {
          [_taskList,_curLine] call BCE_fnc_TaskListDblCLick;
        };

        _ctrlList + (
          [2104,2105] apply {
            _display displayCtrl _x
          }
        );
      };

      _list_Title ctrlSetText ([localize "STR_BCE_TL_Check_List",format["%1 (%2)",localize "STR_BCE_TL_Create_Task", localize "STR_BCE_DoubleClick"]] select _ListState);
      _clearbut ctrlSetText getText (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _clearbut >> "text");

      {
        private ["_w","_condition"];
        _w = getText (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _x >> "w");
        _x ctrlSetPositionW (call compile _w);
        _condition = [!((ctrlIDC _x) in [2104,2105]),true] select _ListState;
        if (_condition) then {
          _x ctrlSetFade 0;
        };
      } forEach _ctrlList;

      _ctrlList
    };
    case 1: {
      _MainList = _display displayCtrl 2100;
      _MainList_POS = ctrlPosition _MainList;
      _To_BottomH = 1 - (((_MainList_POS # 1) - safezoneY) / safezoneH);

      _ctrlList = if !(_ListState) then {

        _BG_grp ctrlSetPositionH (_To_BottomH * SafeZoneH);

        _ctrlList + (
          [2100,2103,2104,2105] apply {
            _display displayCtrl _x
          }
        );
      } else {

        _ctrlList + (
          [2104,2105] apply {
            _display displayCtrl _x
          }
        );
      };

      if !(ctrlshown _desc) then {
        _desc ctrlshow true;
      };
      if !(ctrlshown _clearbut) then {
        _clearbut ctrlshow true;
      };

      //-List of Brevity Codes
      private _page = false;

      private _codelist = getArray (configFile >> "RscDisplayAVTerminal" >> "Brevity_Code");
      reverse _codelist;
      private _text_list = _codelist apply {
        if (_x isequalto "-") then {
          _page = true;
        };
        [nil,_x] select _page;
      } select {!((isnil {_x}) or (_x isEqualTo "-"))};

      reverse _text_list;
      private _text = _text_list apply {
        _x params [["_title",""],["_sub",""]];
        [
          format ["<t size='1.1' align='center' font='PuristaSemibold'>%1</t>",_title],
          format ["<t size='1.1' font='RobotoCondensedBold_BCE'>%1</t> : <t size='1.1' color='#FFD9D9D9'>%2</t>",_title,_sub]
        ] select (_x isEqualType []);
      };

      _desc ctrlSetStructuredText parseText (_text joinString "<br/>");

      private _list_Title_POS = ctrlPosition _list_Title;
      _desc ctrlSetPositionY ((_list_Title_POS # 1) + (_list_Title_POS # 3));
      _desc ctrlSetPositionH (_To_BottomH * SafeZoneH);
      _desc ctrlCommit 0;

      _list_Title ctrlSetText ((localize "STR_BCE_Brevity_Codes") + ":");
      _clearbut ctrlSetText ">";

      {
        _x ctrlSetPositionW 0;
        _x ctrlSetFade 1;
      } forEach _ctrlList;

      {_x ctrlShow false} forEach ([_desc_ex,_desc_show,_desc_show,_squad_title,_squad_pic,_squad_list,_Button_Racks,_List_Racks] + _shownCtrls);
      _ctrlList
    };
  };

  {_x ctrlCommit 0.2} forEach [_BG_grp] + _ctrlList;
};

call ([_TypeChanged,_MenuChanged] select _ismenu);