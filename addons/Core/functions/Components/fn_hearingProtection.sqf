#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_hearingProtection
Description:
		Use for "TGP view" hearing protection.

Parameters:
		_turnOn  - _turnOn hearing protection <BOOL>

Returns:
		<NONE>

Examples
		(begin example)
				true call BCE_fnc_hearingProtection
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_turnOn"];
TRACE_1("fn_hearingProtection (_turnOn)",_turnOn);

if (missionNamespace getVariable ["ace_hearing_enableCombatDeafness",false]) exitWith {

	BCE_have_ACE_earPlugs = !(ACE_Player getVariable ["ACE_hasEarPlugsin", false]);
	ACE_Player setVariable ["ACE_hasEarPlugsIn", BCE_have_ACE_earPlugs && _turnOn, true];

	[true] call ace_hearing_fnc_updateVolume;
	[] call ace_hearing_fnc_updateHearingProtection;
};

if (_turnOn) exitWith {
	0.75 fadeSound 0.1;
};

1.5 fadeSound 1;
