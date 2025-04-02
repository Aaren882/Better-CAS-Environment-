switch _curLine do {
	//-Control type
	case 0:{
		_shownCtrls params [
			"_taskType",
			"_ammo","_fuse","_fireUnits","_rounds","_radius"
		];
		_taskVar_0 = _taskVar # 0;

		private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;

		//-Weapon List
		[
			_ammo,
			_taskUnit
		] call BCE_fnc_WPN_List_CFF;

		(_taskVar_0 param [2,[]]) params [
			["_ctrlSel0",0],
			["_ctrlSel1",0],
			["_ctrlSel2",0],
			["_ctrlSel3","1"],
			["_ctrlSel4","200"]
		];

		//-Default
		_ammo 	lbSetCurSel _ctrlSel0;
		_fuse 	lbSetCurSel _ctrlSel1;
		_fireUnits	lbSetCurSel _ctrlSel2;
		_rounds	ctrlSetText _ctrlSel3;
		_radius	ctrlSetText _ctrlSel4;
	};

	//-Friendly
	/* case 1:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];
		private ["_taskVar_1","_ctrl4POS","_InfoText","_isEmptyInfo","_Info"];
		_taskVar_1 = _taskVar # 1;
		_ctrl4POS = ctrlPosition _ctrl4;
		_InfoText = _taskVar_1 # 4;
		_isEmptyInfo = ((_InfoText == localize "STR_BCE_MarkWith") || (_InfoText == ""));

		_Info = [
			_InfoText,
			localize "STR_BCE_MarkWith"
		] select _isEmptyInfo;
		_Info = [
			_InfoText,
			localize "STR_BCE_MarkWith"
		] select _isEmptyInfo;

		//-Back to previous status
		if ((_taskVar_1 # 0) != "NA") then {
			_ctrl1 lbSetCurSel (_taskVar_1 # 3 # 0);
			_ctrl2 lbSetCurSel (_taskVar_1 # 3 # 1);
			_ctrl4 ctrlSetText _Info;
		} else {
			_ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
		};

		_ctrl1sel = lbCurSel _ctrl1;
		_ctrl3 ctrlSetText (_taskVar_1 # 0);

		if (_ctrl1sel == 0) then {
			_ctrl2 ctrlShow true;
			_ctrl2 call BCE_fnc_IPMarkers;
		} else {
			_ctrl2 ctrlShow false;
		};
	}; */

	//-Target
	case 2:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
		_taskVar_2 = _taskVar # 2;

		(_taskVar_2 param [3,[]]) params [["_ctrlSel1",0],["_ctrlSel2",0]];

		//- Generate Markers
		if (_ctrlSel1 == 0) then {
			_ctrl2 ctrlShow true;
			_ctrl2 call BCE_fnc_IPMarkers;
		} else {
			_ctrl2 ctrlShow false;
		};

		//-Back to previous status
		if ((_taskVar_2 # 0) != "NA") then {
			_ctrl1 lbSetCurSel _ctrlSel1;
			_ctrl2 lbSetCurSel _ctrlSel2;
		};

		_ctrl1sel = lbCurSel _ctrl1;
		_ctrl3 ctrlSetText (_taskVar_2 # 0);
	};

	//-DESC
	case 3:{
		_shownCtrls params ["_ctrl1","_ctrl2"];
		private ["_taskVar_3","_InfoText","_isEmptyInfo","_Info","_ctrlPOS"];
		_taskVar_3 = _taskVar # 3;
		_InfoText = _taskVar_3 # 2;

		_isEmptyInfo = ((_InfoText == localize "STR_BCE_MarkWith") or (_InfoText == ""));

		_Info = [_InfoText, localize "STR_BCE_MarkWith"] select _isEmptyInfo;
		
		//-Back to previous status
		if ((_taskVar_3 # 0) != "NA") then {
			_ctrl1 ctrlSetText (_taskVar_3 # 1);
			_ctrl2 ctrlSetText _Info;
		} else {
			_ctrl1 ctrlSetText "";
			_ctrl2 ctrlSetText localize "STR_BCE_MarkWith";
		};
	};

	//- Medthod of Controls
	case 4:{
		//- [Toolbox, EditBox, output, ETA(StructuredText)]
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

		_taskVar_4 = _taskVar # 4;

		//-Back to previous status
		(_taskVar_4 # 1) params [["_cndtion1",0],["_cndtion2",-1]];
		_ctrl1 lbSetCurSel _cndtion1;

		if (_cndtion2 != -1) then {
			_ctrl2 ctrlSetText (str _cndtion2);
		};
		
		_ctrl3 ctrlSetText (_taskVar_4 # 0);

		call {
      if (_cndtion1 == 1) exitWith {
        _ctrl2 ctrlShow true;
      };
      _ctrl2 ctrlShow false;
    };
	};
};