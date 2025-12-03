/*
  NAME : BCE_fnc_get_TaskIndex

  Params : [["ADJ",[0,1]],["5LINE",[1,0]],["9LINE",[0,0]]]
    _key : e.g. "ADJ", "5LINE"

  Return :
    ["Type", "Cate"]
    ARRAY of Indexes : ex. [0,1] -- ADJ
*/
params [["_key",""]];

if (_key == "") exitWith {
  ["Empty ""_key"" input !!"] call BIS_fnc_error;
};

private _index = localNamespace getVariable ["BCE_Mission_Index", createHashMap];

//- Arrange According (For Task Items)
  if (count _index == 0) then {

    _index = createHashMap;
    {
      _x params ["","_items"];

      private _cate = _forEachIndex;
      {
        _index set [_x,[_forEachIndex,_cate]];
      } forEach _items;
    } forEach (call BCE_fnc_get_BCE_TaskCateClasses);

    localNamespace setVariable ["BCE_Mission_Index", _index];
  };

_index getOrDefault [_key, [-1,-1]];
