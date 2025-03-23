params [["_mode", -1]];
private ["_display","_var","_ctrlUnit","_ctrlList"];

_display = uiNamespace getVariable "BCE_Task_Receiver";

_var = switch (_mode) do {
	case 0: {
		private ["_vehicle","_type","_taskVar"];
		_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
		_type = [9, 5] # ([] call BCE_fnc_get_TaskCurType);
		_taskVar = uiNamespace getVariable format ["BCE_CAS_%1Line_Var", _type];
		(_display displayCtrl 15112) ctrlSetText localize "STR_BCE_Widgets_TIP_TASK";
		
		[format ["%1 [%2]",name _vehicle, groupId group _vehicle], _type, _taskVar]
	};
	default {
		call compile ((vehicle cameraOn) getVariable "BCE_Task_Receiver")
	};
};

_var params ["_caller_info","_type","_taskVar"];

_ctrlUnit = _display displayCtrl 101;
_ctrlList = _display displayCtrl 102;

_ctrlUnit ctrlSetText format ["%1: %2", localize (["STR_BCE_To_AC", "STR_BCE_Caller"] select (_mode < 0)), _caller_info];

//-Set LB
[_ctrlList,_type,_taskVar] call BCE_fnc_SetTaskReceiver;

//-Set UI POS
{
	_x params ["_idc",["_BG",0]];
	private _ctrl = _display displayCtrl _idc;
	private _class = configFile >> "RscTitles" >> "BCE_Task_Receiver" >> ["controls","controlsBackground"] select (_BG > 0) >> ctrlClassName _ctrl;
	private _pos = ["x","y","w","h"] apply {
		call compile getText (_class >> _x)
	};

	_ctrl ctrlSetPosition _pos;
	_ctrl ctrlCommit 0;
} forEach [
	[15110,1],
	[15111,1],
	15112,
	101,
	102
];
