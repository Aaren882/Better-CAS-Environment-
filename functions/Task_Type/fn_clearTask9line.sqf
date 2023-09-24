if ((ctrlShown _description) or (_Veh_Changed) or (_isOverwrite)) then {
  switch _curLine do {
    //-IP/BP
    case 1:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
      _taskVar set [1,["NA","",[],[0,0]]];
      //-Erase 2~4 line
      _taskVar set [2,["NA",180]];
      _taskVar set [3,["NA",200]];
      _taskVar set [4,["NA",15]];

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
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

      //-Erase 2~4 line
      _taskVar set [2,["NA",180]];
      _taskVar set [3,["NA",200]];
      _taskVar set [4,["NA",15]];

      _taskVar set [6,["NA","",[],[0,0],[]]];
      _ctrl3 ctrlSetText "NA";
    };

    //-MARK
    case 7:{
      _shownCtrls params ["_ctrl1"];
      _taskVar set [7,["NA"]];
      _ctrl1 ctrlSetText localize "STR_BCE_MarkWith";
    };

    //-Friendlies
    case 8:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
      _taskVar set [8,["NA","",[],[0,0],""]];
      _ctrl3 ctrlSetText "NA";
      _ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
    };

    //-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth)]
    case 8:{
      _shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];
      _taskVar set [9,["NA",0,[],nil,nil]];
      _ctrl2 ctrlSetText localize "STR_BCE_Bearing";
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
  uiNamespace setVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
};
