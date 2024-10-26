params [["_ctrl",controlNull],"_page","_curLine"];


private _displayName = "cTab_Android_dlg";
private _setting = [_displayName, "showMenu"] call cTab_fnc_getSettings;
_setting set [0,_page];

if !(isnil{_curLine}) then {
  _setting set [2,_curLine];
};

//- Pass POS for Animation Tramsformation
  if (!isNull _ctrl && 1 > _setting # 2) then {
    private _display = ctrlParent _ctrl;
    private _background = _display displayCtrl 4660;
    _background setVariable ["Anim_SwitchTool", true];
    // private _group = ctrlParentControlsGroup _ctrl;

    //- Get Positions
      // private _pos = ctrlPosition _group;
      // private _Sel_pos = ctrlPosition _ctrl;

    // [
    //   _ctrl, //- Selected Control
    //   [
    //     _animPayload,
    //     _Sel_pos
    //   ], // - [Start, End]
    //   ["Spring_Example",_interfaceInit, 1200] // - [Anim_Type, _instant, _BG_IDC, _ignore]
    // ] call BCE_fnc_Anim_CustomOffset;

    //- Get Open-Animation Position (Pass them to "UpdateInterface")
      /*{
        private _offset = 0.5;
        private _result = if (_forEachIndex < 2) then {
          //- Replace "X, Y" only
            (_pos # _forEachIndex) +                //- Background POS
            _x +                                    //- Selected Control's Offset
            _offset * (_Sel_pos # (2 + _forEachIndex))  //- Additional Offset (Base on Control's "W, H")
        } else {
          //- Replace "W, H" only
            _offset * _x
        };
        _pos set [_forEachIndex,_result];
      } forEach _Sel_pos;
      _background setVariable ["Anim_Payload",_pos + [1]];*/
  };

//- UpdateInterface
  [_displayName,[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;