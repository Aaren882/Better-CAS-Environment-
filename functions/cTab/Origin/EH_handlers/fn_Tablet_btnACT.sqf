params [["_info",""]];

//-Control Turret
if (_info isNotEqualTo "") exitWith {
  _vehicle = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
  _current_turret = ((cTab_player getVariable ["TGP_View_Selected_Optic",[["",[-1]],objNull]]) # 0) # 1;

  _condition = [
    ({!((_x getVariable ["TGP_View_Turret_Control", []]) isEqualTo [])} count (crew _vehicle)) > 0,
    (isUAVConnected _vehicle)
  ] select (unitIsUAV _vehicle);

  if (!(isnull _vehicle) && !(_condition) && ((_current_turret # 0) > -1)) then {
    //-delete PIP Cam && close TAD UI
    call cTab_fnc_deleteUAVcam;
    call cTab_fnc_close;

    [{
      params ["_vehicle"];
      [_vehicle,cameraview] call BCE_fnc_onButtonClick_Gunner;
      _vehicle call BCE_fnc_TGP_Select_Confirm;
    }, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
  } else {

    ["UAV","Unable to Control the Turret",5] call cTab_fnc_addNotification;
  };
};

////////////////////////////////////////////////////////////////////////////
_mode = [cTabIfOpen # 1,"mode"] call cTab_fnc_getSettings;

//-View Camera
_View_Cam = {
  private ["_vehicle","_current_turret"];

  _vehicle = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];

  if !(isnull _vehicle) then {
    //-delete PIP Cam && close TAD UI
    call cTab_fnc_deleteUAVcam;
    call cTab_fnc_close;
    [{
      params ["_vehicle"];
      _vehicle call BCE_fnc_TGP_Select_Confirm;
    }, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
  } else {
    ["UAV","None Vehicle Selected",5] call cTab_fnc_addNotification;
  };
};

switch _mode do {
  case "UAV": {
    call _View_Cam;
  };
  case "TASK_Builder": {
    call _View_Cam;
  };
  case "HCAM": {
    ["cTab_Tablet_dlg",[["mode","HCAM_FULL"]]] call cTab_fnc_setSettings;
  };
  case "HCAM_FULL": {
    ["cTab_Tablet_dlg",[["mode","HCAM"]]] call cTab_fnc_setSettings;
  };
};

true
