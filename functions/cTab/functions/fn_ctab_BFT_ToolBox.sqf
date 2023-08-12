private ["_display","_clear","_task","_info","_status"];
params ["_control", "_selectedIndex",["_condition",true]];

_display = ctrlParent _control;
_clear = _display displayCtrl (17000 + 12011);

_task = switch (uiNameSpace getVariable ["BCE_Current_TaskType",0]) do {
  //- 5 line
  case 1: {
    [[-1,2,1],"BCE_CAS_5Line_Var"]
  };
  //- 9 line
  default {
    [[1,6,8],"BCE_CAS_9Line_Var"]
  };
};

_info = _task # 0 # _selectedIndex;

if (_info < 0) exitWith {
  _clear ctrlshow false;
};

_status = ((uiNameSpace getVariable (_task # 1)) # _info) param [0,"NA"];
_clear ctrlshow ((_status != "NA") && (_condition));
