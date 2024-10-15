params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
  _display = findDisplay 12;
  _map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

localNamespace setVariable ["PLP_SMT_distance_distancePoints",[]] ;
localNamespace setVariable ["PLP_SMT_distance_lastClick",-1] ;
localNamespace setVariable ["PLP_SMT_distance_dragging",-1] ;

private _EH = _map ctrlAddEventHandler ["Draw",{
  params ["_map"] ;

  #define MAPPOS(xx,yy)  (_map ctrlMapScreenToWorld [xx,yy])

  private _iscTab = !isnil {cTabIfOpen};
  if (_iscTab && !cTabCursorOnMap) exitWith {};
    
  private _mapScale = ctrlMapScale _map ;
  private _lastClick = localNamespace getVariable ["PLP_SMT_distance_lastClick",-1] ;
  private _distancePoints = localNamespace getVariable ["PLP_SMT_distance_distancePoints",[]] ;
  private _dragging = localNamespace getVariable ["PLP_SMT_distance_dragging",-1] ;

  if (inputMouse 0 == 1 and (_lastClick + 0.3 < time)) then {
    localNamespace setVariable ["PLP_SMT_distance_lastClick",time] ;
  } ;
  if (inputMouse 0 == 0 and (_lastClick + 0.3 > time)) then {
    _distancePoints pushBack (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
    localNamespace setVariable ["PLP_SMT_distance_distancePoints",_distancePoints] ;
    localNamespace setVariable ["PLP_SMT_distance_lastClick",-1] ;
  } ;

  private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
  {
    if (_x distance2D _mPos < 35*_mapScale and inputMouse 0 <= 1) then {
      localNamespace setVariable ["PLP_SMT_distance_dragging",_forEachIndex] ;
    } ;
    if (_x distance2D _mPos < 35*_mapScale and inputMouse 1 == 1) then {
      _distancePoints deleteAt _forEachIndex ;
      localNamespace setVariable ["PLP_SMT_distance_distancePoints",_distancePoints] ;
    } ;
    if (_dragging == _forEachIndex) then {
      if (inputMouse 0 == 0) exitWith {
        localNamespace setVariable ["PLP_SMT_distance_dragging",-1] ;
      } ;
      _distancePoints set [_forEachIndex,_mPos] ;
      localNamespace setVariable ["PLP_SMT_distance_distancePoints",_distancePoints] ;
    } ;
  } forEach _distancePoints ;


  if (count _distancePoints == 1) then {

    private _center = _distancePoints#0 ;
    private _dist = _center distance2D _mPos ;
    private _dir = _center getDir _mPos ;

    _map drawIcon [
      "\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
      [0,0,0,1],_center,
      15,15,0
    ] ;

    _map drawLine [
      _center,_mPos,[0,0,0,1]
    ] ;


    _map drawEllipse [
      _center,_dist,_dist,0,[0,0,0,1],"#(argb,1,1,1)color(1,1,1,0.3)"
    ] ;
    _map drawEllipse [
      _center,_dist,_dist,0,[1,1,1,1],""
    ] ;
    _map drawIcon [
      "#(argb,1,1,1)color(0,0,0,0)",
      [1,1,1,1],MAPPOS(getMousePosition#0 - pixelH * 25,getMousePosition#1 - pixelH * 25),
      0,0,0,format ["%1 m",_dist toFixed 1],1,0.05,"PuristaLight","left"
    ] ;

    private _step = call {
      if (_mapScale < 0.2) exitWith {50} ;
      if (_mapScale < 0.5) exitWith {100} ;
      500
    } ;

    for "_i" from _step to _dist step _step do {
      private _milestone = _i mod (_step*5) == 0 ;
      private _col = if (_milestone) then {[1,0,0,1]} else {[0.8,0.8,0.8,1]} ;
      _map drawEllipse [
        _center,_i,_i,0,_col,""
      ] ;
      if (_milestone) then {
        _map drawIcon [
          "#(argb,1,1,1)color(0,0,0,0)",
          [1,1,1,1],_center vectorAdd [sin _dir*_i,cos _dir*_i],
          0,0,0,format ["%1 m",_i],1,0.05,"PuristaLight","center"
        ] ;
      } ;
    } ;
  } else {
    private _dist = 0 ;
    private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
    {
      _map drawIcon [
        "\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
        [0,0,0,1],_x,
        15,15,0
      ] ;
      /*if (_x distance2D _mPos < 35*_mapScale) then {
        systemChat str (_x distance2D _mPos) ;
        _map ctrlMapCursor ["Track","Move"] ;
      } else {
        _map ctrlMapCursor ["",""] ;
      } ;*/

      if (_forEachIndex != 0) then {
        private _posPrev = _distancePoints#(_forEachIndex-1) ;

        _map drawLine [
          _posPrev,
          _x,
          [0,0,0,1]
        ] ;

        private _distLocal = (_posPrev distance2D _x) ;
        _dist = _dist + _distLocal ;

        private _step = call {
          if (_mapScale < 0.2) exitWith {50} ;
          if (_mapScale < 0.5) exitWith {100} ;
          500
        } ;

        for "_i" from 0 to _dist step _step do {
          if (_i >= ((_dist - _distLocal) max 0)) then {
            private _milestone = _i mod (_step*5) == 0 ;

            private _posLocal = [
              linearConversion [
                _dist-_distLocal,_dist,_i,_posPrev#0,_x#0
              ],
              linearConversion [
                _dist-_distLocal,_dist,_i,_posPrev#1,_x#1
              ]
            ] ;
            private _dirLocal = (_posPrev getDir _x) + 90 ;
            private _lineLeng = if (_milestone) then {120*_mapScale} else {60*_mapScale} ;

            _map drawLine [
              _posLocal vectorAdd [sin _dirLocal * _lineLeng,cos _dirLocal * _lineLeng],
              _posLocal vectorAdd [sin _dirLocal * -_lineLeng,cos _dirLocal * -_lineLeng],
              [0,0,0,1]
            ] ;

            if (_milestone) then {
              _map drawIcon [
                "#(argb,1,1,1)color(0,0,0,0)",
                [0.8,0.8,0.8,1],_posLocal,
                0,0,0,format ["%1 m",_i],1,0.05,"PuristaLight","left"
              ] ;
            } ;
          } ;
        } ;
      } ;

      _map drawIcon [
        "#(argb,1,1,1)color(0,0,0,0)",
        [1,1,1,1],_x,
        15,15,0,format ["%1 m",_dist toFixed 1],1,0.06,"PuristaLight","left"
      ] ;

    } forEach (_distancePoints + [_mPos]) ;
  } ;
}] ;

uiNamespace setVariable ["PLP_SMT_EH",_EH] ;
