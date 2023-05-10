params ["_squad_list", "_lbCurSel"];

_display = ctrlParent _squad_list;
_squad_title = _display displayctrl 20114;
_squad_pic = _display displayctrl 20115;

(call compile (_squad_list lbData _lbCurSel)) params ["_picture","_unit","_title","_turret_info"];

//-Select Turret
_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
if !(isNil{_turret_info}) then {
  player setVariable ["TGP_View_Selected_Optic",[_turret_info,_vehicle],true];
  #if __has_include("\cTab\config.bin")
    if (!(cTabIfOpenStart) && ((cTab_player getVariable ["cTab_TGP_View_EH",-1]) != -1)) then {
      [[["uavCam",str _vehicle]]] call cTab_fnc_updateInterface;
    };
  #endif
};

_squad_pic ctrlSetText _picture;
_squad_pic ctrlSetTooltip _title;
_squad_title ctrlSetStructuredText parseText format ["[%1]",_unit];
