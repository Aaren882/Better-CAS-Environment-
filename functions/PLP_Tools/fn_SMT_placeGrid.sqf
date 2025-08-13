/*
	_MarkerType = 0
	missionNamespace getVariable ["PLP_SMT_Markers",[]]
*/

params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
	_display = findDisplay 12;
	_map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

localNamespace setVariable ["PLP_SMT_placeGrid_lastClick",-1];
localNamespace setVariable ["PLP_SMT_placeGrid_dragging",-1];

private _EH = _map ctrlAddEventHandler ["Draw",{
	params ["_map"];

	#define MAPPOS(xx,yy)	(_map ctrlMapScreenToWorld [xx,yy])

	private _iscTab = !isnil {cTabIfOpen};
	if (_iscTab && !cTabCursorOnMap) exitWith {};

	private _display = ctrlParent _map;
	private _mapScale = ctrlMapScale _map;

	/*{
		_map drawIcon [
			"#(argb,1,1,1)color(0,0,0,0)",
			[1,1,1,1],MAPPOS(getMousePosition#0 - pixelH * 25,getMousePosition#1 + pixelH * 25 + (0.05*0.5 * _forEachIndex)),
			0,0,0,_x,1,0.05,"PuristaLight","left"
		];
	} forEach [
		"L. Drag to make a grid",
		"Ctrl + R. Dbl. Click on your grid to delete"
	];*/

	private _lastClick = localNamespace getVariable ["PLP_SMT_placeGrid_lastClick",-1];
	private _points = missionNamespace getVariable ["PLP_SMT_placeGrid_points",[]];

	private _mPos = _map ctrlMapScreenToWorld getMousePosition;

	if (inputMouse 0 >= 1) then {
		if (_lastClick == -1) then {
			_points pushBack [_mPos,[-1,-1],[-1,-1]];
		};
		localNamespace setVariable ["PLP_SMT_placeGrid_lastClick",time];
	};

	//- Unicode ID to String
	private _getAlphabet = {
		if (_this > 26) then {
			private _return = 65 + floor ((_this / 26)-1);
			_return = _return + (65 + (_this mod 26-1));
			toString [_return]
		} else {
			toString [65 + _this]
		};
	};

	if (inputMouse 0 == 0 && (_lastClick + 0.1 > time)) then {
		_points#(count _points-1) set [1,_mPos];
		localNamespace setVariable ["PLP_SMT_placeGrid_lastClick",-1];

		private _lastGrid = _points#-1;
		_lastGrid params ["_pointA","_pointB","_scale"];
		((_pointA vectorDiff _pointB) apply {abs _x}) params ["_width","_height"];

		if (_width * _height < 100) exitWith {};

		_width = -_width;

		private _pointNE = [];
		_pointNE set [0,(_pointA#0) min (_pointB#0)];
		_pointNE set [1,(_pointA#1) max (_pointB#1)];

		// draw perm marker border
		private _markers = [];
		private _markersText = [];
		private _random = diag_tickTime;
		private _marker = createMarker [format ["PLP_SMT_Grid_%1_L",_random],
		_pointNE vectorAdd [2,-_height/2],currentChannel,player];
		_marker setMarkerSize [2,_height/2-4];
		_markers pushBack _marker;

		private _marker = createMarker [format ["PLP_SMT_Grid_%1_R",_random],
		_pointNE vectorAdd [-_width-2,-_height/2],currentChannel,player];
		_marker setMarkerSize [2,_height/2-4];
		_markers pushBack _marker;

		private _marker = createMarker [format ["PLP_SMT_Grid_%1_T",_random],
		_pointNE vectorAdd [-_width/2,-2],currentChannel,player];
		_marker setMarkerSize [-_width/2,2];
		_markers pushBack _marker;
		
		private _marker = createMarker [format ["PLP_SMT_Grid_%1_B",_random],
		_pointNE vectorAdd [-_width/2,-_height+2],currentChannel,player];
		_marker setMarkerSize [-_width/2,2];
		_markers pushBack _marker;

		// grid
		for "_i" from 0 to (_scale#0)-1 do {
			if (_i != 0) then {
				private _marker = createMarker [
					format ["PLP_SMT_Grid_%1_X%2",_random,_i],
					_pointNE vectorAdd [-_width/(_scale#0)*_i,-_height/2],
					currentChannel,player
				];
				_marker setMarkerSize [0.5,_height/2-4];
				_markers pushBack _marker;
			};

			private _marker = createMarker [
				format ["PLP_SMT_Grid_%1_X%2_text",_random,_i],
				_pointNE vectorAdd [-_width/(_scale#0)*(_i+0.5),25],
				currentChannel,player
			];
			_marker setMarkerText (_i call _getAlphabet);
			_markersText pushBack _marker;
		};
		for "_i" from 0 to (_scale#1)-1 do {
			if (_i != 0) then {
				private _marker = createMarker [
					format ["PLP_SMT_Grid_%1_Y%2",_random,_i],
					_pointNE vectorAdd [-_width/2,-_height/(_scale#1)*_i],
					currentChannel,player
				];
				_marker setMarkerSize [-_width/2-4,0.5];
				_markers pushBack _marker;
			};

			private _marker = createMarker [format ["PLP_SMT_Grid_%1_Y%2_text",_random,_i],
			_pointNE vectorAdd [-25,-_height/(_scale#1)*(_i+0.5)],currentChannel,player];
			_marker setMarkerText str _i;
			_markersText pushBack _marker;
		};

		private _markersTextAlpha = [];
		for "_xx" from 0 to (_scale#0)-1 do {
			for "_yy" from 0 to (_scale#1)-1 do {
				private _marker = createMarker [
					format ["PLP_SMT_Grid_%1_gridTitle_%2_%3",_random,_xx,_yy],
					_pointNE vectorAdd [
						-_width/(_scale#0)*(_xx+0.25),
						-_height/(_scale#1)*(_yy+0.5)
					],
					currentChannel,player
				];
				_marker setMarkerSize [0,0];
				_marker setMarkerText ([_xx call _getAlphabet,_yy] joinString "");
				_markersTextAlpha pushBack _marker;
			};
		};
		
		private _color = if (_iscTab) then {
			private _colorLb = _display displayCtrl (17000 + 1090);
			_colorLb lbData (lbCurSel _colorLb)
		} else {
			// private _colorLb = (_display displayCtrl 2302) controlsGroupCtrl 1090;
			// configName (("true" configClasses (configFile >> "CfgMarkerColors")) # (_colorLb lbValue lbCurSel _colorLb));
			private _colorLb = (_display displayCtrl 2302) controlsGroupCtrl 1090;
			(uiNamespace getVariable ["BCE_Marker_Color_Array",[]]) # (_colorLb lbValue lbCurSel _colorLb);
		};

		_markers apply {
			_x setMarkerShape "Rectangle";
			_x setMarkerColor _color;
			_x setMarkerAlpha 0.8;
			_x setMarkerBrush "SolidFull";
		};
		_markersText apply {
			_x setMarkerType "EmptyIcon";
			_x setMarkerSize [0,0];
			_x setMarkerColor _color;
			_x setMarkerShadow true;
		};
		_markersTextAlpha apply {
			_x setMarkerType "EmptyIcon";
			_x setMarkerSize [0,0];
			_x setMarkerColor _color;
			_x setMarkerShadow false;
			_x setMarkerAlpha 0.45;
		};

		_lastGrid set [3,[_markers,_markersText,_markersTextAlpha]];

		//- Add by Aaren
		//- BoardCast : ["ownerID:netID", Marker Count]
			private _PLP_GLB_Var = missionNamespace getVariable ["PLP_SMT_Markers",createHashMap];
			private _playerID = player call BIS_fnc_netId;
			private _MarkerType = 0;

			private _All_IDs = _PLP_GLB_Var getOrDefault [_playerID, [0,0]];
			_All_IDs set [_MarkerType, (_All_IDs # _MarkerType) + 1];

			_PLP_GLB_Var set [_playerID, _All_IDs];

			missionNamespace setVariable ["PLP_SMT_Markers",_PLP_GLB_Var,true];

			if (_iscTab) then {
				call cTab_fnc_updateUserMarkerList;
			};
	};

	//-Get Color RGBs
	private _color = if (_iscTab) then {
		private _colorLb = _display displayCtrl (17000 + 1090);
    (_colorLb lbData (lbCurSel _colorLb)) call BCE_fnc_getMarkerColor
	} else {
		// private _colorLb = (_display displayCtrl 2302) controlsGroupCtrl 1090;
		// private _class = configName (("true" configClasses (configFile >> "CfgMarkerColors")) # (_colorLb lbValue lbCurSel _colorLb));
		// (getArray (configFile >> "CfgMarkerColors" >> _class >> "color")) apply {
		// 	if (_x isEqualType "") then {call compile _x} else {_x};
		// };

		private _colorLb = (_display displayCtrl 2302) controlsGroupCtrl 1090;
		private _class = (uiNamespace getVariable ["BCE_Marker_Color_Array",[]]) # (_colorLb lbValue lbCurSel _colorLb);
		_class call BCE_fnc_getMarkerColor # 0;
	};
	_color set [3,1];

	{
		_x params ["_pointA","_pointB","_scale"];

		if (_pointB distance [-1,-1] == 0) then {
			_pointB = _mPos;

			((_pointA vectorDiff _pointB) apply {abs _x}) params ["_width","_height"];
			_width = -_width;

			private _pointNE = [];
			_pointNE set [0,(_pointA#0) min (_pointB#0)];
			_pointNE set [1,(_pointA#1) max (_pointB#1)];

			_map drawRectangle [
				_pointNE vectorAdd [-50000,-_height/2],50000,_height/2,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
			];
			_map drawRectangle [
				_pointNE vectorAdd [abs _width + 50000,-_height/2],50000,_height/2,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
			];

			_map drawRectangle [
				_pointNE vectorAdd [_width/2,50000],50000+_width,50000,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
			];
			_map drawRectangle [
				_pointNE vectorAdd [_width/2,-abs _height - 50000],50000+_width,50000,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
			];

			_map drawRectangle [
				_pointA vectorAdd ((_pointB vectorDiff _pointA) vectorMultiply 0.5),_width/2,_height/2,0,_color,""
			];

			private _stepX = round (abs (_width/_mapScale) / 800) max 1;
			for "_xx" from 0 to _stepX-1 do {
				_map drawIcon [
					"#(argb,1,1,1)color(0,0,0,0)",
					_color,_pointNE vectorAdd [(_width/_stepX*-(_xx+0.5)),_mapScale*125],
					0,0,0,(_xx call _getAlphabet),1,0.08,"PuristaLight","center"
				];
				_map drawLine [
					_pointNE vectorAdd [(_width/_stepX*-(_xx+1)),0],
					_pointNE vectorAdd [(_width/_stepX*-(_xx+1)),-_height],
					_color
				];
			};

			private _stepY = round (abs (_height/_mapScale) / 800) max 1;
			for "_yy" from 0 to _stepY-1 do {
				_map drawIcon [
					"#(argb,1,1,1)color(0,0,0,0)",
					_color,_pointNE vectorAdd [_mapScale*-125,(_height/_stepY*-(_yy+0.5))],
					0,0,0,str _yy,1,0.08,"PuristaLight","left"
				];
				_map drawLine [
					_pointNE vectorAdd [0,(_height/_stepY*-(_yy+1))],
					_pointNE vectorAdd [-_width,(_height/_stepY*-(_yy+1))],
					_color
				];
			};
			_scale = [_stepX,_stepY];
			_points#-1 set [2,_scale];
		} else {
			((_pointA vectorDiff _pointB) apply {abs _x}) params ["_width","_height"];

			private _pointNE = [];
			_pointNE set [0,(_pointA#0) min (_pointB#0)];
			_pointNE set [1,(_pointA#1) max (_pointB#1)];

			private _inArea = (_mPos inArea [
				_pointNE vectorAdd [_width/2,-_height/2],
				_width/2,_height/2,0,true
			]);

			if (_inArea) then {
				private _delete = inputMouse "487653633";
				if (_delete) exitWith {
					(_points deleteAt _forEachIndex) params ["","","","_markers"];
					_markers apply {_x apply {deleteMarker _x}};

					//- Add by Aaren
					//- BoardCast : ["ownerID:netID", Marker Count]
						private _PLP_GLB_Var = missionNamespace getVariable ["PLP_SMT_Markers",createHashMap];
						private _playerID = player call BIS_fnc_netId;
						private _MarkerType = 0;

						private _All_IDs = _PLP_GLB_Var getOrDefault [_playerID, [0,0]];
						_All_IDs set [_MarkerType, (_All_IDs # _MarkerType) - 1];

						_PLP_GLB_Var set [_playerID, _All_IDs];

						missionNamespace setVariable ["PLP_SMT_Markers",_PLP_GLB_Var,true];
				};

				_map drawRectangle [
					_pointNE vectorAdd [_width/2,-_height/2],_width/2,_height/2,0,[0,0,0,(cos (time*360/2)+1.1)*0.1],"#(argb,1,1,1)color(1,1,1,1)"
				];
			};
		};
	} forEach _points;

	missionNamespace setVariable ["PLP_SMT_placeGrid_points",_points];
}];

uiNamespace setVariable ["PLP_SMT_EH",_EH];
