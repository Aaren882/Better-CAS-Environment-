private _time = systemTime apply {(["","0"] select (_x < 10)) + (str _x)};
_time resize 6;

private _display = uiNamespace getVariable ["BCE_PhoneCAM_View",displayNull];

//- Print Grid
_grid = _display displayCtrl 55;
_grid ctrlSetBackgroundColor [0,0,0,0.3];
_grid ctrlSetText format["GRID :%1", [getPosVisual player,10] call BCE_fnc_POS2Grid];

private _ctrls = (allControls _display) apply {
  if (50 > ctrlIDC _x) then {
    _x ctrlshow false;
    _x
  } else {
    controlNull
  };
};

[{
  params ["_file","_ctrls", "_grid"];
  _return = "Arma_ScreenShot_Extension" callExtension _file;

  {
    if (isNull _x) then {continue};
    _x ctrlshow true;
  } forEach _ctrls;

  _grid ctrlSetBackgroundColor [0,0,0,0];
  _grid ctrlSetText "";

  //- Exit it if ERROR
  if (_return != "") then {
    systemChat str format ["ERROR from Taking Pictrue. %1", _return];
  } else {
    playSound3D ["\MG8\AVFEVFX\sound\CameraShutter.wss", player, false, getPosASL player, 3, 1, 15];
  };
},
  [format ["%1%2.%3", BCE_PicFilePath_edit, _time joinString "_", ["jpg","png"] # BCE_PicFile_list], _ctrls, _grid], 0.2
] call CBA_fnc_waitAndExecute;