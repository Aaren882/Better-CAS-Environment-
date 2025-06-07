params ["_taskUnit","_cateName","_taskType","_taskVar",["_customInfos",-1]];

_taskVar params ["_taskVar_0","_taskVar_1","_taskVar_2","_taskVar_3","_taskVar_4"];

// (_Wpn_setup # 0) params ["_WeapName_IE","_ModeName_IE","_Mode_IE","_turret_IE","_Count_IE","_muzzle_IE","_ATK_range_IE","_ATK_height_IE"];
// (_Wpn_setup # 1) params ["_WeapName_IA","_ModeName_IA","_Mode_IA","_turret_IA","_Count_IA","_muzzle_IA","_ATK_range_IA","_ATK_height_IA"];

//- Processing (Get i/e & i/a values)
_taskVar_0 params ["","_Task_Type","","","_angleType"];
_taskVar_4 params ["","_MOC_Values","_MOC_Function"];

//- Positions
private _TGPOS = _taskVar_2 # 2;

// private _OT_Dis = round ((_FO_POS distance _TGPOS) / 100) * 100;
// private _OT_Dir = (_FO_POS getDir _TGPOS) call BCE_fnc_getAzimuthMil;

private _MOC_Value = _MOC_Values # 1;
private _MSN_Prepare = true;
private _prepare_Minutes = 3;

private _MOC = switch (typeName _MOC_Value) do {
  case "STRING": { //- STRING "164800"
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

//- Pass into "DataSent" EH
[
  _Task_Type,
  _TGPOS,
  // [_TGPOS,_OT_Dir], //- OT Infos
  _taskVar_1 param [2, []], //- Sheaf Infos
  [_MOC, _MOC_Function, _MSN_Prepare], //- Get MOC Values ["MOC Value", "MOC_Fnc Name"]
  _angleType, //- Fire Angle type
  _customInfos,
  _taskVar
]