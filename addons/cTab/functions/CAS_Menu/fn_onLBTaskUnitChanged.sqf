/*
	NAME : BCE_fnc_onLBTaskUnitChanged

	Params :	
		"_control",
		"_lbCurSel"

	Connection between "BCE_TaskEvent" and "LBSelChanged" Event 
*/

//- Set "LBSelChanged" Eventhandler
	["BCE_TaskBuilding_LBTaskUnitChanged", _this] call CBA_fnc_localEvent;