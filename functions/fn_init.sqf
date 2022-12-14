#define getOpticVars _unit getVariable ["TGP_View_Available_Optics",[]]
#define have_ACE (isClass(configFile >> "CfgPatches" >> "ace_hearing"))

//HUD Compass
["cameraView", BCE_fnc_call_Compass, true] call CBA_fnc_addPlayerEventHandler;
["vehicle", BCE_fnc_SetMFDValue, true] call CBA_fnc_addPlayerEventHandler;
["Air","GetIn",BCE_fnc_Check_Optics] call CBA_fnc_addClassEventHandler;
["Helicopter","GetOut",{
	params ["_vehicle", "_role", "_unit", "_turret"];
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

//////////////////////////////////////////////////////////////////////////////////////////////////
//PostInit Perf_EH
player setVariable ["Have_BCE_Loaded",true,true];
if (({(_x getVariable ["IR_LaserLight_EachFrame_EH",-1]) != -1} count allPlayers) == 0) then {
	call BCE_fnc_perf_EH;
} else {
	call BCE_fnc_ClientSideLaser;
};

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

		if (have_ACE) then {
		  if !(BCE_have_ACE_earPlugs) then {
		    player setVariable ["ACE_hasEarPlugsIn", false, true];
		    [[true]] call ace_hearing_fnc_updateVolume;
		    [] call ace_hearing_fnc_updateHearingProtection;
		  };
		} else {
		  1.5 fadeSound 1;
		};

		_current_EH = player getVariable "TGP_View_EHs";
		removeMissionEventHandler ["Draw3D", _current_EH];

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
		player setVariable ["TGP_View_Selected_Optic",[]];

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
