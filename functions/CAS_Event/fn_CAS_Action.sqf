params ["_grp","_vehicle","_IP_POS","_posTarget","_EGRS","_weaponInfo"];
_weaponInfo params ["_WPNclass","_WPN_Mode","_WPN_turret","_WPN_count","_muzzle","_ATK_range"];

_Set_PitchBank = {
  //-Ripple Bombing
	if (_casType == 2) then {
		//[_vehicle,0,0] call bis_fnc_setpitchbank;
		_vectorDir = [_planePos,[_pos # 0, _pos # 1, _planePos # 2]] call bis_fnc_vectorFromXtoY;
		_awayDis = 1000;
	} else {
		[_vehicle,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
	};
};

//Basic Definition
_dis = _IP_POS distance _posTarget;
_dir = _vehicle getDir _posTarget;
_alt = 2000;
_fly_speed = 400;
_trigger_range = _ATK_range;
//_alt = if (_casType == 2) then {500} else {2000};
_speed = _fly_speed / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;
_fireNull = true;

//Approach
_cfgweapon_path = configFile >> "CfgWeapons";
_Is_GunRun = true in (["machinegun","CannonCore"] apply {_WPNclass isKindOf [_x, configFile >> "CfgWeapons"]});
_Is_Bombing = true in (["bomblauncher","weapon_lgblauncherbase","mk82bomblauncher","USAF_BombLauncherBase"] apply {_WPNclass isKindOf [_x, configFile >> "CfgWeapons"]});

_casType = 0;
_offset_Cfg = 0;

//-Gun run
if (_Is_GunRun) then {
  _casType = 1;
};

//-Bombing
if (_Is_Bombing) then {
	_offset_Cfg = linearConversion [1000, 2000, _trigger_range, 200, 600];
	if (getNumber (_cfgweapon_path >> _WPNclass >> "USAF_ripple") > 0) then {
		_casType = 2;
	  _offset_Cfg = 100;
	};
};
_target_offset = _offset_Cfg + (linearConversion [1000, 2000, _trigger_range, 0, 30]);

_time = time;
_offset = if (_casType == 2) then {35} else {0};

//WayPoints
_posATL = _posTarget getPos [_target_offset,_dir];
_pos =+ _posATL;
_pos set [2,(_pos # 2) + getTerrainHeightASL _pos];
_CAS_Dir = _IP_POS getDir _posTarget;

//Vehicle Setups
_planePos = getPos _vehicle;
_planePos set [2,(_pos # 2) + _alt];

_vehicle setdir _dir;
_vehicle setSpeedMode "FULL";

_vectorUp = vectorup _vehicle;
_vehicle setPosASL _planePos;

_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_vehicle setvectordir _vectorDir;

//CM
{
	private _weapon = _x;
 if (("counter" in toLower(_weapon)) or ("cmlauncher" in toLower(_weapon)) or ("flare" in toLower(_weapon)) or ("cmdispenser" in toLower(_weapon))) then {
	 private _modes = getArray (_cfgweapon_path >> _weapon >> "modes");
	 private _mode = _modes # 0;
	 _vehicle setVariable ["CAS_CounterMeasure",[_weapon,_mode]];
 };
} forEach ((typeOf _vehicle) call bis_fnc_weaponsEntityType);

//Radio
[_vehicle,"CuratorModuleCAS"] call bis_fnc_curatorSayMessage;

//Loop
[{
	params [
		"_posTarget","_casType","_pos","_posATL","_dis","_dir","_alt","_speed","_target_offset",
		"_duration","_time",
		"_vehicle","_planePos","_vectorDir","_vectorUp","_velocity","_offset",
		"_trigger_range","_IP_POS","_EGRS","_weaponInfo","_fireNull","_Set_PitchBank"
	];

	//Set the plane approach vector
	_awayDis = _trigger_range;
	call _Set_PitchBank;

	_vehicle setVelocityTransformation [
		_planePos, [_pos # 0, _pos # 1, (_pos # 2) + _offset],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];

	_vehicle setvelocity (velocity _vehicle);

	//Firing Handler
	if (((getPosASL _vehicle) distance _pos < _awayDis) && (_this # 21)) then {
		_target = _posTarget;
		_this set [21, false];

		[_vehicle,_target,_casType,_weaponInfo] spawn {
			params ["_vehicle"];

			_fire = _this spawn {
				params ["_vehicle","_target","_casType","_weaponInfo"];
				_weaponInfo params ["_WPNclass","_WPN_Mode","_WPN_turret","_WPN_count","_muzzle","_ATK_range"];
				private _shooter = _vehicle turretUnit _WPN_turret;

				//-Reload Time
				private _muzzleCfg = if (_muzzle == "this") then {
					configFile >> "CfgWeapons" >> _WPNclass;
				} else {
					configFile >> "CfgWeapons" >> _WPNclass >> _muzzle;
				};
				private _sleep = if (_WPN_Mode == "this") then {
					getNumber (_muzzleCfg >> "reloadTime");
				} else {
					getNumber (_muzzleCfg >> _WPN_Mode >> "reloadTime");
				};

				private _burst = if (_WPN_Mode == "this") then {
					getNumber (_muzzleCfg >> "burst");
				} else {
					getNumber (_muzzleCfg >> _WPN_Mode >> "burst");
				};

				//Burst Mode - A-10-tastic (Compatibility)
				private _Burst_Mode = (_burst >= 20);

				//Burst Mode
				if (_Burst_Mode) then {
					_time = time + (1.5*_burst*_sleep);
					while {!(time > _time or isnull _vehicle)} do {
						_shooter forceWeaponFire [_WPNclass, _WPN_Mode];
					};
				} else {
					//Rocket run ,Bombing run ,and FullAuto GunRun
					switch (_casType) do {
						case 1:{
							_time = time + 2;
							while {!(time > _time or isnull _vehicle)} do {
								_shooter forceWeaponFire [_WPNclass, _WPN_Mode];
							};
						};
						default {
							for "_i" from 1 to _WPN_count do {
								_shooter forceWeaponFire [_WPNclass, _WPN_Mode];
								uisleep (_sleep*2);
							};
						};
					};
				};
			};
			[{
					params ["_vehicle", "_fire"];
					scriptdone _fire
				}, {
					params ["_vehicle"];

					_vehicle spawn {
						uisleep 0.1;
						_this setVariable ["BCE_Fire_Progress_Done",true];
            uisleep 0.1;
            _this setVariable ["BCE_Fire_Progress_Done",false];
					};
				}, [_vehicle,_fire]
			] call CBA_fnc_waitUntilAndExecute;
		};
	};

	(_vehicle getVariable ["BCE_Fire_Progress_Done",false]) or (isnull _vehicle) or !(alive _vehicle)
}, {
	params [
			"_posTarget","_casType","_pos","_posATL","_dis","_dir","_alt","_speed","_target_offset",
			"_duration","_time",
			"_vehicle","_planePos","_vectorDir","_vectorUp","_velocity","_offset",
			"_trigger_range","_IP_POS","_EGRS","_weaponInfo","_fireNull","_Set_PitchBank"
		];
    private _grp = group _vehicle;

    //-Clear Waypoints
		for "_i" from count waypoints _grp - 1 to 1 step -1 do {
	  	deleteWaypoint [_grp, _i];
	  };

    for "_i" from 1 to 2 do {
      switch (_i) do {
        //-Egress
        case 1:{
          private _pos = _vehicle getPos [2000, _EGRS];
          private _wp = _grp addWaypoint [_pos, 0, _i];

					_wp setWaypointStatements ["true", "vehicle this flyInHeight 2000;"];
        };

        //-Back IP
        //-Get around TG POS
        /* case 2:{
          private _TG_dir = _vehicle getDir _posTarget;
          private _EGRS_pos = _vehicle getPos [5000, _EGRS];
          private _pos = [90,-90] apply {_vehicle getPos [3000,(getDirVisual _vehicle) +  _x]};
          private _pos = if ((_EGRS_pos distance (_pos # 0)) < (_EGRS_pos distance (_pos # 1))) then {
            (_pos # 0)
          } else {
            (_pos # 1)
          };
          if ((_EGRS_pos distance _IP_POS) < (_pos distance _IP_POS)) exitWith {};
          _pos set [2, _alt];
          private _wp = _grp addWaypoint [_pos, 0, _i];
        }; */
        //-Get Back
        case 2:{
          private _IP_dir = _posTarget getDir _IP_POS;
          private _pos = _posTarget getPos [(_posTarget distance2D _IP_POS) + 1500, _IP_dir];

          _pos set [2, _alt];
          private _wp = _grp addWaypoint [_pos, 0, _i];
        };
      };
    };

    /* _vehicle enableAI "TARGET";
  	_vehicle enableAI "AUTOTARGET"; */

		//--- Fire CM
		_vehicle spawn {
			for "_i" from 0 to 10 do {
				driver _this forceweaponfire (_this getVariable ["CAS_CounterMeasure",["CMFlareLauncher","Burst"]]);
				uisleep 0.2;
			};
		};

		//-Egress
		_vehicle flyInHeight _alt/3;

		//Sound Handler
		_vehicle setVariable ["Module_CAS_Sound",false,true];
},[
		_posTarget,_casType,_pos,_posATL,_dis,_dir,_alt,_speed,_target_offset,
		_duration,_time,
		_vehicle,_planePos,_vectorDir,_vectorUp,_velocity,_offset,
		_trigger_range,_IP_POS,_EGRS,_weaponInfo,_fireNull,_Set_PitchBank
	]
] call CBA_fnc_waitUntilAndExecute;
