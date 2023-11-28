params ["_display","_page",["_Back", false]];
private ["_group","_bnt"];

_group = _display displayCtrl 46600;
_bnt = _group controlsGroupCtrl 11;
_group ctrlShow _Back;

private _return = switch _page do {
  case "mission": {
    private ["_vehicle","_condition"];

    _vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
    _condition = (count (_vehicle getVariable ["BCE_Task_Receiver",[]])) > 0;

    _bnt ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select _condition);
    _bnt ctrlSetBackgroundColor ([
      [
        (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
        (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
        (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
        0.8
      ],[
        1,0,0,0.5
      ]
    ] select _condition);

    4661
  };
  case "mission_Build": {
    _display call BCE_fnc_ATAK_TaskCreate;
    _bnt ctrlSetText localize "STR_BCE_Enter";
    _bnt ctrlSetBackgroundColor [0,0,0,0.5];
    nil
  };
  default {
    4660
  };
};

//
if (isnil {_return}) exitWith {};
17000 + _return