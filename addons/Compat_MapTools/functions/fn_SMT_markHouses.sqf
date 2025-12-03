/*
	_MarkerType = 1
	missionNamespace getVariable ["PLP_SMT_Markers",[]]
*/
params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
	_display = findDisplay 12;
	_map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

//missionNamespace setVariable ["PLP_SMT_markHouses_points",[]] ;
localNamespace setVariable ["PLP_SMT_markHouses_lastClick",-1] ;
localNamespace setVariable ["PLP_SMT_markHouses_curPoints",[]] ;

private _EH = _map ctrlAddEventHandler ["Draw",{
	params ["_map"] ;

	#define MAPPOS(xx,yy)	(_map ctrlMapScreenToWorld [xx,yy])

	private _iscTab = !isnil {cTabIfOpen};
	if (_iscTab && !cTabCursorOnMap) exitWith {};

	private _display = ctrlParent _map;
	private _mapScale = ctrlMapScale _map ;

	/*{
		_map drawIcon [
			"#(argb,1,1,1)color(0,0,0,0)",
			[1,1,1,1],MAPPOS(getMousePosition#0 - pixelH * 25,getMousePosition#1 + pixelH * 25 + (0.05*0.5 * _forEachIndex)),
			0,0,0,_x,1,0.05,"PuristaLight","left"
		] ;
	} forEach [
		"L. Click to place a point",
		"Ctrl + R. Dbl. Click to confirm"
	] ;*/

	private _lastClick = localNamespace getVariable ["PLP_SMT_markHouses_lastClick",-1] ;
	private _points = missionNamespace getVariable ["PLP_SMT_markHouses_points",[]] ;
	private _curPoints = localNamespace getVariable ["PLP_SMT_markHouses_curPoints",[]] ;

	private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;


	private _color = if (_iscTab) then {
		// private _MarkerColorCache = uiNamespace getVariable ["BCE_Marker_Color",[]];
    // _MarkerColorCache # lbCurSel _colorLb # 0
		private _colorLb = _display displayCtrl (17000 + 1090);
    _colorLb lbData (lbCurSel _colorLb)
	} else {
		//- #NOTE - Vanilla map
		// private _colorLb = (_display displayCtrl 2302) controlsGroupCtrl 1090;
		// configName (("true" configClasses (configFile >> "CfgMarkerColors")) # (_colorLb lbValue lbCurSel _colorLb));
		private _colorLb = (_display displayCtrl 2302) controlsGroupCtrl 1090;
		(uiNamespace getVariable ["BCE_Marker_Color_Array",[]]) # (_colorLb lbValue lbCurSel _colorLb);
	};

	if (inputMouse 0 >= 1) then {
		if (_lastClick == -1) then {
			_curPoints = [_mPos,[-1,-1],[]] ;
			localNamespace setVariable ["PLP_SMT_markHouses_curPoints",_curPoints] ;
		} ;
		localNamespace setVariable ["PLP_SMT_markHouses_lastClick",time] ;
	} ;
	if (inputMouse 0 == 0 && (_lastClick + 0.1 > time)) then {
		_curPoints params ["_posOrig"] ;
		(_posOrig vectorDiff _mPos) params ["_width","_height"] ;

		private _buildings = ((nearestTerrainObjects [
			_posOrig vectorAdd [-_width/2,-_height/2],
			["HOUSE"],
			(abs _width max abs _height) * sqrt 2/2,
			true
		]) inAreaArray [(_posOrig vectorAdd [-_width/2,-_height/2]),_width/2,_height/2,0,true]) ;

		{
			if (count (_x buildingPos -1) == 0) then {
				_buildings deleteAt _forEachIndex ;
			} ;
		} forEachReversed _buildings ;

		private _markers = [] ;
		{
			private _hash = ((getPosASL _x)#0*5) + ((getPosASL _x)#1 * 7) ;
			private _marker = createMarker [
				["PLP_SMT_markHouses_",_hash] joinString "",
				_x modelToWorld [0,0,0],
				currentChannel,player
			] ;
			_marker setMarkerText str (_forEachIndex+1) ;

			_marker setMarkerType "Mil_dot" ;
			_marker setMarkerSize [0,0] ;
			_marker setMarkerColor _color ;
			_marker setMarkerShadow true ;

			_markers pushBack _marker ;

			/*private _bounding = call {
				private _bbox = boundingBoxReal [_x,"ViewGeometry"] ;
				private _diff = (_bbox#1) vectorDiff (_bbox#0);
				[_diff vectorDotProduct [1,0,0], _diff vectorDotProduct [0,1,0], _diff vectorDotProduct [0,0,1]]
			} ;

			private _marker = createMarker [format ["PLP_SMT_markHouses_%1_L",_hash],
			_x modelToWorld [0,0,0],currentChannel] ;
			_marker setMarkerShape "Rectangle" ;
			_marker setMarkerSize [1,(_bounding#1)/2] ;
			_marker setMarkerDir getDir _x ;
			_marker setMarkerColor _color ;*/
		} forEach _buildings ;

		if (_iscTab) then {
			call cTab_fnc_updateUserMarkerList;
		};

		//- Add by Aaren
		//- BoardCast : ["ownerID:netID", Marker Count]
			private _PLP_GLB_Var = missionNamespace getVariable ["PLP_SMT_Markers",createHashMap];
			private _playerID = player call BIS_fnc_netId;
			private _MarkerType = 1;

			private _All_IDs = _PLP_GLB_Var getOrDefault [_playerID, [0,0]];
			_All_IDs set [_MarkerType, 0 max ((_All_IDs # _MarkerType) + 1)];
			_PLP_GLB_Var set [_playerID, _All_IDs];

			missionNamespace setVariable ["PLP_SMT_Markers",_PLP_GLB_Var,true];

		//- Store into local Variable
		_curPoints = [_posOrig,[_width,_height],_markers,_color] ;
		_points pushBack _curPoints ;
		missionNamespace setVariable ["PLP_SMT_markHouses_points",_points] ;

		localNamespace setVariable ["PLP_SMT_markHouses_lastClick",-1] ;
	} ;

	if (count _curPoints != 0 && inputMouse 0 == 2) then {
		private _posOrig = _curPoints # 0;
		(_posOrig vectorDiff _mPos) params ["_width","_height"] ;

		_color = (getArray (configFile >> "CfgMarkerColors" >> _color >> "color")) apply {
			if (_x isEqualType "") then {call compile _x} else {_x};
		};
		_color set [3,1] ;

		_map drawRectangle [
			_posOrig vectorAdd [-_width/2,-_height/2],
			_width/2,_height/2,0,_color,""
		] ;

		private _pointNE = [] ;
		_pointNE set [0,(_posOrig#0) min (_mPos#0)] ;
		_pointNE set [1,(_posOrig#1) max (_mPos#1)] ;

		_map drawRectangle [
			_pointNE vectorAdd [-50000,-abs _height/2],50000,abs _height/2,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
		] ;
		_map drawRectangle [
			_pointNE vectorAdd [abs _width + 50000,-abs _height/2],50000,abs _height/2,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
		] ;

		_map drawRectangle [
			_pointNE vectorAdd [_width/2,50000],50000+_width,50000,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
		] ;
		_map drawRectangle [
			_pointNE vectorAdd [_width/2,-abs _height - 50000],50000+_width,50000,0,[0,0,0,0.3],"#(argb,1,1,1)color(1,1,1,1)"
		] ;
	} ;

	{
		_x params ["_posOrig","_scale","_markers","_color"] ;
		_scale params ["_width","_height"] ;

		private _inArea = _mPos inArea [_posOrig vectorAdd [-_width/2,-_height/2],_width/2,_height/2,0,true] ;

		if (!_inArea) then {
			_color = (getArray (configFile >> "CfgMarkerColors" >> _color >> "color")) apply {
				if (_x isEqualType "") then {call compile _x} else {_x};
			};
			_color set [3,1] ;
		} else {
			_color = [1,1,1,1] ;
			_map drawRectangle [
				_posOrig vectorAdd [-_width/2,-_height/2],
				abs _width/2,abs _height/2,0,_color,"#(rgb,8,8,3)color(1,1,1,0.3)"
			] ;

			//- on Delete
			if (inputMouse "487653633") then {
				_points deleteAt _forEachIndex ;
				_markers apply {deleteMarker _x} ;

				//- Add by Aaren
					//- BoardCast : ["ownerID:netID", Marker Count]
						private _PLP_GLB_Var = missionNamespace getVariable ["PLP_SMT_Markers",createHashMap];
						private _playerID = player call BIS_fnc_netId;
						private _MarkerType = 1;

						private _All_IDs = _PLP_GLB_Var getOrDefault [_playerID, [0,0]];
						_All_IDs set [_MarkerType, 0 max ((_All_IDs # _MarkerType) - 1)];

						_PLP_GLB_Var set [_playerID, _All_IDs];

						missionNamespace setVariable ["PLP_SMT_Markers",_PLP_GLB_Var,true];
			} ;
		} ;

		_map drawRectangle [
			_posOrig vectorAdd [-_width/2,-_height/2],
			abs _width/2,
			abs _height/2,
			0,
			_color,
			""
		] ;
	} forEach _points ;
}] ;

uiNamespace setVariable ["PLP_SMT_EH",_EH] ;
