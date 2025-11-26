/*
	Name: cTab_fnc_deleteHelmetCam
	
	Author(s):
		Gundy

	Description:
		Delete helmet camera
	
	Parameters:
		NONE
	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		call cTab_fnc_deleteHelmetCam;

*/

private ["_cam"];

if !(isNil "cTabHcams") then {
	_cam = cTabHcams # 0;
	_cam cameraEffect ["TERMINATE","BACK"];
	camDestroy _cam;
	cTabHcams = nil;
};

true
