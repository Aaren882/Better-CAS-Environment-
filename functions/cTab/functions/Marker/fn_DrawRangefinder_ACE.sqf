//- Check Rangefinder (Requir ACE + cTab 1erGTD)
if (ctab_rangefinder_last == 0) exitWith {}; //- Exit on "ctab_rangefinder" Vars are Empty

if (ctab_rangefinder_last > time) then {
  private _last = ctab_rangefinder_last - time;
  private _step = ((_last/5) call BIS_fnc_smoothStep);
  private _size = 40 + _step * 10;
  
  _ctrlScreen drawIcon [
    "z\ace\addons\microdagr\images\icon_mapWaypoints.paa",
    [1,1,1, _step],
    ctab_rangefinder_lastPosition,
    _size, //- Width
    _size, //- Height
    0,
    "Pinned POS",
    1,
    cTabTxtSize * 1.25,
    "RobotoCondensedBold",
    "Right"
  ];
} else {
  ctab_rangefinder_lastPosition = [];
  ctab_rangefinder_last = 0;
};