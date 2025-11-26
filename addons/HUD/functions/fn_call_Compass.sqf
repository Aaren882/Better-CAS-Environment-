#include "script_component.hpp"

params ["_player", "_cameraView"];
_Unit_veh = cameraon;

_condition = if ((count (allTurrets _Unit_veh) > 0) && !((_Unit_veh isKindOf "UAV") || (_Unit_veh isKindOf "UAV_01_base_F"))) then {
	private _turret = _Unit_veh unitTurret _player;
	if ((_turret # 0) < 0) then {
		true
	} else {
		!((getText ([_Unit_veh, _turret] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS)
	};
} else {
	true
};

if (
	(_condition) &&
	(_Unit_veh iskindof "Air") &&
	((_player getVariable ["AHUD_Actived",-1]) == -1) &&
	(_cameraView == "GUNNER") &&
	((_player getVariable ["TGP_View_EHs",-1]) == -1)
) then {

	//- If is on Pilot seat + Has PilotCamera
	private _getTargetVeh = [{
		private _return = _vehicle lockedCameraTo (_vehicle unitTurret _player);
		[objNull, _return] select (_return isEqualType objNull);
	}, {
		(getPilotCameraTarget _vehicle) # 2
	}] select (driver _Unit_veh == _player && hasPilotCamera _Unit_veh);

	_AHUD_PFH = addMissionEventHandler ["Draw3D", {
		_thisArgs params ["_vehicle","_player","_getTargetVeh"];
		
		//Draw Compass
		if (cameraOn == _vehicle) then {
			if ((_vehicle call BCE_fnc_filtered_compass) && (_player getVariable ["TGP_view_3D_Compass",true]) && (BCE_compass_fn)) then {
				private _objVeh = call _getTargetVeh;
				call BCE_fnc_3DCompass;
			};

			_time = _player getVariable ["TGP_View_MapIcons_last",-1];
			_alpha = abs (1 min _time);
			if ((_time != -1) && (BCE_Mapicon_fn)) then {
				call BCE_fnc_map_Icon;
			};
			if ((_player getVariable ["TGP_view_LandMark_Icon",true]) && (BCE_Landmarks_fn)) then {
				call BCE_fnc_LandMarks_icon;
			};

			_cam = _vehicle;

			//Update UnitList
			if (missionNamespace getVariable ["TGP_View_Unit_List_update", -1] <= time) then {
				call BCE_fnc_TGP_UnitList;
				missionNamespace setVariable ["TGP_View_Unit_List_update", time+1];
			};

			if (count TGP_View_Unit_List > 0) then {
				_boxActive = BCE_UnitTrack_fn;
				_friendlyActive = BCE_FriendlyTrack_fn;
				call BCE_fnc_Unit_Icon;
			};
		};

		if (BCE_touchMark_fn) then {
			call BCE_fnc_touchMark;
		};

		//-Exit
		if ((cameraView != "GUNNER") || (cameraon isEqualTo _player)) then {
			removeMissionEventHandler ["Draw3D", _thisEventHandler];
			_player setVariable ["AHUD_Actived",-1,true];
		};

	}, [_Unit_veh,_player,_getTargetVeh]];
	_player setVariable ["AHUD_Actived",_AHUD_PFH,true];
};
