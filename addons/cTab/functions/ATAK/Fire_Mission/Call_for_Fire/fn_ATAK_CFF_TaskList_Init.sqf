/* 
  NAME : BCE_fnc_ATAK_CFF_TaskList_Init
  
  Init Task List tags for CFF Missions
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
  ["_MSN_State",0] //- "MSN_State"
];
_MSN_infos params [
  "_WPN_IE",
  "_WPN_IA",
  "_random_POS"
];
_WPN_IE params ["_lbAmmo_IE","_lbFuse_IE","_fireUnitSel_IE","_setCount_IE","_radius_IE","_fuzeVal_IE"];
_WPN_IA params ["_lbAmmo_IA","_lbFuse_IA",["_fireUnitSel_IA",1],"_setCount_IA","_radius_IA","_fuzeVal_IA"];

//- Mission ID setup
	_tagGroup setVariable ["CFF_Task_Mission",_MSN_name];
	
	//- Mark if it's executing mission
	if (_MSN_name call BCE_fnc_CFF_Mission_CheckActive) then {
		private _exec_bnt = _tagGroup controlsGroupCtrl 16;
		_exec_bnt ctrlSetStructuredText parseText "<img image='MG8\AVFEVFX\data\pause.paa'/>";
		_tagGroup setVariable ["CFF_Task_Mission_EXEC",true];
	};

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
    format ["AMMO (i/e) : |[ %1 ]",getText (configFile >> "CfgMagazines" >> _lbAmmo_IE >> "displayName")],
    format ["TG : %1| i/e : %2x%3", _TG_Grid, _setCount_IE,_fireUnitSel_IE],
    format [
      "From : %1 (%2)| i/a : %3x%4",
      groupId group _requester,
      name _requester,
      _setCount_IA,
      _fireUnitSel_IA
    ]
  ];
