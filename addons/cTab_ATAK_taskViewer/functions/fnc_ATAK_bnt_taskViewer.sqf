params ["_ctrlBnts","_ctrlPOS","_subMenu","_interfaceInit"];
_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

//- Arrange Bottons layout (Back only)
{
	_x ctrlShow false;
	false
} count (_ctrlBnts select [1]);

_size = (4 * (_ctrlPOS # 2));

_bnt_back ctrlSetPositionW _size;
_bnt_back ctrlCommit 0;
