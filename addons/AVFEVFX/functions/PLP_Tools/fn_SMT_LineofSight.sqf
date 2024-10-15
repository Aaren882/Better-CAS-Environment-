params ["_display","_map_IDC"];

if (isnil{_map_IDC}) then {
  _display = findDisplay 12;
  _map_IDC = 51;
};
private _map = _display displayCtrl _map_IDC;

localNamespace setVariable ["PLP_SMT_LineOfSight_basePos",[-1,-1]] ;
localNamespace setVariable ["PLP_SMT_LineOfSight_lastClick",-1] ;
localNamespace setVariable ["PLP_SMT_LineOfSight_dirDist",[-1,-1]] ;

private _EH = _map ctrlAddEventHandler ["Draw",{
  params ["_map"] ;

  #define MAPPOS(xx,yy)  (_map ctrlMapScreenToWorld [xx,yy])
  
  private _mapScale = ctrlMapScale _map ;

  /*{
    _map drawIcon [
      "#(argb,1,1,1)color(0,0,0,0)",
      [1,1,1,1],MAPPOS(getMousePosition#0 - pixelH * 25,getMousePosition#1 + pixelH * 25 + (0.05*0.5 * _forEachIndex)),
      0,0,0,_x,1,0.05,"PuristaLight","left"
    ] ;
  } forEach [
    "L. Click to add point",
    "L. Drag to move point",
    "R. Click to remove point"
  ] ;*/

  private _lastClick = localNamespace getVariable ["PLP_SMT_LineOfSight_lastClick",-1] ;
  private _basePos = localNamespace getVariable ["PLP_SMT_LineOfSight_basePos",[-1,-1]] ;
  private _calcData = localNamespace getVariable ["PLP_SMT_LineOfSight_calcData",createHashMap] ;

  if (inputMouse 0 == 1 and (_lastClick + 0.3 < time)) then {
    localNamespace setVariable ["PLP_SMT_LineOfSight_lastClick",time] ;
    localNamespace setVariable ["PLP_SMT_LineOfSight_savedLOS",[]] ;

    // reset evaluated data
    localNamespace setVariable ["PLP_SMT_LineOfSight_calcData",createHashMap] ;
  } ;
  if (inputMouse 0 == 0 and (_lastClick + 0.3 > time)) then {
    _basePos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
    localNamespace setVariable ["PLP_SMT_LineOfSight_basePos",_basePos] ;
    localNamespace setVariable ["PLP_SMT_LineOfSight_lastClick",-1] ;
  } ;

  if (_basePos distance2D [-1,-1] != 0) then {
    #define ANGSTEP 0.25
    #define DISTSTEP 6
    #define ANGCOEF 20

    private _mPos = (MAPPOS(getMousePosition#0,getMousePosition#1)) ;
    private _dist = _basePos distance2D _mPos ;
    private _dir = round (_basePos getDir _mPos) ;
    private _distMin = (DISTSTEP max ([_dist-DISTSTEP*70,DISTSTEP] call BIS_fnc_roundNum)) ;

    _map drawIcon [
      "\a3\ui_f\data\Map\Markers\Military\dot_CA.paa",
      [0,0,0,1],_basePos,
      15,15,0
    ] ;
    /*if (_x distance2D _mPos < 35*_mapScale) then {
      systemChat str (_x distance2D _mPos) ;
      _map ctrlMapCursor ["Track","Move"] ;
    } else {
      _map ctrlMapCursor ["",""] ;
    } ;*/


    _map drawEllipse [
      _basePos,_dist,_dist,0,[0,0,0,1],"#(argb,1,1,1)color(1,1,1,0.3)"
    ] ;
    _map drawEllipse [
      _basePos,_dist,_dist,0,[1,1,1,1],""
    ] ;
    private _step = call {
      if (_mapScale < 0.2) exitWith {100} ;
      if (_mapScale < 0.5) exitWith {500} ;
      500
    } ;

    private _posStart = _basePos + [getTerrainHeightASL _basePos + 0.5] ;
    
    for "_n" from _distMin to _dist step DISTSTEP do {
      // get evaluated data so no need to recalc/calc every frame
      private _hash = _calcData getOrDefault [_n,createHashMap,true] ;
      for "_i" from (_dir-(ANGSTEP*ANGCOEF)) to (_dir+(ANGSTEP*ANGCOEF)) step ANGSTEP do {
        private _hash = _hash get _i ;
        // reuse calculated
        private _intersect = call {
          if (isNil "_hash") then {
            private _posDir = _basePos getPos [_n,_i] ;
            _posDir set [2,getTerrainHeightASL _posDir + 0.5] ;
            terrainIntersectAtASL [_posStart,_posDir]
          } else {
            _hash
          } ;
        } ;
        if (_intersect distance2D [0,0] != 0) then {
          //private _intDist = _basePos distance2D _intersect ;
          private _mapEdge1 = _basePos getPos [_n,_i-ANGSTEP/2] ;
          private _mapEdge2 = _basePos getPos [_n,_i+ANGSTEP/2] ;

          private _intEdge1 = _basePos getPos [(_n + DISTSTEP) min _dist,_i-ANGSTEP/2] ;
          private _intEdge2 = _basePos getPos [(_n + DISTSTEP) min _dist,_i+ANGSTEP/2] ;

          _map drawTriangle
          [
            [
              _mapEdge1,
              _mapEdge2,
              _intEdge1,

              _mapEdge2,
              _intEdge1,
              _intEdge2
            ],
            [1,0,0,0.5],
            "#(rgb,1,1,1)color(1,1,1,1)"
          ] ;
        } ;
      } ;
    } ;

    for "_i" from _step to _dist step _step do {
      private _milestone = _i mod (_step*5) == 0 ;
      private _col = if (_milestone) then {[1,0,0,1]} else {[0.8,0.8,0.8,1]} ;
      _map drawEllipse [
        _basePos,_i,_i,0,_col,""
      ] ;
      if (_milestone) then {
        _map drawIcon [
          "#(argb,1,1,1)color(0,0,0,0)",
          [1,1,1,1],_basePos getPos [_i,_dir],
          0,0,0,format ["%1 m",_i],1,0.05,"PuristaLight","center"
        ] ;
      } ;
    } ;

    _map drawLine [
      _basePos getPos [
        _distMin,round (_dir-(ANGSTEP*ANGCOEF))-ANGSTEP/2
      ],
      _basePos getPos [_dist,round (_dir-(ANGSTEP*ANGCOEF))-ANGSTEP/2],
      [0.6,0,0,1]
    ] ;
    _map drawLine [
      _basePos getPos [
        _distMin,round (_dir+(ANGSTEP*ANGCOEF))+ANGSTEP/2
      ],
      _basePos getPos [_dist,round (_dir+(ANGSTEP*ANGCOEF))+ANGSTEP/2],
      [0.6,0,0,1]
    ] ;
    for "_i" from round (_dir-(ANGSTEP*ANGCOEF)) to round (_dir+(ANGSTEP*ANGCOEF))-ANGSTEP step ANGSTEP do {
      _map drawLine [
        _basePos getPos [
          _distMin,round (_i-ANGSTEP)-ANGSTEP/2
        ],
        _basePos getPos [
          _distMin,round (_i+ANGSTEP)+ANGSTEP/2
        ],
        [0.6,0,0,1]
      ] ;
    } ;
    _map drawIcon [
      "#(argb,1,1,1)color(0,0,0,0)",
      [1,1,1,1],_mPos,
      15,15,0,format ["%1 m",_dist toFixed 1],1,0.06,"PuristaLight","left"
    ] ;

  } ;
}] ;

uiNamespace setVariable ["PLP_SMT_EH",_EH] ;