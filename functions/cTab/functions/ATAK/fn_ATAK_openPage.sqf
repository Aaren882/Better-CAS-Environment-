params ["_display","_page",["_Back", false]];
private ["_group","_bnt_Ent"];

_group = _display displayCtrl 46600;
_bnt_Ent = _group controlsGroupCtrl 11;
_bnt_Clear = _group controlsGroupCtrl 13;
_group ctrlShow _Back;

private _return = switch _page do {
	case "mission": {
		private ["_vehicle","_condition"];

		_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
		_condition = (count (_vehicle getVariable ["BCE_Task_Receiver",[]])) > 0;


		//-Style Switching
		_bnt_Ent ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select _condition);
		_bnt_Ent ctrlSetBackgroundColor ([
			[
				(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
				(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
				(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
				0.8
			],[
				1,0,0,0.5
			]
		] select _condition);

		_bnt_Clear ctrlSetStructuredText parseText "<img image='a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa' />";
		_bnt_Clear ctrlSetBackgroundColor ((["R","G","B"] apply {1 - (profilenamespace getvariable ('GUI_BCG_RGB_' + _x))}) + [0.5]);

		4661
	};
	case "mission_Build": {
		_display call BCE_fnc_ATAK_TaskCreate;
		_bnt_Ent ctrlSetText localize "STR_BCE_Enter";
		_bnt_Ent ctrlSetBackgroundColor [0,0,0,0.5];

		_bnt_Clear ctrlSetStructuredText parseText localize "STR_BCE_ClearTaskInfo";
		_bnt_Clear ctrlSetBackgroundColor [1,0,0,0.5];

		nil
	};
	case "Task_Result": {
		4663
	};
	default {
		4660
	};
};

//
if (isnil {_return}) exitWith {};
17000 + _return