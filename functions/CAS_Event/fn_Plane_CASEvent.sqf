params ["_vehicle",["_IP_POS",[]],"_FAD_POS","_posTarget","_EGRS","_weaponInfo","_taskVar","_type"];
_weaponInfo params ["_WPNclass","_WPN_Mode","_WPN_turret","_WPN_count","_muzzle","_ATK_range","_ATK_height"];

if (
	!canMove _vehicle ||
	!alive driver _vehicle ||
	fuel _vehicle == 0 ||
	unitIsUAV _vehicle
) exitWith {};

private ["_isAVT","_isGunShip","_has_IP","_remarks","_task_info","_grp"];

_isAVT = !isnull (finddisplay 160);
if ((_vehicle getVariable ["BCE_Task_Receiver", ""]) != "") exitWith {
	if (_isAVT) then {
		hint localize "STR_BCE_Error_Unavailable";
	} else {
		[
			"TASK_Builder",
			localize "STR_BCE_Error_Unavailable",
			5
		] call cTab_fnc_addNotification;
	};
};

if (_isAVT) then {
	hint localize "STR_BCE_DataSent";
} else {
	[
		"TASK_Builder",
		localize "STR_BCE_DataSent",
		5
	] call cTab_fnc_addNotification;
};

//-is Player
if ((isMultiplayer) && (isplayer _vehicle)) then {
	[["BCE", "Task_Received"],15,"",35,"",true,false,true] remoteExec ["BIS_fnc_advHint",_vehicle,true];
};

_isGunShip = (typeof _vehicle) in ["B_T_VTOL_01_armed_F","USAF_AC130U"];

//-GunShip
if (_isGunShip) then {
	[_vehicle,_posTarget,_ATK_range,_ATK_height] call BCE_fnc_GunShip_Loiter;
};

//-have IP/BP
_has_IP = IP_POS isNotEqualTo [];

