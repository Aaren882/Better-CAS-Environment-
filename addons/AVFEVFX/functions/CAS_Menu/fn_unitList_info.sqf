#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
params ["_squad_list", "_lbCurSel"];

private ["_Selected","_curSel"];

_Selected = (player getVariable ["TGP_View_Selected_Optic",[[],objNull]]) # 0;
(call compile (_squad_list lbData _lbCurSel)) params ["_picture","_unit","_title","_turret_info"];

_display = ctrlParent _squad_list;
_squad_title = _display displayctrl 20114;
_squad_pic = _display displayctrl 20115;

_squad_title ctrlSetStructuredText parseText format ["[%1]",_unit];

if !(isnull _squad_pic) then {
  _squad_pic ctrlSetText _picture;
  _squad_pic ctrlSetTooltip _title;
};

//-Exit if it's still the Same
_curSel = for "_i" from 0 to (lbSize _squad_list) step 1 do {
  private _content = (call compile (_squad_list lbData _i)) # 3;
  if (_Selected isEqualTo _content) then {
    breakWith _i;
  };
};
if (_curSel == _lbCurSel) exitWith {};

//-Select Turret
_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
if !(isNil{_turret_info}) then {
  player setVariable ["TGP_View_Selected_Optic",[_turret_info,_vehicle],true];
  #ifdef cTAB_Installed
    if (!(cTabIfOpenStart) && (cTabActUav != cTab_player)) then {
      [[["uavCam",str _vehicle]]] call cTab_fnc_updateInterface;
    };
  #endif
};
