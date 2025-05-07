params ["_control","_MenuGroup","_settings"];

//- Sending message ATAK interface only
	case "message": {
		private _recip = ["cTab_Android_dlg", "Contactor"] call cTab_fnc_getSettings;
		if (_recip == "") exitWith {
			["MSG","Invaild Recipient...",3] call cTab_fnc_addNotification;
		};

		private _typing = _MenuGroup controlsGroupCtrl 11;
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