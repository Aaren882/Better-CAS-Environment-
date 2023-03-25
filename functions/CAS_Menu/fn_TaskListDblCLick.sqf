params ["_control", "_curLine"];

_display = ctrlParent _control;
_title = _display displayctrl 2003;
_Task_Type = _display displayCtrl 2107;
_sel_TaskType = _Task_Type lbValue (lbCurSel _Task_Type);
_list_result = switch _sel_TaskType do {
  //-5 line
  case 1: {
    _TaskList = _display displayCtrl 2005;
    _taskVar = uiNamespace getVariable ["BCE_CAS_5Line_Var", [["NA",0],["NA","",[],[0,0],""],["NA","111222"],["NA","--",""],["NA",[]]]];
    [_TaskList,_taskVar]
  };
  //-9 line
  default {
    _TaskList = _display displayCtrl 2002;
    _taskVar = uiNamespace getVariable ["BCE_CAS_9Line_Var", [["NA",0],["NA","",[],[0,0]],["NA",180],["NA",200],["NA",15],["NA","desc"],["NA","",[],[0,0],[]],["NA","1111"],["NA","",[],[0,0],""],["NA",0,[],nil,nil],["NA",-1,[]]]];
    [_TaskList,_taskVar]
  };
};
_list_result params ["_TaskList","_taskVar"];

_Expression_class = "true" configClasses (configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _TaskList >>"items");

//-Description
_desc_show = _display displayctrl 20042;
_extend_desc = (_Expression_class apply {getNumber(_x >> "multi_options") == 1}) # _curLine;
_desc_show ctrlshow _extend_desc;

_description = [
  _display displayctrl 2004,
  _display displayctrl 20041
] select _extend_desc;

//-Extended Description
if (_extend_desc) then {
  private ["_vehicle","_squad_param","_unit_info","_squad_title","_squad_pic","_squad_list","_Button_Racks","_text","_turret_optics","_current_optic","_turret_count","_turrets"];
  _vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];

  //-Display info
  _squad_title = _display displayctrl 20114;
  _squad_pic = _display displayctrl 20115;
  _squad_list = _display displayctrl 20116;
  _squad_list ctrlSetPositionH call compile (getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _squad_list >> "H"));
  _squad_list ctrlCommit 0;

  lbClear _squad_list;

  //-Check turrets
  _turret_optics = _vehicle getVariable "TGP_View_Available_Optics";
  _current_optic = _turret_optics find ((player getVariable "TGP_View_Selected_Optic") # 0);
  _turrets = _turret_optics apply {((_x # 1) # 0) + 1};
  _turret_count = [_turrets # 0,0] select (-1 in _turrets);

  #if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
    _Button_Racks = _display displayctrl 201141;
    _List_Racks = _display displayctrl 201142;
  #else
    _Button_Racks = controlNull;
    _List_Racks = controlNull;
  #endif
  {_x ctrlshow true} forEach [_squad_title,_squad_pic,_squad_list,_Button_Racks,_List_Racks];
  //-get crew Info
  {
    private ["_unit_x","_seat","_turret_c","_name","_freq","_radioInfo","_add","_squad_param","_squad_param0","_unit_info","_title"];
    _unit_x = _x;
    _turret_c = _vehicle unitTurret _unit_x;
    _seat = getText ([_vehicle, _turret_c] call BIS_fnc_turretConfig >> "gunnerName");
    _name = ((name _unit_x) splitString " ") # 0;
    _add = _squad_list lbAdd format ["%1 - %2",[_seat,localize "STR_DRIVER"] select (_seat == ""),_name];

    private ["_LOD","_turret","_is_Detached","_turret_info"];

    _turret_info = if (_turret_count == _forEachIndex) then {
      _turret_count = _turret_count + 1;
      (_turret_optics # ((_forEachIndex-1) max 0))
    } else {
      nil
    };

    _squad_param = squadParams _unit_x;

    //-UNIT info
    _unit_info = if (_squad_param isNotEqualTo []) then {
      (_squad_param # 0) params ["", "_title", "", "", ["_picture",""], ["_unit",""]];
      //(_squad_param # 1) params ["", "", "", "", "", ""];
      [_picture,_unit,_title,_turret_info]
    } else {
      private["_faction","_config","_picture"];
      _faction = getText (configof _unit_x >> "faction");
      _config = configFile >> "CfgFactionClasses" >> _faction;

      _picture = getText(_config >> "icon");
      _unit = getText(_config >> "displayName");
      [_picture,_unit,_unit,_turret_info]
    };

    #if __has_include("\z\tfar\addons\core\script_component.hpp")
      _freq = _unit_x call BCE_fnc_getFreq_TFAR;
      _squad_list lbSetTextRight [_add, "LR-" + ([_freq,"“NA”"] select (isnil {_freq}))];
    #else
      _squad_list lbSetTextRight [_add, _unit_info # 1];
    #endif
    _squad_list lbSetData [_add, str _unit_info];

  } forEach flatten ((crew _vehicle) select {(_vehicle unitTurret _x) in ([[-1]] + allTurrets _vehicle)});

  _squad_list lbSetCurSel ([(_current_optic + 1) min (count _turrets),_current_optic] select (-1 in _turrets));

  //-position Extended Description
  if ((ctrlText _desc_show) == "<") then {
    _description ctrlSetPositionH 0;
    _description ctrlCommit 0;
  };
};

_sendData = _display displayCtrl 2105;
_clearbut = _display displayCtrl 2106;
_TaskList ctrlshow false;
_checklist = _display displayCtrl 2100;

//-Write down description
_desc = format ["Description : <br/>%1", _TaskList lbData _curLine];
_description ctrlSetStructuredText parseText _desc;
_sendData ctrlSetText "Enter";

_descriptionPOS = ctrlPosition _description;
_TaskListPOS = ctrlPosition _TaskList;
_titlePOS = ctrlPosition _title;

_title ctrlSetText (_control lbtext _curLine);

//-check current Control
_Expression_Ctrls = (_Expression_class apply {
    getArray (_x >> "Expression_idc")
  }) apply {
  [
    _x apply {_display displayctrl _x},[]
  ] select (_x isEqualTo []);
};

_shownCtrls = _Expression_Ctrls # _curLine;

//-Show Needed Controls
{_x ctrlshow true} forEach ([_title,_description] + _shownCtrls);

switch _sel_TaskType do {
  //-5 line
  case 1: {
    call BCE_fnc_DblClick5line;
  };
  //-9 line
  default {
    call BCE_fnc_DblClick9line;
  };
};
_description ctrlCommit 0;
