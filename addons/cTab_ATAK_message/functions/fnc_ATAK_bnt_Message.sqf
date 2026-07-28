#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_message_fnc_ATAK_bnt_Message
Description:
		Initializes and configures the message button layout and appearance in the cTab interface.

Parameters:
		_ctrlBnts - Array of button controls (e.g., [back, ent, third, result]).
		_ctrlPOS - Control position structure for the buttons.
		_subMenu - Sub-menu handle (if applicable).
		_interfaceInit - Initialization parameters for the interface.

Returns:
		<NONE>

Examples
		(begin example)
				[params] call BCE_cTab_ATAK_message_fnc_ATAK_bnt_Message
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_ctrlBnts","_ctrlPOS","_subMenu","_interfaceInit"];
TRACE_1("fnc_ATAK_bnt_Message",_this);

_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

//- Arrange Bottons layout
  {
    _x ctrlShow false;
    false
  } count (_ctrlBnts select [2]);

  private _size = (2 * (_ctrlPOS # 2));

  _bnt_back ctrlSetPositionW _size;
  
  _bnt_Ent ctrlSetPositionX _size;
  _bnt_Ent ctrlSetPositionW _size;

  _bnt_back ctrlCommit 0;
  _bnt_Ent ctrlCommit 0;

//- Set Color
  _bnt_Ent ctrlSetBackgroundColor [
    (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
    (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
    (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
    0.8
  ];

//- Botton Text
  _bnt_Ent ctrlSetText localize "STR_BCE_SendData";

private _group = ctrlParentControlsGroup _bnt_Ent;
private _commitTime = [0.3, 0] select _interfaceInit;

//- Bottons Fade-out "when showing [Sub-List]"
  if !(_line < 1) then {
    _group ctrlEnable false;
    _group ctrlSetFade 0.75;
  } else {
    _group ctrlSetFade 0;
  };
  _group ctrlCommit _commitTime;
