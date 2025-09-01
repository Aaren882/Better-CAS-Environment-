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
				["_ctrlSel3",["5","1"] select _isIA],
				["_ctrlSel5",["0",""] select _isIA]
			];

			_lbAmmo				lbSetCurSel _ctrlSel0;
			_lbFuze				lbSetCurSel _ctrlSel1;
			_lbFireUnits	lbSetCurSel _ctrlSel2;
			_editRounds		ctrlSetText _ctrlSel3;
			_editFuzeVal	ctrlSetText _ctrlSel5;
		} forEach [
			[_ammo,_fuse,_fireUnits,_rounds,_fuzeVal],
			[_IA_ammo,_IA_fuse,_IA_fireUnits,_IA_rounds,_IA_fuzeVal]
		];
	};

	//- Sheaf
	case 1:{
		_shownCtrls params [
      "_toolBox",
      "_output","_sheaf_Struct",
      "_Radius",
      "_LINE_L","_LINE_W","_LINE_Dir"
    ];

		_taskVar_0 = _taskVar # 0;
		_taskVar_1 = _taskVar # 1;
		(_taskVar_1 param [1,[]]) params [["_ctrlSel1",0],["_Radius_V","150"],["_LINE_V",["50","50","0"]]];

		//- Check Ammunition Effective radius
			private _effectRadius_txt = "--";
			private _Ammo_Data = _taskVar_0 param [3,[]];
			(_Ammo_Data param [0,[]]) params [["_fireAmmo",""]/*,"_FuseData","_fireUnits","_setCount","_fuzeVal"*/];
			if (_fireAmmo != "") then {
				private _ammo = [_fireAmmo,true] call BCE_fnc_getMagazineAmmo;
				private _effectRadius = round getNumber (configfile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
				
				_effectRadius_txt = [str _effectRadius, _effectRadius_txt] select (_effectRadius == 0);
			};
			_sheaf_Struct ctrlSetStructuredText parseText format ["<img image='MG8\AVFEVFX\data\explosion.paa'/> %1 m", _effectRadius_txt];

		//- Set Text
			_Radius ctrlSetText _Radius_V;
			_LINE_L ctrlSetText (_LINE_V # 0);
			_LINE_W ctrlSetText (_LINE_V # 1);
			_LINE_Dir ctrlSetText (_LINE_V # 2);

		//- Init Layout
			_toolBox lbSetCurSel _ctrlSel1;
			[_toolBox,_ctrlSel1,_curLine] call BCE_fnc_onTaskElementChange;

		//- Set output
			_output ctrlSetText (_taskVar_1 # 0);
	};

	//-Target
	case 2:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
		_taskVar_2 = _taskVar # 2;

		(_taskVar_2 param [3,[]]) params [["_ctrlSel1",0],["_ctrlSel2",0]];

		//- Generate Markers
		[_ctrl2,_ctrlSel1,_curLine] call BCE_fnc_onTaskElementChange;

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

		private _typeTOT = typeName _cndtion2;
		private _TOT = call {
			if (_typeTOT == "STRING") exitWith {_cndtion2};
			["",str _cndtion2] select (_cndtion2 != -1) //- Return
		};

		if (_TOT != "") then {
			_ctrl2 ctrlSetText _TOT;
		};
		
		_ctrl3 ctrlSetText (_taskVar_4 # 0);
		[_ctrl2,_cndtion1,_curLine] call BCE_fnc_onTaskElementChange;

		//- Get ETA Time
			private _ETA_txt = "ETA : ""NA""";
			private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
			private _AmmoInfos = (_taskVar # 0) param [3, []];
			private _TG_POS = (_taskVar # 2) param [2, []];
			if (
				alive _taskUnit &&
				_TG_POS isNotEqualTo [] &&
				_AmmoInfos isNotEqualTo []
			) then {
				private _angleType = (_taskVar # 0) param [4, false];

				private _chargeInfo = [
					_taskUnit,
					_AmmoInfos # 0 # 0,
					AGLToASL _TG_POS,
					_angleType
				] call BCE_fnc_getCharge;

				_chargeInfo params ["", "", ["_ETA", 0]];
				
				// private _ETA = round (_taskUnit getArtilleryETA [_TG_POS,_AmmoInfos # 0 # 0]);

				_ETA_txt = format [
					"ETA - %1",
					[floor (_ETA/60), round (_ETA % 60)] joinString ":"
				];
			};

		_ctrl4 ctrlSetStructuredText parseText _ETA_txt;
	};
};