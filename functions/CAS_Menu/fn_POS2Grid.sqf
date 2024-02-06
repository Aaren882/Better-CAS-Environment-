//-Link: https://forums.bohemia.net/forums/topic/221878-problem-getting-8-digit-grids-in-bis_fnc_gridtopos/

params ["_pos",["_gridSize",6,[0]]];

_divisors = [100,10,1];
_gridSizes = [6,8,10];
_divisor = _divisors select (_gridSizes find _gridSize);
_gridResolution = _gridSize / 2;
_pos params ["_posX","_posY"];
_posX = str round floor (_posX / _divisor);
_posY = str round floor (_posY / _divisor);
while {count _posX < _gridResolution} do {
	_posX = "0" + _posX;
};

while {count _posY < _gridResolution} do {
	_posY = "0" + _posY;
};

_posX + _posY
