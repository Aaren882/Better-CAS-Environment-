// params ["_taskVar","_curLine","_shownCtrls"];
#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid

switch _curLine do {
	//- Game Plan
	case 0:{
		_shownCtrls params [
			"_taskType",
			"_CTAmmo","_CTFuse","_CTFireUnits","_CTRounds","_CTFuzeVal","_fireAngle",
			"_IA_ammo","_IA_fuse","_IA_fireUnits","_IA_rounds","_IA_fuzeVal"
		];

		private _textVal = [];
		private _storeVal = (_taskVar # 0) param [2,[]]; 		//- ["IEs","IAs","fireAngle"]
		private _setUpVal = [];
		private _mapValue = _CTAmmo getVariable ["CheckList",createHashMap];

		{
			_x params ["_lbAmmo","_lbFuse","_lbFireUnits","_editRounds","_editFuzeVal"];

			//-Get Data
				private _fireAmmo = _lbAmmo lbData (lbCurSel _lbAmmo);
				private _fireUnitSel = lbCurSel _lbFireUnits;
				private _FuseSel = lbCurSel _lbFuse;
				private _FuseData = _lbFuse lbData _FuseSel;

				private _fireUnits = 1 max (_lbFireUnits lbValue _fireUnitSel);
				private _setCount = 1 max (parseNumber (ctrlText _editRounds));
				private _fuzeVal = parseNumber (ctrlText _editFuzeVal);

				private _data = _mapValue get _fireAmmo;
				_data params ["",["_maxMagazine",1],"_count"];

				//- Check Ammo Count
				if (_fireAmmo != "") then {
					private _maxFireEach = floor (_count / _maxMagazine);
					private _maxFireCount = floor (_count / _fireUnits);
					
					if (
						_setCount > _maxFireEach ||
						_setCount > _maxFireCount
					) then {
						_setCount = _maxFireEach;
						_editRounds ctrlSetText (str _setCount);
					};
				} else {
					_setCount = 1;
					_editRounds ctrlSetText "";
				};
			
			//- Save Selections
			_storeVal set [ //- for UI selection recover
				_forEachIndex,
				[lbCurSel _lbAmmo,_FuseSel,_fireUnitSel,str _setCount,str _fuzeVal]
			];

			//- for Data transfer
				private _valueCheck = [
					[_fireAmmo,""],
					[_FuseData,""],
					[_fireUnits,0],
					[_setCount,0],
					[_fuzeVal,0]
				] apply {
					[_x # 0, nil] select (
						(_x # 0) == (_x # 1) &&
						_forEachIndex == 1
					)
				};
				_setUpVal set [ 
					_forEachIndex,
					_valueCheck
				];

			private _text = format [
				"%1%2 - x%3:%4",
				_fireAmmo, //- Ammo
				[
					format [" (%1)", _FuseData],
					""
				] select (_FuseData == ""), //- Fuze
				_fireUnits,
				_setCount
			];
			_textVal pushBack _text;

		} forEach [
			[_CTAmmo,_CTFuse,_CTFireUnits,_CTRounds,_CTFuzeVal],
			[_IA_ammo,_IA_fuse,_IA_fireUnits,_IA_rounds,_IA_fuzeVal]
		];

		private _taskTypeSel = lbCurSel _taskType;
		private _angleType = _fireAngle getVariable ["Mode", true];
		
		_fireAngle ctrlSetStructuredText parseText localize ([
			"STR_BCE_LO_Angle",
			"STR_BCE_HI_Angle"
		] select _angleType);
		_storeVal set [2, _angleType];
		
		private _result = [
			_textVal joinString "/",
			[_taskTypeSel, _taskType lbData _taskTypeSel],
			_storeVal,
			_setUpVal,
			_angleType //- "false = Low Angle" / "true = High Angle"
		];
		
		_taskVar set [0,_result];
	};

	//- Sheaf Type
	case 1:{
		_shownCtrls params [
      "_toolBox",
      "_output",
      "_Radius",
      "_LINE_L","_LINE_W","_LINE_Dir"
    ];

		private _Sheaf_ModeSel = lbCurSel _toolBox;
		private _Radius_V = ctrlText _Radius;
		private _LINE_V = [ctrlText _LINE_L, ctrlText _LINE_W, ctrlText _LINE_Dir];

		//- Get localized Sheaf info format
			private _sheaf_strArr = [
				_toolBox,
				"modes",
				[]
			] call BCE_fnc_get_Control_Data;

		private _sheaf_str = _sheaf_strArr param [_Sheaf_ModeSel,""];
		private _SheafRaw = call {
			//- Standard Sheaf
			if (_Sheaf_ModeSel == 0) exitWith {
				["100"]
			};
			//- Open Sheaf
			if (_Sheaf_ModeSel == 1) exitWith {
				[_Radius_V] //- Return
			};
			//- Linear Sheaf
			if (_Sheaf_ModeSel == 2) exitWith {
				_LINE_V //- Return
			};
			["50"]
		};
		
		//- Parse Numbers
			private _SheafValue = _SheafRaw apply {floor (parseNumber _x)};
			_sheaf_str = format ([_sheaf_str] + _SheafValue);
				
		//- Set output
			_output ctrlSetText _sheaf_str;

		//- Save Value
			_taskVar set [1, [
				_sheaf_str,
				[_Sheaf_ModeSel, _Radius_V, _LINE_V], //- Selection Store
				[_Sheaf_ModeSel, _SheafValue]
			]];
	};

	//-Target POS
	case 2:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			private _TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5:Elevation(ASL)]
			if !(_TGPOS isEqualTo []) then {
				private _markerInfo = format ["%1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8)];
				_TGPOS resize [3, 0];
				_taskVar set [2,
					[
						_markerInfo,
						_ctrl2 lbText (lbCurSel _ctrl2),
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						(AGLToASL _TGPOS) # 2
					]
				];
			} else {
				_taskVar set [2,["NA",[]]];
			};
		} else {
			private _TGPOS = uinamespace getVariable [["BCE_MAP_ClickPOS","BCE_GRID"] select _isOverwrite,[]];

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Empty, 5:Elevation(ASL), 6:Marker info]
			if !(_TGPOS isEqualTo []) then {
				private _markerInfo = format ["GRID: [%1]",GetGRID(_TGPOS,8)];
				_TGPOS resize [3, 0];
				_taskVar set [2,
					[
						_markerInfo,
						"GRID",
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						(AGLToASL _TGPOS) # 2
					]
				];
			} else {
				_taskVar set [2,["NA",[]]];
			};
		};
		_ctrl3 ctrlSetText (_taskVar # 2 # 0);
	};

	//-DESC
	case 3:{
		_shownCtrls params ["_ctrl1","_ctrl2"];

		private _text = ctrlText _ctrl1;
		private _InfoText = ctrlText _ctrl2;
		
		private _isEmptyInfo = {
			params ["_txt","_empty"];
			[
				_txt,
				""" """
			] select ((_txt == _empty) || (_txt == ""));
		};
		
		private _Info = [["","NA"] select (_text == "")] + (
			[
				[_text, "--"],
				[_InfoText, localize "STR_BCE_MarkWith"]
			] apply {
				_x call _isEmptyInfo
			}
		);
		
		_taskVar set [3, _Info];
	};

	//- Medthod of Controls
	case 4:{
		//- [Toolbox, EditBox, output, ETA(StructuredText)]
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

		private _pop_reason = "";
		private _ctrlMethod = lbCurSel _ctrl1; //- [At-Ready, TOT, AMC].

		private _ctrlParse = call {
			if (_ctrlMethod == 0) exitWith {
				["At-Ready", 0]
			};
			if (_ctrlMethod == 1) exitWith {
				private _input = ctrlText _ctrl2;
				private _TOT_time = if (count _input != 4) then {
					private _output = parseNumber _input;

					//- Check Min Value
					if (_output < 5) then {
						_pop_reason = "ToT(minutes) Must be >= 5 mins";
					};

					_output
				} else {
					private _clock_Hour = parseNumber (_input select [0,2]);

					//- Check Min Value (24hr)
					if (_clock_Hour - floor dayTime < 1) then {
						_pop_reason = "ToT(Clock) Must be >= 1 Hour";
					};
					_input //- Clock Time
				};

				["TOT - " + str _TOT_time, _TOT_time]
			};
			if (_ctrlMethod == 2) exitWith {
				["At My Command", -1]
			};
		};
		_ctrlParse params ["_type",["_value",-1]];
		
		if (_pop_reason != "") exitWith {
			hintSilent _pop_reason;
		};

		//- Update ouput display
			_ctrl3 ctrlSetText _type;

    private _functions = [_ctrl1,"functions",[]] call BCE_fnc_get_Control_Data;
		_taskVar set [4, [_type, [_ctrlMethod, _value], _functions param [_ctrlMethod, ""]]];
	};
};

