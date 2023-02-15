#define CHECK_TASK(TASK) ((TASK select 0) != "NA")

switch (_Task_Type lbValue (lbCurSel _Task_Type)) do {
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
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",[]]]];
    _taskVar params ["",["_taskVar_1",["NA","",[]]],"","","","",["_taskVar_6",["NA","111222"]],"","",["_taskVar_9",["NA",0,[],nil,nil]],["_taskVar_10",["NA",[]]]];

    if (!(_vehicle isEqualTo objNull) && ((_taskVar_6 # 0) != "NA") && ((_taskVar_9 # 0) != "NA") && ((_taskVar_10 # 0) != "NA")) then {
      (_taskVar_10 # 1) params ["_WeapName","_ModeName","_class","_Mode","_turret","_Count","_muzzle","_ATK_range"];
      [_vehicle, _taskVar_1 # 2, _taskVar_6 # 2, _taskVar_9 # 1, [_class,_Mode,_turret,_Count,_muzzle,_ATK_range],_taskVar,9] call BCE_fnc_Plane_CASEvent;
    } else {
      hint "Fail...\nCheck 6,9,Remarks,and selected Aircraft.";
    };
  };
};
