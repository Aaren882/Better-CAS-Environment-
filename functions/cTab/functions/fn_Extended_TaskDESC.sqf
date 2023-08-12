params ["_control","_lbCurSel"];

_display = ctrlParent _control;
_desc = _display displayCtrl (17000 + 1790);

_veh = player getVariable ["TGP_View_Selected_Vehicle",objNull];
_var = _veh getVariable ["BCE_Task_Receiver",[]];

_var params [["_caller",objNull],["_callerGrp",""],["_type",""],"",["_time",""]];

//-get UNIT info
_textInfo = if (isnull _caller) then {
  ["--","N/A","","N/A","","No description"];
} else {
  (_caller call BCE_fnc_getUnitParams) params ["",["_unit",""],["_title",""],""];

  [_type,_time,_callerGrp,name _caller,_title,_control lbTextRight _lbCurSel];
};

_text = format (["Task Type: <t color='#e3c500'>%1 line [%2]</t><br/>Caller: <t color='#e3c500'>%3 [%4] %5</t><br/><br/>Detail:<br/><t color='#e3c500'>%6</t>"] + _textInfo);
_desc ctrlSetStructuredText parseText _text;
