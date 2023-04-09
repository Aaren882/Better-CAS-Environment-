params ["_control"];

_move = {
  params["_ctrl","_open",["_isList",false]];
  if (_open) then {
    _pos = [
      _pos,
      [
        _pos # 0,
        _pos # 1,
        5 * (safezoneH / 40),
        _pos # 3
      ]
    ] select _isList;
    _ctrl ctrlSetPosition _pos;
  } else {
    _ctrl ctrlSetPosition [
      (_pos # 0) + (_pos # 2),
      _pos # 1,
      0,
      0
    ];
  };
  _ctrl ctrlSetFade ([1,0] select _open);
};

_display = ctrlparent _control;
_list_Racks = _display displayCtrl 201142;
_unit_pic = _display displayCtrl 20115;

_pos = ["x","y","w","h"] apply {
  call compile (getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _unit_pic >> _x))
};

if !(ctrlEnabled _list_Racks) then {
  _list_Racks ctrlenable true;
  [_list_Racks,true,true] call _move;
  [_unit_pic,false] call _move;
} else {
  _list_Racks ctrlenable false;
  [_list_Racks,false,true] call _move;
  [_unit_pic,true] call _move;
};
{_x ctrlCommit 0.3} forEach [_list_Racks,_unit_pic];

///////////////////////////////////////////////////////////////////////////////////////
//-get Racks radio
_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
_radio_Racks = _vehicle getVariable ["acre_sys_rack_vehicleRacks", []];
lbClear _list_Racks;

//-racks info
{
  _rack = _x;
  _class = configFile >> "CfgVehicles" >> (_rack call acre_sys_rack_fnc_getRackBaseClassname);

  //-mounted radio
  _radio = _rack call acre_api_fnc_getMountedRackRadio;
  _radioInfo = _radio call BCE_fnc_getFreq_ACRE;
  _radioInfo params ["_freq",["_channel",""]];

  _add = _list_Racks lbAdd format["%1: %2",_forEachIndex+1,getText (_class >> "displayName")];
  _color = [[1,0,0,0],[1,1,1,1]] select (([_radio,"getOnOffState"] call acre_sys_data_fnc_dataEvent) == 1);

  _list_Racks lbSetColor [_add, _color];
  _list_Racks lbSetSelectColorRight [_add, _color];

  if (_channel != "") then {
    _list_Racks lbSetTooltip [_add, _channel];
  };

  _list_Racks lbSetTextRight [_add, ([_freq,"“NA”"] select (isnil {_freq}))];
} forEach _radio_Racks;
