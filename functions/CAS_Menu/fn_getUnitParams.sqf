params ["_unit_x",["_turret_info",nil]];

_squad_param = squadParams _unit_x;

//-UNIT info
_result = if (_squad_param isNotEqualTo []) then {
  (_squad_param # 0) params ["", "_title", "", "", ["_picture",""], ["_unit",""]];

  [_picture,_unit,_title,_turret_info]
} else {
  private["_faction","_config","_picture"];
  _faction = getText (configof _unit_x >> "faction");
  _config = configFile >> "CfgFactionClasses" >> _faction;

  _picture = getText(_config >> "icon");
  _unit = getText(_config >> "displayName");
  [_picture,_unit,_unit,_turret_info]
};

_result
