params ["_display","_page",["_condition",true],["_BG", false]];

(_display displayCtrl 46600) ctrlShow ((_page != "main") && (_condition));

private _return = switch _page do {
  case "mission": {
    4661
  };
  case "mission_Build": {
    _display call BCE_fnc_ATAK_TaskCreate;
    4662
  };
  default {
    4660
  };
};

[17000 + _return , [17000 + _return, 46600]] select _BG;
