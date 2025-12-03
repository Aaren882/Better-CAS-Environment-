#include "script_component.hpp"
/*
	Name: cTab_fnc_userMenuSelect

	Author(s):
		Gundy, Riouken

	Edit:
		Aaren

	Description:
		Process user menu select events, initiated by "\cTab\shared\cTab_markerMenu_controls.hpp"


	Parameters:
		0: INTEGER - Type of user menu select event - if this doesn't match a valid type it will be considered to be an IDC

	Returns:
		BOOLEAN - TRUE

	Example:
		[1] call cTab_fnc_userMenuSelect;
*/

#include "\cTab\shared\cTab_gui_macros.hpp"

disableSerialization;
params ["_typeID"];

private _displayName = cTabIfOpen # 1;
private _display = uiNamespace getVariable _displayName;

private _reset_Veh = false;
private _idcToShow = 0;

call {
	// send cTabUserSelIcon to server

	if (_typeID == 1) exitWith {
		cTabUserSelIcon pushBack cTab_player;
		[call cTab_fnc_getPlayerEncryptionKey,cTabUserSelIcon] call cTab_fnc_addUserMarker;
	};

	// Lock UAV cam to clicked position
	if (_typeID == 2) exitWith {
		[cTabUserSelIcon # 0] call cTab_fnc_lockUavCamTo;
	};

	//-connect to Vehicle
	if (_typeID == 3) exitWith {

		private _curSel = localNamespace getVariable ["cTab_BFT_CurSel",objNull];

		if !(isnull _curSel) then {
			switch (true) do {

				//- Air Support
				case (_curSel isKindOf "Air"): {
					private ["_reset_Veh","_Selected_Optic"];
					
					if !(isEngineOn _curSel) exitWith {
						["Task_Builder",localize "STR_BCE_Error_EngineOff",5] call cTab_fnc_addNotification;
					};
					_reset_Veh = true;
       		[
						_curSel,
						"AIR" call BCE_fnc_get_TaskCateIndex
					] call BCE_fnc_set_TaskCurUnit;
					["cTab_Tablet_dlg",[["uavCam",str _curSel]],false] call cTab_fnc_setSettings;

					_Selected_Optic = player getVariable ["TGP_View_Selected_Optic",[[],objNull]];
					if (((player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) || (_curSel isNotEqualTo (_Selected_Optic # 1))) then {
						player setVariable ["TGP_View_Selected_Optic",[([_curSel,0] call BCE_fnc_Check_Optics) # 0, _curSel],true];
						
						//-ATAK
						if ("Android" in _displayName) then {
							[true,_display] call BCE_fnc_ATAK_onVehicleChanged;
						};
					};
				};
				//- Call For Fire (Artiliry) [Group Object]
				case (_curSel in cTabARTYlist): {
					[
						_curSel,
						"GND" call BCE_fnc_get_TaskCateIndex
					] call BCE_fnc_set_TaskCurUnit;
				};
			};
		};
	};
	//-DisConnect Vehicle
	if (_typeID == -3) exitWith {
		_reset_Veh = true;
		[objNull] call BCE_fnc_set_TaskCurUnit;
		player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];
		["cTab_Tablet_dlg",[["uavCam",str objNull]],false] call cTab_fnc_setSettings;

		if (cTabActUav != cTab_player) then {
			call cTab_fnc_deleteUAVcam;
		};

		//-ATAK
		if ("Android" in _displayName) then {
			[false,_display] call BCE_fnc_ATAK_onVehicleChanged;
		};
	};

  //- Delete Marker
	if (_typeID == -4) exitWith {
		_list = _display displayCtrl (17000 + 12010);

		_task = switch ([] call BCE_fnc_get_TaskCurType) do {
			//- 5 line
			case 1: {
				[-1,2,1]
			};
			//- 9 line
			default {
				[1,6,8]
			};
		};
		[_list, false, 'cTab_Tablet_dlg', 17000, _task # (lbCurSel _list)] call BCE_fnc_clearTaskInfo;
		[_list, lbCurSel _list] call BCE_fnc_ctab_BFT_ToolBox;
	};

	//-Edit Marker
	if (_typeID in [41,42,43]) exitWith {
		
		private _taskType = call BCE_fnc_get_TaskCurType;
		private _cate = ("AIR" call BCE_fnc_get_TaskCateIndex) # 1; // ex. [nil, 0]
		private _taskVar =  ([_taskType,_cate,_display,false] call BCE_fnc_getTaskVar) # 0;

		private _task = switch (_taskType) do {
			//- 5 line
			case 1: {
				// [[-1,2,1],"BCE_CAS_5Line_Var"]
				[-1,2,1]
			};
			//- 9 line
			default {
				// [[1,6,8],"BCE_CAS_9Line_Var"]
				[1,6,8]
			};
		};

		private _info = switch _typeID do {
			//-IP/BP
			case 41: {
				["IP/BP",_task # 0]
			};
			//-GRID
			case 42: {
				["GRID",_task # 1]
			};
			//-FRND
			case 43: {
				["FRND",_task # 2]
			};
		};

		if ((_info # 1) < 0) exitWith {};

		//-CurSel Marker
		private _marker = allMapMarkers # (localNamespace getVariable ["cTab_BFT_CurSel",-1]);
		private _POS = markerPos _marker;

		//-GRID info
		private _mode = "BCE_" + (_info # 0);

		//-if GRID isnt "NA" and isnt setting GRID atm
		private _condition = if !("GRID" in _mode) then {
			private _TG_var = _taskVar # (_task # 1);
			private _TG_POS = _TG_var param [2,[]];

			(_TG_POS isEqualTo _POS)
		} else {
			TRACE_2("fn_userMenuSelect",_taskVar,_task);

			private _condit = -1 < ([
				_task # 0,
				_task # 2
			] findIf {
				private _var_POS = (_taskVar # _x) param [2,[]];
				(_var_POS isEqualTo _POS)
			});

			TRACE_1("fn_userMenuSelect",_condit);

			_condit
		};

		//-GRID cant be the same as the others
		if (_condition) exitWith {
			["Task_Builder",localize "STR_BCE_Error_Same_TG_FRD",3] call cTab_fnc_addNotification;
		};

		uinamespace setVariable [_mode, _POS];

		_ctrlEnter = _display displayctrl (17000 + 21051);
		[_ctrlEnter, 17000, true, _info # 1] call BCE_fnc_DataReceiveButton;

		private _list = _display displayCtrl (17000 + 12010);
		[_list, lbCurSel _list] call BCE_fnc_ctab_BFT_ToolBox;
	};

	//- overwrite "_idcToShow"
	_idcToShow = switch _typeID do {
		/*case 11: {3301};
		case 12: {3303};
		case 13: {3304};
		case 14: {
			if (cTabUserSelIcon # 1 != 0) then {
				cTabUserSelIcon set [2,0];
				3304
			} else {3307};
		};
		case 21: {3305};
		case 31: {3306};

		case 100: {3308};
		case 101: {3309};
		case 102: {3310};
		case 103: {3311};*/

		default {_typeID};
	};
};

// Hide all menu controls
{ctrlShow [_x,false]} count [3300,3301,3302,3303,3304,3305,3306,3307, 3308,3309,3310,3311 ,17000 + 3300,17000 + 33000,17000 + 3301];

//-clean variable
if ((_typeID == 0) || (_reset_Veh)) then {
	localNamespace setVariable ["cTab_BFT_CurSel",objNull];
};

// Bring the menu control we want to show into position and show it
if (_idcToShow != 0) then {
	private _control = _display displayCtrl _idcToShow;
	if !(isNull _control) then {
		private ["_controlPos","_screenPos","_screenEdgeX","_screenEdgeY","_controlEdgeX","_controlEdgeY"];
		_controlPos = ctrlPosition _control;

		// figure out screen edge positions and where the edges of the control would be if we were just to move it blindly to cTabUserPos
		_screenPos = ctrlPosition (_display displayCtrl IDC_CTAB_LOADINGTXT);
		_screenEdgeX = (_screenPos # 0) + (_screenPos # 2);
		_screenEdgeY = (_screenPos # 1) + (_screenPos # 3);
		_controlEdgeX = (cTabUserPos # 0) + (_controlPos # 2);
		_controlEdgeY = (cTabUserPos # 1) + (_controlPos # 3);

		// if control would be clipping the right edge, correct control position
		_controlPos set [0, [cTabUserPos # 0, _screenEdgeX - (_controlPos # 2)] select (_controlEdgeX > _screenEdgeX)];

		// if control would be clipping the bottom edge, correct control position
		_controlPos set [1, [cTabUserPos # 1, _screenEdgeY - (_controlPos # 3)] select (_controlEdgeY > _screenEdgeY)];

		// move to position and show
		_control ctrlSetPosition _controlPos;
		_control ctrlCommit 0;
		_control ctrlShow true;
		ctrlSetFocus _control;
	};
};

true
