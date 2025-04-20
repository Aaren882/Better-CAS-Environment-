/*
  NAME : BCE_fnc_Init_ATAK_Custom_DropMenu

  Init "_listGroup" Values
*/

params ["_tag_class","_listGroup"];

private _config = _tag_class >> "DropMenu_Props";

//- Variable for cTab_fnc_getSettings
  private _Variable_Name = [_config,"Variable_Name",""] call BIS_fnc_returnConfigEntry;
  if (_Variable_Name == "") exitWith {
    ["No Entry ""Variable_Name"" in ""%1""", ctrlClassName _controlGroup] call BIS_fnc_error;
    //- Return
      false
  };

//- #NOTE - Data is Saved in "_listGroup" (The List itself)
  if (_Variable_Name != (_listGroup getVariable ["Variable_Name", ""])) then {
    _listGroup setVariable ["Variable_Name",_Variable_Name];
  };

  //- Set "MaxOpened" value
    private _MaxOpened = [_config,"MaxOpened",-1] call BIS_fnc_returnConfigEntry;
    if (
      _MaxOpened > 0 && //- Must more than 0 or it will be multi-Sel
      isNil{_listGroup getVariable "MaxOpened"}
    ) then {
      _listGroup setVariable ["MaxOpened",_MaxOpened];
    };

//- Return
  true