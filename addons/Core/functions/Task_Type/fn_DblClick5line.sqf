switch _curLine do {
	//-Control type
	case 0:{
		_shownCtrls params [
			"_title_ctrl","_ctrl",
			"_title_type","_type",
			"_ord_title",
			"_weap","_mode","_range","_count","_height"
		];
		_taskVar_0 = _taskVar # 0;

		//-Weapon List
		private _veh = [nil,"AIR" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
		[ctrlParent _weap,_weap,_veh,false,false,false] call BCE_fnc_checkList;

		//-Default
		if ((_taskVar_0 # 0) != "NA") then {
			_taskVarSel = _taskVar_0 # 4;
			_ctrl lbSetCurSel (_taskVarSel # 0);
			_type lbSetCurSel (_taskVarSel # 1);
			_weap lbSetCurSel (_taskVarSel # 2);
			_mode lbSetCurSel (_taskVarSel # 3);
			_range lbSetCurSel (_taskVarSel # 4);
			_count ctrlSetText (_taskVarSel # 5);
			_height ctrlSetText (_taskVarSel # 6);
		}/*  else {
			_ctrl lbSetCurSel 0;
			_type lbSetCurSel 0;
			_weap lbSetCurSel 0;
			// _weap lbSetCurSel (lbCurSel _checklist);
		} */;

		/*if !(isnil {_description}) then {
			_weapPOS = ctrlPosition _weap;
			_rangePOS = ctrlPosition _range;
			_countPOS = ctrlPosition _count;

			//-Expression
			_mode ctrlSetPositionX ((_weapPOS # 0) + (_weapPOS # 2));
			_count ctrlSetPositionX ((_weapPOS # 0) + (_rangePOS # 2));
			_height ctrlSetPositionX ((_weapPOS # 0) + (_rangePOS # 2) + (_countPOS # 2));

			[_mode,_count,_height] apply {_x ctrlCommit 0};
		};*/
	};

	//-Friendly
	case 1:{
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

		//-Description POS
		/* _c = 0;
		{
			_c = _c + ((ctrlPosition _x) # 3);
		} forEach [_ctrl1,_ctrl2,_ctrl4];
		private _c = (_titlePOS # 3) + _c;
		_description ctrlSetPositionY ((_TaskListPOS # 1) + _c);
		_description ctrlSetPositionH ((_TaskListPOS # 3) - _c); */

		/* _ctrl2POS = ctrlPosition _ctrl2;
		_ctrl3POS = ctrlPosition _ctrl3;

		//-Expression
		_ctrl3 ctrlSetPosition
		[
			(_ctrl2POS # 0) + (_ctrl2POS # 2),
			_ctrl2POS # 1,
			_ctrl2POS # 2,
			_ctrl2POS # 3
		];
		_ctrl3 ctrlCommit 0;

		_ctrl4 ctrlSetPosition
		[
			_TaskListPOS # 0,
			(_TaskListPOS # 1) + (_c) - (_ctrl4POS # 3),
			_ctrl4POS # 2,
			_ctrl4POS # 3
		];
		_ctrl4 ctrlCommit 0; */
	};

	//-Target
	case 2:{
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3"];
		_taskVar_2 = _taskVar # 2;

		//-Back to previous status
		if ((_taskVar_2 # 0) != "NA") then {
			_ctrl1 lbSetCurSel (_taskVar_2 # 3 # 0);
			_ctrl2 lbSetCurSel (_taskVar_2 # 3 # 1);
		};

		_ctrl1sel = lbCurSel _ctrl1;
		_ctrl3 ctrlSetText (_taskVar_2 # 0);

		if (_ctrl1sel == 0) then {
			_ctrl2 ctrlShow true;
			_ctrl2 call BCE_fnc_IPMarkers;
		} else {
			_ctrl2 ctrlShow false;
		};

		//-Description POS
		/* private _c = _titlePOS # 3;
		{
			_c = _c + ((ctrlPosition _x) # 3);
		} forEach [_ctrl1,_ctrl2];

		_description ctrlSetPositionY ((_TaskListPOS # 1) + _c);
		_description ctrlSetPositionH ((_TaskListPOS # 3) - _c); */

		/* _ctrl2POS = ctrlPosition _ctrl2;
		_ctrl3POS = ctrlPosition _ctrl3;

		//-Expression
		_ctrl3 ctrlSetPosition
		[
			(_ctrl2POS # 0) + (_ctrl2POS # 2),
			_ctrl2POS # 1,
			_ctrl2POS # 2,
			_ctrl2POS # 3
		];
		_ctrl3 ctrlCommit 0; */
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

		//-Exit
		/* if !(isnil {_description}) then {
			private ["_c","_ctrl1POS","_ctrl2POS"];
			_c = _titlePOS # 3;
			{
				_c = _c + ((ctrlPosition _x) # 3);
			} forEach [_ctrl1,_ctrl2];

			_description ctrlSetPositionY ((_TaskListPOS # 1) + _c);
			_description ctrlSetPositionH ((_TaskListPOS # 3) - _c);

			_ctrl1POS = ctrlPosition _ctrl1;
			_ctrl2POS = ctrlPosition _ctrl2;

			//-Expression
			_ctrl2 ctrlSetPositionY ((_ctrl1POS # 1) + (_ctrl1POS # 3));
			_ctrl2 ctrlCommit 0;
		}; */
	};

	//-Remarks
	case 4:{
		//-FAD/H [Toolbox, EditBox, output, Toolbox(Azimuth), DanClose(Text), DanClose(Box)]
		_shownCtrls params ["_ctrl1","_ctrl2","_ctrl3","_ctrl4","_ctrl5","_ctrl6"];

		_taskVar_4 = _taskVar # 4;

		//-Back to previous status
		if ((_taskVar_4 # 0) != "NA") then {
			(_taskVar_4 # 3) params [["_cndtion1",0],["_cndtion2",0],["_cndtion3",false]];
			_ctrl1 lbSetCurSel _cndtion1;
			_ctrl4 lbSetCurSel _cndtion2;
			_ctrl6 cbSetChecked _cndtion3;

			if ((_taskVar_4 # 1) != -1) then {
				_ctrl2 ctrlSetText (str (_taskVar_4 # 1));
			};
		} else {
			_ctrl2 ctrlSetText localize "STR_BCE_Bearing_ENT";
		};

		_ctrl1sel = lbCurSel _ctrl1;
		_ctrl3 ctrlSetText (_taskVar_4 # 0);

		if (_ctrl1sel == 0) then {
      _ctrl2 ctrlShow false;
      _ctrl4 ctrlShow true;
    };
    if (_ctrl1sel == 1) then {
      _ctrl2 ctrlShow true;
      _ctrl4 ctrlShow false;
    };
    if (_ctrl1sel == 2) then {
      _ctrl2 ctrlShow false;
      _ctrl4 ctrlShow false;
    };

		//-Description POS
		/* private _c = _titlePOS # 3;
		{
			_c = _c + ((ctrlPosition _x) # 3);
		} forEach [_ctrl1,_ctrl2,_ctrl3,_ctrl5];

		_description ctrlSetPositionY ((_TaskListPOS # 1) + _c);
		_description ctrlSetPositionH ((_TaskListPOS # 3) - _c); */

		/* _ctrl2POS = ctrlPosition _ctrl2;
		_ctrl3POS = ctrlPosition _ctrl3;

		//-Expression
		_ctrl3 ctrlSetPosition
		[
			(_ctrl2POS # 0) + (_ctrl2POS # 2),
			_ctrl2POS # 1,
			_ctrl2POS # 2,
			_ctrl2POS # 3
		];
		_ctrl3 ctrlCommit 0; */
	};
};
