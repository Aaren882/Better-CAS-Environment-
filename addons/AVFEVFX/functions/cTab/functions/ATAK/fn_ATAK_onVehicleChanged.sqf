params ["_connect","_display"];

//- Update Interface
  "showMenu" call BCE_fnc_cTab_UpdateInterface;

//- Pylon info
if (_connect) then {
  //-Connected
  _display call BCE_fnc_ATAK_Refresh_Weapons;
} else {
  //-Disconnected
  private _group = _display displayCtrl (17000 + 4661);
  {lbClear (_group controlsGroupCtrl (17000 + 2020 + _x))} count [0,1];
};