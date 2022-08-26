#define getOpticVars _unit getVariable ["TGP_View_Available_Optics",[]]

//HUD Compass
["cameraView", {_this spawn BCE_fnc_call_Compass}, true] call CBA_fnc_addPlayerEventHandler;
["vehicle", {call BCE_fnc_SetMFDValue}, true] call CBA_fnc_addPlayerEventHandler;
["Air","GetIn",BCE_fnc_Check_Optics] call CBA_fnc_addClassEventHandler;

//ACE Actions
call BCE_fnc_ACE_actions;

//////////////////////////////////////////////////////////////////////////////////////////////////
//PostInit Perf_EH
if ((player getVariable ["IR_LaserLight_EachFrame_EH",-1]) == -1) then {
	player call BCE_fnc_perf_EH;
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

//LaserDesignator
["visionMode", {
	params ["_unit", "_visionMode", "_visionModePrev"];

	if (_visionMode == 2) then {
		if ((player getVariable ["IR_LaserLight_EachFrame_EH",-1]) != -1) then {
			removeMissionEventHandler ["EachFrame",(player getVariable ["IR_LaserLight_EachFrame_EH",-1])];
			player setVariable ["IR_LaserLight_EachFrame_EH",-1];
			IR_LaserLight_UnitList = [];
			(allUnits + vehicles) apply {
				call BCE_fnc_delete;
			};
		};
	} else {
		//Sustainable EH
		if ((player getVariable ["IR_LaserLight_EachFrame_EH",-1]) == -1) then {
			_unit call BCE_fnc_perf_EH;
		};
	};
},true] call CBA_fnc_addPlayerEventHandler;

["featureCamera", {
	params ["_unit","_mode"];
	if (!(_mode isEqualTo "") && !((player getVariable ["TGP_View_Camera", []]) isEqualTo [])) then {
    camUseNVG false;
		
		ppEffectDestroy (player getVariable "TGP_View_Camera") # 1;

		556 cutRsc ["default","PLAIN"];
		cutText ["", "BLACK IN",0.5];

		1.5 fadeSound 1;

		_current_EH = player getVariable "TGP_View_EHs";
		removeMissionEventHandler ["Draw3D", _current_EH];

		player setVariable ["TGP_View_EHs",-1];
		player setVariable ["TGP_View_Camera", []];

    [2] call BCE_fnc_OpticMode;
	};
},true] call CBA_fnc_addPlayerEventHandler;

//Delete
["All", "Deleted", {
	params["_unit"];

	//IR stuffs
	if !(_unit getVariable ["IR_LaserLight_Souce_Inf",objNull] isEqualTo objNull) then {
		deleteVehicle (_unit getVariable "IR_LaserLight_Souce_Inf");
	};
	if !(_unit getVariable ["IR_LaserLight_Souce_Air",[]] isEqualTo []) then {
	  (_unit getVariable "IR_LaserLight_Souce_Air") apply {deleteVehicle _x};
		_unit setVariable ["IR_LaserLight_Souce_Air",[]];
	};


	//TGP View
	if ((player getvariable ["TGP_View_Selected_Vehicle",objNull]) isEqualTo _unit) then {
		player setvariable ["TGP_View_Selected_Vehicle",objNull];
		player setVariable ["TGP_View_Selected_Optic",[]];

		if !((player getVariable ["TGP_View_Camera", []]) isEqualTo []) then {
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
