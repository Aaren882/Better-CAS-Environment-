// #include "\MG8\AVFEVFX\cTab\has_cTab.hpp"

addMissionEventHandler ["EachFrame", {
	if (count IR_LaserLight_UnitList > 0) then {
		IR_LaserLight_UnitList apply {
			if (_x call BCE_fnc_isLaserOn) then {
				_x call BCE_fnc_LaserDesignator;
			};
		};
	};

	//-DoorGunner Laser Sync
	(allunits select {!(_x getVariable ["BCE_turret_Gunner_Laser",[]] isEqualTo [])}) apply {
		_x call BCE_fnc_gunnerLoop;
	};

	//-TGP Update
	call BCE_fnc_UpdateCameraInfo;

	//-cTab Main System
	if (BCE_System_cTab_Loaded) then {
		private _cTabPlayer = missionNamespace getVariable ["BIS_fnc_moduleRemoteControl_unit",player];
		if (cTab_player != _cTabPlayer) then {
			cTab_player = _cTabPlayer;

			call cTab_fnc_close;
			call cTab_fnc_updateLists;
			// call cTab_fnc_updateUserMarkerList;

			// remove msg notification
			cTabRscLayerMailNotification cutText ["", "PLAIN"];
		};
	};
	// #endif

	//-Take Client Side Handler
	private _BCE_list = (allPlayers select {_x getVariable ["Have_BCE_Loaded",false]}) apply {str _x};
	_BCE_list sort true;

	if ((_BCE_list # 0) == str player) then {
		call BCE_fnc_ServerClientSide;
		removeMissionEventHandler [_thisEvent, _thisEventHandler];
	};
}];

player setVariable ["Have_BCE_Loaded",true,true];
