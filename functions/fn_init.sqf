#define getOpticVars ([_unit,0] call BCE_fnc_Check_Optics)

//HUD Compass
["cameraView", BCE_fnc_call_Compass, true] call CBA_fnc_addPlayerEventHandler;
["vehicle", BCE_fnc_SetMFDValue, true] call CBA_fnc_addPlayerEventHandler;
["AllVehicles","GetIn",(_this # 0) call BCE_fnc_Check_Optics] call CBA_fnc_addClassEventHandler;
["Helicopter","GetOut",{
	params ["", "", "_unit"];
	private _laser = _unit getVariable ["BCE_turret_Gunner_Laser",[]];
	private _light = _unit getVariable ["BCE_turret_Gunner_Lights",[]];

	if !(_laser isEqualTo []) then {
		_unit call BCE_fnc_deleteGunnerLaserSources;
	};
	if !(_light isEqualTo []) then {
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
/* if (BCE_SYSTEM_Handler == "") then {
	call BCE_fnc_ServerClientSide;
} else {
	call BCE_fnc_ClientSide;
}; */

["turret", {
	params ["_unit", "_turret", "_turretPrev"];
	if !(_unit getVariable ["BCE_turret_Gunner_Lights",[]] isEqualTo []) then {
		 _unit call BCE_fnc_deleteGunnerLightSources;
	};
	if !(_unit getVariable ["BCE_turret_Gunner_Laser",[]] isEqualTo []) then {
		 _unit call BCE_fnc_deleteGunnerLaserSources;
	};
},true] call CBA_fnc_addPlayerEventHandler;

["featureCamera", {
	params ["_unit","_mode"];
	if (!(_mode isEqualTo "") && !(TGP_View_Camera isEqualTo [])) then {
    camUseNVG false;
		ppEffectDestroy (TGP_View_Camera # 1);

		556 cutRsc ["default","PLAIN"];
		cutText ["", "BLACK IN",0.5];

		#if __has_include("\z\ace\addons\hearing\config.bin")
		  if !(BCE_have_ACE_earPlugs) then {
		    player setVariable ["ACE_hasEarPlugsIn", false, true];
		    [[true]] call ace_hearing_fnc_updateVolume;
		    [] call ace_hearing_fnc_updateHearingProtection;
		  };
		#else
		  1.5 fadeSound 1;
		#endif

		removeMissionEventHandler [_thisEvent, _thisEventHandler];

		player setVariable ["TGP_View_EHs",-1,true];
		//TGP_View_Camera = [];

    [2] call BCE_fnc_OpticMode;
	};
},true] call CBA_fnc_addPlayerEventHandler;

//Delete
["All", "Deleted", {
	params["_unit"];

	//IR Lasers
	if !((_unit getVariable ["IR_LaserLight_Source_Inf",objNull]) isEqualTo objNull) then {
		deleteVehicle (_unit getVariable "IR_LaserLight_Source_Inf");
		//_unit setVariable ["IR_LaserLight_Source_Inf",objNull,true];
	};
	if !((_unit getVariable ["IR_LaserLight_Source_Air",[]]) isEqualTo []) then {
	  (_unit getVariable "IR_LaserLight_Source_Air") apply {deleteVehicle _x};
		//_unit setVariable ["IR_LaserLight_Source_Air",[],true];
	};

	//TGP View
	if ((player getvariable ["TGP_View_Selected_Vehicle",objNull]) isEqualTo _unit) then {
		player setVariable ["TGP_View_Selected_Vehicle",objNull];
		player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];

		if !(TGP_View_Camera isEqualTo []) then {
			camUseNVG false;
			call BCE_fnc_Cam_Delete;
			[2] call BCE_fnc_OpticMode;
		};
	};

	//Doorgunner
	if !(getOpticVars isEqualTo []) then {
		(crew _unit) apply {
			if !(_x getVariable ["BCE_turret_Gunner_Lights",[]] isEqualTo []) then {
			   _x call BCE_fnc_deleteGunnerLightSources;
			};
			if !(_x getVariable ["BCE_turret_Gunner_Laser",[]] isEqualTo []) then {
			   _x call BCE_fnc_deleteGunnerLaserSources;
			};
		};
	};
}] call CBA_fnc_addClassEventHandler;
