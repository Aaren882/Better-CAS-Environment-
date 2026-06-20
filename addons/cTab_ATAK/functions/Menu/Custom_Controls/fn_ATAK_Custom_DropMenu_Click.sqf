/*
  NAME : BCE_fnc_ATAK_Custom_DropMenu_Click

  on Drop Menu Clicked
*/
params ["_ctrl"];

private _displayName = cTabIfOpen param [1,""];
if (_displayName == "") exitWith {
  ["""_displayName"" isn't exist (cTab/BCE Custom UI Control)"] call BIS_fnc_error;
};

private _groupSel = ctrlParentControlsGroup _ctrl;
private _ctrlIndex = _groupSel getVariable ["Index",""];

if (_ctrlIndex isEqualTo "") exitWith {
  ["""_ctrlIndex"" isn't exist (cTab/BCE Custom UI Control)"] call BIS_fnc_error;
};

//- Get Settings
  private _listGroup = ctrlParentControlsGroup _groupSel;
  private _Variable_Name = _listGroup getVariable ["Variable_Name",""];
  private _MaxOpened = _listGroup getVariable ["MaxOpened",-1];

//- Set Variable
private _className = ctrlClassName _groupSel;
private _groupSel_IDC = ctrlIDC _groupSel;
private _cTab_Setting = [_displayName, "Custom_DropMenu"] call cTab_fnc_getSettings;
private _checkedGroup = _cTab_Setting getOrDefault [_Variable_Name,[]];
private _findIndex = _checkedGroup find _ctrlIndex;
private _open = _findIndex < 0;

//- Toggle Box
  if (_open) then {
    _checkedGroup pushBack _ctrlIndex;
  } else {
    _checkedGroup deleteAt _findIndex;
  };

  if (
    _MaxOpened > 0 && //- Must be greater than 0
    _MaxOpened < count _checkedGroup
  ) then {
    _checkedGroup deleteAt 0;
  };

//- Get Control Height
  private _tagH = (ctrlPosition _ctrl) # 3;

//- Expend List Element
private _Sum_H = 0;
{
  private _grpCtrl = _listGroup controlsGroupCtrl _x;
  private _Index = _grpCtrl getVariable ["Index",""];

  // - Move Other tagGroups
  private _h = if (_Index in _checkedGroup) then {
    _tagH * (_grpCtrl getVariable ["Expand_Height",1])
  } else {
    _tagH
  };

  [
    _grpCtrl, // - Ctrl
    [
      [],
      [
        nil,
        _Sum_H,
        nil,
        _h
      ]
    ], // - [End]
    ["ATAK_Toggle_Fast_Spring",false, 1200, [2]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
  ] call BCE_fnc_Anim_CustomOffset;

  _Sum_H = _Sum_H + _h;
} forEach (_listGroup getVariable ["data",[]]); //- get List Group IDCs

//- Save cTab Variable
  _cTab_Setting set [_Variable_Name,_checkedGroup];
  [_displayName,[["Custom_DropMenu",_cTab_Setting]],false] call cTab_fnc_setSettings;

//- Get Custom Event #NOTE - "onTagClick"
  private _fnc = uiNamespace getVariable [
    _listGroup getVariable ["onTagClick",""],
    {}
  ];

//- Fire up Event
  privateAll;
  import ["_ctrl", "_fnc"];
  _ctrl call _fnc;
