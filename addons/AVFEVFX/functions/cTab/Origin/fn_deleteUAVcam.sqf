/*
  Name: cTab_fnc_deleteUAVcam

  Author(s):
    Gundy

  Description:
    Delete UAV camera

  Parameters:
    Optional:
    0: OBJECT - Camera to delete

  Returns:
    BOOLEAN - TRUE

  Example:
    // delete all UAV cameras
    [] call cTab_fnc_deleteUAVcam;

    // delete a specific UAV camera
    [_cam] call cTab_fnc_deleteUAVcam;
*/
private ["_displayName","_display","_mode","_squad_list","_EH"];

_displayName = cTabIfOpen # 1;
_display = uiNamespace getVariable _displayName;

_mode = [_displayName,"mode"] call cTab_fnc_getSettings;
_squad_list = [20116,17000 + 1785] select (_mode == "TASK_Builder");

cTabUAVcams apply {
  private _cam = _x # 1;
  _cam cameraEffect ["TERMINATE","BACK"];
  camDestroy _cam;
};

cTabUAVcams = [];
cTabActUav = cTab_player;

// remove camera direction update event handler if no more cams are present
_EH = cTab_player getVariable ["cTab_TGP_View_EH",-1];
(_display displayctrl 20114) ctrlSetStructuredText parseText "";
lbClear (_display displayCtrl _squad_list);

if (_EH != -1) then {
  if (_EH > 0) then {
    removeMissionEventHandler ["Draw3D",_EH];
  };
  cTab_player setVariable ["cTab_TGP_View_EH",-1,true];
};

true
