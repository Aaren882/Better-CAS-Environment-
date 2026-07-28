#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_message_fnc_ATAK_msg_Line_Create
Description:
		Creates and displays a structured text message line (ATAK Message Line) on the display.

Parameters:
		_list  - The group control of the message line.
		_type  - The type of message line (e.g., 2 for Send, 4 for Time).
		_txt   - The text content to display in the message line.

Returns:
		Return description <NONE>

Examples
		(begin example)
				[params] call BCE_cTab_ATAK_message_fnc_ATAK_msg_Line_Create
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */
params ["_list","_type","_txt"];

TRACE_1("fnc_ATAK_msg_Line_Create",_this);

private _ctrlMsg = _display ctrlCreate [
  [configFile >> "RscTitles" >>"ATAK_Message_Line", configFile >> "ATAK_Message_Line"] select _isDialog,
  -1,
  _list
];
private _txt = parseText _txt;

switch (_type) do {
  //- Send
  case 2: {
    _txt setAttributes ["align","right"];
    _txt = composeText [_txt];
  };
  //- Time
  case 4: {
    _txt setAttributes ["align","center","size","0.8"];
    _txt = composeText [_txt];
  };
};

_ctrlMsg ctrlSetStructuredText _txt;
_ctrlMsg ctrlSetBackgroundColor ([
  [0,0,1,0.1],
  [0,0,1,0.1],
  [0,1,0,0.05],
  [0,0,0,0]
] # _type);

_ctrlMsg ctrlSetPositionH ctrlTextHeight _ctrlMsg;

_ctrlMsg
