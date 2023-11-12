#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
params ["_vehicle"];

_player = player;
if ((_player getVariable ["TGP_View_EHs", -1]) != -1) exitWith {};

#define Equal isEqualTo
//#define have_ACE (isClass(configFile >> "CfgPatches" >> "ace_hearing"))
#if __has_include("\z\ace\addons\hearing\config.bin")
  #define have_ACE 1
#endif

_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal", "Back"];

#ifdef have_ACE
  if (ace_hearing_enableCombatDeafness) then {
    BCE_have_ACE_earPlugs = _player getVariable ["ACE_hasEarPlugsin", false];
    _player setVariable ["ACE_hasEarPlugsIn", true, true];

    [[true]] call ace_hearing_fnc_updateVolume;
    [] call ace_hearing_fnc_updateHearingProtection;
  } else {
    0 fadeSound 0.1;
  };
#else
  0 fadeSound 0.1;
#endif
TGP_View_Unit_List = [];

//PP Effect
_pphandle = ppEffectCreate ["FilmGrain", 1501];
_pphandle ppEffectEnable true;
_pphandle ppEffectAdjust [0.5, 1, 0, [1.0, 0.1, 1.0, 0.75], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
_pphandle ppEffectCommit 0;

_config_path = configOf _vehicle;

_Optic_LODs = [_vehicle,0] call BCE_fnc_Check_Optics;

if ((_player getVariable ["TGP_View_Selected_Optic",[]]) Equal []) then {
  _player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
};

if !(_vehicle Equal ((_player getVariable "TGP_View_Selected_Optic") # 1)) then {
  _player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_vehicle],true];
};

