params ["_list_Racks"];

_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
_radio_Racks = _vehicle getVariable ["acre_sys_rack_vehicleRacks", []];

if (count _radio_Racks == 0) exitWith {
  _list_Racks ctrlshow false;
};

lbClear _list_Racks;

//-racks info
{
  private ["_rack","_class","_radio","_radioInfo","_add","_color"];
  _rack = _x;
  _class = configFile >> "CfgVehicles" >> (_rack call acre_sys_rack_fnc_getRackBaseClassname);

  //-mounted radio
  _radio = _rack call acre_api_fnc_getMountedRackRadio;
  _radioInfo = _radio call BCE_fnc_getFreq_ACRE;
  _radioInfo params ["_freq",["_channel",""]];

  _add = _list_Racks lbAdd format["%1: %2",_forEachIndex+1,getText (_class >> "displayName")];
  _color = [[1,0,0,1],[1,1,1,1]] select (([_radio,"getOnOffState"] call acre_sys_data_fnc_dataEvent) == 1);

  _list_Racks lbSetColor [_add, _color];
  _list_Racks lbSetColorRight [_add, _color];
  _list_Racks lbSetSelectColor [_add, _color];
  _list_Racks lbSetSelectColorRight [_add, _color];

  if (_channel != "") then {
    _list_Racks lbSetTooltip [_add, _channel];
  };

  _list_Racks lbSetTextRight [_add, ([_freq,"“NA”"] select (isnil {_freq}))];
} forEach _radio_Racks;
