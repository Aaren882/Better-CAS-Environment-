/* 
  NAME : BCE_fnc_ATAK_CFF_TaskList_Init
  
  Fire up after created
*/
params ["_tagGroup","_MenuData"];

private _tag = _tagGroup controlsGroupCtrl 15;
private _info_ls = _tagGroup controlsGroupCtrl 50;

_MenuData params ["_MSN_name","_values"];
_values params [
  "_MSN_Type",
  "_TG_Grid",
  "_requester",
  "_MSN_infos",
  ["_MSN_State",false] //- "MSN_State"
];
_MSN_infos params [
  "_WPN_IE",
  "_WPN_IA",
  "_random_POS"
];
_WPN_IE params ["","_lbFuse_IE","","_setCount_IE","",""];
_WPN_IA params ["","_lbFuse_IA","","_setCount_IA","",""];

_tagGroup setVariable ["CFF_Task_Mission",_MSN_name];

//- Apply Infos
  _tag ctrlSetStructuredText parseText format [
    "%1. %2<t align='right'>%3 </t>",
    _forEachIndex + 1,
    _MSN_name,
    _MSN_Type
  ];

  {
    (_x splitString "|") params ["_L","_R",["_pic",""]];

    private _row = _info_ls lnbAddRow [_L,""];
    _info_ls lnbSetTextRight [[_row, 0], _R];

    if (_pic != "") then {
      _info_ls lnbSetPictureRight [[_row, 0], _pic];
    };
  } forEach [
    format ["TG : %1| i/e : %2", _TG_Grid, _setCount_IE],
    format ["From : %1(%2)| i/a : %3", groupId group _requester, name _requester, ["--", str _setCount_IA] select (_setCount_IA > 0)]
  ];