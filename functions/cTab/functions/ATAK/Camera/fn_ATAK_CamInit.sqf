params ["_display"];

_unit = focusOn;
_resolution = _display displayCtrl 50;
_resolution ctrlSetText format ["%1x%2", getResolution # 0, getResolution # 1];

_user = _display displayCtrl 51;
_name = profileName;
_user ctrlSetText _name;

_group = _display displayCtrl 52;
_group ctrlSetText (groupId group _unit);

//- Ex. At Greece UTC+2
_lat = -getNumber (configFile / "CfgWorlds" / worldName / "latitude"); //- Arma3 using negative value
_zulu = round (_lat / 15);
_zulu = format ["Zulu%1%2", ["+","-"] select (_zulu < 0),_zulu];


//- Set Camera
_cam = "camera" camCreate [0,0,0]; 
_cam cameraEffect ["Internal", "Back","rttN"];
cutText ["", "BLACK IN",0.5];

cameraEffectEnableHUD true; 
showCinemaBorder false;
switchCamera _cam;

if (vehicle _unit != _unit) then {
  private _veh = vehicle _unit;
  private _offset = _veh worldToModelVisual (ASLToAGL (eyePos _unit));
  _cam attachTo [_veh,_offset vectorAdd [0,0.4,0]];
} else {
  _cam attachTo [_unit, [0,0.4,0.2], "head"];
};

_Exit_ctrl = _display displayCtrl 15;
_Exit_ctrl ctrlSetText format [localize "STR_BCE_Press_key" + " " + localize "STR_BCE_Exit_Camera", ((["Better CAS Environment (TGP)", "Exit"] call CBA_fnc_getKeybind) # -1 # 0) call CBA_fnc_localizeKey];

//- Loop for Camera Infos
[{
  params ["_unit","_cam","_display","_zulu"];

  _dir = getCameraViewDirection _unit;
  _dir apply {(linearConversion [-1,1,_x,-65,65,true])};
  _Vec = _dir apply {(linearConversion [-1,1,_x,-65,65,true])};
  _DirUp = [nil, 0, _Vec # 2, 0] call BIS_fnc_transformVectorDirAndUp;

  _cam setVectorDir _dir;
  _cam setVectorDirAndUp _DirUp;

  //- Update Time
  _time = _display displayCtrl 53;
  _time ctrlSetText format ["%1 %2",_zulu, [daytime] call BIS_fnc_timeToString];

  //- In 10 GRIDs
  _dateCtrl = _display displayCtrl 54;
  
  _date = date;
  _date resize 3;
  _dateCtrl ctrlSetText format ["%1", (_date apply {(["","0"] select (_x < 10)) + (str _x)}) joinString "/"];
  
  (isnull _display) || !(alive _unit)
}, {
  params ["_unit","_cam"];

  cutText ["", "BLACK IN",0.5];
  _cam cameraeffect ["Terminate", "back"]; 
  camDestroy _cam;
  switchCamera _unit;

}, [_unit,_cam, _display,_zulu]
] call CBA_fnc_waitUntilAndExecute;