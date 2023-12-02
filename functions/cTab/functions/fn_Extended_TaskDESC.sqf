params ["_control","_lbCurSel"];
private ["_display","_desc","_veh","_var","_textInfo","_text"];

_display = ctrlParent _control;
_desc = _display displayCtrl (17000 + 1790);

_veh = player getVariable ["TGP_View_Selected_Vehicle",objNull];
_var = _veh getVariable ["BCE_Task_Receiver",[]];

_var params [["_caller",objNull],["_callerGrp",""],["_type",""],"",["_time",""]];

//-get UNIT info
_textInfo = if (isnull _caller) then {
  ["--","N/A","","N/A","",localize "STR_BCE_No_Info"];
} else {
  (_caller call BCE_fnc_getUnitParams) params ["",["_unit",""],["_title",""],""];

  [_type,_time,_callerGrp,name _caller,_title,_control lbTextRight _lbCurSel];
};

_text = format ([
    "%1: <t color='#e3c500'>%4 line [%5]</t><br/>%2: <t color='#e3c500'>%6 [%7] %8</t><br/><br/>%3:<br/><t color='#e3c500'>%9</t>",
    localize "STR_BCE_Task_Type",
    localize "STR_BCE_Caller",
    localize "STR_BCE_Detail"
  ] + _textInfo
);
_desc ctrlSetStructuredText parseText _text;
