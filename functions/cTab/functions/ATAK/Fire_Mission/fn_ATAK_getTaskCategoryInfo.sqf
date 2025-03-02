/* 
  "_group" : Menu Group => "(call BCE_fnc_ATAK_getCurrentAPP) # 1"
  "_Setting" : ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings

  Return :
    "_taskMenu" : Task ControlGroup class ("AIR_9_LINE","AIR_5_LINE" etc)
    "_subSel" : Type Index
*/

params ["_group","_settings"];

_settings params ["","","_subInfos"];
_subInfos params ["", "", ["_subMenu_Map", createHashMap]];

private _category = _group controlsGroupCtrl (17000 + 2102);
private _cateSel = lbCurSel _category;
private _cateData = _category getVariable ["data",[]];

//- "Game Plan", "SubMenu"
  private _subData = _subMenu_Map getOrDefault [_cateData # _cateSel, []];
  _subData params [["_subSel",0]];

private _taskMenu = switch (_cateSel) do {
  case 0: {
    ["AIR_9_LINE","AIR_5_LINE"] # _subSel
  };
  default {
    ""
  }
};

//- Return
[_taskMenu,_cateSel,_subSel]