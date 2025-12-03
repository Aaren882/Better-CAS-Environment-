/*
  PARAMS :
    "_taskUnit"	    - Data will be sent to this Unit
    "_cateName"	    - Task Cate Name ("AIR", "GND")
    "_taskType"		  - Index of the "Task Type"
    "_taskVar"		  - Task Variables
    "_customInfos"	- Custom Infos can be anything (OPTIONAL)

  Description :
    Send Data to the Unit for Task Type
    This function is used to send data to the unit for a specific task type.
    It processes the task variables and prepares the data to be sent.
    
    Returns an array containing the processed data.
*/

params ["_taskUnit","_cateName","_taskType","_taskVar",["_customInfos",-1]];

_taskVar params ["_taskVar_0","_taskVar_1","_taskVar_2","_taskVar_3","_taskVar_4"];

//- Processing (Get i/e & i/a values)
_taskVar_0 params ["","_taskTypeInfo","","","_angleType"];
_taskVar_4 params [
	"",
	["_MOC_Values",[0,0]],
	["_MOC_Function","BCE_fnc_CFF_AT_READY",[""]]
];

//- Positions
private _TGPOS = _taskVar_2 # 2;

// private _OT_Dis = round ((_FO_POS distance _TGPOS) / 100) * 100;
// private _OT_Dir = (_FO_POS getDir _TGPOS) call BCE_fnc_getAzimuthMil;

private _MSN_State = 0;
private _MSN_Prepare = true;

//- #NOTE - "At-Ready" by default
_MOC_Values params [["_MOC_Type",0,[0]],["_MOC_Value",0,[0]]];

//- Method of control
	private _prepare_Minutes = 3;
  private _MOC = switch (typeName _MOC_Value) do {
    case "STRING": { //- STRING "164800" => "HHMMSS"
      private _time = (parseNumber _MOC_Value) - _prepare_Minutes;
      ([_time, 4] call CBA_fnc_formatNumber) + "00"
    };
    default { //- NUMBER
      _MSN_Prepare = _MOC_Value >= 0;
      
      //- Return
      if (_MOC_Value > 0) then {
        private _daytime = dayTime;
        private _hours = floor _daytime;
        private _minutes = floor ((_daytime - _hours) * 60);
        
        [_hours,_minutes + _MOC_Value - _prepare_Minutes, 0]
      } else {
        ""
      }
    };
  };

//- Mission Type
	private _RECURSION_INFO = [0,0]; //- [RECUR_COUNT, RECUR_INTERVAL (Sec)] #NOTE - For each unit
  switch (_taskType) do {
    case 1: { //- Suppression
      //- ex. ["NA",[],[[8,1,8],[1,1,1,1,0]]]
      private _taskVals = _taskVar_3 param [1, []];
      private _varStore = _taskVar_3 param [2, [[],[]]];
        _varStore params ["","_SUP_Checks"];
        _SUP_Checks params ["","","","_SkipAdjust_C","_MinSec_C"];
        _taskVals params ["_duration_V",["_rounds_V",0],"_interval_V",["_rnds_Cnt",0]];
      
      _MSN_State = _SkipAdjust_C;
      if (_MSN_State == 1) then { //- #NOTE - Only on FFE
        _RECURSION_INFO = [
					_rnds_Cnt - 1, //- #NOTE - Need to minus 1 ,so it won't have extra 1 round
					_interval_V * ([60, 1] select (_MinSec_C == 1))
				];
      };
    };
		case 2: { //- Imm-Suppression
			_MSN_State = 1;

			//- get Reload time
				private _gunner = gunner _taskUnit;
				private _turret = _taskUnit unitTurret _gunner;
				private _weapon = _taskUnit currentWeaponTurret _turret;
				private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;

			// - Get Reload time from CfgWeapons
			_delay = [
					_weaponCfg >> currentWeaponMode _gunner,
					"reloadTime",
					getNumber (_weaponCfg >> "reloadTime")
				] call BIS_fnc_returnConfigEntry;

			["RELOAD", _delay max (floor random [10,12,15]), _taskUnit] call BCE_fnc_set_CFF_Value;
		};
  };

//- Pass into "DataSent" EH
[
  [_taskType, _taskTypeInfo, _MSN_Prepare, _MSN_State, _RECURSION_INFO],
  _TGPOS,
  _taskVar_1 param [2, [0, [100]]], //- Sheaf Infos (#NOTE - default Standard 100m radius)
  [_MOC, _MOC_Function], //- Get MOC Values ["MOC Value", "MOC_Fnc Name"]
  _angleType, //- Fire Angle type
  _customInfos,
  _taskVar
]
