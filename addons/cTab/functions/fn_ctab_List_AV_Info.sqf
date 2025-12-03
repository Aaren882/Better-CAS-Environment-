params ["_list","_vehicle"];
private ["_config","_List_index"];

//-Make sure list is clean
lbclear _list;

_config = configFile >> "CfgWeapons";
_List_index = [
	["STR_DRIVER",{
		[name (driver _veh),"-"] select (isnull (driver _veh))
	}],
	["STR_GUNNER",{
		if (isNil {_current_turret}) exitWith {"-"};
		[name _turret_Unit,"-"] select (isnull (_turret_Unit) or (_turret_Unit isEqualTo (driver _veh)))
	}],
	["STR_A3_RscDisplayAVTerminal_AVT_Text_WPN",{
		if (isNil {_current_turret}) exitWith {"-"};
		[
			getText (_config >> _veh currentWeaponTurret _current_turret >> "DisplayName"),
			"-"
		] select (getText (_config >> _veh currentWeaponTurret _current_turret >> "DisplayName") == "");
	}],
	["STR_A3_RscDisplayAVTerminal_AVT_Text_FUEL",{
		format ["%1%2",round ((fuel _veh) * 100) , "%"];
	}],
	["STR_A3_RscDisplayAVTerminal_AVT_Text_POS",{
		format ["%1 %2",localize "$str_a3_rscdisplayartillery_artillerygridtext",mapGridPosition _veh]
	}],
	["STR_A3_RscDisplayAVTerminal_AVT_Text_AZT",{
		format ["%1°",round (getdir _veh)]
	}],
	["STR_A3_RscDisplayAVTerminal_AVT_Text_SPD",{
		format ["%1 km/h",round (speed _veh)]
	}],
	["STR_A3_RscDisplayAVTerminal_AVT_Text_ALT",{
		format ["%1 m",round ((getPosASL _veh) # 2)]
	}]
] apply {
	[_list lbAdd (localize (_x # 0)), _x # 1]
};

[{
	params ["_veh","_list","_List_index","_config"];

	(cTab_player getVariable ["TGP_View_Selected_Optic",[[],objNull]]) params ["_connected_Optic","_vehicle_New"];

	if (alive _vehicle_New) then {
		_current_turret = _connected_Optic # 1;
		_turret_Unit = _veh turretUnit _current_turret;

		_List_index apply {
			_list lbSetTextRight [_x # 0,call (_x # 1)];
		};
	};

	!(ctrlShown _list) or (isNull _list) or (_veh != _vehicle_New) or !(alive cTab_player) or !(alive _veh)
}, {
}, [_vehicle,_list,_List_index,_config]
] call CBA_fnc_waitUntilAndExecute;
