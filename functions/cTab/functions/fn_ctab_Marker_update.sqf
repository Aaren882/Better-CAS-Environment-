[
  {
    //- Update Markers
      call cTab_fnc_updateUserMarkerList;
    BCE_cTab_Marker_Sync_time call BCE_fnc_cTab_Marker_update;
  }, 
  [],
  _this
] call CBA_fnc_waitAndExecute;