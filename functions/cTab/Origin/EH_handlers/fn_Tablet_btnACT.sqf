params [["_info",""]];

//-Control Turret
if (_info isNotEqualTo "") exitWith {
  private ["_vehicle","_current_turret","_condition"];
  _vehicle = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];

  if (isNull _vehicle) exitWith {
    ["UAV",localize "STR_BCE_Error_Vehicle",5] call cTab_fnc_addNotification;
  };

  _current_turret = ((cTab_player getVariable ["TGP_View_Selected_Optic",[["",[-1]],objNull]]) # 0) # 1;

  _condition = [
    false,
    (isUAVConnected _vehicle) && (((UAVControl _vehicle) # 0) isNotEqualTo cTab_player)
  ] select (unitIsUAV _vehicle);

  if (
    !(isnull _vehicle) &&
    !(_condition) &&
    ((_current_turret # 0) > -1) &&
    ({!((_x getVariable ["TGP_View_Turret_Control", []]) isEqualTo [])} count (crew _vehicle) == 0) &&
    !((getText ([_vehicle, _current_turret] call BIS_fnc_turretConfig >> "turretInfoType")) in ["","RscWeaponZeroing"])
  ) then {
    //-delete PIP Cam && close TAD UI
    call cTab_fnc_deleteUAVcam;
    call cTab_fnc_close;

    [{
      params ["_vehicle"];
      [_vehicle,cameraview] call BCE_fnc_onButtonClick_Gunner;
      _vehicle call BCE_fnc_TGP_Select_Confirm;
    }, [_vehicle], 0.1] call CBA_fnc_WaitAndExecute;
  } else {

    ["UAV",localize "STR_BCE_Error_ControlTurret",5] call cTab_fnc_addNotification;
  };
};

////////////////////////////////////////////////////////////////////////////
private _displayName = cTabIfOpen # 1;
private _mode = [_displayName,"mode"] call cTab_fnc_getSettings;

//-Live Feed
private _View_Cam = {
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
    ["UAV",localize "STR_BCE_Error_Vehicle",5] call cTab_fnc_addNotification;
  };
};

//-ATAK
if ("Android" in _displayName) exitWith {
  _mode = ([_displayName, "showMenu"] call cTab_fnc_getSettings) # 0;
  switch _mode do {
    default {
      call _View_Cam;
    };
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
