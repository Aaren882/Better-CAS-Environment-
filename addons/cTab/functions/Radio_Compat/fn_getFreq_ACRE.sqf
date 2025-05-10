Params ["_radio"];

/* _namespace = (acre_sys_data_radioData getvariable "acre_vrc103_id_1");
_namespace getvariable "allowed"
["driver"] */

_namespace = [_radio,"getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
//_channel = str (_radio call acre_api_fnc_getRadioChannel);
_channel = [_radio,"getListInfo"] call acre_sys_data_fnc_dataEvent;

_RX = str(_namespace getvariable "frequencyRX");
_TX = str(_namespace getvariable "frequencyTX");

[[format["RT: %1/%2",_RX,_TX],_channel],[_RX,_channel]] select (_RX == _TX);

/* _infos = _acre_getUnitRadios apply {
	private ["_namespace","_channel","_RX","_TX"];
	_namespace = [_x,"getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
	_channel = str (_x call acre_api_fnc_getRadioChannel);

	_RX = str(_namespace getvariable "frequencyRX");
	_TX = str(_namespace getvariable "frequencyTX");

	[[format["RT: %1/%2",_RX,_TX],_channel],[_RX,_channel]] select (_RX == _TX);
}; */

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
