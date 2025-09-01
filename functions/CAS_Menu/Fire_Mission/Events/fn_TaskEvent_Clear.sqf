/*
  Use for triggering Clear Task/Mission Variable
  # LINK .\fn_getTaskProps.sqf
  
  Remove Current TaskVar : "_curLine"
*/

params ["_curLine"];

([] call BCE_fnc_getDisplayTaskProps) params ["_varName","_default","_events"];
([_curLine, _varName] call BCE_fnc_getTaskComponents) params ["_shownCtrls","_desc_str"];

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0) && 
    _desc_str == ""
  ) exitWith {
    ["No task info is found, neither ""UI Controls"" nor ""Description""."] call BIS_fnc_error;
  };

([] call BCE_fnc_getDisplayTaskProps) params ["","","_events"];

//- #NOTE - This is the Pool for the lines the needs to be Cleared
  // Params : ["LINE", "VALUE"] -- e.g. [2,["NA"]]
  private _clearPool = []; // <-- Da Pool

//- Fire Function
  [_clearPool] call (uiNamespace getVariable [(_events get "Clear"),{}]);


//- Save Variable
private _curType = [] call BCE_fnc_get_TaskCurType;
private _cateSel = ["Cate"] call BCE_fnc_get_TaskCurSetup;
private _display = ctrlParent (["BCE_Holder"] call BCE_fnc_getTaskSingleComponent);

{
  _x params ["_curLine","_value"];
  [
    [
      _curType,
      _cateSel,
      _display
    ],
    _curLine,
    _value
  ] call BCE_fnc_setTaskVar;
  false
} count _clearPool;

//- #TODO - Update Map Infos
	[] call BCE_fnc_Update_TaskMapInfo;