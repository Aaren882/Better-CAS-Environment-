/*
  NAME : BCE_fnc_get_TaskCateIndex

  Params : [["CFF",[0,1]],["5LINE",[1,0]],["9LINE",[0,0]]]
    _key : e.g. "CFF", "5LINE"

  Return :
    ["Type", "Cate"]
    ARRAY of Indexes : 
      -- ex. [nil,0] -- AIR
      -- ex. [nil,1] -- GND
*/
params [["_key",""]];

if (_key == "") exitWith {
  ["Empty ""_key"" input !!"] call BIS_fnc_error;
};

//-- #NOTE - categories => ["_key","_types"]
[nil, (call BCE_fnc_get_BCE_TaskCateClasses) findIf {_key == (_x # 0)}];