#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_taskViewer_fnc_ATAK_Tag_Init
Description:
		Initializes the display of data tags within the cTab_ATAK_taskViewer.

Parameters:
		_tagGroup  - The controls group object containing the tags/info list.
		_MenuData  - A structure containing menu data, including title, values, and frequency.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_tagGroup","_MenuData"];
TRACE_1("fnc_ATAK_Tag_Init",_this);

_MenuData params ["_title","_values"];
_values params [["_description",""], ["_mediaData",createHashMap]];

private _mediaBnt = _tagGroup controlsGroupCtrl 17;

//- Save Media into tag controlGroup
if (count _mediaData isNotEqualTo 0) then {
	_tagGroup setVariable ["Media", _mediaData];
} else {
	_mediaBnt ctrlEnable false; //- Disable button if non-media 
};

private _tag = _tagGroup controlsGroupCtrl 15;
private _descGrp = _tagGroup controlsGroupCtrl 100;
private _desc = _descGrp controlsGroupCtrl 1;

TRACE_4("fnc_ATAK_Tag_Init [Controls]",_tag,_mediaBnt,_descGrp,_desc);

//- Apply Infos
  _tag ctrlSetStructuredText parseText format [
    "<img size='1' image='%2'/> %1",
    _title,
		QPATHTOEF(Core,data\ExpandList.paa)
  ];

  _desc ctrlSetStructuredText parseText _description;
	_desc ctrlSetPositionH ctrlTextHeight _desc;
	_desc ctrlCommit 0;
