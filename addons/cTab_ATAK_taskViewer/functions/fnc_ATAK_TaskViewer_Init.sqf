#include "script_component.hpp"
params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _listGroup = _group controlsGroupCtrl 10;

//- Create DropMenu
  [
    "ATAK_TaskView_Tag",
    _listGroup,
    _isDialog,
    GVAR(List) toArray false // _tasks
  ] call BCE_fnc_Create_ATAK_Custom_DropMenu;
