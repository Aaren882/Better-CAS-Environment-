/*
  Name: cTab_fnc_setInterfacePosition
  
  Author(s):
    Gundy
  
  Description:
    Move the whole interface by a provided offset
  
  Parameters:
    0: STRING - uiNamespace variable name of interface
    1: ARRAY  - offset in the form of [x,y]
  
  Returns:
    BOOLEAN - TRUE
  
  Example:
    ["cTab_Tablet_dlg",[0.2,0.1]] call cTab_fnc_setInterfacePosition;
*/

private ["_display","_isDialog","_backgroundCtrl","_backgroundClassName","_displayConfigContainers"];
// disableSerialization;

params ["_displayName","_offset"];
_offset params ["_xOffset","_yOffset"];

_display = uiNamespace getVariable _displayName;
_isDialog = [_displayName] call cTab_fnc_isDialog;

// get both classes "controls" and "controlsBackground" if they exist
_displayConfigContainers = if (_isDialog) then {
  configFile >> _displayName
} else {
  configFile >> "RscTitles" >> _displayName
};

{
  {
    private _ctrl = _display displayCtrl getNumber (_x >> "idc");
    private _ctrlPosition = ctrlPosition _ctrl;
    _ctrl ctrlSetPositionX ((_ctrlPosition # 0) + _xOffset);
    _ctrl ctrlSetPositionY ((_ctrlPosition # 1) + _yOffset);
    _ctrl ctrlCommit 0;
    false
  } count ("0 < getNumber (_x >> 'idc')" configClasses _x);
  false
} count ("true" configClasses _displayConfigContainers);

true