params ["_display","_items","_Index"];

_IDCs_list = _items # 0;

_IDCs_list apply {
  {
    if (_forEachIndex == _Index) exitWith {
      _x apply {_display displayctrl _x}
    };
  } forEach _x;
};
