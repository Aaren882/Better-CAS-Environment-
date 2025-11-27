//-For Drawing Icon

private _Optic_Var = player getVariable ["TGP_View_Selected_Optic",[]];

_Optic_Var params ["_Optic_LODs",["_vehicle",objNull]];

//-Exit if is nil
if (isnil {_Optic_LODs}) exitWith {};

if ((_Optic_Var isEqualTo []) or (!(isplayer (driver _vehicle)) && (missionNamespace getVariable ["BCE_TAC_Map_AIxcd_POS",true]))) exitWith {
	private _dir_simp = missionNamespace getVariable ["BCE_Directional_object_AV",objNull];
	if (_dir_simp isEqualTo objNull) then {
		deleteVehicle _dir_simp;
		missionNamespace setVariable ["BCE_Directional_object_AV",objNull,true];
	};
};

if (missionNamespace getVariable ["BCE_Directional_object_AV",objNull] isEqualTo objNull) then {
	private _dir_simp = createSimpleObject ["a3\data_f\cube.p3d", [0,0,0]];
	hideObject _dir_simp;
	_dir_simp attachTo [_vehicle, [0,100,0], _Optic_LODs # 0, true];
	missionNamespace setVariable ["BCE_Directional_object_AV",_dir_simp,true];

	//-Delete Directional Object
	[{
		private _selected = player getVariable ["TGP_View_Selected_Optic",[]];
		private _condition = if (_selected isEqualTo []) then {
			true
		} else {
			(!(alive (_selected # 1)) && !(isEngineOn (_selected # 1)))
		};
		((isNull(findDisplay 160)) or (_condition))
	}, {
			deleteVehicle (_this # 0);
			missionNamespace setVariable ["BCE_Directional_object_AV",objNull,true];
		}, [_dir_simp]
	] call CBA_fnc_waitUntilAndExecute;
} else {
	(missionNamespace getVariable "BCE_Directional_object_AV") attachTo [_vehicle, [0,100,0], _Optic_LODs # 0, true];
};
