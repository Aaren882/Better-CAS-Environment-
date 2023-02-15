//-Link: https://forums.bohemia.net/forums/topic/221878-problem-getting-8-digit-grids-in-bis_fnc_gridtopos/

params ["_grid"];

_count = count _grid;
_size = _count / 2;
_multis = [1,10,100];
_counts = [10,8,6];
_multi = _multis # (_counts find _count);
_posX = (parseNumber (_grid select [0,_size])) * _multi;
_posY = (parseNumber (_grid select [_size,_size + _size])) * _multi;
[_posX,_posY,0]
