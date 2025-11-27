#include "script_component.hpp"

params ["_vehicle",["_mode",-1]];
private ["_class_veh","_cache","_Camera_Cache","_IRLaser_Cache","_allTurrets","_config_path","_pilot_cam_LOD","_Turrets_Optics","_Optic_LODs","_turret_Weapons","_return"];

//-exit if _vehicle is not Vehicle
if !(_vehicle in vehicles) exitWith {[]};

_class_veh = typeOf _vehicle;

_cache = localNamespace getVariable ["BCE_System_Caches", createHashMap];

//-Check caches
if !("BCE_Camera_Cache" in _cache) then {
	_cache set ["BCE_Camera_Cache", createHashMap];
};
if !("BCE_IRLaser_Cache" in _cache) then {
	_cache set ["BCE_IRLaser_Cache", createHashMap];;
};

//- Get caches
_Camera_Cache = _cache get "BCE_Camera_Cache";
_IRLaser_Cache = _cache get "BCE_IRLaser_Cache";

//-Exit with Return
if ((_mode > -1) && (_class_veh in ([_Camera_Cache, _IRLaser_Cache] # _mode))) exitWith {
	private _result = ([_Camera_Cache, _IRLaser_Cache] # _mode) get _class_veh;
	[_result, []] select (isNil {_result});
};

_allTurrets = (allTurrets _vehicle)/* select {
	!((getText ([_vehicle, _x] call BIS_fnc_turretConfig >> "turretInfoType")) in GUNNER_OPTICS)
}*/;

//-Exit if "_allTurrets" is empty
if ((_allTurrets findif {true} < 0) && !(hasPilotCamera _vehicle)) exitWith {[]};

//- on cache generating
	_config_path = configOf _vehicle;
	
	_turret_Weapons = ([[-1]] + _allTurrets apply {
		[
			[_x, flatten getArray ([_vehicle, _x] call BIS_fnc_turretConfig >> "Weapons")],
			[_x, getArray (_config_path >> "Weapons")]
		] select ((_x # 0) < 0);
	}) select {
		((_x # 1) findIf {"laserdesignator" in tolower _x}) > -1
	};

	if ((_mode == 1) && ((_class_veh in _IRLaser_Cache) || (count _turret_Weapons < 1))) exitWith {[]};

	//-Available Optics
		_pilot_cam_LOD = if (
			(isClass (_config_path >> "pilotCamera")) &&
			(getNumber (_config_path >> "pilotCamera" >> "controllable") == 1) &&
			!(unitIsUAV _vehicle)
		) then {
			[getText (_config_path >> "memoryPointDriverOptics"),[-1],true]
		} else {
			["",[]]
		};

		_Turrets_Optics = if ((_allTurrets findif {true}) > -1) then {
			_allTurrets apply {
				private ["_cfg","_text","_is_Detached"];
				_cfg = [_vehicle, _x] call BIS_fnc_turretConfig;
				_text = getText (_cfg >> "memoryPointGunnerOptics");
				_is_Detached = (getNumber (_cfg >> "Detached_Optic")) == 1;
				[
					[_text,_x,_is_Detached],
					["",[]]
				] select ((_vehicle selectionPosition _text) isEqualTo [0,0,0]);
			};
		} else {
			[]
		};

		_Turrets_Optics = [_pilot_cam_LOD] + _Turrets_Optics;

		//--Filter
		_Optic_LODs = _Turrets_Optics select {
			!(_x isEqualTo ["",[]])
		};

		if (count _Optic_LODs > 0) then {
			_Camera_Cache set [_class_veh, _Optic_LODs];
		};

	//-FOV handler
		if (((count _allTurrets > 0) || (hasPilotCamera _vehicle)) && (_vehicle isKindOf "Air")) then {

			//-Apply default Turret FOV
			
			if (isNil{_vehicle getVariable "BCE_Cam_FOV_Angle"}) then {
				private _map = createHashMap;
				(_Camera_Cache get _class_veh) apply {
					private ["_turret","_config","_optic","_class","_fov"];

					_turret = _x # 1;
					
					//-if is a pilot Cam (TGP)
					_config = [
						[_vehicle, _turret] call BIS_fnc_turretConfig,
						_config_path >> "PilotCamera"
					] select ((_turret # 0) == -1);

					_class = ([
						[_config >> "ViewOptics"],
						"true" configClasses (_config >> "OpticsIn")
					] select isclass (_config >> "OpticsIn")) # 0;

					//-init camera FOV
					_class = _class >> "initFov";
					_fov = [
						getNumber _class,
						call compile (getText _class)
					] select (isText _class);

					//-Set FOV
					_map set [str _turret, deg _fov];
				};

				_vehicle setVariable ["BCE_Cam_FOV_Angle",_map,true];
				_map = nil;
			};
			

			if (isnil "BCE_FOV_actEHs") then {
				BCE_FOV_actEHs = ["zoomIn","zoomOut"] apply {
					addUserActionEventHandler [_x, "Analog", {
						//-Get FOV is all turrets and TGP (if curretly in an Aircraft)
						private ["_vehicle","_var","_unit","_turret"];
						_vehicle = cameraOn;
						_var = _vehicle getVariable "BCE_Cam_FOV_Angle";

						if (
							(_vehicle isKindOf "Air") &&
							!(isNil{_var}) &&
							(
								((allTurrets _vehicle) findIf {true} > -1) ||
								(hasPilotCamera _vehicle)
							)
						) then {
							if (cameraview == "GUNNER") then {
								//-check is an UAV
								_unit = [player, getConnectedUAVUnit player] select (unitIsUAV cameraOn);
								_turret = _vehicle unitTurret _unit;

								//-Set Variable + Send to Network
								_var set [str _turret, (round (deg (getObjectFOV _vehicle))) max 1];
								_vehicle setVariable ["BCE_Cam_FOV_Angle",_var,true];
							};
						} else {
							{
								removeUserActionEventHandler [_x, "Analog", BCE_FOV_actEHs # _forEachIndex];
							} forEach ["zoomIn","zoomOut"];

							BCE_FOV_actEHs = nil;
						};
					}];
				};
			};
		};

	//-Get memory point for LaserDesignators
		if (count _turret_Weapons > 0) then {

			private _result = _turret_Weapons apply {
				private ["_turret","_is_turret","_config","_turret_pos_mem","_gunBeg","_offset"];
				_turret = _x # 0;
				_is_turret = (_turret # 0) >= 0;

				if (_is_turret) then {
					_config = [_vehicle, _turret] call BIS_fnc_turretConfig;
					_turret_pos_mem = getText (_config >> "memoryPointGunnerOptics");
				} else {
					_config = _config_path;
					_turret_pos_mem = getText (_config >> "memoryPointDriverOptics");
				};

				_gunBeg = [
					getText (_config >> "gunBeg"),
					nil
				] select ((_vehicle isKindOf "Air") && (_is_turret));

				_offset = [
					[0,0,0],
					getArray (_config >> "LaserDesignator_Offset")
				] select (isArray (_config >> "LaserDesignator_Offset"));

				[_is_turret,[_turret_pos_mem,_offset,_turret,_gunBeg] select {!isnil {_x}}]
			};
			_IRLaser_Cache set [_class_veh, _result];
		};

localNamespace setVariable ["BCE_System_Caches", _cache];

_return = ([_Camera_Cache, _IRLaser_Cache] # _mode) get _class_veh;

if (isNil {_return}) exitWith {[]};

//-Return
[[],_return] select (_mode > -1);
