if !(ace_map_gestures_enabled) exitWith {};

call {
  if (
    _toggle_show || (inputMouse 0) != 2
  ) exitWith {
    if (ace_map_gestures_EnableTransmit) then {
      ace_map_gestures_EnableTransmit = false;
      ACE_player setVariable ["ace_map_gestures_pointPosition", nil, true];
    };
  };

  if (!ace_map_gestures_EnableTransmit) then {
    ace_map_gestures_EnableTransmit = true;
  };

  ace_map_gestures_cursorPosition = _ctrlScreen ctrlMapScreenToWorld getMousePosition;
  if (
    ace_map_gestures_cursorPosition distance2D (ACE_player getVariable ["ace_map_gestures_pointPosition", [0, 0, 0]]) >= 1
  ) then {
    [ACE_player, "ace_map_gestures_pointPosition", ace_map_gestures_cursorPosition, ace_map_gestures_interval] call ace_common_fnc_setVariablePublic;
  };
};

if (getClientStateNumber < 10) then {
  [_ctrlScreen, ace_map_gestures_briefingMode] call cTab_fnc_MapPointer;
} else {
  [_ctrlScreen, [[ACE_player, ace_map_gestures_maxRange]]] call cTab_fnc_MapPointer;
};