#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_GunShip_Loiter
Description:
		Handles Gunship Loitering behavior over a target position.

Parameters:
		_vehicle - gunship object
		_posTarget - target position to loiter over
		_ATK_range - radius of the loiter circle # DEFAULT: 1500m
		_ATK_height - altitude for loitering

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_vehicle","_posTarget",["_ATK_range",1500],"_ATK_height"];
TRACE_1("fn_GunShip_Loiter",_this);

if (!canMove _vehicle || !alive driver _vehicle || fuel _vehicle == 0) exitWith {};

private ["_grp","_WP01","_shooter","_allWps"];

_grp = group effectiveCommander _vehicle;
_WP01 = [_grp, currentWaypoint _grp];
_shooter = _vehicle turretUnit _WPN_turret;

if (waypointType _WP01 != "LOITER") then {
	_allWps = waypoints _grp;
	_allWps apply {deleteWaypoint _x};
	_WP01 = _grp addWaypoint [_posTarget, 0];
	_WP01 setWaypointType "Loiter";
} else {
	_WP01 setWaypointPosition [_posTarget, 0];
};
_WP01 setWaypointLoiterType "CIRCLE_L";
_WP01 setWaypointLoiterRadius _ATK_range;
_vehicle setCollisionLight false;
_vehicle setPilotLight false;

_vehicle flyInHeight _ATK_height;

_grp allowFleeing 0;
_vehicle disableAI "TARGET";
_vehicle disableAI "AUTOTARGET";
