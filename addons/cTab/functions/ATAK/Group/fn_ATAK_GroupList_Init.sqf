#include "script_component.hpp"

/*
  NAME : BCE_fnc_ATAK_GroupList_Init
*/
params ["_tagGroup","_MenuData"];

_MenuData params ["_title","_values"];
_values params ["_group","_teamName",["_freq",-1]];
if (_freq < 0) exitWith {};

private _tag = _tagGroup controlsGroupCtrl 15;
private _info_ls = _tagGroup controlsGroupCtrl 50;

//- Apply Infos
  _tag ctrlSetStructuredText parseText format [
    "<img size='1' image='%3'/> %1<t align='right'>%2 </t>",
    _title,
    _teamName, //- Call Sign or something you like
		QPATHTOEF(Core,data\ExpandList.paa)
  ];

  {
    (_x splitString "|") params ["_L","_R",["_pic",""]];

    private _row = _info_ls lnbAddRow [_L,""];
    _info_ls lnbSetTextRight [[_row, 0], _R];

    if (_pic != "") then {
      _info_ls lnbSetPictureRight [[_row, 0], _pic];
    };
  } forEach [
    format ["Leader : %1| ”NW” %2°", name leader _group, 160],
    format ["Freq : %1| |%2", _freq, "\cTab\img\icon_signalStrength_ca.paa"]
  ];