_Selected_Optic = _player getVariable "TGP_View_Selected_Optic";
_turret = (_Selected_Optic # 0) # 1;
_is_Detached = (_Selected_Optic # 0) # 2;

//call BCE_fnc_UpdateCameraUI;
_cam attachTo [_vehicle, [0,0,0],(_Selected_Optic # 0) # 0,!_is_Detached];
_cam camSetFov 0.75;

TGP_View_Camera = [_cam,_pphandle];

//UI setup
556 cutRsc ["BCE_TGP_View_GUI","PLAIN",0.3,false];
cutText ["", "BLACK IN",0.5];

cameraEffectEnableHUD true;
showCinemaBorder false;

_player setVariable ["TGP_View_laser_update", [time,""]];

//Crews
_turret_Unit = _vehicle turretUnit _turret;

_gunner = [name _turret_Unit,"--"] select (((_turret_Unit Equal objNull) or (_turret_Unit Equal (driver _vehicle))));
_pilot = [name (driver _vehicle),"--"] select ((driver _vehicle) Equal objNull);

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

//- Widgets
_widgets_ctrl = _display displayCtrl 2000;
_Exit_ctrl = _display displayCtrl 2025;
_widget_01_ctrl = _Widgets_ctrl controlsGroupCtrl 100;
_env_ctrl = _display displayCtrl 101;

//- Weapon
_WeaponDelay_ctrl = _display displayCtrl 1033;
_WeaponDelay_ctrl ctrlShow false;

//- ENG
_ENG_W_ctrl = _display displayCtrl 1025;

_pilot_ctrl = _display displayCtrl 1028;
_Gunner_ctrl = _display displayCtrl 1029;
_Vehicle_ctrl = _display displayCtrl 1030;

//UI
_pilot_ctrl ctrlSetText (format ["Pilot: %1", _pilot]);
_Gunner_ctrl ctrlSetText (format ["Gunner: %1", _gunner]);
_Vehicle_ctrl ctrlSetText (getText (_config_path >> "DisplayName"));

//-widgets
_widgets_01 = [
  ["Unit_Tracker_Box","TGP_view_Unit_Tracker_Box","Tracker Box"],
  ["Unit_Tracker","TGP_view_Unit_Tracker","Unit Tracker"],
  ["Compass","TGP_view_3D_Compass","3D Compass"],
  ["Unit_MapIcon","TGP_view_Map_Icon","Map Icon"],
  ["LandMark_Icon","TGP_view_LandMark_Icon","LandMark Icon"],
  ["ToggleCursor","TGP_view_Mouse_Cursor","Mouse Cursor",false]
];

{
  _x params ["_action","_var","_text",["_default",true]];
  private ["_key","_index","_color"];

  _key = (["TGP Cam Settings", _action] call CBA_fnc_getKeybind) # 8 # 0 # 0;
  _index = _widget_01_ctrl lbAdd format ["%1 %2", _text, keyImage _key];
  _widget_01_ctrl lbSetPicture [_index,"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa"];

  _color = [
    [1, 0, 0, 1],
    [1, 1, 1, 1]
  ] select (player getVariable [_var,_default]);

  _widget_01_ctrl lbSetPictureColor [_forEachIndex, _color];
  _widget_01_ctrl lbSetColor [_forEachIndex, _color];
} foreach _widgets_01;

//-Set Exit Hint
_Exit_ctrl ctrlSetText format ["Press %1 to Exit Camera",keyImage ((["TGP Cam Settings", "Exit"] call CBA_fnc_getKeybind) # 8 # 0 # 0)];

[BCE_fnc_Set_EnvironmentList, [_env_ctrl,lbSize _env_ctrl - 1], 0] call CBA_fnc_waitAndExecute;

//Draw Icons And Set DirUp
_idEH = addMissionEventHandler ["Draw3D", {
  _cam = _thisArgs # 0;
  _vehicle = _thisArgs # 1;
  _Optic_LODs = _thisArgs # 2;
  _player = _thisArgs # 3;
  (_thisArgs # 4) params ["_time_ctrl","_Altitude_ctrl","_Grid_ctrl","_vision_ctrl","_Laser_ctrl","_camDir_ctrl","_Fuel_ctrl","_Weapon_ctrl","_Ammo_ctrl","_Mode_ctrl","_ENG_W_ctrl","_widget_01_ctrl","_widgets_01"];

  _Selected_Optic = (_player getVariable "TGP_View_Selected_Optic") # 0;
  _Selected_Optic params ["_TGP","_turret","_is_Detached"];

  //-Output TGP Dir (For current controlling vehicle only)
  if (_is_Detached) then {
    private _wRot = [
      [_vehicle,_turret] call BCE_fnc_getTurretDir,
      (_vehicle getVariable ["BCE_Camera_Info_Air",[[],[0,0,0]]]) # 1
    ] select ((_turret # 0) < 0);
    [_cam, _wRot, false] call BCE_fnc_VecRot;
  };

  //-A3TI
  _visionType = _player getVariable ["TGP_View_Optic_Mode", 2];
  #if __has_include("\A3TI\config.bin")
    _A3TI = call A3TI_fnc_getA3TIVision;
    if (_visionType == 2) then {
      _vision_ctrl ctrlSetText format ["CMODE %1",[_A3TI, "NORMAL"] select (isnil {_A3TI})];
    };
  #endif

  //UI Update
  _time_ctrl ctrlSetText (format ["Time: %1",call BCE_fnc_UpdateTime]);
  _Altitude_ctrl ctrlSetText (format ["Altitude: %1",Round ((getPosASL _vehicle) # 2)]);
  _Grid_ctrl ctrlSetText (format ["Grid: %1",mapGridPosition (screenToWorld [0.5,0.5])]);
  _camDir_ctrl ctrlSetText (format ["%1°", round (getDir _cam)]);
  _Fuel_ctrl ctrlSetText (format ["Fuel: %1%2", round ((fuel _vehicle) * 100),"%"]);
  _Engine_damage = _vehicle getHitPointDamage "hitEngine";

  //Engine
  _color = if (_Engine_damage > 0) then {
    [
      [0.94,0.7,0,1],
      [1,0,0,1]
    ] select (_Engine_damage >= 0.5)
  } else {
    [1,1,1,1]
  };
  _ENG_W_ctrl ctrlSetTextColor _color;

  if (isNull findDisplay 1022553) then {
    player setVariable ["TGP_view_Mouse_Cursor",false];
  };

  //-Widgets
  {
    _x params ["","_var","",["_default",true]];
    private _color = [
      [1, 0, 0, 1],
      [1, 1, 1, 1]
    ] select (player getVariable [_var,_default]);
    _widget_01_ctrl lbSetPictureColor [_forEachIndex, _color];
    _widget_01_ctrl lbSetColor [_forEachIndex, _color];
  } foreach _widgets_01;

  //currentWeapon
  _weapon_info = weaponState [_vehicle,_turret];
  _weapon_info params ["_infoWeapon", "_infomuzzle", "_infomode", "_infomagazine", "_ammoCount", "_roundReloadPhase", "_magazineReloadPhase"];

  //-Ammo Count
  _count = ({
    _x params ["_m","_c"];
    (_m == _infomagazine) && (_c > 0)
  } count (magazinesAmmo [_vehicle, true])) max 1;

  _ammoCount = _count * _ammoCount;

  _Weapon_ctrl ctrlSetText getText (configFile >> "CfgWeapons" >> _infoWeapon >> "DisplayName");
  if ((getText (configFile >> "CfgWeapons" >> _infoWeapon >> "DisplayName") == "") or ("laserdesignator" in (tolower _infoWeapon))) then {
    _Mode_ctrl ctrlSetText "";
    _Ammo_ctrl ctrlSetText "";
  } else {
    _Mode_ctrl ctrlSetText (format ["Mode: %1", getText (configFile >> "CfgWeapons" >> _infoWeapon >> _infomode >> "DisplayName")]);
    _Ammo_ctrl ctrlSetText (format ["Ammo: %1  %2", getText (configFile >> "CfgMagazines" >> _infomagazine >> "displayNameShort"), _ammoCount]);
  };

  _Weapon_ctrl ctrlSetTextColor ([[1,1,1,1],[0.76,0.71,0.215,1]] select ((_roundReloadPhase > 0) or (_magazineReloadPhase > 0)));

  //Laser
  if (_vehicle isLaserOn _turret) then {
    _laser_Vars = _player getVariable "TGP_View_laser_update";
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
  if (_player getVariable ["TGP_view_LandMark_Icon",true]) then {
    call BCE_fnc_LandMarks_icon;
  };

  if (BCE_touchMark_fn) then {
    call BCE_fnc_touchMark;
  };

  call BCE_fnc_Cam_Layout;

  #ifdef cTAB_Installed
  	#define exitCdt (!(isnull curatorcamera) or !(isnil{cTabIfOpen}))
  #else
  	#define exitCdt !(isnull curatorcamera)
  #endif

  //-Exit
  if (exitCdt) then {
    if !(TGP_View_Camera Equal []) then {
      camUseNVG false;

  		ppEffectDestroy (TGP_View_Camera # 1);

  		556 cutRsc ["default","PLAIN"];
  		cutText ["", "BLACK IN",0.5];

      #ifdef have_ACE
        if !(BCE_have_ACE_earPlugs) then {
          _player setVariable ["ACE_hasEarPlugsIn", false, true];
          [[true]] call ace_hearing_fnc_updateVolume;
          [] call ace_hearing_fnc_updateHearingProtection;
        };
      #else
        1.5 fadeSound 1;
      #endif

      TGP_View_Camera = [];

      [2] call BCE_fnc_OpticMode;
    };

		private _current_EH = _player getVariable ["TGP_View_EHs",-1];
    if (_current_EH != -1) then {
      removeMissionEventHandler ["Draw3D", _thisEventHandler];
  		_player setVariable ["TGP_View_EHs",-1,true];
    };
  };
},[
  _cam,_vehicle,_Optic_LODs,_player,
  [_time_ctrl,_Altitude_ctrl,_Grid_ctrl,_vision_ctrl,_Laser_ctrl,_camDir_ctrl,_Fuel_ctrl,_Weapon_ctrl,_Ammo_ctrl,_Mode_ctrl,_ENG_W_ctrl,_widget_01_ctrl,_widgets_01]
]];

_player setVariable ["TGP_View_EHs",_idEH,true];
_player setVariable ["TGP_View_Camera_FOV", 0.75];

//-Set Camera Vision Mode
_visionMode = _player getVariable ["TGP_View_Optic_Mode",2];
#if __has_include("\A3TI\config.bin")
  _A3TI = A3TI_FLIR_VisionMode;
  _visionMode = [_visionMode,_A3TI] select (_A3TI > -1);
#endif
_visionMode call BCE_fnc_OpticMode;
