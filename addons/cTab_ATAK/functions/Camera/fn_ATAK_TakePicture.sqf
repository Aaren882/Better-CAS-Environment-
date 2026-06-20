#include "script_component.hpp"

private _display = uiNamespace getVariable ["BCE_PhoneCAM_View",displayNull];

//- Print Grid
_grid = _display displayCtrl 55;
_grid ctrlSetBackgroundColor [0,0,0,0.3];
_grid ctrlSetText format["GRID :%1", [getPosVisual player,10] call BCE_fnc_POS2Grid];

_grid = _display displayCtrl 55;

private _ctrls = (allControls _display) apply {
  if (50 > ctrlIDC _x) then {
    _x ctrlshow false;
    _x
  } else {
    controlNull
  };
};


[{
  params ["_ctrls", "_grid"];
	
	private _screenshot = [] call BCE_fnc_screenShot; //- Take picture
  
  {
    if (isNull _x) then {continue};
    _x ctrlshow true;
  } forEach _ctrls;

  _grid ctrlSetBackgroundColor [0,0,0,0];
  _grid ctrlSetText "";

  //- Exit it if ERROR
  if (_screenshot isEqualTo []) exitwith {};

  playSound3D [QPATHTOEF(Core,sound\CameraShutter.wss), player, false, getPosASL player, 3, 1, 15];

  //- CBA_EH to trigger this 👇
	["bce_took_screenshot", _screenshot] call CBA_fnc_localEvent; //- upload to discord
},
  [
    _ctrls, 
    _grid
  ], 0.2
] call CBA_fnc_waitAndExecute;
