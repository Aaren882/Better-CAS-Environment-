/*
  NAME : BCE_fnc_get_TaskCurLine

  Params : 
    "Display" : Display Object
  
  Set current task Line from task Display
*/
params [["_display",displayNull]];

//- ON Empty input
if (isnull _display) then {
  //-- _description Control Should be always Included in the controls
    private _description = "taskDesc" call BCE_fnc_getTaskSingleComponent;
  
  _display = ctrlParent _description;
};

//- Get Display IDD
  private _IDD = str (ctrlIDD _display);

private _map = ["CurDisplay", createHashMap] call BCE_fnc_get_TaskCurSetup;

_map getOrDefault [_IDD, -1];