/*
	NAME : BCE_fnc_onLBTaskTypeChanged

	Params :	
		"_control",
		"_lbCurSel",
		["_IDC_offset",0]

	Connection between "BCE_TaskEvent" and "LBSelChanged" Event 
*/

//- Set "LBSelChanged" Eventhandler
	["BCE_TaskBuilding_LBTaskTypeChanged", _this] call CBA_fnc_localEvent;