_remarks = switch _type do {
	case 5: {_taskVar # 4};
	case 9:{_taskVar # 10};
};

//-Fix FAD/H if there's nothing
if (((_remarks # 0) == "NA") && !(_has_IP)) then {
	private ["_HDG","_To_Dir","_text"];
	_HDG = round(_posTarget getDirVisual _FAD_POS);
	_To_Dir = [_HDG - 180,360 + (_HDG - 180)] select ((_HDG - 180) < 0);
	_text = format ["“%1” to “%2”",_HDG call BCE_fnc_getAzimuth,_To_Dir call BCE_fnc_getAzimuth];

	_remarks set [0,_text];
	_remarks set [1,_HDG];
};

//- Send over Task
_task_info = str [
	format ["%2 [%3]", localize "STR_BCE_Caller", name player, groupId group player],
	_type,
	_taskVar,
	call BCE_fnc_UpdateTime
];
_vehicle setVariable ["BCE_Task_Receiver", _task_info, true];

if ((_vehicle isKindOf "Helicopter") || !(BCE_AI_CAS_Support_fn) || (isplayer _vehicle) || (_isGunShip)) exitWith {};

_vehicle disableAI "TARGET";
_vehicle disableAI "AUTOTARGET";

_grp = group _vehicle;

//-Clear Waypoints
for "_i" from count waypoints _grp - 1 to 1 step -1 do {
	deleteWaypoint [_grp, _i];
};

if (_has_IP && (_IP_POS isNotEqualTo _FAD_POS)) then {
	private _wp = _grp addWaypoint [_IP_POS, 0];
};

_IP = [_FAD_POS,_IP_POS] select _has_IP;

//-Set Waypoints
if ((_vehicle distance2D _posTarget) <= (_vehicle distance2D _IP)) then {
	_ActWP = [4,5] select _has_IP;
	for "_i" from 1 to 5 do {
		switch _i do {
			//-Get around TG POS
			case 1:{
				private _TG_dir = _FAD_POS getDirVisual _posTarget;
				private _pos = [90,-90] apply {_posTarget getPos [3000, _TG_dir + _x]};
				private _pos = _pos select ((_vehicle distance2D (_pos # 0)) > (_vehicle distance2D (_pos # 1)));
				if ((_vehicle distance2D _IP_POS) <= (_vehicle distance2D _pos)) then {
					_ActWP = _ActWP - 1;
					_vehicle flyInHeight _ATK_height;
					continue;
				};
				_pos set [2, (getpos _vehicle) # 2];
				private _wp = _grp addWaypoint [_pos, 0];
				_wp setWaypointStatements ["true", format ["vehicle this flyInHeight %1;",_ATK_height]];
			};
			//-Get a line
			case 2:{
				//-Last WP
				private _TG_dir = _FAD_POS getDirVisual _posTarget;
				private _LastWP = [90,-90] apply {_posTarget getPos [5000, _TG_dir + _x]};
				private _LastWP = [-10,10] select ((_vehicle distance (_LastWP # 0)) > (_vehicle distance (_LastWP # 1)));

				private _IP_dir = _posTarget getDirVisual _FAD_POS;
				private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 2000) max 4000, _IP_dir+_LastWP];

				_pos set [2, (getpos _vehicle) # 2];
				private _wp = _grp addWaypoint [_pos, 0];
			};
			case 3:{
				private _IP_dir = _posTarget getDirVisual _FAD_POS;
				private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 1000) max 3000, _IP_dir];

				_pos set [2, (getpos _vehicle) # 2];
				private _wp = _grp addWaypoint [_pos, 0];
			};
			//-IP
			case 4:{
				private _IP_dir = _posTarget getDirVisual _FAD_POS;
				private _pos = _posTarget getPos [2500, _IP_dir];
				_pos set [2, (getpos _vehicle) # 2];

				private _wp = _grp addWaypoint [_pos, 0];

				if !(_vehicle getVariable ["Module_CAS_Sound",false]) then {
					//Sound Handler
					_vehicle setVariable ["Module_CAS_Sound",true,true];

					[{
							params ["_ActWP","_grp","_vehicle"];

							((currentWaypoint _grp) > _ActWP) || !(alive _vehicle) || (isplayer _vehicle) || ((_vehicle getVariable ["BCE_Task_Receiver", ""]) == "")
						}, {
							params ["_ActWP","_grp","_vehicle"];

							//Call Event
							if ((alive _vehicle) && !(isplayer _vehicle) && ((_vehicle getVariable ["BCE_Task_Receiver", ""]) != "")) then {
								_this call BCE_fnc_CAS_Action;
							};
						}, [_ActWP,_grp]+_this
					] call CBA_fnc_waitUntilAndExecute;
				};
			};
			//-TG
			case 5:{
				private _wp = _grp addWaypoint [_posTarget, 0];
			};
		};
	};
} else {
	_ActWP = [3,4] select _has_IP;
	for "_i" from 1 to 4 do {
		switch _i do {
			//-Get a line
			case 1:{
				//-Last WP
				private _TG_dir = _FAD_POS getDirVisual _posTarget;
				private _LastWP = [90,-90] apply {_posTarget getPos [5000, _TG_dir + _x]};
				private _LastWP = [-10,10] select ((_vehicle distance (_LastWP # 0)) < (_vehicle distance (_LastWP # 1)));

				private _IP_dir = _posTarget getDirVisual _FAD_POS;
				private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 2000) max 4000, _IP_dir+_LastWP];

				_pos set [2, (getpos _vehicle) # 2];
				private _wp = _grp addWaypoint [_pos, 0];
				_wp setWaypointStatements ["true", format ["vehicle this flyInHeight %1;",_ATK_height]];
			};
			case 2:{
				private _IP_dir = _posTarget getDirVisual _FAD_POS;
				private _pos = _posTarget getPos [((_posTarget distance2D _FAD_POS) + 1000) max 3000, _IP_dir];

				_pos set [2, (getpos _vehicle) # 2];
				private _wp = _grp addWaypoint [_pos, 0];
			};
			//-IP
			case 3:{
				private _IP_dir = _posTarget getDirVisual _FAD_POS;
				private _pos = _posTarget getPos [2500, _IP_dir];
				_pos set [2, (getpos _vehicle) # 2];

				private _wp = _grp addWaypoint [_pos, 0];

				if !(_vehicle getVariable ["Module_CAS_Sound",false]) then {
					//Sound Handler
					_vehicle setVariable ["Module_CAS_Sound",true,true];

					[{
							params ["_ActWP","_grp","_vehicle"];

							((currentWaypoint _grp) > _ActWP) || !(alive _vehicle) || (isplayer _vehicle) || ((_vehicle getVariable ["BCE_Task_Receiver", ""]) == "")
						}, {
							params ["_ActWP","_grp","_vehicle"];

							//Call Event
							if ((alive _vehicle) && !(isplayer _vehicle) && ((_vehicle getVariable ["BCE_Task_Receiver", ""]) != "")) then {
								_this call BCE_fnc_CAS_Action;
							};
						}, [_ActWP,_grp]+_this
					] call CBA_fnc_waitUntilAndExecute;
				};
			};
			//-TG
			case 4:{
				private _wp = _grp addWaypoint [_posTarget, 0];
			};
		};
	};
};
