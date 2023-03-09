Params ["_unit","_vehicle"];

//-get Racks radio
_acre_getUnitRadios = (["ACRE_PRC117F", _unit] call acre_api_fnc_getAllRadiosByType) + (
  _vehicle call acre_api_fnc_getVehicleRacks
) apply {
  _x call acre_api_fnc_getMountedRackRadio
};

_acre_getUnitRadios = _acre_getUnitRadios select {
  (([_x,"getOnOffState"] call acre_sys_data_fnc_dataEvent) == 1)
  /* && ([_x,_unit] call acre_sys_rack_fnc_isRadioAccessible)*/
};


/* _namespace = (acre_sys_data_radioData getvariable "acre_vrc103_id_1");
_namespace getvariable "allowed"
["driver"] */

_infos = _acre_getUnitRadios apply {
  private _namespace = [_x,"getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
  private _channel = str (_x call acre_api_fnc_getRadioChannel);

  private _RX = str(_namespace getvariable "frequencyRX");
  private _TX = str(_namespace getvariable "frequencyTX");

  [[format["RT: %1/%2",_RX,_TX],_channel],[_RX,_channel]] select (_RX == _TX);
};

(_infos # 0)

//_channel = [str(_acre_channels # 0),nil] select (count _acre_channels == 0);
//hintSilent str [_acre_getUnitRadios,_acre_channels,_freq,time];

//_acre_getUnitRadios = ([[], _acre_getUnitRadios] call acre_sys_data_fnc_sortRadioList) # 1;

/* [[_unit], {
  params ["_unit"];
  _unit setVariable ["BCE_get"];
}] remoteExec ['call', 2]; */
/* if ((count _acre_getUnitRadios) == 0) then {

}; */

//["ctcssrx","frequencyrx","synclength","ctcsstx","encryption","mode","frequencytx","modulation","power","trafficrate","tek"]
//(["acre_prc117f_id_3","getCurrentChannelData"] call acre_sys_data_fnc_dataEvent) getvariable "frequencyrx";
