#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid

switch _curLine do {
	//-Control Type
	case 0:{
		_shownCtrls params [
			"_title_ctrl","_ctrl",
			"_title_type","_type",
			"_ord_title",
			"_CTweap","_CTmode","_CTrange","_CTcount","_CTHeight"
		];
		
		_typeCAS = ["T1","T2","T3"] # (lbCurSel _ctrl);
		_typeATK = ["BoT","BoC"] # (lbCurSel _type);

		_ordance = _CTmode lbdata (lbcursel _CTmode);
		_ordnanceInfo = call compile _ordance;
		_ordnanceInfo params ["_WeapName","_ModeName","_class","_Mode","_turret",["_Count",1,[0]]];

		//-Ammo Count
		_setCount = call compile (ctrlText _CTcount);
		_height = call compile (ctrlText _CTHeight);

		if (isnil{_setCount} || isnil{_height}) exitWith {};

		if (_setCount > _Count) then {
			_setCount = _Count;
			_CTcount ctrlSetText (str _Count);
		};
		
		//-so you can set it to whatever you want
		_lowest = 0;

		//-if it isn't a player (AI)
		if !(isPlayer _vehicle) then {
			_lowest = [50,500] select (_vehicle isKindOf "plane");
		};

		if (_height < _lowest) then {
			_height = _lowest;
			_CTHeight ctrlSetText (str _lowest);
		};

		//-Attack Range
		_rangeIndex = lbCurSel _CTrange;
		_ATK_range = _CTrange lbValue _rangeIndex;

		_Count = _setCount;

		_isnil = isnil {_ordnanceInfo};
		_text = format ["%1 %2 %3 %4m",_typeCAS,_typeATK,[_WeapName,"NA"] select _isnil,_height];

		_result = [
			_text,
			_typeCAS,
			_typeATK,
			[],
			[lbCurSel _ctrl,lbCurSel _type,lbCurSel _CTweap,lbCurSel _CTmode,_rangeIndex,str _setCount,str _height]
		];

		if !(isnil {_WeapName}) then {
			_result set [3,_ordnanceInfo + [_ATK_range,_height]];
		};
		
		_taskVar set [0,_result];
	};

	//-Friendly
	case 1:{
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
	};

	//-Target POS
	case 2:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			_TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5:Elevation(ASL), 6:RAM]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["%1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8)];
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
			_TGPOS = uinamespace getVariable [["BCE_MAP_ClickPOS","BCE_GRID"] select _isOverwrite,[]];

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Empty, 5:Elevation(ASL), 6:Marker info]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["GRID: [%1]",GetGRID(_TGPOS,8)];
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
		private ["_InfoText","_isEmptyInfo","_Info"];

		if (isnil {_text}) then {
			_text = ctrlText _ctrl1;
		};
		_InfoText = ctrlText _ctrl2;
		
		_isEmptyInfo = {
			params ["_txt","_empty"];
			[
				_txt,
				_empty
			] select ((_txt == _empty) || (_txt == ""));
		};
		
		_Info = [["","NA"] select (_text == "")] + (
			[
				[_text, "--"],
				[_InfoText, localize "STR_BCE_MarkWith"]
			] apply {
			_x call _isEmptyInfo
		});
		
		_taskVar set [3, _Info];
	};

	//-Remarks
	case 4:{
		//-FAD/H [Toolbox, EditBox, output, Toolbox(Azimuth), DanClose(Text), DanClose(Box)]
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5","_ctrl6"];

		private _HDG = _ctrl4 lbValue (lbCurSel _ctrl4);
		private _ctrl1Sel = lbCurSel _ctrl1;

		//-Set Default
		if (_ctrl1Sel == 2) then {
			_text = "FAD: “Default”";
			_ctrl3 ctrlSetText _text;
			_taskVar set [4,[_text,-1,[_ctrl1Sel,lbCurSel _ctrl4,cbChecked _ctrl6]]];
		} else {
			if (_ctrl1Sel == 1) then {
				_TextInfo = ctrlText _ctrl2;

				//-Debug
				if ((_TextInfo == "") || (_TextInfo == localize "STR_BCE_Bearing_ENT") || isnil{(call compile _TextInfo)}) exitWith {
					hint localize "STR_BCE_Error_InputVal";
					_ctrl2 ctrlSetText localize "STR_BCE_Bearing_ENT";
				};

				_HDG = (round (call compile _TextInfo)) % 360;
			};

			_HDG = [_HDG, 360 * ((_HDG / 360)-1)] select (_HDG < 0);
			_cardinaldir = _HDG call BCE_fnc_getAzimuth;

			_To_Dir = [_HDG - 180,360 + (_HDG - 180)] select ((_HDG - 180) < 0);

			_DanClose = [""," [Danger Close]"] select (cbChecked _ctrl6);
			_text = format ["“%1” to “%2”",_cardinaldir,_To_Dir call BCE_fnc_getAzimuth];

			if !(isnil"_cardinaldir") then {
				_taskVar set [4,[_text + _DanClose,_HDG,[_ctrl1Sel,lbCurSel _ctrl4,cbChecked _ctrl6]]];
				_ctrl3 ctrlSetText _text;
			};
		};
	};
};

//-Automatically Generate
//-Line 1
if (([!("Andorid" in (cTabIfOpen # 1)), false] select isnil {cTabIfOpen}) || _IDC_offset == 0) then {
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

uiNamespace setVariable ["BCE_CAS_5Line_Var",_taskVar];