//-Automatically Generate
//-Line 1
/* if (([!("Andorid" in (cTabIfOpen # 1)), false] select isnil {cTabIfOpen}) || _IDC_offset == 0) then {
	(_taskVar # 0) pushBackUnique ((_display displayCtrl (_IDC_offset + 2005)) lbText 0);
};

//-2 Friendly
if (((_taskVar # 1 # 0) != "NA") && ((_taskVar # 2 # 0) != "NA") && (!((localize "STR_BCE_With") in (_taskVar # 1 # 0)) || (_isOverwrite))) then {
	private ["_taskVar_1","_taskVar_2","_HDG","_dist","_cardinaldir","_InfoText","_info","_isEmptyInfo"];
	_taskVar_1 = _taskVar # 1;
	_taskVar_2 = _taskVar # 2;

	//-[Text ,Dist]
	_TGPOS = _taskVar_1 # 2;
	_HDG = round (((_taskVar_2 # 2) getDir _TGPOS) / 10) * 10;
	_dist = round (((_taskVar_2 # 2) distance2D _TGPOS) / 10) * 10;
	_cardinaldir = _HDG call BCE_fnc_getAzimuth;
	_InfoText = _taskVar_1 # 4;
	_isEmptyInfo = ((_InfoText == localize "STR_BCE_MarkWith") || (_InfoText == ""));

	_info = format ([
		["“%1” %2m [%3] %4: [%5]", _cardinaldir, _dist, GetGRID(_TGPOS,8), localize "STR_BCE_With", toUpper _InfoText],
		["“%1” %2m [%3]", _cardinaldir, _dist, GetGRID(_TGPOS,8)]
	] select _isEmptyInfo);

	_taskVar set [1, [_info,_taskVar_1 # 1,_taskVar_1 # 2,_taskVar_1 # 3,_taskVar_1 # 4]];
};
*/