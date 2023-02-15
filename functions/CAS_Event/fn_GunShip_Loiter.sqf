params ["_vehicle","_posTarget",["_ATK_range",1500]];

if (!canMove _vehicle || !alive driver _vehicle || fuel _vehicle == 0) exitWith {};

private _grp = group effectiveCommander _vehicle;
private _WP01 = [_grp, currentWaypoint _grp];
private _shooter = _vehicle turretUnit _WPN_turret;

if (waypointType _WP01 != "LOITER") then {
	private _allWps = waypoints _grp;
	reverse _allWps;
	{deleteWaypoint _x} forEach _allWps;
	_WP01 = _grp addWaypoint [_posTarget, 0];
	_WP01 setWaypointType "Loiter";
} else {
	_WP01 setWaypointPosition [_posTarget, 0];
};
_WP01 setWaypointLoiterType "CIRCLE_L";
_WP01 setWaypointLoiterRadius _ATK_range;
_vehicle setCollisionLight false;
_vehicle setPilotLight false;

_vehicle flyInHeight 1000;

_grp allowFleeing 0;
_vehicle disableAI "TARGET";
_vehicle disableAI "AUTOTARGET";
