params ["_control"];
private ["_curType","_taskVar","_display","_ctrlTitle","_TaskList","_components","_isOverwrite","_DESC_Type"];

(["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings) params ["","_shown","_curLine"];

if !(_shown) exitwith {};

_curType = uiNameSpace getVariable ["BCE_Current_TaskType",0];
_taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

if (isnil {_taskVar}) exitWith {hintSilent "Error Variable is empty"};

_display = ctrlParent _control;
_ctrlTitle = tolower (ctrlText _control);

_TaskList = _display displayCtrl (17000+4661);
_components = _display displayCtrl (17000+4662);

private _bnt = (_display displayCtrl 46600) controlsGroupCtrl 11;

//-Enter Data
if (_ctrlTitle == localize "STR_BCE_Enter") exitWith {
	//-get curLine
	if (_curLine > count _taskVar) then {
		_curLine = (count _taskVar) - 1;
	};

	_isOverwrite = false;
	_DESC_Type= uiNamespace getVariable ["BCE_ATAK_Desc_Type",0];

	///-Enter Data
	_shownCtrls = [_components,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
	call ([BCE_fnc_DataReceive9line, BCE_fnc_DataReceive5line] # _curType);

	call BCE_fnc_ATAK_Refresh_TaskInfos;
};

//-Send Data
if (_ctrlTitle == localize "STR_BCE_SendData") exitWith {
	private ["_vehicle","_sel_TaskType","_NotAVT"];

	_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
	if (
		(isnull _vehicle) || 
		(count (_vehicle getVariable ["BCE_Task_Receiver",[]])) > 0
	) exitWith {
		[
			"BFT",
			localize ("STR_BCE_Error_" + (["Unavailable","Vehicle"] select (isnull _vehicle))),
			5
		] call cTab_fnc_addNotification;
	};
	_sel_TaskType = _curType;
	_NotAVT = true;
	if (call BCE_fnc_SendTaskData) then {
		_bnt ctrlSetText localize "STR_BCE_Abort_Task";
		_bnt ctrlSetBackgroundColor [1,0,0,0.5];
	};
};

//-Abort Mission
if (_ctrlTitle == localize "STR_BCE_Abort_Task") exitWith {
	private _vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
	_vehicle setVariable ["BCE_Task_Receiver", [], true];
	_vehicle setVariable ["Module_CAS_Sound",false,true];

	//-Clear Waypoints
	_grp = group _vehicle;
	for "_i" from count waypoints _grp to 0 step -1 do {
		deleteWaypoint [_grp, _i];
	};
	_grp addWaypoint [getpos _vehicle, 0];
	

	_bnt ctrlSetText localize "STR_BCE_SendData";
	_bnt ctrlSetBackgroundColor ([
		(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
		(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
		(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
		0.8
	]);
};
