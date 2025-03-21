params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

//- Create the Correct Mission Builder
  private _category = _group controlsGroupCtrl (17000 + 2102);
  private _cateSel = ["Cate",0] call BCE_fnc_get_TaskCurSetup;
  _category lbSetCurSel _cateSel;

  //- Connects to => "BCE_Mission_Property" Category
  private _cateData = getArray (configFile >> ctrlClassName _group >> "controls" >> ctrlClassName _category >> "data");
  _category setVariable ["data", _cateData]; //- Set Data

  //- Add EH
  _category ctrlAddEventHandler ["ToolBoxSelChanged", {
    ["Cate", _this # 1] call BCE_fnc_set_TaskCurSetup;
    [] call BCE_fnc_ATAK_updateTaskControl;
  }];

//- Update Task controlGroup
  private _ctrl = [_group,_settings] call BCE_fnc_ATAK_updateTaskControl;

//- Update Scroll value
[
  {
    _this ctrlSetScrollValues [uiNamespace getVariable ["BCE_ATAK_Scroll_Value",0], -1];
  }, _ctrl
] call CBA_fnc_execNextFrame;