params ["_display","_page",["_Back", false]];

(_display displayCtrl 46600) ctrlShow _Back;

private _return = switch _page do {
  case "mission": {
    4661
  };
  case "mission_Build": {
    _display call BCE_fnc_ATAK_TaskCreate;
    nil
  };
  default {
    4660
  };
};

//
if (isnil {_return}) exitWith {};
17000 + _return