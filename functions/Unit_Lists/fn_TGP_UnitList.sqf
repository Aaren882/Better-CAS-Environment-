TGP_View_Unit_List = allUnits select {((_x distance _cam < BCE_Tracker_Render_sdr) && (_x distance _cam < (getObjectViewDistance # 0)) && (_x iskindof "CAManBase") && !(_x in _vehicle))};

TGP_View_Marker_List = allunits select {
  _vehicle = (player getVariable "TGP_View_Selected_Optic") # 1;
  _current_turret = ((player getVariable "TGP_View_Selected_Optic") # 0) # 1;
  if (_current_turret isEqualTo []) then {_current_turret = [-1]};
  _turret_Unit = _vehicle turretUnit _current_turret;

  (_x isEqualTo _turret_Unit) or (_x getVariable ["TGP_View_Marker_last",-1] != -1)
};
