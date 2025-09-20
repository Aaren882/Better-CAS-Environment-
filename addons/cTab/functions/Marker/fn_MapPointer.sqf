//- From "ace_map_gestures_fnc_drawMapGestures"
//- Change the Display icon

params ["_mapHandle", "_positions"];
private _players = [_positions, ace_map_gestures_fnc_getProximityPlayers, missionNamespace, "ace_map_gestures_proximityPlayersCache", 1] call ace_common_fnc_cachedCall;

{
  private _pos = _x getVariable "ace_map_gestures_pointPosition";
  
  if (alive _x && { !isNil "_pos" }) then {
    if (_x == ACE_player && { !isNil "ace_map_gestures_cursorPosition" }) then {
      _pos = ace_map_gestures_cursorPosition;
    };
    private _colorMap = ace_map_gestures_GroupColorCfgMappingNew getOrDefault [toLower groupId (group _x), [ace_map_gestures_defaultLeadColor, ace_map_gestures_defaultColor]]; 
    private _color = _colorMap select (_x != leader _x);
    
    _mapHandle drawIcon ["a3\ui_f\data\igui\cfg\simpletasks\types\target_ca.paa", _color, _pos, 25, 25, 0, "", 1, 0.030, "RobotoCondensedBold", "left"];
    _mapHandle drawIcon ["#(argb,1,1,1)color(0,0,0,0)", ace_map_gestures_nameTextColor, _pos, 20, 20, 0, name _x, 0, 0.030, "RobotoCondensedBold", "left"];
  };
} forEach _players;
