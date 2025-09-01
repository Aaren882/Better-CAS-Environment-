/*
  NAME : BCE_fnc_doAim_CFF
*/

params[
	"_taskUnit",
	"_chargeInfo",
	["_initDelay", 2] //- #NOTE - needs Delay or the mission will stuck 
];

//- check "_chargeInfo" exist
	private _noCharge = _chargeInfo findIf {true} < 0;
	["CFF_Action", _thisScript, _taskUnit] call BCE_fnc_set_CFF_Value;
	// diag_log "--------------------------";
	// diag_log format ["doAim_CFF : _chargeInfo = %1", _chargeInfo];
	// diag_log format ["MSN_PROG = %1", ["MSN_PROG", 0, _taskUnit] call BCE_fnc_get_CFF_Value];

private _gunner = gunner _taskUnit;
private _isMsger = ["CFF_MSGER", false, _taskUnit] call BCE_fnc_get_CFF_Value;
private _turretPath = (assignedVehicleRole _gunner) # 1;
private _turretConfig = [_taskUnit, _turretPath] call CBA_fnc_getTurret;

private _gunBeg = getText(_turretConfig >> "gunBeg");
private _gunEnd = getText(_turretConfig >> "gunEnd");
private _last_aimDir = 0;

_chargeInfo params ["_charge", "_angleA", "_ETA", "_pos"];

while {!_noCharge} do {
	
	// Make unit aim. #NOTE - "doWatch" takes local OBJECT
		// _gunner doWatch _pos;
		[_gunner, _pos] remoteExecCall ["doWatch",_gunner,true];

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

		sleep _initDelay; //- #NOTE - 👈 Delay goes to here
		
		//- Run Fire Mission
			private _CFF_info = _taskUnit call BCE_fnc_getCurUnit_CFF;
			// diag_log format ["_CFF_info MOC : %1", _CFF_info param [5,""]];

			//- Make sure Fire mission is empty when the unit is REMOTE 😐
			waitUntil {
				//- FIRE !!!!
				[_taskUnit,_chargeInfo] call (uiNamespace getVariable [_CFF_info param [5,""],{}]);

				(-1 == ["MSN_PROG", -1, _taskUnit] call BCE_fnc_get_CFF_Value)
			};

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
		};
	
	sleep 10;
	_last_aimDir = _aimDir;
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