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
		private ["_typeCAS","_typeATK","_ordance","_ordnanceInfo","_setCount","_height","_lowest","_rangeIndex","_ATK_range","_text","_isnil","_text","_result"];
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
	//-IP/BP
	case 1:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
		
		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			_TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:GRID]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["%1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), mapGridPosition _TGPOS];
				_TGPOS resize [3, 0];
				_taskVar set [1,
					[
						_markerInfo,
						_ctrl2 lbText (lbCurSel _ctrl2),
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2]
					]
				];
			} else {
				_taskVar set [1,["NA",[]]];
			};
		} else {
			if ((lbCurSel _ctrl1 == 1) || (_isOverwrite)) then {
				_TGPOS = uinamespace getVariable [["BCE_MAP_ClickPOS","BCE_IP/BP"] select _isOverwrite,[]];

				//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Elevation]
				if !(_TGPOS isEqualTo []) then {
					_TGPOS resize [3, 0];
					_markerInfo = format ["GRID: [%1]",mapGridPosition _TGPOS];
					_taskVar set [1,
						[
							_markerInfo,
							"GRID",
							_TGPOS,
							[lbCurSel _ctrl1,lbCurSel _ctrl2]
						]
					];
				} else {
					_taskVar set [1,["NA",[]]];
				};
			} else {
				_TGPOS = getpos cameraOn;
				_TGPOS set [2,0];
				_markerInfo = format ["GRID: [%1]",mapGridPosition _TGPOS];
				_taskVar set [1,
					[
						_markerInfo,
						"GRID",
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2]
					]
				];
			};
		};
		_ctrl3 ctrlSetText (_taskVar # 1 # 0);
	};

	//-DESC
	case 5:{
		_shownCtrls params ["_ctrl"];
		if (isnil {_text}) then {
			_text = ctrlText _ctrl;
		};
		_isEmptyInfo = ((_text == "--") || (_text == ""));

		_taskVar set [5,
			[
				["",_text],
				["NA","--"]
			] select _isEmptyInfo
		];
	};

	//-GRID
	case 6:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];

		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			_TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5:Elevation(ASL), 6:RAM]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["%1 [%2]", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8)];
				_TGPOS resize [3, 0];
				_taskVar set [6,
					[
						_markerInfo,
						_ctrl2 lbText (lbCurSel _ctrl2),
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						(AGLToASL _TGPOS) # 2,
						_markerInfo
					]
				];
			} else {
				_taskVar set [6,["NA",[]]];
			};
		} else {
			_TGPOS = uinamespace getVariable [["BCE_MAP_ClickPOS","BCE_GRID"] select _isOverwrite,[]];

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:Empty, 5:Elevation(ASL), 6:Marker info]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["GRID: [%1]",GetGRID(_TGPOS,8)];
				_TGPOS resize [3, 0];
				_taskVar set [6,
					[
						_markerInfo,
						"GRID",
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						(AGLToASL _TGPOS) # 2,
						_markerInfo
					]
				];
			} else {
				_taskVar set [6,["NA",[]]];
			};
		};
		_ctrl3 ctrlSetText (_taskVar # 6 # 0);
	};

	//-MARK
	case 7:{
		_shownCtrls params ["_ctrl1"];

		private _text = toUpper (trim (ctrlText _ctrl1));
		private _isEmptyInfo = ((_text == localize "STR_BCE_MarkWith") || (_text == ""));
		private _info = [format [" %1 :[%2]", localize "STR_BCE_With", _text],""] select _isEmptyInfo ;

		if _isEmptyInfo then {
			_ctrl1 ctrlSetText localize "STR_BCE_MarkWith";
		};

		_taskVar set [7,[
				["NA"],
				[_info,_text]
			] select (_text != "")
		];
	};

	//-Friendlies
	case 8:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4"];

		private _text = ctrlText _ctrl4;
		private _isEmptyInfo = ((_text == localize "STR_BCE_MarkWith") || (_text == ""));
		private _info = format ["%1 :[%2]", localize "STR_BCE_With", [toUpper _text,"NA"] select _isEmptyInfo];
		if _isEmptyInfo then {
			_ctrl4 ctrlSetText localize "STR_BCE_MarkWith";
		};

		if ((lbCurSel _ctrl1 == 0) && !(_isOverwrite)) then {
			_TGPOS = call compile (_ctrl2 lbData (lbCurSel _ctrl2));

			//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:LBCurSel, 5: Mark Info]
			if !(_TGPOS isEqualTo []) then {
				_markerInfo = format ["FRND: %1 [%2] %3", _ctrl2 lbText (lbCurSel _ctrl2), GetGRID(_TGPOS,8), _info];
				_TGPOS resize [3, 0];
				_taskVar set [8,
					[
						_markerInfo,
						_ctrl2 lbText (lbCurSel _ctrl2),
						_TGPOS,
						[lbCurSel _ctrl1,lbCurSel _ctrl2],
						_text
					]
				];
			} else {
				_taskVar set [8,["NA","",[],[0,0],""]];
			};
		} else {
			if ((lbCurSel _ctrl1 == 1) || (_isOverwrite)) then {
				_TGPOS = uinamespace getVariable [["BCE_MAP_ClickPOS","BCE_FRND"] select _isOverwrite,[]];

				//-[1:Marker, 2:Marker Name, 3:Marker POS, 4:CurSel, 5: Mark Info]
				if !(_TGPOS isEqualTo []) then {
					_markerInfo = format ["FRND: %1", _info];
					_TGPOS resize [3, 0];
					_taskVar set [8,
						[
							_markerInfo,
							"GRID",
							_TGPOS,
							[lbCurSel _ctrl1,lbCurSel _ctrl2],
							_text
						]
					];
				} else {
					_taskVar set [8,["NA","",[],[0,0],""]];
				};
			} else {
				_TGPOS = getpos cameraOn;
				_TGPOS set [2,0];
				_markerInfo = format ["FRND: [%1] %2",mapGridPosition _TGPOS, _info];
				_taskVar set [8,
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
		_ctrl3 ctrlSetText (_taskVar # 8 # 0);
	};

	//-EGRS [Toolbox, EditBox, output, Toolbox(Azimuth)]
	case 9:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5"];

		_HDG = _ctrl4 lbValue (lbCurSel _ctrl4);
		_TGPOS = nil;
		_marker = nil;
		if (lbCurSel _ctrl1 == 1) then {
			_TextInfo = ctrlText _ctrl2;

			//-Debug
			if ((_TextInfo == "") || (_TextInfo == localize "STR_BCE_Bearing_ENT") || isnil{(call compile _TextInfo)}) exitWith {
				hint localize "STR_BCE_Error_InputVal";
				_ctrl2 ctrlSetText localize "STR_BCE_Bearing_ENT";
			};

			_HDG = round (call compile _TextInfo);
			if (_HDG > 360) exitWith {
				_ctrl2 ctrlSetText localize "STR_BCE_Bearing_ENT";
				_HDG = nil;
			};
		} else {
			if (lbCurSel _ctrl1 == 2) then {
				_TGPOS = call compile (_ctrl5 lbData (lbCurSel _ctrl5));
				_TGPOS resize [3, 0];
				_marker = _ctrl5 lbText (lbCurSel _ctrl5);
			};
			if (lbCurSel _ctrl1 == 3) then {
				_TGPOS = getpos cameraOn;
				_TGPOS set [2,0];
				_marker = localize "STR_BCE_Tit_OverHead";
			};
		};

		_cardinaldir = _HDG call BCE_fnc_getAzimuth;

		_text = [
			format ["%1",_marker],
			format ["%1 %2°",_cardinaldir,_HDG]
		] select (isnil "_marker");

		if !(isnil"_cardinaldir") then {
			_taskVar set [9,[_text,_HDG,[lbCurSel _ctrl1,lbCurSel _ctrl4,lbCurSel _ctrl5],_TGPOS,_marker]];
			_ctrl3 ctrlSetText (_taskVar # 9 # 0);
		};
	};

	//-Remarks
	case 10:{
		//-FAD/H [Toolbox, EditBox, output, Toolbox(Azimuth), DanClose(Text), DanClose(Box)]
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5","_ctrl6"];

		private _HDG = _ctrl4 lbValue (lbCurSel _ctrl4);
		private _ctrl1Sel = lbCurSel _ctrl1;

		//-Set Default
		if (_ctrl1Sel == 2) then {
			_text = "FAD: “Default”";
			_ctrl3 ctrlSetText _text;
			_taskVar set [10,[_text,-1,[_ctrl1Sel,lbCurSel _ctrl4,cbChecked _ctrl6]]];
		} else {
			if (_ctrl1Sel == 1) then {
				_TextInfo = ctrlText _ctrl2;

				//-Debug
				if ((_TextInfo == "") || (_TextInfo == localize "STR_BCE_Bearing_ENT") || isnil{(call compile _TextInfo)}) exitWith {
					hint "Wrong Input!!";
					_ctrl2 ctrlSetText localize "STR_BCE_Bearing_ENT";
				};

				_HDG = (round (call compile _TextInfo)) % 360;
			};

			_HDG = [_HDG, 360 * ((_HDG / 360)-1)] select (_HDG < 0);
			_To_Dir = _HDG call BCE_fnc_getAzimuth;

			_From_Dir = [_HDG - 180,360 + (_HDG - 180)] select ((_HDG - 180) < 0);

			_DanClose = [""," [Danger Close]"] select (cbChecked _ctrl6);
			_text = format ["“%1” to “%2”",_From_Dir call BCE_fnc_getAzimuth,_To_Dir];

			if !(isnil"_To_Dir") then {
				_taskVar set [10,[_text + _DanClose,_From_Dir,[_ctrl1Sel,lbCurSel _ctrl4,cbChecked _ctrl6]]];
				_ctrl3 ctrlSetText _text;
			};
		};
	};
};

//-Automatically Generate
if (((_taskVar # 1 # 0) != "NA") && ((_taskVar # 6 # 0) != "NA")) then {
	private ["_taskVar_1","_taskVar_6","_HDG","_cardinaldir","_DIST"];
	_taskVar_1 = _taskVar # 1;
	_taskVar_6 = _taskVar # 6;

	//-2 HDG [Text ,Heading]
	_HDG = round (((_taskVar_1 # 2) getDirVisual (_taskVar_6 # 2)) / 10) * 10;

	_cardinaldir = _HDG call BCE_fnc_getAzimuth;

	_taskVar set [2, [format ["“%1” %2°", _cardinaldir, _HDG],_HDG]];

	//-3 DIST [Text ,Distance]
	_DIST = round (((_taskVar_1 # 2) distance2D (_taskVar_6 # 2)) / 100) * 100;
	_taskVar set [3, [format ["%1m",_DIST],_DIST]];
};

//- 6 GRID	//- 4 ELEV
if ((_taskVar # 6 # 0) != "NA") then {
	private ["_taskVar_6","_taskVar_7","_ELEV"];
	_taskVar_6 = _taskVar # 6;
	_taskVar_7 = _taskVar # 7;

	_ELEV = round (((_taskVar_6 # 4) * 3.2808399) / 10) * 10;

	//-in Feet
	_taskVar set [4, [format ["%1 MSL",_ELEV],_ELEV]];

	//-EGRS
	if (((_taskVar # 9 # 0) != "NA") && !(isnil {_taskVar # 9 # 3})) then {
		private ["_taskVar_9","_HDG","_text"];
		_taskVar_9 = _taskVar # 9;
		_HDG = round ((_taskVar_6 # 2) getDirVisual (_taskVar_9 # 3));
		_text = format ["[%1] %2 %3°",_taskVar_9 # 4, _HDG call BCE_fnc_getAzimuth, _HDG];
		_taskVar set [9,[_text,_HDG,_taskVar_9 # 2,_taskVar_9 # 3,_taskVar_9 # 4]];
	};
	//-Mark with
	_taskVar set [6, [format ["%1%2",_taskVar_6 # 5, ["",_taskVar_7 # 0] select ((_taskVar # 7 # 0) != "NA")],_taskVar_6 # 1,_taskVar_6 # 2,_taskVar_6 # 3,_taskVar_6 # 4,_taskVar_6 # 5]];
};

//-8 Friendlies
if (((_taskVar # 8 # 0) != "NA") && ((_taskVar # 6 # 0) != "NA") && (!((localize "STR_BCE_With") in (_taskVar # 8 # 0)) || (_isOverwrite))) then {
	private ["_taskVar_6","_taskVar_8","_HDG","_dist","_cardinaldir","_InfoText","_info","_isEmptyInfo"];
	_taskVar_6 = _taskVar # 6;
	_taskVar_8 = _taskVar # 8;

	//-[Text ,Dist]
	_TGPOS = _taskVar_8 # 2;
	_HDG = round (((_taskVar_6 # 2) getDirVisual _TGPOS) / 10) * 10;
	_dist = round (((_taskVar_6 # 2) distance2D _TGPOS) / 10) * 10;
	_cardinaldir = _HDG call BCE_fnc_getAzimuth;
	_InfoText = _taskVar_8 # 4;
	_isEmptyInfo = ((_InfoText == localize "STR_BCE_MarkWith") || (_InfoText == ""));

	_info = [
		format ["“%1” %2m %3: [%4]", _cardinaldir, _dist, localize "STR_BCE_With", toUpper _InfoText],
		format ["“%1” %2m", _cardinaldir, _dist]
	] select _isEmptyInfo;
	_taskVar set [8,[_info,_taskVar_8 # 1,_taskVar_8 # 2,_taskVar_8 # 3,_taskVar_8 # 4]];
};

uiNamespace setVariable ["BCE_CAS_9Line_Var",_taskVar];
