/*
 	Name: cTab_fnc_createHelmetCam
 	
 	Author(s):
		Gundy, Riouken

 	Description:
		Set up helmet camera and display on supplied render target
	
	Parameters:
		0: STRING - Render target
		1: STRING - Name of unit with helmet camera (format used from `str unitObject`)
 	
 	Returns:
		OBJECT - helmet cam be set up to
 	
 	Example:
		["rendertarget12",str player] call cTab_fnc_createHelmetCam;
*/

private ["_renderTarget","_data","_newHost","_camOffSet","_oldCam","_oldHost","_target","_cam"];
params ["_renderTarget","_data",["_usePIP",true]];

//- Exit on Empty
if (_data == "") exitWith {objNull};

_newHost = objNull;
_camOffSet = [];

// see if given unit name is still in the list of units with valid helmet cams
{
	if (_data == str _x) exitWith {_newHost = _x;};
} count cTabHcamlist;

if !(_usePIP) exitWith {_newHost};

call {
	// should unit not be in a vehicle
	if (vehicle _newHost isKindOf "CAManBase") exitWith {
		_camOffSet = [0.12,0,0.15];
	};
	// if unit is in a vehilce, see if 3rd person view is allowed
	if (difficultyEnabled "3rdPersonView") exitWith {
		_newHost = vehicle _newHost;
		// Might want to calculate offsets based on the actual vehicle dimensions in the future
		_camOffSet = [0,-8,4];
	};
	// if unit is in a vehicle and 3rd person view is not allowed
	_newHost = objNull;
};

// if there is no valid unit or we are not allowed to set up a helmet cam in these conditions, drop out of full screen view
if (IsNull _newHost) exitWith {
	["cTab_Tablet_dlg",[["mode","HCAM"]]] call cTab_fnc_setSettings;
	_newHost
};

// if there is already a camera, see if its the same one we are about to set up
// if true, render to given target (in case the target has changed), else delete the camera so we can create a new one
if (!isNil "cTabHcams") then {
  cTabHcams params ["_oldCam","_oldHost"];
	if (_oldHost isEqualTo _newHost) then {
		_oldCam cameraEffect ["INTERNAL","BACK",_renderTarget];
	} else {
		call cTab_fnc_deleteHelmetCam;
	};
};

// only continue if there is no helmet cam currently set up
if (!isNil "cTabHcams") exitWith {cTabHcams # 1};

_cam = "camera" camCreate getPosATL _newHost;
_cam camPrepareFov 0.700;
_cam camCommitPrepared 0;
if (vehicle _newHost == _newHost) then {
	_cam attachTo [_newHost,_camOffSet,"Head",true];
} else {
	_cam attachTo [_newHost,_camOffSet];
};
_cam cameraEffect ["INTERNAL","BACK",_renderTarget];

cTabHcams = [_cam,_newHost];

_newHost
