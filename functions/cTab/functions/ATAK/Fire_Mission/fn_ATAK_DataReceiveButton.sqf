params ["_control"];
private ["_settings","_curType","_taskVar","_display","_ctrlTitle","_TaskList","_components","_isOverwrite","_DESC_Type"];

_settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
_settings params ["_page","_shown","_subInfos"];
_subInfos params ["_subMenu","_curLine"];

if !(_shown) exitwith {};

_display = ctrlParent _control;
_ctrlTitle = ctrlText _control;

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _bnt = (_display displayCtrl 46600) controlsGroupCtrl 11;

switch (_page) do {
	//- Sending message ATAK interface only
	case "message": {
		private _recip = ["cTab_Android_dlg", "Contactor"] call cTab_fnc_getSettings;
		if (_recip == "") exitWith {
			["MSG","Invaild Recipient...",3] call cTab_fnc_addNotification;
		};

		private _typing = _group controlsGroupCtrl 11;
		private _msgBody = ctrlText _typing;

		if (_msgBody == "") exitWith {};

		private _playerEncryptionKey = call cTab_fnc_getPlayerEncryptionKey;
		private _time = call cTab_fnc_currentTime;
		private _msgTitle = format ["%1 - %2:%3 (%4)",_time,groupId group player,[player] call CBA_fnc_getGroupIndex,name player];
		private _recipientNames = "";
		{
			if (_recip == str _x) exitWith {
				_recipientNames = format ["%1:%2 (%3)",groupId group _x,[_x] call CBA_fnc_getGroupIndex,name _x];
				["cTab_msg_receive",[_x,_msgTitle,_msgBody,_playerEncryptionKey,player]] call CBA_fnc_whereLocalEvent;
			};
			nil
		} count ([player] + playableUnits);

		private _msgArray = player getVariable ["cTab_messages_" + _playerEncryptionKey,[]];
		_msgArray pushBack [[_time,_recipientNames] joinString " - ", _msgBody,2];
		player setVariable ["cTab_messages_" + _playerEncryptionKey,_msgArray];

		["cTab_Android_dlg", [["showMenu",_settings]],true,true] call cTab_fnc_setSettings;
		_typing ctrlSetText "";
		
		["ctab_messagesUpdated"] call CBA_fnc_localEvent;
	};
	//- Mission Builders
	case "mission": {
		call {

			//- Task elements
			private _curType = ["Type",0] call BCE_fnc_get_TaskCurSetup;
			private _taskVar = uiNameSpace getVariable (["BCE_CAS_9Line_Var","BCE_CAS_5Line_Var"] # _curType);

			//- Enter Infos (on Building Page)
				if (_subMenu == "Task_Building") exitWith {
					if (isnil {_taskVar}) exitWith {["Error Variable is empty"] call BIS_fnc_error};
					
					//-get curLine
					if (_curLine > count _taskVar) then {
						_curLine = (count _taskVar) - 1;
					};

					private _isOverwrite = false;
					private _DESC_Type= localNamespace getVariable ["BCE_ATAK_Desc_Type",0];

					///-Enter Data
					private _shownCtrls = [_group,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
					private _fnc = ["BCE_fnc_DataReceive9line", "BCE_fnc_DataReceive5line"] # _curType;
					
					call (uiNamespace getVariable _fnc);
					call BCE_fnc_ATAK_Refresh_TaskInfos;
				};
			
			///- Other Conditions
			private _vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
			//- Abort Mission
				if (_ctrlTitle == localize "STR_BCE_Abort_Task") exitWith {
					_vehicle setVariable ["BCE_Task_Receiver","", true];
					_vehicle setVariable ["Module_CAS_Sound",false,true];

					//-Clear Waypoints
					private _grp = group _vehicle;
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
			
			//- Send Data
				//- Check Vehicle Availability
					if (
						(isnull _vehicle) || 
						((_vehicle getVariable ["BCE_Task_Receiver",""])) != ""
					) exitWith {
						[
							"BFT",
							localize ("STR_BCE_Error_" + (["Unavailable","Vehicle"] select (isnull _vehicle))),
							5
						] call cTab_fnc_addNotification;
					};
				private _sel_TaskType = _curType;
				private _NotAVT = true;
				if (call BCE_fnc_SendTaskData) then {
					_bnt ctrlSetText localize "STR_BCE_Abort_Task";
					_bnt ctrlSetBackgroundColor [1,0,0,0.5];
				};
		};
	};
	case "VideoFeeds": {
		0 call cTab_Tablet_btnACT;
	};
};
	
/* switch (_ctrlTitle) do {
	case localize "STR_BCE_Control_Turret": {
		0 call cTab_Tablet_btnACT;
	};
	//-Enter Data
		case localize "STR_BCE_Enter": {
			//-get curLine
			if (_curLine > count _taskVar) then {
				_curLine = (count _taskVar) - 1;
			};

			_isOverwrite = false;
			_DESC_Type= localNamespace getVariable ["BCE_ATAK_Desc_Type",0];

			///-Enter Data
			_shownCtrls = [_group,_curLine,1,false,true] call BCE_fnc_Show_CurTaskCtrls;
			call BCE_fnc_ATAK_Refresh_TaskInfos;
		};
	//-Send Data
		case localize "STR_BCE_SendData": {
			private ["_vehicle","_sel_TaskType","_NotAVT"];
			_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
			if (
				(isnull _vehicle) || 
				((_vehicle getVariable ["BCE_Task_Receiver",""])) != ""
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
		case localize "STR_BCE_Abort_Task": {
			private _vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
			_vehicle setVariable ["BCE_Task_Receiver","", true];
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
}; */