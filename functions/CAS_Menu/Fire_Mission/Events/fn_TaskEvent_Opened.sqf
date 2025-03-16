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
([] call BCE_fnc_getTaskProps) params ["_varName","_default","_events"];
([] call BCE_fnc_getTaskVar) params ["_taskVar"];

(_curLine call BCE_fnc_getTaskComponents) params ["_shownCtrls","_desc_str"];

// #!SECTION UPDATE CurLine
//- Update Current Display's CurLine
  [_curLine] call BCE_fnc_set_TaskCurLine;

//- On Empty Returns
  if (
    (_shownCtrls findIf {true} < 0) && 
    _desc_str == ""
  ) exitWith {
    ["No Task Infos are found - Make sure ""Vaild _curLine"" and ""Controls are created correctly"""] call BIS_fnc_error;
  };

//- Setup Description and Layout
  private _description = [2004] call BCE_fnc_getTaskSingleComponent;

  if !(isnull _description) then {
    private _groupDESC = ctrlParentControlsGroup _description;

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

//- Fires Function
  call (uiNamespace getVariable [(_events get "Opened"),{}]);