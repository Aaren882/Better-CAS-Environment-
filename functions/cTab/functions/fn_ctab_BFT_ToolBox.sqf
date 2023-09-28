private ["_display","_clear","_task","_info","_status"];
params ["_control", "_selectedIndex",["_condition",true]];

_display = ctrlParent _control;
if (_control isEqualTo (_display displayCtrl (17000 + 12010))) then {
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
} else {
  private ["_PLP_Tool","_PLP_EH","_displayName","_mapTypes","_currentMapType","_currentMapTypeIndex","_mapIDC","_map","_SelTool"];

  _PLP_Tool = _display displayCtrl 73453;
  _PLP_EH = uiNamespace getVariable ["PLP_SMT_EH",-1];

  _displayName = cTabIfOpen # 1;
  _mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
  _currentMapType = [_displayName,"mapType"] call cTab_fnc_getSettings;
  _currentMapTypeIndex = [_mapTypes,_currentMapType] call BIS_fnc_findInPairs;
  _mapIDC = _mapTypes # _currentMapTypeIndex # 1;

  //-Clean up
  if !(isNull _PLP_Tool) then {
    ctrlDelete _PLP_Tool;
  };
  if (_PLP_EH > 0) then {
    (_display displayCtrl _mapIDC) ctrlRemoveEventHandler ["Draw",_PLP_EH];
  };

  //-POLPOX Map Tools
  _SelTool = _Toolswitch (lbCurSel _control) do {
    //- 5 line
    case 0: {
      PLP_fnc_SMT_distance;
    };
    case 1: {
      PLP_fnc_SMT_markHouses;
    };
    case 2: {
    	PLP_fnc_SMT_height;
    };
    case 3: {
      PLP_fnc_SMT_compass;
    };
    case 4: {
      PLP_fnc_SMT_placeGrid;
    };
    case 5: {
      PLP_fnc_SMT_findFlat;
    };
  };
  [_display, _mapIDC] call _SelTool;
};
