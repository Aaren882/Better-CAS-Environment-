// - "9Line" call BCE_fnc_getTaskVar
// RETURN : [ARRAY , ARRAY]
params [["_taskID",""]];

private _name = format ["BCE_CAS_%1_Var",_taskID];

private _defaultVal = switch _taskID do {
  case "5Line": {
    [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",-1,[]]]
  };
  case "9Line": {
    [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","--"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]
  };
  default {[]};
};

private _taskVar = uiNamespace getVariable [_name,_defaultVal];

private _maximum = count _defaultVal; //- Remark Index
[_taskVar, _defaultVal, _maximum]