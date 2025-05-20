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
  "_taskTypeInfo",
  "_TGPOS", //- OT Infos
  "_WPN_exec",
  "_Control_Function",
  "_customInfos",
  "_taskVar"
];
_taskTypeInfo params ["_taskType_ID","_taskType"];

private _group = group _taskUnit;

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
    _taskType,
    _taskVar,
    [daytime] call BIS_fnc_timeToString
  ]; */


//- #NOTE - Record Task
  private _CFF_Map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];

  private _random_POS = if !(_customInfos in _CFF_Map) then {
    //- 10000 Task Budget
    private _Task_CNT = missionNamespace getVariable ["BCE_CFF_Task_ID", 0];

    private _taskTypeBravo = 1 max floor (_Task_CNT / 10000);
    
    private _MSN_Key =  [
      [_taskType_ID + 1, true] call BIS_fnc_phoneticalWord,
      [_taskTypeBravo, true] call BIS_fnc_phoneticalWord,
      [_Task_CNT mod 10000, 4] call CBA_fnc_formatNumber //- Limit 10000
    ] joinString "";

    missionNamespace setVariable [
      "BCE_CFF_Task_ID", //- Update Count
      _Task_CNT + 1,
      true
    ];
    
    private _Wpn_setup = _taskVar # 0 # 3;
    // private _random_POS = _TGPOS;
    private _random_POS = [
      [
        [_TGPOS, 0]
      ],
      []
    ] call BIS_fnc_randomPos;
  
  //- #NOTE - Set Mission ID e.g.(AB1001)
    /* _CFF_Map set [
      _MSN_Key,
      [
        _taskType,
        [_TGPOS,8] call BCE_fnc_POS2Grid,
        player,
        [
          (_Wpn_setup # 0),
          (_Wpn_setup # 1),
          _random_POS
        ],
        0 //- "MSN_State"
      ]
    ];

    _group setVariable ["BCE_CFF_Task_Pool", _CFF_Map]; */
    private _MSN_Values = [
      _taskType,
      [_TGPOS,8] call BCE_fnc_POS2Grid,
      player,
      [
        (_Wpn_setup # 0),
        (_Wpn_setup # 1),
        _random_POS
      ],
      0 //- "MSN_State"
    ];
    [_MSN_Key,_MSN_Values,_taskUnit] call BCE_fnc_CFF_Mission_Set_Value;

    //- RETURN
      _random_POS
  } else {
    
    ([_customInfos,_taskUnit] call BCE_fnc_CFF_Mission_Get_Values) params [
      "_MSN_Type",
      "_TG_Grid",
      "_requester",
      "_MSN_infos",
      ["_MSN_State",0]
    ];

    /* 
      #ANCHOR - "MSN_State" descriptions
      - 0 : on "Registered" (Default)
      - 1 : on "Fire For Effect"
      - 2 : Mission is Ended "EOM"
      - 3 : Mission is "Archived"
    */

    _MSN_infos params [
      "_Wpn_setup_IE",
      "_Wpn_setup_IA",
      "_random_POS"
    ];
    
    //- #NOTE - Replace "_WPN_exec"
    //- ["_lbAmmo","_lbFuse",["_fireUnitSel",1],"_setCount","_radius","_fuzeVal"]
    _WPN_exec = if (_MSN_State == 1) then {
      //- EFFECTIVE ROUNDS
      _Wpn_setup_IE
    } else {
      //- ADJUST ROUNDS
      private _i = -1;
      _Wpn_setup_IA apply { //- Replace the Empty Values with IE
        _i = _i + 1;
        [_x,_Wpn_setup_IE # _i] select (isnil {_x})
      };
    };
    
    //- RETURN
      _random_POS
  };
   // ["BCE_Task_CFF_Sent", [_taskUnit,_data], _group] call CBA_fnc_targetEvent;
  
//- #NOTE - Submit Data Only (Check "_WPN_exec" is empty)
  if ((count _WPN_exec) == 0) exitWith {};

//- #SECTION - Execution
  _WPN_exec params ["_lbAmmo","_lbFuse",["_fireUnitSel",1],"_setCount","_radius","_fuzeVal"];
  private _CFF_info = [_random_POS, _lbAmmo,_setCount,_radius,[_lbFuse,_fuzeVal],_Control_Function];
  private _MagData = createHashMap;
  private _MagFire = createHashMap;

  private _vehs = (units _group) apply {vehicle _x}; 
  _vehs = _vehs arrayIntersect _vehs;

  //- Magazines Data
  {
    private _unit = _x;
    private _unit_str = str _unit;
    private _allMags = magazinesAmmo _unit;

    //- Vaildate Ammo Existence
      private _has_Ammo = false;
      {
        if (_lbAmmo == _x # 0) exitWith {_has_Ammo = true};
      } count _allMags;
    if !(_has_Ammo) then {continue};

    //- #NOTE - Setting up Magazines
      
      // Find the requested ammo and count the amount of rounds.
        private _nrRounds = 0;
        private _otherMags = [];
        {
          if ((_x # 0) == _lbAmmo && (_x # 1) > 0) then {
            _nrRounds = _nrRounds + (_x # 1);
          } else {
            _otherMags pushback _x;
          };
        } forEach _allMags;

      // Calculate how many mags should be created, based on the total rounds and mag capacity.
        private _magCap = (getNumber(configfile >> "CfgMagazines" >> _lbAmmo >> "count")) max 1;
        private _magsToAdd = [];
        for [{_i = _nrRounds - _magCap}, {true}, {_i = _i - _magCap}] do {
          private _magValue = _MagFire getOrDefault [_unit_str,0];
          if (_i < 0) exitWith {
            if (_i + _magCap > 0) then {
              _magsToAdd pushback [_lbAmmo, _i + _magCap];
              _MagFire set [_unit_str, _magValue + _i + _magCap];
            };
          };
          _magsToAdd pushback [_lbAmmo, _magCap];
          _MagFire set [_unit_str, _magValue + _magCap];
        };

    //- Set sortList Data
      _MagData set [
        _unit_str, 
        [
          _unit,
          _magsToAdd,
          _otherMags
        ]
      ];
  } forEach _vehs;

  //- Arrange Fire Order 
    //- #NOTE - [["Unit_STR", AmmoCount]]
    private _MagFire_ARR = _MagFire toArray false;
    _MagFire_ARR = [_MagFire_ARR, 1, false] call CBA_fnc_sortNestedArray;
    _MagFire_ARR = _MagFire_ARR select [0, _fireUnitSel];

  //- Apply Fire Mission
  {
    (_MagData get _x) params [
      "_unit",
      "_magsToAdd",
      "_otherMags"
    ];

    private _gunner = gunner _unit;
    private _turret = _unit unitTurret _gunner;

    // Remove weapon, remove mags. Add 1 mag, add weapon to load the mag instantly. Then add the remaining mags.
      private _allMags = magazinesAmmo _unit;
      private _weapon = _unit currentWeaponTurret _turret;
      _unit removeWeaponTurret [_weapon, _turret];
      {_unit removeMagazinesTurret [(_x # 0), _turret]} forEach _allMags;
    
    // Removing mags is not instant and the code continues before removal is finished.
      [
        {
          params ["_unit","_gunner","_weapon","_turret","_magsToAdd","_otherMags","_CFF_info"];

          //- Adding Weapons
          if !(alive _unit) exitWith {};

          // private _dispersion = getNumber (configFile >> "CfgWeapons" >> _weapon >> "artilleryDispersion");

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

          // _gunner doWatch (ASLtoAGL (_CFF_info # 0));
          //- Do Fire mission
          call BCE_fnc_CFF_Action;
        },
        [
          _unit,
          _gunner,
          _weapon,
          _turret,
          _magsToAdd,
          _otherMags,
          _CFF_info //- "_CFF_info"
        ]
      ] call CBA_fnc_execNextFrame;
  } forEach (_MagFire_ARR apply {_x # 0});
//- #!SECTION
nil