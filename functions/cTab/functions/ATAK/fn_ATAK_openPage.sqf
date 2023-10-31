params ["_display","_page",["_condition",true],["_R", false]];

(_display displayCtrl 46600) ctrlShow ((_page != "main") && (_condition));

private _return = switch _page do {
  case "mission": {
    4661
  };
  default {
    4660
  };
};

[17000 + _return , [17000 + _return, 46600]] select _R;
