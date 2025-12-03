#include "script_component.hpp"

/*
	NAME : BCE_fnc_ATAK_FireAdjust_Init_Impact
*/
params ["_AdjustGrp","_config"];

private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5003;
private _OT_Display = _AdjustGrp controlsGroupCtrl 5002;
//- Refresh UI Values
	_AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values

//- Update OT info
	_OT_Display spawn {
		private _OT_Display = _this;
		
		while {!isNull _OT_Display} do {
			//- Get mission infos
				private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
				private _curMSN = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
				_curMSN params [["_taskData",""]];

				private _taskValues = _taskData call BCE_fnc_CFF_Mission_Get_Values;
				_taskValues params [
					"",
					"_TG_Grid"
				];

			//- Use 2D ,so it doesn't too accurate
				private _FO = call CBA_fnc_currentUnit;
				private _dist = ((_TG_Grid call BCE_fnc_Grid2POS) distance2D _FO) / 1000; 

			//- Apply Text
				_OT_Display ctrlSetStructuredText parseText format [
					"%1 OT : %2",
					QSTRUCTURE_IMAGE(Core,data\binoculars.paa),
					[round _dist, floor (_dist * 10) / 10] select (_dist < 1)
				];
			sleep 0.5;
		};
	};

