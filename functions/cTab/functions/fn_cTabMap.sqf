params["_display","_ctrl"];

private _displayName = cTabIfOpen # 1;
(focusOn getVariable ["TGP_View_Selected_Optic",[[],objNull]]) params ["_connected_Optic","_veh"];

//- Aerial vehicle
if (alive _veh) then {
	private _color = [1,1,0.3,0.8];
	private _pos = getPosASLVisual _veh;

	_ctrl drawIcon [
		"\a3\ui_f\data\IGUI\Cfg\Targeting\MarkedTarget_ca.paa",
		_color,
		_pos,
		50,
		50,
		0,
		format ["%1 || ASL: %2m Speed: %3km/h",name (driver _veh),round(_pos # 2), round(Speed _veh)],
		1,
		0.06,
		"RobotoCondensed_BCE",
		"right"
	];

	//-Waypoints
	private _current_WP = currentWaypoint group _veh;
	private _WPpos = getWPPos [_veh,_current_WP];
	if !(_WPpos isEqualTo [0,0,0]) then {
		_ctrl drawArrow [_pos, _WPpos, _color];
	};
	private _waypoints = (waypoints _veh) select {waypointType _x == "MOVE"};

	{
		_x params ["_group","_index"];

		if (_index >= _current_WP) then {
			private ["_WP_index","_WPpos","_WPposNext"];
			_WP_index = [
				_x,
				_waypoints # (_forEachIndex + 1)
			] select (_forEachIndex < (count _waypoints - 1));

			_WPpos = getWPPos _x;
			_WPposNext = getWPPos _WP_index;

			if (!(_WPpos isEqualTo [0,0,0]) && !(_WPposNext isEqualTo [0,0,0])) then {
				_ctrl drawArrow [_WPpos, _WPposNext, _color];
			};
		};
	} forEach _waypoints;

	//-Camera Info
	if ((_connected_Optic findIf {true} > -1) && (uinamespace getVariable ['BCE_Terminal_Targeting',true])) then {
		private _current_turret = _connected_Optic # 1;
		private _isPilot = (_current_turret # 0) == -1;

		//-tell what pos for the turret
		private _FocusPos = if ((local _veh) && _isPilot) then {
			private _info = getPilotCameraTarget _veh;
			[nil,_info # 1] select (_info # 0);
		} else {
			if (_isPilot) then {
				private _var = _veh getVariable ["BCE_Camera_Info_Air",["[false,[]]","[]",objNull]];
				_var = parseSimpleArray (_var # 0);
				[nil,_var # 1] select (_var # 0);
			} else {
				[_veh,_current_turret] call BCE_fnc_Turret_InterSurface;
			};
		};
		
		//-draw FOV for curret connected turret (except FFV)
		if (!isnil {_FocusPos} && !isNull (_veh turretUnit _current_turret)) then {
			private ["_dis","_wpn","_turretName","_text"];

			_dis = _veh distance _FocusPos;
			_wpn = getText(configFile >> "CfgWeapons" >> (_veh currentWeaponTurret _current_turret) >> "DisplayName");

			_turretName = [
				getText ([_veh, _current_turret] call BIS_fnc_turretConfig >> "gunnerName"),
				localize "STR_DRIVER"
			] select _isPilot;

			_text = trim format [
				" %1 : %2 km [%3]",
				_turretName,
				round(_dis/100) / 10,
				[_wpn,"NA"] select (_wpn == "")
			];
			[_veh,_ctrl,_FocusPos,_current_turret,_color,_text,uinamespace getVariable ['BCE_Terminal_Targeting',true]] call BCE_fnc_DrawFOV;
			
			//- Focus on TG point
				if (_displayName find "Android" > -1 && uiNamespace getVariable ["BCE_ATAK_TRACK_Focus",false]) then {
					//- Update Text Info
						private _unit = getPosVisual focusOn;
						private _g = (_display displayCtrl 21640) controlsGroupCtrl 20; //- 17000 + 4640
						(_g controlsGroupCtrl 12) ctrlSetText format["%1° %2m",round (_unit getDirVisual _FocusPos), round ((_unit distance2D _FocusPos)/10) * 10];
					
					//- Draw on Map
						private _pos = vectorLinearConversion [0,1,0.95,_unit,_FocusPos,true];
						_ctrl drawArrow [_unit, _pos, [1,1,1,1]];

						_ctrl ctrlMapAnimAdd [
							0, 
							cTabMapScale, 
							_FocusPos
						];
					ctrlMapAnimCommit _ctrl;
				};
		};
	};
};

//- ARTY Connection
_veh = focusOn getVariable ["BCE_CFF_Selected_Group",objNull];
if (alive _veh) then {
	private _color = [1,1,0.3,0.8];
	private _pos = getPosASLVisual _veh;

	_ctrl drawIcon [
		"\a3\ui_f\data\IGUI\Cfg\Targeting\MarkedTarget_ca.paa",
		_color,
		_pos,
		50,
		50,
		0,
		"",
		1,
		0.06,
		"RobotoCondensed_BCE",
		"right"
	];
};

//-Exit if it's not cTab or TAD
if (_displayName find "Tablet" < 0 && _displayName find "Android" < 0) exitWith {};

//- CAS
private _curCate = ["Cate",0] call BCE_fnc_get_TaskCurSetup;
private _curType = [] call BCE_fnc_get_TaskCurType;
if (_curCate == 0) then {
	private _taskVar = ([] call BCE_fnc_getTaskVar) # 0;
	_taskVar = switch _curType do {
		//-5 line
		case 1: {
			private _FRD = _taskVar # 1;
			private _Target = _taskVar # 2;
			private _remarks = _taskVar # 4;
			[["NA",[]],_Target,_FRD,["NA",[]],_remarks]
		};
		//-9 line
		default {
			private _IPBP = _taskVar # 1;
			private _Target = _taskVar # 6;
			private _FRD = _taskVar # 8;
			private _EGRS = _taskVar # 9;
			private _remarks = _taskVar # 10;
			[_IPBP,_Target,_FRD,_EGRS,_remarks]
		};
	};
	_taskVar params ["_IPBP","_Target","_FRD","_EGRS","_remarks"];

	[_ctrl] call BCE_fnc_drawEach_TaskMapInfo;

	//-Draw IP/BP
	if (!("Marker" in (_IPBP # 0))) then {
		// [_ctrl,1] call BCE_fnc_draw_TaskMapInfo;
		/* _ctrl drawIcon [
			"\a3\ui_f\data\GUI\Cfg\Cursors\hc_overfriendly_gs.paa",
			[1,1,0,1],
			_IPBP # 2,
			40,
			40,
			0,
			_IPBP # 0,
			1,
			0.075,
			"RobotoCondensed_BCE",
			"right"
		]; */
	};

	if ((_Target # 0) != "NA") then {

		//-IP to TG line
		if ((_IPBP # 0) != "NA") then {
			private _posDiff = ((_Target # 2) vectorDiff (_IPBP # 2)) vectorMultiply 0.95;
			_ctrl drawArrow [
				_IPBP # 2,
				(_IPBP # 2) vectorAdd _posDiff,
				[1,1,0,1]
			];
		};

		//-FAD/H to TG line
		if ((_remarks # 1) != -1) then {
			private _HDG = (_remarks # 1) + 180;
			private _relPOS = (_Target # 2) getPos [1000, _HDG];
			private _posDiff = ((_Target # 2) vectorDiff _relPOS) vectorMultiply 0.9;
			_ctrl drawArrow [
				_relPOS vectorAdd _posDiff,
				_relPOS,
				[0.6,1,0.37,1]
			];

			_ctrl drawIcon [
				"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
				[0.6,1,0.37,1],
				_relPOS,
				30,
				30,
				0,
				_remarks # 0,
				1,
				0.075,
				"RobotoCondensed_BCE",
				["right","left"] select (_HDG > 180)
			];
		};

		//-Draw Target
		// [_ctrl,6] call BCE_fnc_draw_TaskMapInfo;
		
		//-Icon
		/* private _Icon = [
			"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
			"\a3\ui_f\data\GUI\Cfg\Cursors\hc_overenemy_gs.paa"
		] select ((_Target # 1) == "GRID");

		_ctrl drawIcon [
			_Icon,
			[1,0,0,1],
			_Target # 2,
			30,
			30,
			0,
			_Target # 0,
			1,
			0.075,
			"RobotoCondensed_BCE",
			"right"
		]; */
	};

	//-Friendly
	if ((_FRD # 0) != "NA") then {

		//-Draw Arrow
		if ((_Target # 0) != "NA") then {
			private _posDiff = ((_FRD # 2) vectorDiff (_Target # 2)) vectorMultiply 0.9;
			_ctrl drawArrow [
				(_Target # 2),
				(_Target # 2) vectorAdd _posDiff,
				[0,0.5,1,1]
			];
		};

		//-Draw Friendly
		// [_ctrl,8] call BCE_fnc_draw_TaskMapInfo;
		//-Icon
		/* private _Icon = [
			"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
			"\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"
		] select ((_FRD # 1) == "GRID");

		_ctrl drawIcon [
			_Icon,
			[0,0.5,1,1],
			_FRD # 2,
			30,
			30,
			0,
			_FRD # 0,
			1,
			0.075,
			"RobotoCondensed_BCE",
			"right"
		]; */
	};

	//-EGRS
	if (
		((_EGRS # 0) != "NA") && ((_Target # 0) != "NA")
	) then {
		private _HDG = _EGRS # 1;
		private _relPOS = [
			(_Target # 2) vectorAdd (((_EGRS # 3) vectorDiff (_Target # 2)) vectorMultiply 0.95),
			(_Target # 2) getPos [500, _HDG]
		] select (isnil{_EGRS # 3});

		_ctrl drawArrow [
			(_Target # 2),
			_relPOS,
			[1,1,1,1]
		];

		//-Draw Egress 
		// [_ctrl,9] call BCE_fnc_draw_TaskMapInfo;

		_ctrl drawIcon [
			"\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa",
			[1,1,1,1],
			_relPOS,
			30,
			30,
			0,
			format ["EGRS: %1",_EGRS # 0],
			1,
			0.075,
			"RobotoCondensed_BCE",
			"left"
		];
	};
};
