params ["_vehicle"];

_player = player;
if ((_player getVariable ["TGP_View_EHs", -1]) != -1) exitWith {};

#define Equal isEqualTo
#define have_ACE (isClass(configFile >> "CfgPatches" >> "ace_hearing"))

_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back"];

if (have_ACE && ace_hearing_enableCombatDeafness) then {
  BCE_have_ACE_earPlugs = _player getVariable ["ACE_hasEarPlugsin", false];
  _player setVariable ["ACE_hasEarPlugsIn", true, true];

  [[true]] call ace_hearing_fnc_updateVolume;
  [] call ace_hearing_fnc_updateHearingProtection;
} else {
  0 fadeSound 0.1;
};
TGP_View_Unit_List = [];

//PP Effect
_pphandle = ppEffectCreate ["FilmGrain", 1501];
_pphandle ppEffectEnable true;
_pphandle ppEffectAdjust [0.5, 1, 0, [1.0, 0.1, 1.0, 0.75], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
_pphandle ppEffectCommit 0;

_config_path = configFile >> "CfgVehicles" >> typeOf _vehicle;
_A3TI = isclass(configFile >> "CfgPatches" >> "A3TI");

_Optic_LODs = _vehicle getVariable ["TGP_View_Available_Optics",[]];

if ((_player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) then {
  _player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
};

if !(_vehicle Equal ((_player getVariable "TGP_View_Selected_Optic") # 1)) then {
  _player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
};

_Selected_Optic = _player getVariable "TGP_View_Selected_Optic";
_current_turret = (_Selected_Optic # 0) # 1;
_is_Detached = (_Selected_Optic # 0) # 2;

if (_is_Detached) then {
  _cam attachTo [_vehicle, [0,0,0],(_Selected_Optic # 0) # 0];
} else {
  _cam attachTo [_vehicle, [0,0,0],(_Selected_Optic # 0) # 0,true];
};

_cam camSetFov 0.75;

TGP_View_Camera = [_cam,_pphandle];

//UI setup
556 cutRsc ["BCE_TGP_View_GUI","PLAIN",0.3,false];
cutText ["", "BLACK IN",0.5];

cameraEffectEnableHUD true;
showCinemaBorder false;


[_player getVariable ["TGP_View_Optic_Mode",2]] call BCE_fnc_OpticMode;

_player setVariable ["TGP_View_laser_update", [time,""]];

//Crews
_pilot = if ((driver _vehicle) Equal objNull) then {
  "None"
} else {
  name (driver _vehicle)
};

_turret_Unit = _vehicle turretUnit _current_turret;
_gunner = if (_turret_Unit Equal objNull) then {
  "None"
} else {
  name _turret_Unit
};

//-Controls
_display = uiNameSpace getVariable "BCE_TGP";
_time_ctrl = _display displayCtrl 1001;
_Altitude_ctrl = _display displayCtrl 1002;
_Grid_ctrl = _display displayCtrl 1003;
_vision_ctrl = _display displayCtrl 1005;
_Laser_ctrl = _display displayCtrl 1023;
_camDir_ctrl = _display displayCtrl 1024;
_Fuel_ctrl = _display displayCtrl 1026;
_Weapon_ctrl = _display displayCtrl 1027;
_Ammo_ctrl = _display displayCtrl 1031;
_Mode_ctrl = _display displayCtrl 1032;

//- Weapon
_WeaponDelay_ctrl = _display displayCtrl 1033;
_WeaponDelay_ctrl ctrlShow false;

//- ENG
_ENG_W_ctrl = _display displayCtrl 1025;
_ENG_Y_ctrl = _display displayCtrl 1052;
_ENG_R_ctrl = _display displayCtrl 1053;

_pilot_ctrl = _display displayCtrl 1028;
_Gunner_ctrl = _display displayCtrl 1029;
_Vehicle_ctrl = _display displayCtrl 1030;

//UI
_pilot_ctrl ctrlSetText (format ["Pilot: %1", _pilot]);
_Gunner_ctrl ctrlSetText (format ["Gunner: %1", _gunner]);
_Vehicle_ctrl ctrlSetText (getText (_config_path >> "DisplayName"));

//Draw Icons And Set DirUp
_idEH = addMissionEventHandler ["Draw3D", {
  _cam = _thisArgs # 0;
  _vehicle = _thisArgs # 1;
  _Optic_LODs = _thisArgs # 2;
  _player = _thisArgs # 3;
  _A3TI = _thisArgs # 4;
  (_thisArgs # 5) params ["_time_ctrl","_Altitude_ctrl","_Grid_ctrl","_vision_ctrl","_Laser_ctrl","_camDir_ctrl","_Fuel_ctrl","_Weapon_ctrl","_Ammo_ctrl","_Mode_ctrl","_ENG_W_ctrl","_ENG_Y_ctrl","_ENG_R_ctrl"];

  _Selected_Optic = (_player getVariable "TGP_View_Selected_Optic") # 0;
  _TGP = _Selected_Optic # 0;
  _current_turret = _Selected_Optic # 1;
  _is_Detached = _Selected_Optic # 2;

  if (_is_Detached) then {
    _wRot = if (_current_turret isEqualTo []) then {
      (_vehicle getVariable ["BCE_Camera_Info_Air",[[],[0,0,0]]]) # 1
    } else {
      (_vehicle selectionVectorDirAndUp [_TGP, "Memory"]) # 0;
    };
    [_cam, _wRot, false] call BCE_fnc_VecRot;
  };

  //-A3TI
  _visionType = _player getVariable ["TGP_View_Optic_Mode", 2];
  if (_A3TI) then {
    if (((call A3TI_fnc_getA3TIVision) != "") && (_visionType == 2)) then {
      _vision_ctrl ctrlSetText (format ["CMODE %1",call A3TI_fnc_getA3TIVision]);
    } else {
      if (((call A3TI_fnc_getA3TIVision) == "")  && (_visionType == 2)) then {
        _vision_ctrl ctrlSetText "CMODE NORMAL";
      };
    };
  };

  /* _camDir = (_vehicle selectionVectorDirAndUp [_TGP, "Memory"]) # 0;
  //_camDir = (_vehicle selectionPosition "PiP0_pos") vectorFromTo (_vehicle selectionPosition "PiP0_dir");
  _cam setVectorDirAndUp [_camDir,_camDir vectorCrossProduct [-(_camDir # 1), _camDir # 0, 0]];*/
  //hintSilent str [[_camDir,_camDir vectorCrossProduct [-(_camDir # 1), _camDir # 0, 0]],_TGP];

  //UI Update
  _time_ctrl ctrlSetText (format ["Time: %1",call BCE_fnc_UpdateTime]);
  _Altitude_ctrl ctrlSetText (format ["Altitude: %1",Round ((getPosASL _vehicle) # 2)]);
  _Grid_ctrl ctrlSetText (format ["Grid: %1",mapGridPosition (screenToWorld [0.5,0.5])]);
  _camDir_ctrl ctrlSetText (format ["%1??", round (getDir _cam)]);
  _Fuel_ctrl ctrlSetText (format ["Fuel: %1%2", round ((fuel _vehicle) * 100),"%"]);

  //Engine
  if ((_vehicle getHitPointDamage "hitEngine") > 0) then {
    _ENG_W_ctrl ctrlSetText "";
    if ((_vehicle getHitPointDamage "hitEngine") >= 0.5) then {
      _ENG_Y_ctrl ctrlSetText format ["%1", ""];
      _ENG_R_ctrl ctrlSetText format ["%1", "ENG"];
    } else {
      _ENG_Y_ctrl ctrlSetText (format ["%1", "ENG"]);
      _ENG_R_ctrl ctrlSetText "";
    };
  } else {
    _ENG_W_ctrl ctrlSetText (format ["%1", "ENG"]);
    _ENG_Y_ctrl ctrlSetText "";
    _ENG_R_ctrl ctrlSetText "";
  };

  //currentWeapon
  _weapon_info = weaponState [_vehicle,_current_turret];
  _weapon_info params ["_infoWeapon", "_infoMuzzle", "_infomode", "_infomagazine", "_ammoCount", "_roundReloadPhase", "_magazineReloadPhase"];

  _Weapon_ctrl ctrlSetText (format ["%1", getText (configFile >> "CfgWeapons" >> _infoWeapon >> "DisplayName")]);
  if ((getText (configFile >> "CfgWeapons" >> _infoWeapon >> "DisplayName") == "") or ("laserdesignator" in (tolower _infoWeapon))) then {
    _Mode_ctrl ctrlSetText "";
    _Ammo_ctrl ctrlSetText "";
  } else {
    _Mode_ctrl ctrlSetText (format ["Mode: %1", getText (configFile >> "CfgWeapons" >> _infoWeapon >> _infomode >> "DisplayName")]);
    _Ammo_ctrl ctrlSetText (format ["Ammo: %1  %2", getText (configFile >> "CfgMagazines" >> _infomagazine >> "displayNameShort"), _ammoCount]);
  };

  if ((_roundReloadPhase > 0) or (_magazineReloadPhase > 0)) then {
    _Weapon_ctrl ctrlSetTextColor [0.76,0.71,0.215,1];
  } else {
    _Weapon_ctrl ctrlSetTextColor [1,1,1,1];
  };

  _laser_Vars = _player getVariable "TGP_View_laser_update";
  //Laser
  if (isLaserOn _vehicle) then {
    if ((_laser_Vars # 0) <= time) then {
      if ((_laser_Vars # 1) Equal "") then {
        _player setVariable ["TGP_View_laser_update", [time+0.2,"L T D / R"]];
      } else {
        _player setVariable ["TGP_View_laser_update", [time+0.2,""]];
      };
      _Laser_ctrl ctrlSetText (_laser_Vars # 1);
    };
  } else {
    _Laser_ctrl ctrlSetText "";
  };

  //Update UnitList
  if (missionNamespace getVariable ["TGP_View_Unit_List_update",-1] <= time) then {
    call BCE_fnc_TGP_UnitList;
    missionNamespace setVariable ["TGP_View_Unit_List_update", time+1];
  };

  if (_player getVariable ["TGP_view_3D_Compass",true]) then {
    call BCE_fnc_3DCompass;
  };

  if (count TGP_View_Unit_List > 0) then {
    _friendlyActive = true;
    _boxActive = true;
    call BCE_fnc_Unit_Icon;
  };
  if (_player getVariable ["TGP_view_Map_Icon",true]) then {
    _alpha = 0.4;
    call BCE_fnc_map_Icon;
  };

  if (BCE_touchMark_fn) then {
    call BCE_fnc_touchMark;
  };

  call BCE_fnc_Cam_Layout;

  //-Exit
  if !(isnull curatorcamera) then {

    if !(TGP_View_Camera isEqualTo []) then {
      camUseNVG false;

  		ppEffectDestroy (TGP_View_Camera # 1);

  		556 cutRsc ["default","PLAIN"];
  		cutText ["", "BLACK IN",0.5];

      if (have_ACE) then {
        if !(BCE_have_ACE_earPlugs) then {
          _player setVariable ["ACE_hasEarPlugsIn", false, true];
          [[true]] call ace_hearing_fnc_updateVolume;
          [] call ace_hearing_fnc_updateHearingProtection;
        };
      } else {
        1.5 fadeSound 1;
      };

      TGP_View_Camera = [];

      [2] call BCE_fnc_OpticMode;
    };

		_current_EH = _player getVariable ["TGP_View_EHs",-1];
    if (_current_EH != -1) then {
      removeMissionEventHandler ["Draw3D", _current_EH];
  		_player setVariable ["TGP_View_EHs",-1,true];
    };
  };
},[
  _cam,_vehicle,_Optic_LODs,_player,_A3TI,
  [_time_ctrl,_Altitude_ctrl,_Grid_ctrl,_vision_ctrl,_Laser_ctrl,_camDir_ctrl,_Fuel_ctrl,_Weapon_ctrl,_Ammo_ctrl,_Mode_ctrl,_ENG_W_ctrl,_ENG_Y_ctrl,_ENG_R_ctrl]
]];

_player setVariable ["TGP_View_EHs",_idEH,true];
_player setVariable ["TGP_View_Camera_FOV", 0.75];
