params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
	_display = findDisplay 12;
	_map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

localNamespace setVariable ["PLP_SMT_compass_origPos",[-1,-1]] ;
localNamespace setVariable ["PLP_SMT_compass_lastClick",-1] ;
localNamespace setVariable ["PLP_SMT_compass_dragging",-1] ;

private _EH = _map ctrlAddEventHandler ["Draw",{
	params ["_map"] ;

	#define MAPPOS(xx,yy)	(_map ctrlMapScreenToWorld [xx,yy])

	private _iscTab = !isnil {cTabIfOpen};
	if (_iscTab && !cTabCursorOnMap) exitWith {};

	private _mapScale = ctrlMapScale _map ;

	/*{
		_map drawIcon [
			"#(argb,1,1,1)color(0,0,0,0)",
			[1,1,1,1],MAPPOS(getMousePosition#0 - pixelH * 25,getMousePosition#1 + pixelH * 25 + (0.05*0.5 * _forEachIndex)),
			0,0,0,_x,1,0.05,"PuristaLight","left"
		] ;
	} forEach [
		"L. Click to place point",
		"Hold R. Click to show Mil"
	] ;*/

	private _lastClick = localNamespace getVariable ["PLP_SMT_compass_lastClick",-1] ;
	private _origPos = localNamespace getVariable ["PLP_SMT_compass_origPos",[-1,-1]] ;
	private _dragging = localNamespace getVariable ["PLP_SMT_compass_dragging",-1] ;

	if (inputMouse 0 == 1 and (_lastClick + 0.3 < time)) then {
		localNamespace setVariable ["PLP_SMT_compass_lastClick",time] ;
	} ;
	if (inputMouse 0 == 0 and (_lastClick + 0.3 > time)) then {
		localNamespace setVariable ["PLP_SMT_compass_origPos",(MAPPOS(getMousePosition#0,getMousePosition#1))] ;
		localNamespace setVariable ["PLP_SMT_compass_lastClick",-1] ;
	} ;

	if (_origPos distance2D [-1,-1] != 0) then {
		private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
		private _dist = (_origPos distance2D _mPos) max (1500*_mapScale) ;
		private _dir = _origPos getDir _mPos ;

		_map drawIcon [
			"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
			[1,1,1,1],_origPos,
			15,15,0
		] ;

		_map drawLine [
			_origPos,_origPos vectorAdd [(sin _dir)*_dist,(cos _dir)*_dist],[1,0,0,1]
		] ;

		_map drawLine [
			_origPos vectorAdd [_dist*0.4,0,0],_origPos vectorAdd [_dist*-0.4,0,0],[1,1,1,1]
		] ;
		_map drawLine [
			_origPos vectorAdd [0,_dist*0.4,0],_origPos vectorAdd [0,_dist*-0.4,0],[1,1,1,1]
		] ;

		_map drawEllipse [
			_origPos,_dist,_dist,0,[0,0,0,1],"#(argb,1,1,1)color(1,1,1,0.3)"
		] ;
		_map drawEllipse [
			_origPos,_dist,_dist,0,[1,1,1,1],""
		] ;


		if (inputMouse 0 == 2) then {
			private _step = call {
				if (_dist / _mapScale > 5000) exitWith {360/6400*10} ;
				if (_dist / _mapScale > 2500) exitWith {360/6400*25} ;
				360/6400*100
			} ;

			for "_i" from 0 to 360 step _step do {
				private _leng = call {
					if (_i mod (360/6400*200) == 0) exitWith {250} ;
					//if (_i mod 15 == 0) exitWith {150} ;
					150
				} ;
				_leng = ((_dist-(_leng*_mapScale)) max (_leng*_mapScale)) ;

				_map drawLine [
					_origPos vectorAdd [(sin _i)*(_leng min _dist),(cos _i)*(_leng min _dist)],
					_origPos vectorAdd [(sin _i)*_dist,(cos _i)*_dist],
					[1,1,1,1]
				] ;

				private _leng = ((_dist-(450*_mapScale)) max (450*_mapScale)) ;
				if (_i mod (360/6400*200) == 0 and _i != 0) then {
					_map drawIcon [
						"#(argb,1,1,1)color(0,0,0,0)",
						[1,1,1,1],_origPos vectorAdd [(sin _i)*_leng,(cos _i)*_leng],
						0,0,0, str (_i/360*64),1,0.04,"PuristaLight","center"
					] ;
				} ;
			} ;

			_map drawIcon [
				"#(argb,1,1,1)color(0,0,0,0)",
				[1,1,1,1],_origPos vectorAdd [(sin _dir)*(_dist-150*_mapScale),(cos _dir)*(_dist-150*_mapScale)],
				15,15,0,format ["%1 Mil.",_dir/360*6400 toFixed 1],1,0.06,"PuristaLight","left"
			] ;
		} else {
			private _step = call {
				if ((_dist / _mapScale) < 500) exitWith {10} ;
				if ((_dist / _mapScale) < 1000) exitWith {5} ;
				1
			} ;

			for "_i" from 0 to 360 step _step do {
				private _leng = call {
					if (_i mod 45 == 0) exitWith {250} ;
					if (_i mod 15 == 0) exitWith {150} ;
					50
				} ;
				_leng = ((_dist-(_leng*_mapScale)) max (_leng*_mapScale)) ;

				_map drawLine [
					_origPos vectorAdd [(sin _i)*(_leng min _dist),(cos _i)*(_leng min _dist)],
					_origPos vectorAdd [(sin _i)*_dist,(cos _i)*_dist],
					[1,1,1,1]
				] ;

				private _leng = ((_dist-(450*_mapScale)) max (450*_mapScale)) ;
				if (_i mod 15 == 0 and _i != 360) then {
					_map drawIcon [
						"#(argb,1,1,1)color(0,0,0,0)",
						[1,1,1,1],_origPos vectorAdd [(sin _i)*_leng,(cos _i)*_leng],
						0,0,0,format ["%1",_i],1,0.04,"PuristaLight","center"
					] ;
				} ;
			} ;

			_map drawIcon [
				"#(argb,1,1,1)color(0,0,0,0)",
				[1,1,1,1],_origPos vectorAdd [(sin _dir)*(_dist-150*_mapScale),(cos _dir)*(_dist-150*_mapScale)],
				15,15,0,format ["%1 deg.",_dir toFixed 1],1,0.06,"PuristaLight","left"
			] ;
		} ;

		private _step = call {
			if ((_dist / _mapScale) < 500) exitWith {90} ;
			if ((_dist / _mapScale) < 1000) exitWith {45} ;
			45/2
		} ;
		for "_i" from 0 to 360 step _step do {
			private _leng = ((_dist-(750*_mapScale)) max (750*_mapScale)) ;

			private _dir = call {
				[
					"N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"
				] # (_i/360*16)
			} ;

			if (_i != 360) then {
				private _size = call {
					if (_i mod 90 == 0) exitWith {0.12} ;
					if (_i mod 45 == 0) exitWith {0.08} ;
					0.04
				} ;
				_map drawIcon [
					"#(argb,1,1,1)color(0,0,0,0)",
					[0.8,0.8,0.8,1],_origPos vectorAdd [(sin _i)*_leng,(cos _i)*_leng],
					0,0,0,format ["%1",_dir],1,_size,"PuristaLight","center"
				] ;
			} ;
		} ;
	} ;
}] ;

uiNamespace setVariable ["PLP_SMT_EH",_EH] ;
