#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_Marker_fnc_Add_to_MarkerList
Description:
		Add Marker to cTab UserMarker List for rendering or extra process.

Parameters:
		_position  - Parameter description <2D Vector>
		_Marker_Cate  - Marker Category <INT NUMBER>
		_Marker_Type  - Parameter description <INT NUMBER - INDEX of Marker DropBox>
		_id  - Marker ID that's going to be registered <OBJECT>
		_colorSel  - Parameter description <OBJECT>

Returns:
		<NONE>

Examples
		(begin example)
				[params] call BCE_cTab_Marker_fnc_Add_to_MarkerList
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_position","_Marker_Cate","_Marker_Type","_id","_colorSel"];
TRACE_1("fnc_Add_to_MarkerList",_this);

private _SelIcon = [
  _position,
  _Marker_Cate,_id,_colorSel,
  call cTab_fnc_currentTime,
  cTab_player
];

[call cTab_fnc_getPlayerEncryptionKey,_SelIcon] call cTab_fnc_addUserMarker;
