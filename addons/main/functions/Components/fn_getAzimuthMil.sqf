/*
  NAME : BCE_fnc_getAzimuthMil

  Return : <STRING>
    ex. "0152.1"
*/

params ["_HDG"];
if (isnil{_HDG}) exitWith {nil};

// #NOTE - According to "B2C2497 Call For Indirect Fire"
  // 17.777777... ~= 17.8

[_HDG/360*6400, 4] call CBA_fnc_formatNumber;
