(calculatePath ["wheeled_APC", "safe", getpos player, customWaypointPosition]) addEventHandler ["PathCalculated", {  
  private _path = _this # 1;
  systemChat str [_path,time];
  if (count _path > 2) then {
    private _temp = [];
    private _previus = [];
    private _i = 0;
    {
      private _p = _x;
      _p set [2, 0];
      //- Make sure there no waypoint between 10 meters
        if (10 > vectorMagnitude (_p vectorDiff _previus)) then {continue};
      
      //- Create Marker
        private _marker = createMarker ["markerW" + str _i, _p];  
        _marker setMarkerType "mil_dot";  
        _marker setMarkerText str _i;

      _temp pushBack _p;
      _i = _i + 1;
      _previus = _p;
    } forEach _path; 
    missionNamespace setVariable ["Calculated_Path",_temp];
  }; 
}];

//- get vectors (from END => START)
  _temp = [];
  _path =+ Calculated_Path; //- =+ Copy the Value

  //- Only in vectorDir 0 <= 1
  for "_i" from ((count _path) -1) to 0 step -1 do {
    if (_i == 0) then {break};
    _temp pushback vectorNormalized ((_path # (_i - 1)) vectorDiff (_path # _i));
  };
  
  Calculated_Path_Vec = _temp;

//- Search User is going to which waypoint index
  private _temp =+ Calculated_Path_Vec;
  private _pathCount = count _temp; 

  _UserPos = getPosASLVisual player;
  _UserPos set [2, 0];
  _toUserVec = Calculated_Path apply {_UserPos vectorDiff _x};
  reverse _toUserVec;
  _i = 0;

  _index = _temp findIf {
    private _vec = _toUserVec # _i;
    _i = _i + 1;
    _x vectorDotProduct _vec < 0 && vectorMagnitude _vec < 20
  };

  _pathCount - (_index max 0) + 1

//- Statis ////
  Calculated_Path = [[3775.5,4797.5,197.074],[3775.5,4800.5,196.984],[3775.5,4817.5,196.646],[3776.5,4818.5,196.687],[3781.5,4823.5,196.817],[3781.98,4823.48,196.819],[3791.22,4845.37,195.279],[3801.1,4868.88,191.927],[3810.99,4893.1,188.588],[3818.24,4918.8,184.387],[3821.49,4944.45,179.76],[3820.61,4962.65,177.516],[3815.8,4971.7,176.574],[3803.13,4979.77,176.623],[3785.82,4991.87,175.661],[3771.03,5007.52,173.129],[3757.66,5029.37,167.747],[3747.75,5052.73,161.402],[3740.39,5073,156.009],[3732.24,5092.31,151.11],[3722.77,5109.62,146.875],[3704.76,5130.78,140.702],[3681.35,5151.7,133.335],[3663.94,5170.63,126.732],[3651,5193.51,123.005],[3642.84,5212.02,119.889],[3640.16,5228.21,118.32],[3633.63,5227.55,118.268]];
  { 
    private _marker = createMarker ["marker_path" + str _forEachIndex, _x];  
    _marker setMarkerType "mil_dot";  
    _marker setMarkerText str _forEachIndex;  
  } forEach Calculated_Path; 