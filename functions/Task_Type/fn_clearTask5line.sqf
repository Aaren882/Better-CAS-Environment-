if ((ctrlShown _description) or (_Veh_Changed)) then {
  switch _curLine do {
    case 1:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
      _taskVar set [1,["NA","",[],[0,0],""]];
      _ctrl3 ctrlSetText "NA";
      _ctrl4 ctrlSetText "Mark with...";
    };
    //-DESC
    case 3:{
      _shownCtrls params ["_ctrl1","_ctrl2"];
      _ctrl1 ctrlSetText "";
      _ctrl2 ctrlSetText "Mark with...";
      _taskVar set [3,["NA","--",""]];
    };
    default {
      _taskVar set [_curLine, ["NA",[]]];
    };
  };
  uiNamespace setVariable ["BCE_CAS_5Line_Var", _taskVar];
} else {
  uiNamespace setVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]]];
};

//-Task Status
{
  if ((_x # 0) != "NA") then {
    _TaskList lbSetTextRight [_forEachIndex, (_x # 0)];
    _TaskList lbSetPictureRight [_forEachIndex,"\a3\ui_f\data\Map\Diary\Icons\diaryAssignTask_ca.paa"];
    _TaskList lbSetPictureRightColor [_forEachIndex, [0, 1, 0, 1]];
    _TaskList lbSetPictureRightColorSelected [_forEachIndex, [0, 1, 0, 1]];
  } else {
    _TaskList lbSetPictureRight [_forEachIndex,"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"];
    _TaskList lbSetPictureRightColor [_forEachIndex, [0, 0, 0, 0]];
    _TaskList lbSetPictureRightColorSelected [_forEachIndex, [0, 0, 0, 0]];
    _TaskList lbSetTextRight [_forEachIndex, _Expression_TextR # _forEachIndex];
  };
} forEach (uiNamespace getVariable "BCE_CAS_5Line_Var");
