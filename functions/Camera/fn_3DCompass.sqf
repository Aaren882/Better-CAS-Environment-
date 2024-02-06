[
	["N",[1,0,0,0.7],[0,1,0],[0,0.5,0]],
	["S",[1,1,1,0.5],[0,-1,0],[0,-0.5,0]],
	["E",[1,1,1,0.5],[1,0,0],[0.5,0,0]],
	["W",[1,1,1,0.5],[-1,0,0],[-0.5,0,0]],
	["",[0,1,0,0.4]]
] apply {
	_x params ["_letter", "_color", "_offset1", "_offset2"];

	private ["_FOV","_FOV_POS","_center","_letter2","_POS1","_POS2","_size"];
	_FOV = round (call BCE_fnc_trueZoom * 10) / 10;
	_FOV_POS = [0,0,8];

	if (_FOV >= 1) then {
		_FOV_POS = [0,0,15];
	};
	if (_FOV >= 2) then {
		_FOV_POS = [0,0,30];
	};
	if (_FOV >= 5) then {
		_FOV_POS = [0,0,80];
	};
	if (_FOV >= 10) then {
		_FOV_POS = [0,0,120];
	};
	if (_FOV >= 20) then {
		_FOV_POS = [0,0,150];
	};

	_center = AGLToASL (positionCameraToWorld _FOV_POS);
	_letter2 = ".";

	//- Switch
	if (_letter != "") then {

		_size = 0.05;
		_POS1 = _center vectorAdd _offset1;
		_POS2 = _center vectorAdd _offset2;

		private _Center_H = _center # 2;
		_POS1 set [2, _Center_H];
		_POS2 set [2, _Center_H];

	} else {
		_size = 0.04;

		if (abs speed _vehicle < 0.1) then {
			_POS1 = nil;
			_POS2 = nil;
		} else {
			private _vector = velocity _vehicle;
			private _UpDown = _vector # 2;

			_POS1 = _center vectorAdd (vectorNormalized _vector);
			_POS2 = _center vectorAdd ((vectorNormalized _vector) vectorMultiply 0.5);
			_letter = format ["%1 m/s %2",round (_UpDown / 10) * 10,["↑","↓"] select (_UpDown < 0)];
			_letter2 = "*";
			_color = [[0,1,0,0.4],[1,0,0,0.4]] select (_UpDown < -30);
		};
	};

	//-Draw Icons
	{
		_x params ["_letter","_POS",["_size",0.05]];
		if (isnil {_POS}) then {break};
		drawIcon3D [
			"",
			_color,
			ASLToAGL _POS,
			0,
			0,
			0,
			_letter,
			2,
			_size,
			"PuristaMedium"
		];
	} count [
		[_letter,_POS1,_size],
		[_letter2,_POS2]
	];
};
