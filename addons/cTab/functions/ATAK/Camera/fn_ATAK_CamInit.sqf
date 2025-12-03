params ["_displayName","_components"];

_display = uiNamespace getVariable [_displayName, displayNull];
if (isnull _display) exitWith {};

_unit = focusOn;
_user = _display displayCtrl 51;
_group = _display displayCtrl 52;

//- Ex. At Greece UTC+2
  _lat = -getNumber (configFile / "CfgWorlds" / worldName / "latitude"); //- Arma3 using negative value
  _zulu = round (_lat / 15);
  _zulu = format ["Zulu%1%2", ["+","-"] select (_zulu < 0),_zulu];

_Exit_ctrl = _display displayCtrl 15;
_Exit_ctrl ctrlSetText format [localize "STR_BCE_Press_key" + " " + localize "STR_BCE_Exit_Camera", ((["Better CAS Environment (TGP)", "Exit"] call CBA_fnc_getKeybind) # -1 # 0) call CBA_fnc_localizeKey];

_Sync = true;
_can_Exit = !isnil {_components};

_cam = switch _displayName do {
  case "BCE_PhoneCAM_View": {

    //- Close cTab Interface
      call cTab_fnc_close;
    
    //- User Name
      _user ctrlSetText profileName;
      _group ctrlSetText (groupId group _unit);
    
    _resolution = _display displayCtrl 50;
    _resolution ctrlSetText format ["%1x%2", getResolution # 0, getResolution # 1];

    //- Set Camera
      _cam = [true] call BCE_fnc_ATAK_FullScreenCamera;
      if (vehicle _unit != _unit) then {
        private _veh = vehicle _unit;
        private _offset = _veh worldToModelVisual (ASLToAGL (eyePos _unit));
        _cam attachTo [_veh,_offset vectorAdd [0,0.4,0]];
      } else {
        _cam attachTo [_unit, [0,0.4,0.2], "head"];
      };

    //- Functional Button
      _ctrl_hint = _display displayCtrl 16;

      _bnt_Hint = [
        ["STR_BCE_Take_ScreenShot","ScreenShot"],
        ["STR_BCE_ATAK_FlashLight","FlashLight"]
      ] apply {
        _x params ["_fnc","_id"];
        format [localize "STR_BCE_Press_key" + " ”" + localize _fnc + "“", ((["Better CAS Environment (cTab ATAK Camera)", _id] call CBA_fnc_getKeybind) # -1 # 0) call CBA_fnc_localizeKey]
      };

      _ctrl_hint ctrlSetText (_bnt_Hint joinString " | ");
    
    _cam
  };
  case "BCE_HCAM_View": {

      //- Check Context
      if !(canSuspend) exitWith {
        //- Check Camera Data
          if (isnil{cTabHcams}) exitWith {objNull};
          private _newHost = cTabHcams # 1;
          
        //- Close cTab Interface (Dont do it first ,data from cTab can be Transferred easily)
          call cTab_fnc_deleteHelmetCam;
          call cTab_fnc_close;
        
        //- Active again -\\ _components : [OBJECT, Can Exit];
          [_displayName,[_newHost,false]] spawn {
            uiSleep 0.1;
            _this call BCE_fnc_ATAK_CamInit;
          };
        objNull
      };

      _Sync = false;
      _newHost = _components # 0;
      _can_Exit = _components # 1;
      
      //- User Name
        _user ctrlSetText name _newHost;
        _group ctrlSetText (groupId group _newHost);

      _camOffSet = call {
        // should unit not be in a vehicle
        if (vehicle _newHost isKindOf "CAManBase") exitWith {
          [0.12,0,0.15];
        };
        // if unit is in a vehilce, see if 3rd person view is allowed
        if (difficultyEnabled "3rdPersonView") exitWith {
          _newHost = vehicle _newHost;
          // Might want to calculate offsets based on the actual vehicle dimensions in the future
          [0,-8,4];
        };
        // if unit is in a vehicle and 3rd person view is not allowed
        _newHost = objNull;
        []
      };

      if (_camOffSet findIf {true} < 0) exitWith {objNull};
    
    //- Set Camera
      _cam = [] call BCE_fnc_ATAK_FullScreenCamera;
      _cam camPrepareFov 0.7;
      _cam camCommitPrepared 0;
      if (vehicle _newHost == _newHost) then {
        _cam attachTo [_newHost,_camOffSet,"Head",true];
      } else {
        _cam attachTo [_newHost,_camOffSet];
      };
    
    _cam
  };
};

if (isNull _cam) exitWith {
  if (_can_Exit) then {
    _display closeDisplay 0;
  };
};

//- Loop for Camera Infos
[{
  params ["_unit","_cam","_display","_zulu","_Sync"];

  if (_Sync) then {
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
  };
  
  //- Update Time
  private _time = _display displayCtrl 53;
  _time ctrlSetText ([_zulu, [daytime] call BIS_fnc_timeToString] joinString " ");

  //- Update Date
  private _dateCtrl = _display displayCtrl 54;
  private _date = date;
  _date resize 3;
  _dateCtrl ctrlSetText ((_date apply {(["","0"] select (_x < 10)) + (str _x)}) joinString "/");

  (isnull _cam) || 
  (isnull _display) || 
  !(alive _unit) || 
  !(isNull curatorCamera) || 
  ((incapacitatedState _unit) == "UNCONSCIOUS")
}, {
  params ["_unit","_cam","_display","","_Sync"];

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
  if (_Sync) then {
    private _light = localNamespace getVariable ["BCE_ATAK_Camera_FlashLight",objNull];
    if !(isnull _light) then {
      deleteVehicle _light;
      localNamespace setVariable ["BCE_ATAK_Camera_FlashLight",nil];
    };
  };

}, [_unit,_cam, _display,_zulu,_Sync]
] call CBA_fnc_waitUntilAndExecute;
