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

private ["_cam","_camToDelete","_i"];

//private _camToDelete = [objNull,_this # 0] select (count _this == 1);

// remove cameras
/* for "_i" from (count cTabUAVcams -1) to 0 step -1 do {
	_cam = cTabUAVcams # _i # 1;
	if (isNull _camToDelete || {_cam == _camToDelete}) then {
		0 = cTabUAVcams deleteAt _i;
		_cam cameraEffect ["TERMINATE","BACK"];
		camDestroy _cam;
	};
}; */
cTabUAVcams apply {
	_cam = _x # 1;
	_cam cameraEffect ["TERMINATE","BACK"];
	camDestroy _cam;
};
cTabUAVcams = [];
cTabActUav = cTab_player;
// remove camera direction update event handler if no more cams are present
if (count cTabUAVcams == 0) then {
	private _EH = cTab_player getVariable ["cTab_TGP_View_EH",-1];
	private _display = uiNamespace getVariable (cTabIfOpen # 1);
	(_display displayctrl 20114) ctrlSetStructuredText parseText "";
	lbClear (_display displayCtrl 1775);
	lbClear (_display displayCtrl 20116);
	if (_EH != -1) then {
		removeMissionEventHandler ["Draw3D",_EH];
		cTab_player setVariable ["cTab_TGP_View_EH",-1];
	};
};

true
