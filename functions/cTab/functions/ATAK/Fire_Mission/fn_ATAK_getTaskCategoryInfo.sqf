/* 
  "_group" : Menu Group => "(call BCE_fnc_ATAK_getCurrentAPP) # 1"
  "_Setting" : ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings

  Return :
    "_taskMenu" : Task ControlGroup class (e.g. "AIR_9_LINE","AIR_5_LINE" etc)
    "_subSel" : Type Index
*/

params ["_group","_settings"];

private _subInfos = _settings param [2,[]];
private _subMenu_Map = _subInfos param [2, createHashMap];

/* private _category = _group controlsGroupCtrl (17000 + 2102);
private _cateData = _category getVariable ["data",[]]; */
private _cateSel = ["Cate",0] call BCE_fnc_get_TaskCurSetup;
private _cateData = _cateSel call BCE_fnc_get_BCE_TaskCateClass;

//- "Game Plan", "SubMenu"
  // private _subData = _subMenu_Map getOrDefault [_cateData # _cateSel, []];
  private _subData = _subMenu_Map getOrDefault [_cateData, []];
  _subData params [["_subSel",0]];

private _taskMenu = switch (_cateSel) do {
  case 0: {
    ["AIR_9_LINE","AIR_5_LINE"] # _subSel
  };
  case 1: {
    "Call_For_Fire"
  };
  default {
    ""
  }
};

//- Return
[_taskMenu,_cateSel,_subSel]