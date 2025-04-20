params ["_taskUnit","_taskVar"];

_taskVar params ["_taskVar_0","_taskVar_1","_taskVar_2","_taskVar_3","_taskVar_4"];

// (_Wpn_setup # 0) params ["_WeapName_IE","_ModeName_IE","_Mode_IE","_turret_IE","_Count_IE","_muzzle_IE","_ATK_range_IE","_ATK_height_IE"];
// (_Wpn_setup # 1) params ["_WeapName_IA","_ModeName_IA","_Mode_IA","_turret_IA","_Count_IA","_muzzle_IA","_ATK_range_IA","_ATK_height_IA"];

//- Processing (Get i/e & i/a values)
_taskVar_0 params ["","_Task_Type","","_Wpn_setup"];

//- Positions
private _FO_POS = _taskVar_1 # 2;
private _TGPOS = _taskVar_2 # 2;

private _OT_Dis = round ((_FO_POS distance _TGPOS) / 100) * 100;
private _OT_Dir = (_FO_POS getDir _TGPOS) call BCE_fnc_getAzimuthMil;

//- Pass into "DataSent" EH
[
  _Task_Type # 1,
  [_TGPOS,_OT_Dir], //- OT Infos
  _Wpn_setup, //- WPN Values
  _taskVar
]