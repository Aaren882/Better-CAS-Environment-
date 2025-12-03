params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
	_display = findDisplay 12;
	_map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

localNamespace setVariable ["PLP_SMT_findFlat_origPos",[-1,-1]] ;
localNamespace setVariable ["PLP_SMT_findFlat_lastClick",-1] ;
localNamespace setVariable ["PLP_SMT_findFlat_dragging",-1] ;

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

	private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
	private _scale = 150 * _mapScale ;

	private _baseHeight = getTerrainHeightASL _mPos ;

	private _heights = [] ;

	for "_xx" from -8 to 8 do {
		for "_yy" from -8 to 8 do {
			private _posLocal = (_mPos vectorAdd [_xx * _scale,_yy * _scale]) ;
			private _height = getTerrainHeightASL _posLocal ;
			_heights pushBack _height ;

			#define COEF 250

			private _col = call {
				if (_height > _baseHeight) then {
					if (_height > (_baseHeight + COEF*_mapScale)) exitWith {
						vectorLinearConversion [
							_baseHeight + COEF*_mapScale,_baseHeight + COEF*2*_mapScale,_height,[1,0,0],[0,0,0]
						] ;
					} ;
					vectorLinearConversion [
						_baseHeight,_baseHeight + COEF*_mapScale,_height,[0,1,0],[1,0,0]
					] ;
				} else {
					if (_height < (_baseHeight - COEF*_mapScale)) exitWith {
						vectorLinearConversion [
							_baseHeight - COEF*_mapScale,_baseHeight - COEF*2*_mapScale,_height,[0,0,1],[0,0,0]
						] ;
					} ;
					vectorLinearConversion [
						_baseHeight,_baseHeight - COEF*_mapScale,_height,[0,1,0],[0,0,1]
					] ;
				} ;
			} ;

			_map drawRectangle [
				(_mPos vectorAdd [_xx * _scale,_yy * _scale]),_scale/2,_scale/2,0,_col + [1],
				"#(argb,1,1,1)color(1,1,1,0.5)"
			] ;
		} ;
	} ;

	_map drawRectangle [
		_mPos,_scale*8.5,_scale*8.5,0,[1,1,1,1],
		""
	] ;

	_map drawIcon [
		"#(argb,1,1,1)color(0,0,0,0)",
		[1,1,1,1],(_mPos vectorAdd [-8 * _scale,-9.5 * _scale]),
		0,0,0,format ["%1 m^2",(_scale*16) toFixed 1],1,0.04,"PuristaLight","right"
	] ;

	private _avg = 0 ;
	_heights apply {_avg = _avg + _x} ;
	_avg = _avg / count _heights ;

	_map drawIcon [
		"#(argb,1,1,1)color(0,0,0,0)",
		[1,1,1,1],(_mPos vectorAdd [9 * _scale,7.5 * _scale]),
		0,0,0,format ["AVG: %1 m",_avg toFixed 1],1,0.04,"PuristaLight","right"
	] ;
	_map drawIcon [
		"#(argb,1,1,1)color(0,0,0,0)",
		[1,1,1,1],(_mPos vectorAdd [9 * _scale,5.5 * _scale]),
		0,0,0,format ["LOWEST: %1 m",(selectMin _heights) toFixed 1],1,0.04,"PuristaLight","right"
	] ;
	_map drawIcon [
		"#(argb,1,1,1)color(0,0,0,0)",
		[1,1,1,1],(_mPos vectorAdd [9 * _scale,4.5 * _scale]),
		0,0,0,format ["HIGHEST: %1 m",(selectMax _heights) toFixed 1],1,0.04,"PuristaLight","right"
	] ;
}] ;

uiNamespace setVariable ["PLP_SMT_EH",_EH] ;
