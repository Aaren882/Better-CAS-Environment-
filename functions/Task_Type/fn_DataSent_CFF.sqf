/*
  NAME : BCE_fnc_DataSent_CFF

  Description :
    Send Data to the Unit for CFF Mission
    This function is used to send data to the unit for a CFF mission.
    It processes the task variables and prepares the data to be Executed.
    
    Returns an array containing the processed data.
*/

params ["_taskUnit","_data"];

if (
	!canMove _taskUnit ||
	!alive _taskUnit ||
	unitIsUAV _taskUnit
) exitWith {false};

_data params [
  "_taskTypeInfo",
  "_TGPOS",
  "_Sheaf_Info",
  "_MOC_Values",
  "_angleType",
  "_MSN_Key",
  "_taskVar"
];

/*
  _taskTypeInfo : Array of Task Type Information
    _taskType_ID    : ID of the Task Type (0,1,2)
    _taskType       : Name of the Task Type ("ADJUST","SUPPRESS"...)
    _MSN_Prepare    : If true, prepare the mission (default is false)
    _MSN_State      : Current state of the mission (0 = Registered, 1 = FFE, 2 = EOM, 3 = Archived)
    _RECURSION_INFO : Recursion Information
      _RECUR_COUNT    : Count of Recursion (0 = No Recursion)
      _RECUR_INTERVAL : Interval of Recursion (in seconds, negative = no delay)
*/
_taskTypeInfo params ["_taskType_ID","_taskType","_MSN_Prepare","_MSN_State","_RECURSION_INFO"];

/* 
  _MOC_Value    : Delay Value [-1,0, ...]
  _MOC_Function : Function after Charge is found
*/
_MOC_Values params ["_MOC_Value","_MOC_Function"];

private _group = group _taskUnit;
private _CFF_Map = _MSN_Key call BCE_fnc_CFF_Mission_Get_Values;

private _WPN_exec = [];
private _random_POS = nil;

//- Hint
  private _isAVT = !isnull (finddisplay 160);

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


