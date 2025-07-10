params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

/* private _tag_Name = "ATAK_CFF_STD";
private _tag_class = [configFile >> "RscTitles" >> _tag_Name, configFile >> _tag_Name] select _isDialog;
private _sum_H = 0;
private _data = [];

private _checkedGroup = ["cTab_Android_dlg", "CFF_TaskList"] call cTab_fnc_getSettings; */

private _groupClass = ctrlClassName _group;
private _listGroup = _group controlsGroupCtrl 10;
private _Category = _group controlsGroupCtrl (17000 + 2102);

//- Check Category Selection
private _PgComponents = _settings param [3, createHashMap];
(_PgComponents getOrDefault [_groupClass, []]) params [["_cateSel",0]];

if (_Category getVariable ["LBChanged_EH",-1] < 0) then {
  _Category lbSetCurSel _cateSel; //- Set Current Category Selection

  //- Set Event Handler for Category Selection
  _Category setVariable ["LBChanged_EH", _Category ctrlAddEventHandler [
    "ToolBoxSelChanged", {
      params ["_ctrl","_lbCurSel"];
    
      //- Update Category Selection
      [nil,"Task_CFF_List",_lbCurSel,true] call BCE_fnc_ATAK_ChangeTool; 
    }]
  ];
};

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
private _grp = group _taskUnit;

//- get custom Groups
private _CFF_Missions = (
    [
      _grp getVariable ["BCE_CFF_Task_Pool",createHashMap],
      localNamespace getVariable ["#BCE_CFF_Task_RAT_Pool",createHashMap]
    ] # _cateSel
      
  /* createHashMapFromArray [
    ["AB0001",["Adjust Fire","11112222", player, 5]],
    ["AB0002",["Suppress","33334456", player,5,3]]
  ] */
) toArray false;
// reverse _CFF_Missions;

//- Create DropMenu 
  [
    ["ATAK_CFF_STD","ATAK_CFF_RAT"] # _cateSel,
    _listGroup,
    _isDialog,
    _CFF_Missions
  ] call BCE_fnc_Create_ATAK_Custom_DropMenu;
  
//- Clear List
/* {ctrlDelete _x} count allControls _listGroup;

//- Create Option Tags
{
  _x params [["_MSN_name",""],["_values",[]]];

  if (_MSN_name == "") then {continue};

  _values params ["_MSN_Type","_TG_Grid","_requester","_IE_rounds",["_IA_rounds",0]];

  private _IDC = 100 - _forEachIndex; //- IDC Prefix = 100
  private _ctrl = _display ctrlCreate [
    _tag_class,
    _IDC, 
    _listGroup
  ];
  _ctrl setVariable ["Index", _forEachIndex]; //- Set Ctrl Index
  _data pushBack _IDC; //- Push IDC into Data


  //- Expend Control Group
    private _expand = _ctrl getVariable ["Expand_Height", 1];
    private _tag = _ctrl controlsGroupCtrl 15;
    private _tagH = (ctrlPosition _tag) # 3;
    private _ctrlH = _tagH * ([1,_expand] select (_forEachIndex in _checkedGroup));
    _ctrl ctrlSetPositionH _ctrlH;

  //- Sorting Position
    _ctrl ctrlSetPositionY _sum_H;
    _ctrl ctrlCommit 0;
    _sum_H = _sum_H + _ctrlH;

  _tag ctrlSetStructuredText parseText format [
    "%1. %2<t align='right'>%3 </t>",
    _forEachIndex + 1,
    _MSN_name,
    _MSN_Type
  ];

  private _info_ls = _ctrl controlsGroupCtrl 50;
  
  //- Apply Infos
    {
      (_x splitString "|") params ["_L","_R",["_pic",""]];

      private _row = _info_ls lnbAddRow [_L,""];
      _info_ls lnbSetTextRight [[_row, 0], _R];

      if (_pic != "") then {
        _info_ls lnbSetPictureRight [[_row, 0], _pic];
      };
    } forEach [
      format ["TG : %1| i/e : %2", _TG_Grid, _IE_rounds],
      format ["From : %1(%2)| i/a : %3", groupId group _requester, name _requester, ["--", str _IA_rounds] select (_IA_rounds > 0)]
    ];
} forEach _CFF_Missions;

//- Save Data (Convinient to grab)
  _group setVariable ["data", _data]; */