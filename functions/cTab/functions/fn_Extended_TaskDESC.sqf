params ["_control","_lbCurSel"];
private ["_display","_desc","_veh","_var","_textInfo","_text"];

_display = ctrlParent _control;
_desc = _display displayCtrl (17000 + 1790);

_veh = [nil,"AIR" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;;
_var = call compile (_veh getVariable ["BCE_Task_Receiver",""]);

//-get UNIT info
_textInfo = if (isNil {_var}) then {
	["--","N/A","","N/A","",localize "STR_BCE_No_Info"];
} else {
	_var params [["_caller_info",""],["_type",""],"",["_time",""]];

	//-[%4, %5, %6, |%7]
	[_type,_time,_caller_info,_control lbTextRight _lbCurSel];
};

_text = format ([
		"%1: <t color='#e3c500'>%4 line [%5]</t><br/>%2: <t color='#e3c500'>%6</t><br/><br/>%3:<br/><t color='#e3c500'>%7</t>",
		localize "STR_BCE_Task_Type",
		localize "STR_BCE_Caller",
		localize "STR_BCE_Detail"
	] + _textInfo
);
_desc ctrlSetStructuredText parseText _text;
