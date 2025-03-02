params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

_group spawn {
  uisleep 0.01;
  
  //-restore Task Type
    _this ctrlSetScrollValues [uiNamespace getVariable ["BCE_ATAK_Scroll_Value",0], -1];
  //- Update List
    private _ctrl = _this controlsGroupCtrl (17000 + 2107);
    _ctrl lbSetCurSel (uiNamespace getVariable ["BCE_Current_TaskType",0]);
};


//- Create the Correct Mission Builder
private _category = _group controlsGroupCtrl (17000 + 2102);
private _cateSel = lbCurSel _category;

private _cateData = getArray (configFile >> ctrlClassName _group >> "controls" >> ctrlClassName _category >> "data");
_category setVariable ["data", _cateData]; //- Set Data

//- Update Task controlGroup
  private _ctrl = [_group,_settings] call BCE_fnc_ATAK_updateTaskControl;