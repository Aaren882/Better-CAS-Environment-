params ["_group",["_interfaceInit",false],"_settings"];

_group spawn {
  uisleep 0.01;
  
  //-restore Task Type
    _this ctrlSetScrollValues [uiNamespace getVariable ["BCE_ATAK_Scroll_Value",0], -1];
  //- Update List
    private _ctrl = _this controlsGroupCtrl (17000 + 2107);
    _ctrl lbSetCurSel (uiNamespace getVariable ["BCE_Current_TaskType",0]);
};