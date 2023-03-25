if ((ctrlShown _description) or (_Veh_Changed)) then {
  switch _curLine do {
    //-IP/BP
    case 1:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
      _taskVar set [1,["NA","",[],[0,0]]];
      _ctrl3 ctrlSetText "NA";
    };

    //-DESC
    case 5:{
      _shownCtrls params ["_ctrl1"];
      _ctrl1 ctrlSetText "";
      _taskVar set [5,["NA",[]]];
    };

    //-GRID
    case 6:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
      _taskVar set [6,["NA","",[],[0,0],[]]];
      _ctrl3 ctrlSetText "NA";
      _ctrl4 ctrlSetText "Mark with...";
    };

    //-MARK
    case 7:{
      _shownCtrls params ["_ctrl1"];
      _taskVar set [7,["NA"]];
      _ctrl1 ctrlSetText "Mark with...";
    };

    //-Friendlies
    case 8:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
      _taskVar set [8,["NA","",[],[0,0],""]];
      _ctrl3 ctrlSetText "NA";
      _ctrl4 ctrlSetText "Mark with...";
    };

    //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth)]
    case 8:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];
      _taskVar set [9,["NA",0,[],nil,nil]];
      _ctrl2 ctrlSetText "Bearing...";
      _ctrl3 ctrlSetText "NA";
    };
    default {
      _shownCtrls apply {
        if (ctrlIDC _x == 2014) then {
          _x ctrlSetText "NA";
          break;
        };
      };
      _taskVar set [_curLine, _default # _curLine];
    };
  };
  uiNamespace setVariable ["BCE_CAS_9Line_Var", _taskVar];
} else {
  uiNamespace setVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",[]]]];
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
} forEach (uiNamespace getVariable "BCE_CAS_9Line_Var");
