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
	private _noCharge = _chargeInfo findIf {true} < 0;

private _isMsger = ["CFF_MSGER", false, _taskUnit] call BCE_fnc_get_CFF_Value;
private _turretPath = (assignedVehicleRole _gunner) # 1;
private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

// private _gunAnim = getText(_turretConfig >> "gun");
private _gunBeg = getText(_turretConfig >> "gunBeg");
private _gunEnd = getText(_turretConfig >> "gunEnd");
private _last_aimDir = 0;

while {!_noCharge} do {
	///- Get Mission Infos
		private _CFF_info = _taskUnit call BCE_fnc_getCurUnit_CFF;

	// Make unit aim.
		(gunner _taskUnit) doWatch _pos;

	// Calculate the vertical angle of the unit by using triangle calculations.
		private _posA2 = _taskUnit modelToWorldWorld (_taskUnit selectionPosition _gunBeg);
		private _posC2 = _taskUnit modelToWorldWorld (_taskUnit selectionPosition _gunEnd);

	// Check if the unit is aiming with the correct angle.
		private _aimDir = (_posC2 vectorFromTo (AGLToASL _pos)) vectorDistance (_posC2 vectorFromTo _posA2);

	//- if _chargeFound Exit
	if (_aimDir < 0.1) then {
		
		//- Send ETA to FO
			if (
				_isMsger &&
				0 == count (["chargeInfo",[],_taskUnit] call BCE_fnc_get_CFF_Value)
			) then {
				[
					_taskUnit,
					format [localize "STR_BCE_CFF_MSG_ETA_SPLASH",round _ETA],
					"CFF_ETA_SPLASH"
				] call BCE_fnc_Send_Task_RadioMsg;
			};
		["chargeInfo",_chargeInfo,_taskUnit] call BCE_fnc_set_CFF_Value;

		sleep 10;
		//- Run Fire Mission
			[_taskUnit,_chargeInfo] call (uiNamespace getVariable [_CFF_info param [5,""],{}]);

		//- Exit Loop
		break;
	};

	//- Check ARTY Exist
		if (
			!alive _taskUnit ||
			_aimDir == _last_aimDir ||
			"" == (["CFF_MSN", "", _taskUnit] call BCE_fnc_get_CFF_Value)
		) then {
			_noCharge = true;
			break;
		};
	
	_last_aimDir = _aimDir;
	sleep 3;
};

//- check "_chargeInfo" exist
	if (_noCharge) exitWith {
		[_gunner, format [
			localize "STR_BCE_CFF_MSG_NO_CARGE",
			str groupId _taskUnit
		], "CFF_NO_CARGE"] call BCE_fnc_Send_Task_RadioMsg;

		_taskUnit removeEventHandler ["Fired", ["MSN_FIRE_EH", -1, _taskUnit] call BCE_fnc_get_CFF_Value];
		_taskUnit setVariable ["#CFF_MSN_Data", nil];
	};

nil