#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_message_fnc_ATAK_bnt_MessageSend_Click
Description:
		Sends a message notification through the ATAK interface.
		It validates recipients, constructs the message title (including time, group, and player name), and sends the message body to all specified recipients.

Parameters:
		_control  - The control group object (unused in current implementation).
		_MenuGroup - The menu group container object.
		_settings - The settings object retrieved from the dialog.

Returns:
		None.
		
Examples:
		(begin example)
				[params] call BCE_cTab_ATAK_message_fnc_ATAK_bnt_MessageSend_Click
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_control","_MenuGroup","_settings"];
TRACE_1("fnc_ATAK_bnt_MessageSend_Click",_this);

//- Sending message ATAK interface only
	private _recip = ["cTab_Android_dlg", "recipient"] call cTab_fnc_getSettings;
	if (_recip == "") exitWith {
		["MSG","Invalid Recipient...",3] call cTab_fnc_addNotification;
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
