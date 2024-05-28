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

camUseNVG false;
false setCamUseTi 0;
false setCamUseTi 1;

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

_Exit_ctrl = _display displayCtrl 16;

_bnt_Hint = [
  ["STR_BCE_Take_ScreenShot","ScreenShot"],
  ["STR_BCE_ATAK_FlashLight","FlashLight"]
] apply {
  _x params ["_fnc","_id"];
  format [localize "STR_BCE_Press_key" + " ”" + localize _fnc + "“", ((["Better CAS Environment (cTab ATAK Camera)", _id] call CBA_fnc_getKeybind) # -1 # 0) call CBA_fnc_localizeKey]
};

_Exit_ctrl ctrlSetText (_bnt_Hint joinString " | ");

//- Loop for Camera Infos
[{
  params ["_unit","_cam","_display","_zulu"];

  private _light = localNamespace getVariable ["BCE_ATAK_Camera_FlashLight",objNull];
  private _dir = getCameraViewDirection _unit;
  private _Vec = (_dir apply {(linearConversion [-1,1,_x,-65,65,true])}) # 2;
  private _DirUp = [nil, 0, _Vec, 0] call BIS_fnc_transformVectorDirAndUp;
  
  if !(isnull _light) then {
    _light setVectorDir _dir;
    _light setVectorDirAndUp _DirUp;
  };
  _cam setVectorDir _dir;
  _cam setVectorDirAndUp _DirUp;

  //- Update Time
  private _time = _display displayCtrl 53;
  _time ctrlSetText format ["%1 %2",_zulu, [daytime] call BIS_fnc_timeToString];

  //- In 10 GRIDs
  private _dateCtrl = _display displayCtrl 54;
  
  private _date = date;
  _date resize 3;
  _dateCtrl ctrlSetText format ["%1", (_date apply {(["","0"] select (_x < 10)) + (str _x)}) joinString "/"];

  (isnull _display) || 
  !(alive _unit) || 
  !(isNull curatorCamera) || 
  ((incapacitatedState _unit) == "UNCONSCIOUS")
}, {
  params ["_unit","_cam","_display"];

  if (isNull curatorCamera) then {
    camDestroy _cam;
    switchCamera _unit;
    cutText ["", "BLACK IN",0.5];
    _cam cameraeffect ["Terminate", "back"]; 
  };

  if !(isnull _display) then {
    558 cutRsc ["default","PLAIN"];
  };

  //- Delete Light
  private _light = localNamespace getVariable ["BCE_ATAK_Camera_FlashLight",objNull];
  if !(isnull _light) then {
    deleteVehicle _light;
    localNamespace setVariable ["BCE_ATAK_Camera_FlashLight",nil];
  };

}, [_unit,_cam, _display,_zulu]
] call CBA_fnc_waitUntilAndExecute;