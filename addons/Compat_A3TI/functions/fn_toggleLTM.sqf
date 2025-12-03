/*
	Author: Lala14

	Function:
		A3TI_fnc_toggleLTM

	Description:
	Toggles on unit if their LTM is on or off

	Parameter(s):
	NONE

	Returns:
	NONE
*/

_unit = call A3TI_fnc_getCurrentControlledUnit;

if (
	isNull _unit || (
		BCE_AUTO_LTM_A3TI_fn &&
		1 != count _this
	)
) exitWith {};

_isLTMon = !isNil {_unit getVariable ["A3TI_LTM_StartTime",nil]};
_curVehConfig = call A3TI_fnc_getPlayerTurret;
_lastVehConfig = (_unit getVariable ["A3TI_LTM_currentTurretConfig",configNull]);
_param = [!_isLTMon,_this # 0] select BCE_AUTO_LTM_A3TI_fn;

if (_param) then {
	if (
		((vehicle _unit isKindOf "Plane") || (vehicle _unit isKindOf "UAV") || (vehicle _unit isKindOf "Helicopter")) && 
		!(vehicle _unit isKindOf "LandVehicle")
	) then {
		_unit setVariable ["A3TI_LTM_StartTime",time,true];
		if ((isNull(_lastVehConfig)) || !(_lastVehConfig isEqualTo _curVehConfig)) then {
			_unit setVariable ["A3TI_LTM_currentTurretConfig",call A3TI_fnc_getPlayerTurret,true];
			_unit setVariable ["A3TI_LTM_Mode", 0, true];
		};
		//_unit setVariable ["A3TI_LTM_Mode"]
	};
} else {
	_unit setVariable ["A3TI_LTM_StartTime",nil,true];
	//_unit setVariable ["A3TI_LTM_currentTurretConfig",nil,true];
};
