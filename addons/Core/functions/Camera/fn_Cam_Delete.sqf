#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_Cam_Delete
Description:
		Delete TGP Camera.

Parameters:
		<NONE>

Returns:
		<NONE>

Examples
		(begin example)
				call BCE_fnc_Cam_Delete
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */
TRACE_1("fn_Cam_Delete",TGP_View_Camera);

TGP_View_Camera params ["_cam","_ppEffect"];

if (isNull curatorCamera) then {
	_cam cameraEffect ["Terminate", "back"];
	camDestroy _cam;
	cutText ["", "BLACK IN",0.5];
};

camUseNVG false;
ppEffectDestroy _ppEffect;
("BCE_TGP_View_GUI" call BIS_fnc_rscLayer) cutRsc ["default","PLAIN"];

private _current_EH = player getVariable "TGP_View_EHs";
removeMissionEventHandler ["Draw3D", _current_EH];

player setVariable ["TGP_View_EHs",-1,true];
TGP_View_Camera = [];

if !(isNull findDisplay 1022553) then {
	closedialog 1022553;
	player setVariable ["TGP_view_Mouse_Cursor",false];
};
