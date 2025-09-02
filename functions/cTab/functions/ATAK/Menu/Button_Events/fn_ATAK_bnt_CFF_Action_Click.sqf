params ["_control","_MenuGroup","_settings"];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
if (isnull _taskUnit) exitWith {};

//- Execute Fire mission
//- #LINK - functions/CAS_Menu/Call_for_Fire/fn_CFF_Mission_XMIT.sqf

//- Get current CFF mission infos
  private _curMSN = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
  _curMSN params [["_taskData",""]];

//- #NOTE - Exit if there's no "_taskData"
if (_taskData == "") exitWith {};

//- Check mission is active
	private _sentData = if (_taskData call BCE_fnc_CFF_Mission_CheckActive) then {
		_control ctrlSetText localize "STR_BCE_SendData";
		_control ctrlSetBackgroundColor ([
			(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
			(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
			(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
			0.8
		]);

		//- STOP CFF Mission
		[_taskData] call BCE_fnc_CFF_Mission_STOP;
		[formationLeader _taskUnit, localize "STR_BCE_CFF_MSG_CHECK_FIRE", "CFF_CHECK_FIRE"] call BCE_fnc_Send_Task_RadioMsg;
		
		nil
	} else {
		_control ctrlSetText localize "STR_BCE_Abort_Task";
		_control ctrlSetBackgroundColor [1,0,0,0.5];

		_taskData
	};

if (isNil "_sentData") exitWith {};

//- Send Data
  [
    _taskUnit,
    nil,
    _sentData
  ] call BCE_fnc_SendTaskData;