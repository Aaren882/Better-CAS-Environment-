/*
  NAME : BCE_fnc_CFF_Mission_Get_RAT_Values

  Description : Get values from "Record as Target"
  
  Return : 
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

//- Get "_MSN_Values"
private _pool = localNamespace getVariable ["#BCE_CFF_Task_RAT_Pool", createHashMap];

_pool getOrDefault [_taskID, []]
