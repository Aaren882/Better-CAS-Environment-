params ["_control", "_curLine"];
private ["_display","_idc","_EditBox"];

uiNamespace setVariable ["BCE_ATAK_Desc_Type",_curLine];

_display = ctrlParent _control;
_idc = [2028,2044] # (uiNameSpace getVariable ["BCE_Current_TaskType",0]);
_EditBox = (_display displayCtrl (17000 + 4661)) controlsGroupCtrl (17000 + _idc);

_EditBox ctrlShow (_curLine < 1);