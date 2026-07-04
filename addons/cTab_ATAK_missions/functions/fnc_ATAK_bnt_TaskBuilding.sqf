#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_bnt_TaskBuilding
Description:
		Arranges and configures the buttons for the task building interface based on the category.

Parameters:
		_ctrlBnts  - ControlGroup containing button controls.
		_ctrlPOS   - ControlPosition object used for layout calculation.
		_subMenu    - SubMenu control.
		_interfaceInit - Interface initialization parameter.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_ctrlBnts","_ctrlPOS","_subMenu","_interfaceInit"];
TRACE_1("fnc_ATAK_bnt_TaskBuilding",_this);

_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

private _cateClass = [] call BCE_fnc_get_BCE_TaskCateClass; //- AIR, GND, OTH
private _width = _ctrlPOS # 2;
private _SelBnts =+ _ctrlBnts;

switch (_cateClass) do {
  case "GND": {
    _bnt_third ctrlshow false;
    _width = (_ctrlPOS # 2) * 4/3;
    _SelBnts = [_bnt_back,_bnt_Ent,_bnt_result];
  };
  default {
    _bnt_third ctrlshow true;
  };
};

//- Arrange Bottons layout
  {
    _x ctrlSetPositionX (_width * _forEachIndex);
    _x ctrlSetPositionW _width;
    _x ctrlCommit 0;
  } forEach _SelBnts;

_bnt_Ent ctrlSetText localize "STR_BCE_Enter";
_bnt_Ent ctrlSetBackgroundColor [0,0,0,0.5];

_bnt_result ctrlSetStructuredText parseText localize "STR_BCE_ClearTaskInfo";
_bnt_result ctrlSetBackgroundColor [1,0,0,0.5];
