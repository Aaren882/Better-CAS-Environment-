params ["_control", "_curLine"];
private ["_display","_EditBox"];

uiNamespace setVariable ["BCE_ATAK_Desc_Type",_curLine];

_display = ctrlParent _control;
_EditBox = (_display displayCtrl (17000 + 4661)) controlsGroupCtrl (17000 + 2028);

_EditBox ctrlShow (_curLine < 1);