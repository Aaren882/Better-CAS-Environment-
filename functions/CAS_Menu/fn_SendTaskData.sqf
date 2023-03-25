#define CHECK_TASK(TASK) ((TASK select 0) != "NA")
_drawT = {
  _HDG = _FRPOS getDirVisual _TGPOS;
  _POSs = [-90,90] apply {
    _TGPOS getPos [
      3000,
      _HDG + _x
    ]
  };
  _dis = _POSs apply {_from distance2D _x};

  (_POSs select ((_from distance (_POSs # 0)) > (_from distance (_POSs # 1))))
};

switch _sel_TaskType do {
  //-5 line
  case 1: {
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]]];
    _taskVar params ["_taskVar_0","_taskVar_1","_taskVar_2","_taskVar_3","_taskVar_4"];

    if (CHECK_TASK(_taskVar_1) && CHECK_TASK(_taskVar_2) && CHECK_TASK(_taskVar_3)) then {
      (_taskVar_4 # 1) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range"];
      [_vehicle, [], _taskVar_2 # 2, 0, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range],_taskVar,5] call BCE_fnc_Plane_CASEvent;
    } else {
      hint "Fail...\nCheck 2, 3, 4,and selected Aircraft.";
    };
  };
  //-9 line
  default {
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    _taskVar params ["_taskVar_0",["_taskVar_1",["NA","",[]]],"","","","",["_taskVar_6",["NA","111222"]],"","_taskVar_8",["_taskVar_9",["NA",0,[],nil,nil]],"_taskVar_10"];

    if (!(_vehicle isEqualTo objNull) && CHECK_TASK(_taskVar_0) && CHECK_TASK(_taskVar_6) && CHECK_TASK(_taskVar_8) && CHECK_TASK(_taskVar_9)) then {
      (_taskVar_0 # 3) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range"];

      _IP_NA = "NA" in _taskVar_1;
      _FAD_NA = (_taskVar_10 # 1) == -1;

      //-FAD/H
      _from = [_taskVar_1 # 2,_vehicle] select _IP_NA;
      _TGPOS = _taskVar_6 # 2;
      _FRPOS = _taskVar_8 # 2;

      //-Dont have both
      _POS = if (_FAD_NA && _IP_NA) then {
        call _drawT;
      } else {
        //-have FAD
        if !(_FAD_NA) then {
          (_TGPOS getPos [
            [_from distance2D _TGPOS, 3000] select _IP_NA,
            _taskVar_10 # 1
          ])
        } else {
          //-No FAD have IP
          if !(_IP_NA) then {
            call _drawT;
          };
        };
      };
      [_vehicle, _taskVar_1 # 2, _POS, _taskVar_6 # 2, _taskVar_9 # 1, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range],_taskVar,9] call BCE_fnc_Plane_CASEvent;
    } else {
      hint "Fail...\ncheck “Game Plan” ,6 ,8 ,9 ,and selected Aircraft.";
    };
  };
};
