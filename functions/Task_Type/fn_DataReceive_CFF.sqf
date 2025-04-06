// params ["_taskVar","_curLine","_shownCtrls"];
#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid

switch _curLine do {
	//- Game Plan
	case 0:{
		_shownCtrls params [
			"_taskType",
			"_CTAmmo","_CTFuse","_CTFireUnits","_CTRounds","_CTRadius"
		];

		//-Get Data
		_fireAmmo = _CTAmmo lbData (lbCurSel _CTAmmo);
		_fireUnitSel = lbCurSel _CTFireUnits;

		_fireUnits = _CTFireUnits lbValue _fireUnitSel;
		_setCount = parseNumber (ctrlText _CTRounds);
		_radius = parseNumber (ctrlText _CTRadius);

		private _mapValue = _CTAmmo getVariable ["CheckList",createHashMap];
		private _data = _mapValue get _fireAmmo;
		_data params ["",["_maxMagazine",1],"_count"];

		//- Check Ammo Count
			_maxFireEach = floor (_count / _maxMagazine);
			_maxFireCount = floor (_count / _fireUnits);
			
			if (
				_setCount > _maxFireEach ||
				_setCount > _maxFireCount
			) then {
				_setCount = _maxFireEach;
				_CTRounds ctrlSetText (str _setCount);
			};

		//- Save Selections
		_text = format [
			"%1 (%2) - x%3:%4 %5m",
			_fireAmmo, //- Ammo
			"", //- Fuze
			_fireUnits,
			_setCount,
			_radius
		];
		_result = [
			_text,
			lbCurSel _taskType,
			[lbCurSel _CTAmmo,lbCurSel _CTFuse,_fireUnitSel,str _setCount,str _radius]
		];

		if (_fireAmmo != "") then {
			_result set [3,[_fireAmmo,_fireUnits,_setCount,_radius]];
		};
		
		_taskVar set [0,_result];
	};

	//-Friendly
	/* case 1:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

		private _text = ctrlText _ctrl4;
		private _isEmptyInfo = ((_text == localize "STR_BCE_MarkWith") || (_text == ""));
		private _info = format ["%1 :[%2]", localize "STR_BCE_With", [toUpper _text, "NA"] select _isEmptyInfo];

		if _isEmptyInfo then {
			_ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
		};

		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			_TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5: Mark Info]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["FRND: %1 [%2] %3", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8), _info];
				_TGPOS resize [3, 0];
				_taskVar set [1,
					[
						_markerInfo,
						_ctrl2 lbText (lbCurSel _ctrl2),
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						_text
					]
				];
			} else {
				_taskVar set [1,["NA","",[],[0,0],""]];
			};
		} else {
			if ((lbCurSel _ctrl1 == 1) || (_isOverwrite)) then {
				_TGPOS = uinamespace getVariable [["BCE_MAP_ClickPOS","BCE_FRND"] select _isOverwrite,[]];

				//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:CurSel, 5: Mark Info]
				if !(_TGPOS isEqualTo []) then {
					_markerInfo = format ["FRND: %1", _info];
					_TGPOS resize [3, 0];
					_taskVar set [1,
						[
							_markerInfo,
							"GRID",
							_TGPOS,
							[lbCurSel _ctrl1,lbCurSel _ctrl2],
							_text
						]
					];
				} else {
					_taskVar set [1,["NA","",[],[0,0],""]];
				};
			} else {
				_TGPOS = getpos cameraOn;
				_TGPOS set [2,0];
				_markerInfo = format ["FRND: [%1] %2",mapGridPosition _TGPOS, _info];
				_taskVar set [1,
					[
						_markerInfo,
						"GRID",
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						_text
					]
				];
			};
		};
		_ctrl3 ctrlSetText (_taskVar # 1 # 0);
	}; */

	//-Target POS
	case 2:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			private _TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5:Elevation(ASL), 6:RAM]
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

		_text = ctrlText _ctrl1;
		_InfoText = ctrlText _ctrl2;
		
		_isEmptyInfo = {
			params ["_txt","_empty"];
			[
				_txt,
				""" """
			] select ((_txt == _empty) || (_txt == ""));
		};
		
		_Info = [["","NA"] select (_text == "")] + (
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

		private _ctrlMethod = lbCurSel _ctrl1; //- [At-Ready, TOT, AMC].

		private _ctrlParse = call {
			if (_ctrlMethod == 0) exitWith {
				["At-Ready"]
			};
			if (_ctrlMethod == 1) exitWith {
				private _TOT_time = parseNumber (ctrlText _ctrl2);
				["TOT - " + str _TOT_time, _TOT_time]
			};
			if (_ctrlMethod == 2) exitWith {
				["At My Command"]
			};
		};
		_ctrlParse params ["_type",["_value",-1]];
		
		//- Update ouput display
			_ctrl3 ctrlSetText _type;

		_taskVar set [4, [_type, [_ctrlMethod,_value]]];
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