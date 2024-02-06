params ["_control"];

_move = {
	params["_ctrl","_open",["_isList",false]];
	if (_open) then {
		_pos = [
			_pos,
			[
				_pos # 0,
				_pos # 1,
				5 * (safezoneH / 40),
				_pos # 3
			]
		] select _isList;
		_ctrl ctrlSetPosition _pos;
	} else {
		_ctrl ctrlSetPosition [
			(_pos # 0) + (_pos # 2),
			_pos # 1,
			0,
			0
		];
	};
	_ctrl ctrlSetFade ([1,0] select _open);
};

_display = ctrlparent _control;
_list_Racks = _display displayCtrl 201142;
_unit_pic = _display displayCtrl 20115;

_pos = ["x","y","w","h"] apply {
	call compile (getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _unit_pic >> _x))
};

if !(ctrlEnabled _list_Racks) then {
	_list_Racks ctrlenable true;
	[_list_Racks,true,true] call _move;
	[_unit_pic,false] call _move;
} else {
	_list_Racks ctrlenable false;
	[_list_Racks,false,true] call _move;
	[_unit_pic,true] call _move;
};
{_x ctrlCommit 0.3} forEach [_list_Racks,_unit_pic];

///////////////////////////////////////////////////////////////////////////////////////
//-get Racks radio
_list_Racks call BCE_fnc_setRacks_ACRE;
