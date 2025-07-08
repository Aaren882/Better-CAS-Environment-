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

// (_Wpn_setup # 0) params ["_WeapName_IE","_ModeName_IE","_Mode_IE","_turret_IE","_Count_IE","_muzzle_IE","_ATK_range_IE","_ATK_height_IE"];
// (_Wpn_setup # 1) params ["_WeapName_IA","_ModeName_IA","_Mode_IA","_turret_IA","_Count_IA","_muzzle_IA","_ATK_range_IA","_ATK_height_IA"];

//- Processing (Get i/e & i/a values)
_taskVar_0 params ["","_taskTypeInfo","","","_angleType"];
_taskVar_4 params ["","_MOC_Values","_MOC_Function"];

//- Positions
private _TGPOS = _taskVar_2 # 2;

// private _OT_Dis = round ((_FO_POS distance _TGPOS) / 100) * 100;
// private _OT_Dir = (_FO_POS getDir _TGPOS) call BCE_fnc_getAzimuthMil;

private _MSN_State = 0;
private _MSN_Prepare = true;

private _MOC_Value = _MOC_Values # 1;
private _prepare_Minutes = 3;
private _RECURSION_INFO = [0,0]; //- [RECUR_COUNT, RECUR_INTERVAL]

//- Method of control
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
  switch (_taskType) do {
    case 1: {
      //- ex. ["NA",[],[[8,1,8],[1,1,1,1,0]]]
      private _taskVals = _taskVar_3 param [1, []];
      private _varStore = _taskVar_3 param [2, [[],[]]];
        _varStore params ["","_SUP_Checks"];
        _SUP_Checks params ["","","","_SkipAdjust_C","_MinSec_C"];
        _taskVals params ["_duration_V",["_rounds_V",0],"_interval_V",["_rnds_Cnt",0]];
      
      _MSN_State = _SkipAdjust_C;
      if (_MSN_State == 1) then { //- #NOTE - Only on FFE
        _RECURSION_INFO = [_rnds_Cnt, _interval_V * ([60, 1] select (_MinSec_C == 1))];
      };
    };
  };

//- Pass into "DataSent" EH
[
  [_taskType, _taskTypeInfo, _MSN_Prepare, _MSN_State, _RECURSION_INFO],
  _TGPOS,
  // [_TGPOS,_OT_Dir], //- OT Infos
  _taskVar_1 param [2, []], //- Sheaf Infos
  [_MOC, _MOC_Function], //- Get MOC Values ["MOC Value", "MOC_Fnc Name"]
  _angleType, //- Fire Angle type
  _customInfos,
  _taskVar
]