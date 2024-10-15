/*
  Function handling IF_Main keydown event
  Based on player equipment and the vehicle type he might be in, open or close a cTab device as Main interface.
  No Parameters
  Returns TRUE when action was taken (interface opened or closed)
  Returns FALSE when no action was taken (i.e. player has no cTab device / is not in cTab enabled vehicle)

  (previously in player_init.sqf)
*/
if (cTabIfOpenStart) exitWith {false};
_previousInterface = "";
if (cTabUavViewActive) exitWith {
  objNull remoteControl (gunner cTabActUav);
  vehicle cTab_player switchCamera 'internal';
  cTabUavViewActive = false;
  call cTab_fnc_onIfTertiaryPressed;
  true
};
if (!isNil "cTabIfOpen" && {cTabIfOpen # 0 == 0}) exitWith {
  // close Main
  call cTab_fnc_close;
  true
};
if !(isNil "cTabIfOpen") then {
  _previousInterface = cTabIfOpen # 1;
  // close Secondary / Tertiary
  call cTab_fnc_close;
};

_player = cTab_player;
_vehicle = vehicle _player;
_interfaceName = call {
  if ([_player,_vehicle,"TAD"] call cTab_fnc_unitInEnabledVehicleSeat) exitWith {
    cTabPlayerVehicleIcon = getText (configOf _vehicle/"Icon");
    "cTab_TAD_dsp"
  };
  if ([_player,ctab_core_androidDevices] call cTab_fnc_checkGear) exitWith {"cTab_Android_dsp"};
  if ([_player,ctab_core_dagrDevices] call cTab_fnc_checkGear) exitWith {
    cTabMicroDAGRmode = if ([_player,ctab_core_tabDevices] call cTab_fnc_checkGear) then {0} else {2};
    "cTab_microDAGR_dsp"
  };
  if ([_player,_vehicle,"FBCB2"] call cTab_fnc_unitInEnabledVehicleSeat) exitWith {"cTab_FBCB2_dlg"};
  if ([_player,ctab_core_tabDevices] call cTab_fnc_checkGear) exitWith {"cTab_Tablet_dlg"};
  // default
  ""
};

//- Exit if can't show ATAK Side Display
if (_interfaceName == "cTab_Android_dsp" && !BCE_cTab_Side_Display) exitWith {
  false
};

if (
  _interfaceName != "" && 
  _interfaceName != _previousInterface
) exitWith {
  // queue the start up of the interface as we might still have one closing down
  [{
    if (isNil "cTabIfOpen") then {
      [_this # 1] call CBA_fnc_removePerFrameHandler;
      (_this # 0) call cTab_fnc_open;
    };
  },0,[0,_interfaceName,_player,_vehicle]] call CBA_fnc_addPerFrameHandler;
  true
};

false