params ["_vehicle","_ctrl","_FocusPos","_turret","_color","_text",["_condition",true]];

//-Draw condition
if !(_condition) exitWith {};

private ["_angle","_veh_POS","_dis","_dir","_vertices"];

_angle = _vehicle getVariable "BCE_Cam_FOV_Angle";

if (isnil{_angle}) exitWith {};

//-Vars
_angle = _angle get (str _turret);
_veh_POS = getPosASLVisual _vehicle;
_dis = _vehicle distance2D _FocusPos;
_dir = _veh_POS getDirVisual _FocusPos;

//-Drawing
_vertices = [_veh_POS] + ([_angle,-_angle] apply {
	_veh_POS getPos [_dis*1.2, _dir + (_x / 2)]
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
