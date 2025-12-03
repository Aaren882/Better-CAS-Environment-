TGP_View_Unit_List = allUnits select {
	(
		(_x distance _cam < BCE_Tracker_Render_sdr) &&
		(_x distance _cam < (getObjectViewDistance # 0)) &&
		(_x iskindof "CAManBase") &&
	 !(_x in _vehicle)
	)
};

TGP_View_Marker_List = allunits select {
	((_x getVariable ["TGP_View_Marker_last",-1]) > 0)
};
