/*
  NAME : BCE_fnc_DataSent_CFF
*/

params ["_taskUnit","_data"];

if (
	!canMove _taskUnit ||
	!alive _taskUnit ||
	unitIsUAV _taskUnit
) exitWith {false};

_data params [
  "_Task_Type",
  "_OT_Infos", //- OT Infos
  "_Wpn_setup",
  "_taskVar"
];
(_Wpn_setup # 0) params ["_lbAmmo_IE","_lbFuse_IE","_fireUnitSel_IE","_setCount_IE","_radius_IE","_fuzeVal_IE"];
(_Wpn_setup # 1) params ["_lbAmmo_IA","_lbFuse_IA","_fireUnitSel_IA","_setCount_IA","_radius_IA","_fuzeVal_IA"];

_OT_Infos params ["_TGPOS","_OT_Dir"];

//- Hint
  private _isAVT = !isnull (finddisplay 160);
  /* if (() != "") exitWith {
    if (_isAVT) then {
      hint localize "STR_BCE_Error_Unavailable";
    } else {
      [
        "TASK_Builder",
        localize "STR_BCE_Error_Unavailable",
        5
      ] call cTab_fnc_addNotification;
    };
  }; */

  if (_isAVT) then {
    hint localize "STR_BCE_DataSent";
  } else {
    [
      "TASK_Builder",
      localize "STR_BCE_DataSent",
      5
    ] call cTab_fnc_addNotification;
  };

  //- Receiver
  //-- MP && is Player
  /* if ((isMultiplayer) && (isplayer _taskUnit)) then {
    [["BCE", "Task_Received"],15,"",35,"",true,false,true] remoteExec ["BIS_fnc_advHint",_taskUnit,true];
  }; */


//- Send over Task
  /* private _task_info = str [
    format ["%2 [%3]", localize "STR_BCE_Caller", name player, groupId group player],
    _Task_Type,
    _taskVar,
    [daytime] call BIS_fnc_timeToString
  ]; */

private _group = group _taskUnit;

//- Create Task Pool
  private _CFF_Map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];

//- 10000 Task Budget
  private _Task_CNT = missionNamespace getVariable ["BCE_CFF_Task_ID", -1];

  _Task_CNT = [
    _Task_CNT + 1,
    0
  ] select (_Task_CNT == 10000); //- Limit 10000

  missionNamespace setVariable [
    "BCE_CFF_Task_ID", //- Update Count
    _Task_CNT,
    true
  ];
  
  //- Set Mission ID e.g.(AB1001)
  _CFF_Map set [
    format ["AB%1", [_Task_CNT, 4] call CBA_fnc_formatNumber],
    [
      _Task_Type,
      [_TGPOS,8] call BCE_fnc_POS2Grid,
      player,
      _setCount_IE,
      [_setCount_IA, nil] select (_setCount_IA == 1)
    ]
  ];

  _group setVariable ["BCE_CFF_Task_Pool", _CFF_Map];
  // ["BCE_Task_CFF_Sent", [_taskUnit,_data], _group] call CBA_fnc_targetEvent;
  
//- #SECTION - Execution
  private _vehs = (units _group) apply {vehicle _x}; 
  _vehs = _vehs arrayIntersect _vehs;

  {
    private _unit = _x;
    private _allMags = magazinesAmmo _unit;
    if !(_lbAmmo_IE in (_allMags apply {_x # 0})) then {continue};

    private _gunner = gunner _unit;
    private _turret = _unit unitTurret _gunner;
    
    // Find the requested ammo and count the amount of rounds.
      private _nrRounds = 0;
      private _otherMags = [];
      {
        if ((_x # 0) == _lbAmmo_IE && (_x # 1) > 0) then {
          _nrRounds = _nrRounds + (_x # 1);
        } else {
          _otherMags pushback _x;
        };
      } forEach _allMags;

    // Remove weapon, remove mags. Add 1 mag, add weapon to load the mag instantly. Then add the remaining mags.
      // _allMags = magazinesAmmo _unit;
      private _weapon = _unit currentWeaponTurret _turret;
      _unit removeWeaponTurret [_weapon, _turret];
      {_unit removeMagazinesTurret [(_x # 0), _turret]} forEach _allMags;

    // Calculate how many mags should be created, based on the total rounds and mag capacity.
      private _magCap = (getNumber(configfile >> "CfgMagazines" >> _lbAmmo_IE >> "count")) max 1;
      private _magsToAdd = [];
      for [{_i = _nrRounds - _magCap}, {true}, {_i = _i - _magCap}] do {
        if (_i < 0) exitWith {
          if (_i + _magCap > 0) then {
            _magsToAdd pushback [_lbAmmo_IE, _i + _magCap];
          };
        };
        _magsToAdd pushback [_lbAmmo_IE, _magCap];
      };
    
    // Removing mags is not instant and the code continues before removal is finished.
      [
        {
          params ["_unit","_gunner","_weapon","_turret","_magsToAdd","_otherMags","_CFF_info"];

          //- Adding Weapons
          if !(alive _unit) exitWith {};

          private _addWeapon = true;
          {
            _unit addMagazine _x;
            if (_addWeapon) then {
              _unit setWeaponReloadingTime [_gunner, currentMuzzle _gunner, 0];
              _unit addWeaponTurret [_weapon, _turret];
              _gunner selectWeapon _weapon;
              _addWeapon = false;
            };
          } forEach _magsToAdd;
          {_unit addMagazine _x} forEach _otherMags;

          _unit setWeaponReloadingTime [_gunner, currentMuzzle _gunner, 0];
          _unit doArtilleryFire _CFF_info;
        },
        [_unit,_gunner,_weapon,_turret,_magsToAdd,_otherMags,[_TGPOS, _lbAmmo_IE, _setCount_IE]],
        2
      ] call CBA_fnc_waitAndExecute;
  } forEach _vehs;
// #!SECTION