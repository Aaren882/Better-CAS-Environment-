#include "\a3\ui_f\hpp\defineCommonGrids.inc"
params ["_item","_display"];

private _cGrp = if (isnil{_display}) then {
	(findDisplay 12) ctrlCreate ["PLP_SMT_Description",73454];
} else {
	_display displayCtrl 73454;
};

private _displayName = getText (_item >> "displayNameFull") ;
if (_displayName == "") then {_displayName = getText (_item >> "displayName")} ;

private _cTitle = _cGrp controlsGroupCtrl 1 ;
_cTitle ctrlSetText _displayName ;

private _cControls = _cGrp controlsGroupCtrl 2 ;
_cControls ctrlSetText getText (_item >> "controls") ;

private _cDesc = _cGrp controlsGroupCtrl 3 ;
_cDesc ctrlSetText getText (_item >> "description") ;

private _height = (ctrlPosition _cControls)#1 + ctrlTextHeight _cControls ;
private _sep = _cGrp controlsGroupCtrl 11 ;
_sep ctrlSetPositionY (_height + GUI_GRID_H*(0.15)) ;
_sep ctrlCommit 0 ;

_cDesc ctrlSetPositionY (_height + GUI_GRID_H*(0.35)) ;
_cDesc ctrlCommit 0 ;

private _height = (ctrlPosition _cDesc)#1 + ctrlTextHeight _cDesc ;
private _bg = _cGrp controlsGroupCtrl 10 ;
_bg ctrlSetPositionH (_height + GUI_GRID_H*(0.15)) ;
_bg ctrlCommit 0 ;
