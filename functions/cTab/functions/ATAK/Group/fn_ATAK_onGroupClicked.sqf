params ["_ctrl"];

private _groupSel = ctrlParentControlsGroup _ctrl;
private _ctrlIndex = _groupSel getVariable ["Index",-1];
if (_ctrlIndex < 0) exitWith {};

//- Set Variable
private _className = ctrlClassName _groupSel;
private _groupSel_IDC = ctrlIDC _groupSel;
private _checkedGroup = ["cTab_Android_dlg", "group_Info"] call cTab_fnc_getSettings;
private _findIndex = _checkedGroup find _ctrlIndex;
private _open = _findIndex < 0;

//- Toggle Box
if (_open) then {
  _checkedGroup pushBack _ctrlIndex;
} else {
  _checkedGroup deleteAt _findIndex;
};

// - set Control Height
  private _tagH = (ctrlPosition _ctrl) # 3;

  // - Check if is SYSTEM TAG
    private _height = if (_open) then {
      _tagH * ([2,3] select (_className == "ATAK_Group_Manage_Custom"));
    } else {
      _tagH
    };

private _displayGroup = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
private _list = _displayGroup controlsGroupCtrl 10;

//- Expend List Element
private _Sum_H = 0;
{
  private _grpCtrl = _list controlsGroupCtrl _x;

  [
    _grpCtrl, // - Ctrl
    [
      [],
      [
        nil,
        _Sum_H,
        nil,
        [nil, _height] select (_ctrlIndex == _forEachIndex)
      ]
    ], // - [End]
    ["ATAK_Toggle_Fast_Spring",false, 1200, [2]] // - [Anim_Type, _instant, _BG_IDC, _ignore]
  ] call BCE_fnc_Anim_CustomOffset;
  
  private _h = if (_ctrlIndex == _forEachIndex) then {
    _height;
  } else {
    // - Check if is SYSTEM TAG
    if (_forEachIndex in _checkedGroup) then {
      _tagH * ([3,2] select (_x < 100));
    } else {
      _tagH;
    };
  };
  _Sum_H = _Sum_H + _h;
} forEach (_displayGroup getVariable ["data",[]]); //- get List Group IDCs

["cTab_Android_dlg",[["group_Info",_checkedGroup]],false] call cTab_fnc_setSettings;