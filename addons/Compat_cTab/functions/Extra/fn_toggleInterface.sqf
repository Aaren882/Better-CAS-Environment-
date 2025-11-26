params ["_interfaceType", "_interfaceName", "_player", "_vehicle"];

if (cTabIfOpenStart) exitWith {false};

if (cTabUavViewActive) then {
  objNull remoteControl (gunner cTabActUav);
  vehicle cTab_player switchCamera 'internal';
  cTabUavViewActive = false;
};

private _previousInterface = "";

if !(isNil "cTabIfOpen") then {
  _previousInterface = cTabIfOpen # 1;
  call cTab_fnc_close;
};

//- Exit if can't show ATAK Side Display
if (_interfaceName == "cTab_Android_dsp" && !BCE_cTab_Side_Display) exitWith {
  false
};

if (_interfaceName == "cTab_TAD_dsp" || _interfaceName == "cTab_TAD_dlg") then {
  cTabPlayerVehicleIcon = getText (configOf _vehicle/"Icon");
} else {
  if (_interfaceName == "cTab_microDAGR_dsp" || _interfaceName == "cTab_microDAGR_dlg") then {
    TabMicroDAGRmode = [2,0] select ([_player,ctab_core_tabDevices] call cTab_fnc_checkGear);
  };
};

if (_interfaceName != "" && _interfaceName != _previousInterface) exitWith {

  [{
    if (isNil "cTabIfOpen") then {
      [_this # 1] call CBA_fnc_removePerFrameHandler;
      (_this # 0) call cTab_fnc_open;
    };
  },0,[_interfaceType,_interfaceName,_player,_vehicle]] call CBA_fnc_addPerFrameHandler;
  true
};

false
