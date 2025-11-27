TGP_View_Marker_List apply {
	private["_pos","_time","_alpha"];
	_pos = _x getVariable ["TGP_View_Mark",[]];
	_time = _x getVariable ["TGP_View_Marker_last",1];
	_alpha = abs (1 min _time);
	if (!(_pos isEqualTo []) && (_time != -1)) then {
		drawIcon3D [
			"\a3\ui_f\data\IGUI\Cfg\TacticalPing\TacticalPingDefault_ca.paa",
			[1,0.8,0.2,_alpha],
			_pos,
			1,
			1,
			0,
			name _x,
			1.5,
			0.03,
			"PuristaMedium",
			"",
			true
		];
	};
};
