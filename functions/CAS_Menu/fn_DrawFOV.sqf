params ["_vehicle","_ctrl","_FocusPos","_turret","_color","_text",["_condition",true]];

//-Draw condition
if !(_condition) exitWith {};

private ["_angle","_veh_POS","_dis","_dir","_points","_vertices"];

_angle = _vehicle getVariable "BCE_Cam_FOV_Angle";

if (isnil{_angle}) exitWith {};

//-Vars
_angle = (_angle get (str _turret)) / 2;
_veh_POS = getPosASLVisual _vehicle;
_veh_POS set [2,0];
_dis = (_vehicle distance2D _FocusPos) * 1.2;
_dir = _veh_POS getDirVisual _FocusPos;

//- only generate 1 + 4 vertices
_vertices = [-_angle,_angle];
_points = [];
for "_i" from -_angle to _angle step (_angle/2) do {
	_points pushBack _i;
};
_vertices insert [1, _points];
_points = nil;

//-Drawing
_vertices = [_veh_POS] + (_vertices apply {
	private _pos = _veh_POS getPos [_dis, _dir + _x];
	_pos set [2 ,0];
	_pos
});

_ctrl drawPolygon [_vertices, _color];

_ctrl drawIcon [
	["\a3\ui_f\data\IGUI\Cfg\Cursors\attack_ca.paa","\a3\ui_f\data\IGUI\Cfg\Cursors\board_ca.paa"] select visibleMap,
	_color,
	_FocusPos,
	35,
	35,
	0,
	_text,
	1,
	0.075,
	'PuristaMedium',
	'right'
];
