/*
  NAME : BCE_fnc_get_BCE_curDisplay

  Get Current Display from localNamespace

  Return :
    Display
*/

private _BCE_Holder = ["BCE_Holder"] call BCE_fnc_getTaskSingleComponent;

//- Check Control existance
  if (isNull _BCE_Holder) exitWith {
    ["""BCE_Holder"" does not exist!! Please check whether ""BCE_Holder"" is implemented correctly."] call BIS_fnc_error;

    displayNull
  };

ctrlParent _BCE_Holder;
