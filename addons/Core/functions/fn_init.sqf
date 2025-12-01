#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_main_fn_init
Description:
		Init for the mod.

Parameters:
		_param  - Parameter description <OBJECT>

Returns:
		Return description <NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params [];
TRACE_1("fnc_init",_this);

#define getOpticVars ([_unit,0] call BCE_fnc_Check_Optics)

//HUD Compass
["cameraView", BCE_fnc_call_Compass, true] call CBA_fnc_addPlayerEventHandler;
["vehicle", BCE_fnc_SetMFDValue, true] call CBA_fnc_addPlayerEventHandler;
["AllVehicles","GetIn",{(_this # 0) call BCE_fnc_Check_Optics}] call CBA_fnc_addClassEventHandler;
["Helicopter","GetOut",{
	params ["", "", "_unit"];
	private _laser = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	private _light = _unit getVariable ["BCE_turret_Gunner_Lights",[]];

	if (_laser isNotEqualTo []) then {
		_unit call BCE_fnc_deleteGunnerLaserSources;
	};
	if (_light isNotEqualTo []) then {
		_unit call BCE_fnc_deleteGunnerLightSources;
	};
}] call CBA_fnc_addClassEventHandler;

//ACE Actions
call BCE_fnc_ACE_actions;

//-Debug on MP initiation
if (isMultiplayer) then {
	vehicles apply {_x call BCE_fnc_Check_Optics};
};

//////////////////////////////////////////////////////////////////////////////////////////////////
//PostInit Perf_EH
call BCE_fnc_ClientSide;

//- #SECTION - Eventhandlers for TGP View (ON, OFF)
	[ //- Register TGP view for "CBA_fnc_getActiveFeatureCamera"
    "BCE_TGP_camera",
		{(missionNamespace getVariable ["TGP_View_Camera",[]]) isNotEqualTo []}
	] call CBA_fnc_registerFeatureCamera;

	["BCE_TGP_View_Changed", {
		
		params ["_unit","_TGP_vehicle","_turnOn"];
		[BCE_fnc_hearingProtection, _turnOn] call CBA_fnc_execNextFrame;

	}] call CBA_fnc_addEventHandler;
//- #!SECTION

//- #SECTION - Init Task/Mission Builder Items
	[] call BCE_fnc_getTaskProps;
	[] call BCE_fnc_get_TaskMapInfoEntry;

//- Task/Mission Builder Events : from "Mission_Property.hpp"
	private _event_Func = getArray (configFile >> "BCE_Mission_Property" >> "Event_Functions");
	// Set Eventhandler API
	{
		/*
			"Opened",
			"Enter",
			"Clear"
		*/
		[
			"BCE_TaskBuilding_" + _x, 
			uiNamespace getVariable ("BCE_fnc_TaskEvent_" + _x)
		] call CBA_fnc_addEventHandler;
	} forEach _event_Func;

	//- #NOTE - This is for saving the mission data that is ready to be processed/Executed
	//- #TODO - Add this event for CAS (9-lines, 5-Lines)
		{
			[
				format ["BCE_%1_Mission", _x], 
				uiNamespace getVariable format ["BCE_fnc_%1_Task_Event", _x]
			] call CBA_fnc_addEventHandler;
		} forEach ["Send","Delete","Record","RequestTasks","RespondTasks"];
//- #!SECTION
//////////////////////////////////////////////////////////////////////////////////////////////////
["turret", {
	params ["_unit", "_turret", "_turretPrev"];
	if (_unit getVariable ["BCE_turret_Gunner_Lights",[]] isNotEqualTo []) then {
		_unit call BCE_fnc_deleteGunnerLightSources;
	};
	if (_unit getVariable ["BCE_turret_Gunner_Laser",[]] isNotEqualTo []) then {
		_unit call BCE_fnc_deleteGunnerLaserSources;
	};
},true] call CBA_fnc_addPlayerEventHandler;

//- When Camera Changed (ex. Zeus, Spectator)
["featureCamera", {
	params ["_unit","_mode"];
	TRACE_1("featureCamera",_this);

	private _isTGP_Mode = _mode == "BCE_TGP_camera";
	private _isTGP_Exist = TGP_View_Camera isNotEqualTo [];

	if (!_isTGP_Mode && _isTGP_Mode_Exist) then {
		call BCE_fnc_Cam_Delete;
	 	[2] call BCE_fnc_OpticMode;
	};

	if (_isTGP_Mode) then {
		//- #NOTE : Fire CBA_EH "BCE_TGP_View_Changed" 
			[
				"BCE_TGP_View_Changed",
				[
					_unit,
					(_unit getVariable "TGP_View_Selected_Optic") # 1,
					_isTGP_Exist
				]
			] call CBA_fnc_LocalEvent;
	};
}] call CBA_fnc_addPlayerEventHandler;

//Delete
["All", "Deleted", {
	params["_unit"];

	//IR Lasers
	if ((_unit getVariable ["IR_LaserLight_Source_Inf",objNull]) isNotEqualTo objNull) then {
		deleteVehicle (_unit getVariable "IR_LaserLight_Source_Inf");
		//_unit setVariable ["IR_LaserLight_Source_Inf",objNull,true];
	};
	if ((_unit getVariable ["IR_LaserLight_Source_Air",[]]) isNotEqualTo []) then {
		(_unit getVariable "IR_LaserLight_Source_Air") apply {deleteVehicle _x};
		//_unit setVariable ["IR_LaserLight_Source_Air",[],true];
	};

	//TGP View
	if (([nil,"AIR" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit) isEqualTo _unit) then {
		[objNull] call BCE_fnc_set_TaskCurUnit;
		player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];

		if (TGP_View_Camera isNotEqualTo []) then {
			camUseNVG false;
			call BCE_fnc_Cam_Delete;
			[2] call BCE_fnc_OpticMode;
		};
	};

	//Doorgunner
	if (getOpticVars isNotEqualTo []) then {
		(crew _unit) apply {
			if (_x getVariable ["BCE_turret_Gunner_Lights",[]] isNotEqualTo []) then {
				 _x call BCE_fnc_deleteGunnerLightSources;
			};
			if (_x getVariable ["BCE_turret_Gunner_Laser",[]] isNotEqualTo []) then {
				 _x call BCE_fnc_deleteGunnerLaserSources;
			};
		};
	};
}] call CBA_fnc_addClassEventHandler;
