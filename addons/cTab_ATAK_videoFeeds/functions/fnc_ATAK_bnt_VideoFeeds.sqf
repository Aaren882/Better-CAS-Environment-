#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_videoFeeds_fnc_ATAK_bnt_VideoFeeds
Description:
		Controls the layout and properties of the video feed buttons (bnt_back, bnt_Ent, etc.).

Parameters:
		_ctrlBnts    - An array of control groups/elements to be configured.
		_ctrlPOS     - The position parameters for the controls.
		_subMenu     - The associated sub-menu element.
		_interfaceInit - Initialization parameters for the interface (e.g., fade time).

Returns:
		<NONE>

Examples
		(begin example)
				[params] call BCE_cTab_ATAK_videoFeeds_fnc_ATAK_bnt_VideoFeeds
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_ctrlBnts","_ctrlPOS","_subMenu","_interfaceInit"];
TRACE_1("fnc_ATAK_bnt_VideoFeeds",_this);

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
  _bnt_Ent ctrlSetText localize "STR_BCE_Control_Turret";

//- Bottons Fade-out "when showing [Sub-List]"
  private _group = ctrlParentControlsGroup _bnt_Ent;
  private _commitTime = [0.3, 0] select _interfaceInit;

  if !(_line < 1) then {
    _group ctrlEnable false;
    _group ctrlSetFade 0.75;
  } else {
    _group ctrlSetFade 0;
  };
  _group ctrlCommit _commitTime;
