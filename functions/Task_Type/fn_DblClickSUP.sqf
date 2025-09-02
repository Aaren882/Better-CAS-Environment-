switch _curLine do {
	//-Control type
	case 0:{
		_shownCtrls params [
			"_taskType",
			"_ammo","_fuse","_fireUnits","_rounds","_fuzeVal","_fireAngle",
			"_IA_ammo","_IA_fuse","_IA_fireUnits","_IA_rounds","_IA_fuzeVal"
		];
		_taskVar_0 = _taskVar # 0;
		private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

		private _storeVal = _taskVar_0 param [2,[]]; 		//- ["IEs","IAs","fireAngle"]

		//- Fire Angle Selection
		private _fireAngleType = _storeVal param [2, false];
		_fireAngle setVariable ["Mode", _fireAngleType];
		_fireAngle ctrlSetStructuredText parseText localize ([
			"STR_BCE_LO_Angle",
			"STR_BCE_HI_Angle"
		] select _fireAngleType);
		
		{
			_x params ["_lbAmmo","_lbFuze","_lbFireUnits","_editRounds","_editFuzeVal"];

			if (isNull _lbAmmo) then {continue};
			private _isIA = _lbAmmo == _IA_ammo;

			//- Create Weapon List
				lbClear _lbAmmo;
				if (_isIA) then {
					_lbAmmo lbAdd "--";
					_lbAmmo lbSetValue [0, -1];	
				};
				[
					_lbAmmo,
					_taskUnit
				] call BCE_fnc_WPN_List_CFF;
			
			//- Get Values
			(_storeVal param [_forEachIndex, []]) params [
				["_ctrlSel0",0],
				["_ctrlSel1",0],
				["_ctrlSel2",0],
				["_ctrlSel3",""],
				["_ctrlSel5",["0",""] select _isIA]
			];

			_lbAmmo 			lbSetCurSel _ctrlSel0;
			_lbFuze 			lbSetCurSel _ctrlSel1;
			_lbFireUnits	lbSetCurSel _ctrlSel2;
			_editRounds		ctrlSetText _ctrlSel3;
			_editFuzeVal	ctrlSetText _ctrlSel5;
		} forEach [
			[_ammo,_fuse,_fireUnits,_rounds,_fuzeVal],
			[_IA_ammo,_IA_fuse,_IA_fireUnits,_IA_rounds,_IA_fuzeVal]
		];
	};

	//-DESC
	case 3:{
		// #NOTE - Suppression 3mins, 4 rounds per minute, HE in Effect
		_shownCtrls params ["_Checkboxes","_Duration","_Rounds","_Interval","_SkipAdjust","_MinSec","_StructText","_outputText"];

		private _taskVar_3 = _taskVar # 3;
		private _taskVals = _taskVar_3 param [1, []];
		private _varStore = _taskVar_3 param [2, [[]]];
		(_varStore param [0,[]]) params [["_DurationTxt",0],["_RoundTxt",0],["_IntervalTxt",0]];
		(_varStore param [1,[]]) params [["_ctrlSel1",0],["_ctrlSel2",0],["_ctrlSel3",0],["_ctrlSel4",0],["_ctrlSel5",0]];

		//- Set Current values
		_taskVals params ["_duration_V",["_rounds_V",0],"_interval_V",["_rnds_Cnt",0]];
		
		private _output = if (
			_rounds_V != 0 && _rnds_Cnt != 0
		) then {
			format [
				"Total : %1 Shell(s) & %2 Rnd(s)", //- Total (Shots / Rounds)
				round _rounds_V * _rnds_Cnt,
				_rnds_Cnt
			];
		} else {
			"--"
		};
		_outputText ctrlSetText _output;

		_Duration ctrlSetText str _DurationTxt;
		_rounds ctrlSetText str _RoundTxt;
		_Interval ctrlSetText str _IntervalTxt;

		//- Onload Setup
		{
			[_Checkboxes, _forEachIndex, _curLine] call BCE_fnc_onTaskElementChange;
			_Checkboxes ctrlSetChecked [_forEachIndex, _x == 1];
		} forEach [_ctrlSel1,_ctrlSel2,_ctrlSel3];
		_SkipAdjust ctrlSetChecked [0, _ctrlSel4 == 1];
		_MinSec ctrlSetChecked [0, _ctrlSel5 == 1];
	};

	default { //- By Default
		call BCE_fnc_DblClickADJ;
	};
};