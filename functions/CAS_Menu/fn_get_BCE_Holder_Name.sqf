/*
  NAME : BCE_fnc_get_BCE_Holder_Name

  Get BCE_Holder name from Display

  Return :
    <STRING>
*/

params [["_display", displayNull,[displayNull]]];

if (isNull _display) then {
  private _ctrl = "BCE_Holder" call BCE_fnc_getTaskSingleComponent;
  _display = ctrlParent _ctrl;
};

_display getVariable ["BCE_Holder_Name", ""]