//- #NOTE - Record Task [RETURNS]
  private _MSN_Values = if (count _CFF_Map == 0) then {

		//- #TODO - More realistic Mission numbers
    //- 10000 Task Budget
    private _Task_CNT = missionNamespace getVariable ["BCE_CFF_Task_ID", 0];
    private _taskTypeBravo = 1 max floor (_Task_CNT / 10000);
    private _Wpn_setup = _taskVar # 0 # 3;
    
    _MSN_Key = [
      [_taskType_ID + 1, true] call BIS_fnc_phoneticalWord,
      [_taskTypeBravo, true] call BIS_fnc_phoneticalWord,
      [_Task_CNT mod 10000, 4] call CBA_fnc_formatNumber //- Limit 10000
    ] joinString "";

    missionNamespace setVariable [
      "BCE_CFF_Task_ID", //- Update Count
      _Task_CNT + 1,
      true
    ];
    
		//- a fking simple conversion
		private _radius = LinearConversion [3000,20000,_taskUnit distance2D _TGPOS,0,200,true];
    private _random_POS = [ 
      [
        [_TGPOS, _radius]
      ],
      []
    ] call BIS_fnc_randomPos;
  
  //- #NOTE - Set Mission ID e.g.(AB1001)
    private _MSN_Values = [
      _taskType,
      [_TGPOS,8] call BCE_fnc_POS2Grid,
      player,
      [
        (_Wpn_setup # 0),
        (_Wpn_setup # 1),
        _random_POS, //- try to aim the center First
        _angleType,
        _Sheaf_Info
      ],
      _MSN_State //- "MSN_State"
    ];

		//- Save Mission Data
			[
				"Send",
				_taskUnit,
				[_MSN_Key,_MSN_Values,_taskUnit]
			] call BCE_fnc_Send_MSN_CFF;

    //- RETURN
			_MSN_Values
  } else {
    
    _MSN_Prepare = true; //- //- #NOTE - on "Command"

    //- RETURN
      _MSN_Key call BCE_fnc_CFF_Mission_Get_Values;
  };
  
  //- #NOTE - Replace "_WPN_exec"
  //- ["_lbAmmo","_lbFuze",["_fireUnitSel",1],"_setCount","_fuzeVal"]
  if (_MSN_Prepare) then {
    _MSN_Values params [
      "_MSN_Type",
      "_TG_Grid",
      "_requester",
      "_MSN_infos",
      ["__MSN_State",0]
    ];

    /* 
      #NOTE - "MSN_State" descriptions
      - 0 : on "Registered" (Default)
      - 1 : on "Fire For Effect"
      - 2 : Mission is Ended "EOM"
      - 3 : Mission is "Archived"
    */

    _MSN_infos params [
      "_Wpn_setup_IE",
      "_Wpn_setup_IA",
      "__random_POS",
      "__angleType",
      "__Sheaf_Info"
    ];

    //- Match the Values
    _angleType = __angleType;
    _Sheaf_Info = __Sheaf_Info;
    _MSN_State = __MSN_State; 
    _random_POS = __random_POS;

    //- #NOTE - Replace "_WPN_exec"
    //- ["_lbAmmo","_lbFuze",["_fireUnitSel",1],"_setCount","_fuzeVal"]
    _WPN_exec = if (_MSN_State == 1) then { //- EFFECTIVE ROUNDS
      _Wpn_setup_IE
    } else { //- ADJUST ROUNDS
      private _i = -1;
      _Wpn_setup_IA apply { //- Replace the Empty Values with IE
        _i = _i + 1;
        [_x,_Wpn_setup_IE # _i] select (isnil {_x})
      };
    };
  };

  _WPN_exec params ["_lbAmmo","_lbFuze",["_fireUnitSel",1],"_setCount","_fuzeVal"];
  
//- #NOTE - Submit Data Only (Check "_WPN_exec" is empty)
  if ((count _WPN_exec) == 0) exitWith {};

//- #SECTION - Execution
  
  //- #SECTION - Set Distribution
    private _Sheaf_Pattern = [];

    //- #NOTE - Replace "_random_POS" to first parameter of "_Sheaf_Pattern"
    if (_MSN_State == 1) then { //- When FFE
      
      //- Send MTO (Message to Observer)
				//- Find the ammo type 
				private _ammo = [_lbAmmo,true] call BCE_fnc_getMagazineAmmo;
				private _default_FUZE = _ammo call BCE_fnc_CFF_getAmmoType; 

				private _msg = if (_taskType_ID == 2) then {
					localize "STR_BCE_CFF_MSG_IMM_SUP"
				} else {
					format [
            localize "STR_BCE_CFF_MSG_MTO",
            localize "STR_BCE_CFF_MTO_TITLE",
            str groupId group _taskUnit,
            _fireUnitSel,
            [_lbFuze,_default_FUZE] select (_lbFuze == ""),
            _setCount,
            _MSN_Key //- Mission ID
          ]
				};

        [formationLeader _taskUnit,_msg,"CFF_MTO"] call BCE_fnc_Send_Task_RadioMsg;

      //- Get Sheaf Pattern
      call {
        _Sheaf_Info params ["_Sheaf_ModeSel",["_SheafValue",[]]];
        
        private _rounds = _fireUnitSel * _setCount;
        //- Linear Sheaf : [center, [a, b, angle, rect]]
        if (_Sheaf_ModeSel == 2) exitWith {
          _SheafValue params ["_a","_b","_dir"];

          //- Hexagonal Distribution (Evenly Spacing)
            private _isOdd = _rounds % 2 != 0;
						
						/* private _ammo = _ammo;
						private _submunition = getText (configfile >> "CfgAmmo" >> _ammo >> "submunitionAmmo");
            if (_submunition != "") then { //- Replace "_ammo" with "_submunition"
							_ammo = _submunition;
						}; */

						private _effectRadius = getNumber (configfile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
          
          //- Pick Length & Width
            private _length = _b;
            private _width = _a;

          //- Get middle lines (correcting offsets)
            private _mid_L = _length / 2;
            private _mid_W = _width / 2;

            private _rows = ceil (_width / _effectRadius);
            private _columns = (_rounds + ([0,1] select _isOdd)) / _rows;

          //- Offsets
            private _step_w = _width / (1 + _rows);

            for "_i" from 0 to _rows do {
              private _step_l = _length / (1 + _columns);
              for "_j" from 0 to _columns do {
                private _s = [(_step_l * _j) - _mid_L, (_step_w * _i) - _mid_W];
                _Sheaf_Pattern pushBack [vectorMagnitude _s, (([0,0] getDir _s) + _dir) % 360];
              };
              _columns = (_rounds - _columns) min _columns;
            };
        };

        //- #NOTE - Default
          private _radius = _SheafValue param [0, 100];
          
          for "_i" from 1 to _rounds do {
            private _s = [
              [
                [_random_POS, _radius max 0]
              ],
              []
            ] call BIS_fnc_randomPos;
            _Sheaf_Pattern pushBack [_random_POS distance2D _s, _random_POS getDir _s];
          };
      };
    };

  //- #!SECTION

  private _MagData = createHashMap;
  private _MagFire = createHashMap;

  private _vehs = _group call BCE_fnc_getGroupVehicles; 
	// private _vehs = assignedVehicles _group;

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
    
    //- Save Sheaf Data (Specify Sheaf for Guns)
      private _CFF_info = [_random_POS,_lbAmmo,_setCount,_angleType,[_lbFuze,_fuzeVal],_MOC_Function];
      _CFF_info set [6, _Sheaf_Pattern select [(_forEachIndex * _setCount), _setCount]];
      _CFF_info set [7, _RECURSION_INFO];
    
    //- Save Mission Values
      [["CFF_MSN",_MSN_Key] joinString ":", _CFF_info, _unit] call BCE_fnc_set_CFF_Value;

    // Removing mags is not instant and the code continues before removal is finished.
      [
        {
          params ["_unit","_gunner","_weapon","_turret","_magsToAdd","_otherMags"];

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

          
        },
        [
          _unit,
          _gunner,
          _weapon,
          _turret,
          _magsToAdd,
          _otherMags
        ]
      ] call CBA_fnc_execNextFrame;

    //- #ANCHOR - Do Fire mission
    //- Setup ToT Timer
			private _isMsger = _forEachIndex == 0; //- #NOTE - The first one is the radio msger
      if (_MOC_Value isNotEqualTo "") then {
        [
          _MSN_Key,
          _MOC_Value,
          format [
            "[""%1"",""%2"",_this # 0,0,%3] spawn BCE_fnc_CFF_Action",
            _unit,
            _weapon,
						_isMsger
          ],
          0 //- BaseTime
        ] call BCE_fnc_Add_CountDown;
      } else {
        [_unit,_weapon,_MSN_Key,nil,_isMsger] spawn BCE_fnc_CFF_Action;
      };
  } forEach (_MagFire_ARR apply {_x # 0});
//- #!SECTION
nil