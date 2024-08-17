params ["_ListCtrl",["_mode",0]];

if (isnull _ListCtrl) then {continue};

lbClear _ListCtrl;
private _displayName = cTabIfOpen # 1;
private _default = _ListCtrl lbAdd "--";
_ListCtrl lbSetData [_default,str objNull];

switch _mode do {
  // Populate list of UAVs
  case 0: {
    private _data = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];

    cTabUAVlist apply {
      if ((crew _x) findIf {true} > -1) then {
        private _index = _ListCtrl lbAdd format ["[%1] %2", name (driver _x), getText (configOf _x >> "displayname")];
        _ListCtrl lbSetData [_index,str _x];
      };
    };

    if !(isnull _data) then {
      // Find last selected UAV and # if found
      for "_i" from 0 to (lbSize _ListCtrl - 1) do {
        if (str _data == (_ListCtrl lbData _i)) exitWith {
          _ListCtrl lbSetCurSel _i;
        };
      };
      // If no UAV could be selected, clear last selected UAV
      if (lbCurSel _ListCtrl == 0) then {
        [_displayName,[["uavCam",""]]] call cTab_fnc_setSettings;
        cTab_player setVariable ["TGP_View_Selected_Vehicle",objNull];
        _ListCtrl lbSetCurSel 0;
      };
    } else {
      _ListCtrl lbSetCurSel 0;
    };
  };

  // Populate list of Helmet CAMs
  case 1: {
    private _data = [_displayName,"hCam"] call cTab_fnc_getSettings;
    
    cTabHcamlist apply {
      private _index = _ListCtrl lbAdd format ["%1:%2 (%3)",groupId group _x,[_x] call CBA_fnc_getGroupIndex,name _x];
      _ListCtrl lbSetData [_index,str _x];
    };
    lbSort [_ListCtrl, "ASC"];

    if (_data != "") then {
      // Find last selected hCam and # if found
      for "_x" from 0 to (lbSize _ListCtrl - 1) do {
        if (_data == _ListCtrl lbData _x) exitWith {
          _ListCtrl lbSetCurSel _x;
        };
      };

      // If no hCam could be selected, clear last selected hCam
      if (lbCurSel _ListCtrl == 0) then {
        [_displayName,[["hCam",""]]] call cTab_fnc_setSettings;
      };
    };
  };
};
