/*
  NAME : BCE_fnc_doAim_CFF
*/

// maxDifference = 0.15;	// Ideal number.
// maxDifference = 1;			// Number that works better with the AI aiming bugs, mainly the one where the AI takes a while to aim at low angle shots.
// #define MAX_DIFFERENCE 1
// #define TIMEOUT_SECONDS 40
params[
	"_taskUnit",
	"_chargeInfo"
];
_chargeInfo params ["_charge", "_angleA", "_ETA", "_pos"];

private _gunner = gunner _taskUnit;

//- check "_chargeInfo" exist
	if (_chargeInfo findIf {true} < 0) exitWith {
		[_gunner, format [
			localize "STR_BCE_CFF_MSG_NO_CARGE",
			str groupId _taskUnit
		], "CFF_NO_CARGE"] call BCE_fnc_Send_Task_RadioMsg;

		[["MSN_FIRE_EH","MSN_PROG"], nil,_taskUnit] call BCE_fnc_set_CFF_Value;
	};

private _turretPath = (assignedVehicleRole _gunner) # 1;
private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

private _gunAnim = getText(_turretConfig >> "gun");
private _gunBeg = getText(_turretConfig >> "gunBeg");
private _gunEnd = getText(_turretConfig >> "gunEnd");

while {true} do {
	
	//- Check ARTY Exist
	if (
		!alive _taskUnit ||
		"" == (["CFF_MSN", "", _taskUnit] call BCE_fnc_get_CFF_Value)
	) then {
		_taskUnit removeEventHandler ["Fired", ["MSN_FIRE_EH", -1, _taskUnit] call BCE_fnc_get_CFF_Value];
		[["MSN_FIRE_EH","MSN_PROG"], nil,_taskUnit] call BCE_fnc_set_CFF_Value;
		[_handlerID] call CBA_fnc_removePerFrameHandler;
		break;
	};
	
	///- Get Mission Infos
		private _CFF_info = _taskUnit call BCE_fnc_getCurUnit_CFF;

	//- Start with 0

	// Make unit aim.
		(gunner _taskUnit) doWatch _pos;
		_pos = AGLToASL _pos; //- Replace with ASL

	//- Check Vectors from _posUnit "VecUp" to "VecAim"
		// private _posUnit = getPosASLVisual _taskUnit;
		// private _vecToAim = _posUnit vectorFromTo _pos;
		// private _degVehToAim = 90 - acos (_vecToAim vectorCos (vectorUpVisual _taskUnit));

	// Calculate the vertical angle of the unit by using triangle calculations.
		private _posA2 = _taskUnit modelToWorldVisualWorld (_taskUnit selectionPosition _gunBeg);
		private _posC2 = _taskUnit modelToWorldVisualWorld (_taskUnit selectionPosition _gunEnd);

	//- Get Turrect ELEV
	// private _verDegrees = deg (_taskUnit animationPhase _gunAnim);

	// Find direction difference between the direction to the target and the direction of the unit.
	// If difference is too high, then skip this charge.
		// private _dirToTarget = _posUnit getDirVisual _pos;

		// private _aimDir = _posC2 getDirVisual _posA2;
		// private _diff = (_aimDir - _dirToTarget) % 180;
		// private _goodDir = abs _diff < 5; //- it's pointing correct direction.

	// Check if the unit is aiming with the correct angle.
		// private _difference = abs(_verDegrees - _degVehToAim);
	
		private _aimDir = (_posC2 vectorFromTo _pos) vectorDistance (_posC2 vectorFromTo _posA2);
	//- if _chargeFound Exit
	// private _chargeFound = _goodDir && _difference < MAX_DIFFERENCE;
	if (_aimDir < 0.1) exitWith {
		
		//- Send ETA to FO
			if (
				isformationLeader _taskUnit &&
				0 == count (["chargeInfo",[],_taskUnit] call BCE_fnc_get_CFF_Value)
			) then {
				[
					_taskUnit,
					format [localize "STR_BCE_CFF_MSG_ETA_SPLASH",round _ETA],
					"CFF_ETA_SPLASH"
				] call BCE_fnc_Send_Task_RadioMsg;
			};
		["chargeInfo",_chargeInfo,_taskUnit] call BCE_fnc_set_CFF_Value;

		//- Run Fire Mission
			[
				uiNamespace getVariable [_CFF_info param [5,""],{}],
				[_taskUnit,_chargeInfo]
			] call CBA_fnc_execNextFrame;

		//- Exit Loop
		// [_handlerID] call CBA_fnc_removePerFrameHandler;
		break;
	};

	sleep 1;
};
/* [
	{
		params ["_args","_handlerID"];
		_args params[
			"_taskUnit",
			"_chargeInfo",
			"_cfgProps"
		];

		if (
			
		) exitWith {
			
		};

		_cfgProps params ["_gunAnim","_gunBeg","_gunEnd"];

		

	}, 1, [
		_taskUnit,
		_chargeInfo, [
			getText(_turretConfig >> "gun"),
			getText(_turretConfig >> "gunBeg"),
			getText(_turretConfig >> "gunEnd")
		]
	]
] call CBA_fnc_addPerFrameHandler; */