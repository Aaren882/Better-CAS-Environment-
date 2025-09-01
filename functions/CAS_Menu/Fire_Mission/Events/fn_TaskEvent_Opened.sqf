/*
  NAME : BCE_fnc_TaskEvent_Opened

  On Task/Mission Building Load OR Refresh
*/

params ["_curLine"];

/*
  [
    "Variable Name",   : Default is Class name
    "Default Value",   : For Variable Editting
    "Events (HashMap)" : Functions
  ]
*/
([] call BCE_fnc_getDisplayTaskProps) params ["_varName","_default","_events"];
(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls","_desc_str"];

// #SECTION - UPDATE CurLine
//- Update Current Display's CurLine
  [_curLine] call BCE_fnc_set_TaskCurLine;

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0) && 
    _desc_str == ""
  ) exitWith {
    ["No task info is found, neither ""UI Controls"" nor ""Description""."] call BIS_fnc_error;
  };
([] call BCE_fnc_getTaskVar) params ["_taskVar"];

//- Setup Description and Layout
  private _description = "taskDesc" call BCE_fnc_getTaskSingleComponent;
	private _groupDESC = ctrlParentControlsGroup _description;

  if (!isnull _description && !isnull _groupDESC) then {

    //- Hide all un-needed Controls
      {
        _x ctrlShow (_x in _shownCtrls)
      } count (allControls _groupDESC);

    //- Description Text
      _description ctrlSetStructuredText parseText _desc_str;
      _description ctrlShow true;

    //- Layout
      private _posH = (ctrlPosition _groupDESC) # 3;
      private _posY = 0;
      private _ctrlH = 0;
      {
        (ctrlPosition _x) params ["","_ctrlPOSY","","_ctrlPOSH"];
        //- Find the lowest Control
          if (_ctrlPOSY > _posY) then {
            _posY = _ctrlPOSY;
          };
        //- Get Control Height
          if (!isnull _x && _ctrlH == 0) then {
            _ctrlH = _ctrlPOSH;
          };
      } forEach _shownCtrls;

      _posY = _posY + _ctrlH;

      _description ctrlSetPositionY _posY;
      _description ctrlSetPositionH (_posH - _posY);
      _description ctrlCommit 0;
  };

//- Fire Function
  call (uiNamespace getVariable [(_events get "Opened"),{}]);