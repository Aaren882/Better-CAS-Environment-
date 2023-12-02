#include "\a3\ui_f\hpp\defineCommonGrids.inc"
params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
	_display = findDisplay 12;
  _map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

localNamespace setVariable ["PLP_SMT_height_points",[]] ;
localNamespace setVariable ["PLP_SMT_height_lastClick",-1] ;

private _EH = _map ctrlAddEventHandler ["Draw",{
	params ["_map"] ;

	#define MAPPOS(xx,yy)	(_map ctrlMapScreenToWorld [xx,yy])

	/*{
		_map drawIcon [
			"#(argb,1,1,1)color(0,0,0,0)",
			[1,1,1,1],MAPPOS(getMousePosition#0 - pixelH * 25,getMousePosition#1 + pixelH * 25 + (0.05*0.5 * _forEachIndex)),
			0,0,0,_x,1,0.05,"PuristaLight","left"
		] ;
	} forEach [
		"L. Click to add point"
	] ;*/

	private _iscTab = !isnil {cTabIfOpen};
	if (_iscTab && !cTabCursorOnMap) exitWith {};

	private _display = if (_iscTab) then {
		uiNamespace getVariable (cTabIfOpen # 1)
	} else {
		findDisplay 12
	};

	private _mapScale = ctrlMapScale _map ;

	private _lastClick = localNamespace getVariable ["PLP_SMT_height_lastClick",-1] ;
	private _points = localNamespace getVariable ["PLP_SMT_height_points",[]] ;
	private _dragging = localNamespace getVariable ["PLP_SMT_height_dragging",-1] ;

	if (inputMouse 0 == 1 and (_lastClick + 0.3 < time) and count _points < 2) then {
		localNamespace setVariable ["PLP_SMT_height_lastClick",time] ;
	} ;

	if (inputMouse 0 == 0 and (_lastClick + 0.3 > time)) then {
		_points pushBack (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
		localNamespace setVariable ["PLP_SMT_height_points",_points] ;
		localNamespace setVariable ["PLP_SMT_height_lastClick",-1] ;

		if (count _points == 2) then {
			#define XPOS	(0.05/2)
			#define WIDTH	(0.95)
			#define YPOS (GUI_GRID_H*1.5)
			#define HEIGHT (GUI_GRID_H*6.5)

			private _cGrp = _display ctrlCreate ["PLP_SMT_HeightGraph",73453] ;
			private _return = [] ;

			if ((_points#0)#0 < (_points#1)#0) then {
				for "_i" from 0 to WIDTH step pixelW do {
					_return pushBack getTerrainHeightASL [
						linearConversion [
							0,WIDTH,_i,(_points#0)#0,(_points#1)#0
						],
						linearConversion [
							0,WIDTH,_i,(_points#0)#1,(_points#1)#1
						]
					] ;
				} ;
			} else {
				for "_i" from 0 to WIDTH step pixelW do {
					_return pushBack getTerrainHeightASL [
						linearConversion [
							0,WIDTH,_i,(_points#1)#0,(_points#0)#0
						],
						linearConversion [
							0,WIDTH,_i,(_points#0)#1,(_points#1)#1
						]
					] ;
				} ;
			} ;
			private _return2 = [] ;
			{_return2 append [_forEachIndex,_x]} forEach _return ;
			private _graph = [[0,count _return,selectMin _return,selectMax _return,count _return,0]] ;
			_graph append _return2 ;

			private _result = getGraphValues _graph ;
			{
				if (_forEachIndex != 0 and _forEachIndex != count _return-1) then {
					private _diff = abs ((_result#0#(_forEachIndex-1)) - _x) ;
					private _ctrl = _display ctrlCreate ["RscBackground",-1,_cGrp] ;
					_ctrl ctrlSetPosition [XPOS + (WIDTH/count _return * _forEachIndex),YPOS + HEIGHT * (1-_x),pixelW,pixelH max (_diff * HEIGHT)] ;
					_ctrl ctrlSetPixelPrecision 2 ;
					_ctrl ctrlCommit 0 ;
					_ctrl ctrlSetBackgroundColor [1,1,1,1] ;
				} ;
			} forEach (_result#0) ;

			if (selectMin _return < 0) then {
				private _level = linearConversion [selectMin _return,selectMax _return,0,0,1] ;
				private _ctrl = _cGrp controlsGroupCtrl 1 ;
				_ctrl ctrlSetPositionY (YPOS + HEIGHT * (1-_level)) ;
				_ctrl ctrlSetPixelPrecision 2 ;
				_ctrl ctrlCommit 0 ;
				_ctrl ctrlShow true ;
			} ;

			localNamespace setVariable ["PLP_SMT_Height_MinMax",[selectMin _return,selectMax _return]] ;

		} ;
	} ;

	if (count _points != 0) then {
		private _center = _points#0 ;
		private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;

		if (count _points == 2) then {
			_mPos = _points#1 ;
		} ;

		private _dist = _center distance2D _mPos ;
		private _dir = _center getDir _mPos ;

		_map drawIcon [
			"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
			[0,0,0,1],_center,
			15,15,0
		] ;
		_map drawIcon [
			"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
			[0,0,0,1],_mPos,
			15,15,0
		] ;

		_map drawLine [
			_center,_mPos,[0,0,0,1]
		] ;

		for "_i" from 0 to 10 do {
			private _length = if (_i mod 5 == 0) then {250} else {100} ;
			private _posLocal = [
				linearConversion [0,10,_i,_center#0,_mPos#0],
				linearConversion [0,10,_i,_center#1,_mPos#1]
			] ;
			_map drawLine [
				_posLocal vectorAdd [(sin (_dir+90)) * _length * _mapScale,(cos (_dir+90)) * _length * _mapScale],
				_posLocal vectorAdd [(sin (_dir-90)) * _length * _mapScale,(cos (_dir-90)) * _length * _mapScale],
				[0,0,0,1]
			] ;
		} ;

		if (count _points == 2) then {
			// im lazy
			private _pos2 = _mPos ;
			private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
			private _dist1 = _center distance2D _mPos ;
			//private _dist2 = _pos2 distance2D _mPos ;

			private _length = _center distance2D _pos2 ;

			private _dir = ((_center getDir _mPos) - (_center getDir _pos2)) ;
			private _height = ((sin _dir)*_dist1) ;

			private _cGrp = _display displayCtrl 73453 ;
			private _redLine = _cGrp controlsGroupCtrl 2 ;
			private _redPos = _cGrp controlsGroupCtrl 3 ;

			private _curDist = (_dist1 * cos _dir) ;

			if (abs (_height / _mapScale) < 250 and (_curDist/_length > 0 and _curDist/_length < 1)) then {
				private _curPos = [
					linearConversion [0,_length,_curDist,_center#0,_pos2#0],
					linearConversion [0,_length,_curDist,_center#1,_pos2#1]
				] ;
				private _curHeight = getTerrainHeightASL _curPos ;

				_map drawIcon [
					"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
					[1,0,0,1],_curPos,
					15,15,0,format ["%1 m",getTerrainHeightASL _curPos toFixed 1],1,0.07,"RobotoCondensed","left"
				] ;

				(localNamespace getVariable ["PLP_SMT_Height_MinMax",[-1,-1]]) params ["_min","_max"] ;
				private _level = linearConversion [_min,_max,_curHeight,0,1] ;
				if (_pos2#0 < _center#0) then {
					_redLine ctrlSetPositionX (XPOS + WIDTH * 1-(_curDist/_length)) ;
					_redPos ctrlSetPositionX (XPOS + WIDTH * 1-(_curDist/_length)) ;
				} else {
					_redLine ctrlSetPositionX (XPOS + WIDTH * (_curDist/_length)) ;
					_redPos ctrlSetPositionX (XPOS + WIDTH * (_curDist/_length)) ;
				} ;

				_redPos ctrlSetPositionY (YPOS + HEIGHT * (1-_level)) ;
				_redLine ctrlCommit 0 ;
				_redPos ctrlCommit 0 ;

				_redPos ctrlSetText format ["%1 m",getTerrainHeightASL _curPos toFixed 1] ;
				{_x ctrlShow true} forEach [_redPos,_redLine] ;

			} else {
				{_x ctrlShow false} forEach [_redPos,_redLine] ;
			} ;

		} ;
	} ;
}] ;

uiNamespace setVariable ["PLP_SMT_EH",_EH] ;
