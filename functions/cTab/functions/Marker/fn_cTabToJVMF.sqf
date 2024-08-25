/*
 * vtx_uh60_jvmf_fnc_ctabToJvmf
 *
 * Convert data into Jvmf format
 *
 */
params ["_index", "_marker"];
// _marker params ["_position", "_iconIndex", "_size", "_direction", "_time", "_sender"];
_marker params ["_position", "_iconIndex", "_iconID", "", "_time", "_sender"];

private _position3d = [_position # 0, _position # 1, getTerrainHeightASL _position];

//- Get the correct Marker
	private _marker = "";
	private _target = format ["_USER_DEFINED #%1/%2",((_sender call BIS_fnc_netId) splitString ":") # 0 ,_iconID];
	{
		if (_target in _x) exitWith {
			_marker = _x;
		};
	} count allMapMarkers;

//- Exit if Marker is Empty
	if (_marker == "") exitWith {
		["", "", "", "", "", "", ""]
	};

private _positionType = configName (("true" configClasses (configFile >> "cTab_CfgMarkers")) # _iconIndex);

private _messageComments = [
	_positionType,
	markerText _marker,
	"",
	"AT POSITION " + mapGridPosition _position,
	"AT TIME " + _time
];

private _gridZone = [] call ace_common_fnc_getMGRSdata;
private _gridStr = [_position3d] call ace_common_fnc_getMapGridFromPos;
private _fullPositionString = [_gridZone # 0, _gridZone # 1, _gridStr # 0, _gridStr # 1] joinString " ";

// build the message
private _id = "CTAB" + str _index;
private _recipient = "ALL";
private _messageType = 2;

private _messageContent = [
	_fullPositionString,
	str (round (_position3d # 2)) + " MSL",
	[
		_time,
		getText (configFile >> "CfgMarkers" >> markerType _marker >> "name")
	] joinString " "
] + _messageComments;

private _data = [_position3d];
private _replies = [[_time, name _sender, "SENT", _sender]];

[
	_id, // TITLE
	name _sender, // SENDER
	_recipient, // RECIPIENTS
	_messageType, //MSG TYPE
	_messageContent, //MSG TEXT
	_data, // MSG DATA
	_replies // REPLIES
]