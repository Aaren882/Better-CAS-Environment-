/*
  NAME : BCE_fnc_ATAK_Custom_DropMenu_Init

  Load Drop Menu properties
*/
params ["_controlGroup","_config"];

_config = _config >> "DropMenu_Props";

//- #NOTE - Data is Saved in "_controlGroup" (Tag Group)
//- Set "Expand_Height" value
  private _expand = [_config,"Expand_Height",2] call BIS_fnc_returnConfigEntry;
  _controlGroup setVariable ["Expand_Height",_expand];

//- Set "Index" value
  _controlGroup setVariable ["Index", (ctrlIDC _controlGroup) % 100]; //- Set Ctrl Index

//- #SECTION - Registor EH
    private _tagBnt = _controlGroup controlsGroupCtrl 15;

  //- Other Events #NOTE - Data is Saved in "_controlGroup"
    {
      private _fnc = [_config,_x,""] call BIS_fnc_returnConfigEntry;
      if (_fnc == "") then {continue}; //- Check Empty
      _controlGroup setVariable [_x,_fnc]; //- Save eventName
    } forEach [
      "onTagLoad",
      "onTagClick"
    ];
    _tagBnt ctrlAddEventHandler ["ButtonClick",BCE_fnc_ATAK_Custom_DropMenu_Click];
//- #!SECTION