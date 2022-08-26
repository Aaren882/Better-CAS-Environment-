TGP_View_Unit_List = allUnits select {((_x distance _cam < BCE_Tracker_Render_sdr) && (_x distance _cam < (getObjectViewDistance # 0)) && (_x iskindof "CAManBase") && !(_x in _vehicle))};
