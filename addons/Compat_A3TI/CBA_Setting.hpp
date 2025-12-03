///////////////////TGP//////////////////////
//- A3 Thermal Improvement
[
	"BCE_AUTO_LTM_A3TI_fn","CHECKBOX",
	[localize "STR_BCE_A3TI_AUTO_LTM", localize "STR_BCE_A3TI_AUTO_LTM_tip"],
	["Better CAS Environment", localize "STR_BCE_Title_AV_Cam_Settings"],
	false,
	0,
	{
		if (_this) then {
			private _id1 = ["BCE_AVLaser_ON", {
				// params ["_unit"];
				[true] call A3TI_fnc_toggleLTM;
			}] call CBA_fnc_addEventHandler;

			private _id2 = ["BCE_AVLaser_OFF", {
				[false] call A3TI_fnc_toggleLTM;
			}] call CBA_fnc_addEventHandler;

			localNamespace setVariable ["BCE_A3Ti_EH",[_id1,_id2]];
		} else {
			private _ids = localNamespace getVariable "BCE_A3Ti_EH";
			if (isnil{_ids}) exitWith {};
			
			["BCE_AVLaser_ON",_ids # 0] call CBA_fnc_removeEventHandler;
			["BCE_AVLaser_OFF",_ids # 1] call CBA_fnc_removeEventHandler;
			localNamespace setVariable ["BCE_A3Ti_EH",nil];
		};
	}
] call CBA_fnc_addSetting;