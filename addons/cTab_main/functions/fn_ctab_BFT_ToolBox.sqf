private ["_display","_clear","_task","_info","_status"];
params ["_control", "_selectedIndex",["_condition",true]];

_display = ctrlParent _control;
if (_control isEqualTo (_display displayCtrl (17000 + 12010))) then {
	_clear = _display displayCtrl (17000 + 12011);
	_task = switch ([] call BCE_fnc_get_TaskCurType) do {
		//- 5 line
		case 1: {
			[[-1,2,1],"BCE_CAS_5Line_Var"]
		};
		//- 9 line
		default {
			[[1,6,8],"BCE_CAS_9Line_Var"]
		};
	};

	_info = _task # 0 # _selectedIndex;

	if (_info < 0) exitWith {
		_clear ctrlshow false;
	};

	_status = ((uiNameSpace getVariable (_task # 1)) # _info) param [0,"NA"];
	_clear ctrlshow ((_status != "NA") && (_condition));
} else {
	private ["_PLP_Tool","_PLP_EH","_displayName","_mapTypes","_currentMapType","_currentMapTypeIndex","_mapIDC","_map","_cfg","_SelTool"];

	_PLP_Tool = _display displayCtrl 73453;
	_PLP_EH = uiNamespace getVariable ["PLP_SMT_EH",-1];

	_displayName = cTabIfOpen # 1;
	_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
	_currentMapType = [_displayName,"mapType"] call cTab_fnc_getSettings;
	_currentMapTypeIndex = [_mapTypes,_currentMapType] call BIS_fnc_findInPairs;
	_mapIDC = _mapTypes # _currentMapTypeIndex # 1;

	//-Clean up
	if !(isNull _PLP_Tool) then {
		ctrlDelete _PLP_Tool;
	};
	if (_PLP_EH > 0) then {
		(_display displayCtrl _mapIDC) ctrlRemoveEventHandler ["Draw",_PLP_EH];
	};

	//-POLPOX Map Tools
	_SelTool = switch (lbCurSel _control) do {
		//- 5 line
		case 0: {
			"Distance"
		};
		case 1: {
			"MarkHouses"
		};
		case 2: {
			"Height"
		};
		case 3: {
			"Compass"
		};
		case 4: {
			"EditGrid"
		};
		case 5: {
			"FindFlat"
		};
		case 6: {
			"lineOfSight"
		};
	};
	_cfg = configFile >> "PLP_SMT_Data" >> "RadialMenu" >> _SelTool;
	[_display, _mapIDC] call (missionNamespace getVariable getText (_cfg >> "function"));
	[_cfg,_display] call PLP_fnc_SMT_Description;
};
