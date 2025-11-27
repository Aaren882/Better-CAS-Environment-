// #include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
params ["_control",["_IDC_offset",0],["_show_info",false]];

private _display = ctrlParent _control;
private _vehicle = [nil,"AIR" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

if !(isnull _vehicle) then {
	private ["_current_turret","_turret_select","_squad_list"];
	(call BCE_fnc_getTurret) params ["_cam","_vehicle","_Optic_LODs","_current_turret"];

	if (count _Optic_LODs <= 1) exitWith {};

	_current_turret = [_current_turret + 1,0] select (_current_turret >= ((count _Optic_LODs) - 1));

	_turret_select = _Optic_LODs # _current_turret;
	player setVariable ["TGP_View_Selected_Optic",[_turret_select,_vehicle],true];

	_squad_list = _display displayctrl 20116;

	if (BCE_System_cTab_Loaded) then {
		if (!(cTabIfOpenStart) && (cTabActUav isNotEqualTo focusOn)) then {
			if ("Android" in (cTabIfOpen # 1)) then {
				//- Update Interface
					"showMenu" call BCE_fnc_cTab_UpdateInterface;
			} else {
				[[["uavCam",str _vehicle]]] call cTab_fnc_updateInterface;
			};
		};
	};
	// #endif

	//-Set Turret Display
	if (_show_info) then {
		private ["_turret_txt"];
		_turret_txt = getText ([_vehicle, _turret_select # 1] call BIS_fnc_turretConfig >> "gunnerName");
		_turret_txt = [_turret_txt,localize "STR_DRIVER"] select (_turret_txt == "");

		(_display displayCtrl (_IDC_offset + 46320)) ctrlSetText _turret_txt;
	};

	if (isNull _squad_list) exitWith {};
	if (ctrlshown _squad_list) then {
		_squad_list lbSetCurSel ([(_current_turret + 1) min (count _Optic_LODs),_current_turret] select (-1 in (flatten _Optic_LODs)));
	};
};
