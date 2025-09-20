/*
  NAME : BCE_fnc_ATAK_GroupList_SYSTEM_Init
*/
params ["_tagGroup","_MenuData"];

_MenuData params ["_title","_values"];
_values params ["_icon","_memeberCount"];

private _tag = _tagGroup controlsGroupCtrl 15;
// private _info_ls = _tagGroup controlsGroupCtrl 50;

//- Apply Infos
  _tag ctrlSetStructuredText parseText format [
    "<img size='0.8' image='\a3\ui_f\data\map\markers\military\dot_ca.paa'/><img size='0.8' align='center' image='%1'/><t align='center'> %2</t>",
    _icon,
    _title
  ];

  /* {
    (_x splitString "|") params ["_L","_R",["_pic",""]];

    private _row = _info_ls lnbAddRow [_L,""];
    _info_ls lnbSetTextRight [[_row, 0], _R];

    if (_pic != "") then {
      _info_ls lnbSetPictureRight [[_row, 0], _pic];
    };
  } forEach [
    format ["Memeber : %1", _memeberCount]
  ]; */
