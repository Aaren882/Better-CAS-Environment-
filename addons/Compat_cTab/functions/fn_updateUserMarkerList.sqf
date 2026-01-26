/*
	Name: cTab_fnc_updateUserMarkerList

	Author(s):
		Gundy

	Description:
		Update lists of user markers by finding extracting all the user markers with the right encryption key and then translate the marker data in to a format so that it can be drawn quicker.

	Parameters:
		NONE

	Returns:
		BOOLEAN - Always TRUE

	Example:
		call cTab_fnc_updateUserMarkerList;
*/

if (isNil "cTabIfOpen") exitWith {false};

private _list = [];
{
  private _marker = _x;

  //- Skip on (Prefix "-") or (POLPOX's MapTool Markers)
		if (
      _marker select [0,1] == "-" ||
			("PLP_" in _marker)
    ) then {continue};
  
  private _markerShape = ["ICON","RECTANGLE","ELLIPSE","POLYLINE"] find (MarkerShape _marker);
  private _config = configFile >> "CfgMarkers" >> markerType _marker;

  //- Skip Conditions
		if (
      _markerShape < 0 || //- in-affective "MarkerShape"
      (_markerShape == 0 && getNumber (_config >> "size") == 0) //- if it's System Marker
    ) then {continue};

  private _texture = getText (_config >> "icon");

  //- Check if it's Editable
  private _editable = /*!(_marker find "PLP" > -1) && */(
    "_cTab" in _marker || 
    BCE_cTab_Marker_Sync in _marker || 
    "mtsmarker" in _marker ||
    "SWT_" in _marker
  );
  
	private _index = _forEachIndex;
	private _def_Size = getNumber (_config >> "size");

  if ("mtsmarker" in _marker) then {

    //- #NOTE - Compat for "Metis Marker" (https://steamcommunity.com/sharedfiles/filedetails/?id=1508091616)
      private _prefix = ((_marker splitString "_") # 0) + "_frame";
      private _search = _list findIf {_prefix in (_x # 0)};

		_index = [_forEachIndex, _search] select (_search > -1);
  };

	//- Additional data
	private _markerColor = markerColor _marker;
	private _color = _markerColor call BCE_fnc_getMarkerColor;
	_color = _color select [0,3]; // Exclude alpha

	private _markerDrawMode = [[0],[1,2]] findIf {_markerShape in _x}; // "ICON","RECTANGLE/ELLIPSE"]

  //- _result : [MARKER, SHAPE, DEFAULT_SIZE];
	private _result = [
		_marker,		// <STRING>
		_texture,		// <STRING>
		_index, 		//- <NUMBER>
		_markerShape, // <STRING>
		_def_Size, 		//- <NUMBER>
		_editable,	//- <BOOL>
		_color, 		//- <ARRAY<NUMBER>>
		_markerDrawMode //- <NUMBER>
	];
  
  _list pushBack _result;
} forEach allMapMarkers;

cTabMarkerList = _list;
_list = nil;

//- Get Marker Data for SIT
	private _MarkerColorArr = uiNamespace getVariable ["BCE_Marker_Color_Array",[]];
  // private _MarkerColorCache = uiNamespace getVariable ["BCE_Marker_Color",[]];
  private _rawMarkersList = [cTab_userMarkerLists,call cTab_fnc_getPlayerEncryptionKey,[]] call cTab_fnc_getFromPairs;

  cTabUserMarkerList = _rawMarkersList apply {
    private _RawData = _x # 1;
    _RawData params ["_pos", "_iconIndex", "_iconID", "_colorSel", "", "_sender"];

    //- Get the correct Marker
      private _marker = "";
      private _target = format [BCE_cTab_Marker_Sync + "_DEFINED #%1/%2",((_sender call BIS_fnc_netId) splitString ":") # 0 ,_iconID];
      {
        if (_target in _x) exitWith {_marker = _x};
      } count allMapMarkers;
    
    //- Arrange Data
      private _text = markerText _marker;
      private _dir = floor (markerDir _marker / 45); //- Transiform Dir to Index (N, NE, E, ...)
      private _align = ["right","left"] select ((_dir > 0) && (_dir < 4));
      //- Get Icon Info
      private _color = _MarkerColorArr # _colorSel;
      private _texture = getText (configFile >> "CfgMarkers" >> markerType _marker >> "icon");

    [_x # 0, [_pos,_texture,"",_dir,_color,_text,_align], _RawData]
    // [_x # 0, [_pos,_texture1,_texture2,_dir,_color,_text,_align,_drawSize], _x # 1]
  };

/*[
  [0,[[2644.47,4271.37],0,0,0,"12:00",B Alpha 1-1:1 (Aaren)]],
  [1,[[2523.44,4225.98],0,1,0,"12:00",B Alpha 1-1:1 (Aaren)]],
  [2,[[2509.9,4329.5],0,2,0,"12:00",B Alpha 1-1:1 (Aaren)]]
]*/

["ctab_userMarkerListUpdated"] call CBA_fnc_localEvent;

true
