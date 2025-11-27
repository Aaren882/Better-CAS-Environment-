/*
  NAME : BCE_fnc_set_TaskCurLine

  params :
    "_curLine" : Current line of _curLine
  
  #LINK - functions/CAS_Menu/Fire_Mission/Events/fn_TaskEvent_Opened.sqf
  Set current task Line from task Display
*/
params ["_curLine"];

//- IF _curLine < 0
  if (_curLine < 0) then {
    ([] call BCE_fnc_getTaskVar) params ["_taskVar"];
    _curLine = (count _taskVar) + _curLine;
  };

//-- _description Control Should be always Included in the controls
  private _description = "taskDesc" call BCE_fnc_getTaskSingleComponent;
  
  //- Get Display IDD
  private _IDD = str (ctrlIDD (ctrlParent _description));

//- Get "CurDisplay" Key
  private _map = ["CurDisplay", createHashMap] call BCE_fnc_get_TaskCurSetup;
  _map set [_IDD, _curLine];

//- UPDATE CurLine VALUE => #LINK - .\fn_set_TaskCurSetup.sqf
//- Update "CurDisplay"
  ["CurDisplay",_map] call BCE_fnc_set_TaskCurSetup;
