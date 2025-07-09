/*
  NAME : BCE_fnc_CFF_Mission_Get_Values

  Get Task Unit's Call for Fire Mission Values

  #LINK - functions/Task_Type/fn_DataSent_CFF.sqf
  [
    _taskType,            //- ADJUST, SUPRESS
    "11110000",           //- Grid
    player,               //- Requester
    [
      (_Wpn_setup # 0),   //- "_Wpn_setup_IE"
      (_Wpn_setup # 1),   //- "_Wpn_setup_IA"
      _random_POS,        //- Current targeting POS (Won't be spot on)
      _angleType,         //- false: "LOW", true: "High"
      _Sheaf_Info         //- ["_Sheaf_ModeSel", "_SheafValue"]: [2, [50,100]]
    ],
    _MSN_State            //- 0 : on "Registered", 1 : on "Fire For Effect"
  ]
*/
params [
  "_taskID"
];

private _pool = localNamespace getVariable ["#BCE_CFF_Task_Pool", createHashMap];
private _group = _pool getOrDefault [_taskID, grpNull];

//- Check _taskUnit exist
  if (isnull _group) exitWith {[]};

//- Get TaskUnit group infos (Current Unit's Tasks)
  private _CFF_Map = _group getVariable ["BCE_CFF_Task_Pool", createHashMap];

_CFF_Map getOrDefault [_taskID, []]