params ["_control",["_write",true]];

_move = {
  if (ctrlText _description_show != "<") then {
    _description ctrlSetPosition
    [
      (_pos # 0) - (_pos # 2),
      (_pos # 1),
      (_pos # 2),
      (_pos # 3)
    ];
  } else {
    _description ctrlSetPosition [_pos # 0,_pos # 1,_pos # 2,0];
  };
};

_display = ctrlparent _control;
_description = _display displayCtrl 20041;
_description_show = _display displayCtrl 20042;
_pos = ["x","y","w","h"] apply {
  call compile (getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _description >> _x))
};

if (_write or (ctrlText _description_show == "<")) then {
  _description ctrlSetFade 0;
  _description_show ctrlSetText ">";

  private _text = getText(configFile >> "RscDisplayAVTerminal" >> "controls" >> ctrlClassName _control >> "BCE_Desc");
  if (_write && (_text != "")) then {
    _desc = format ["Description : <br/>%1", _text];
    _description ctrlSetStructuredText parseText _desc;
  };

  call _move;
} else {
  _description ctrlSetFade 1;
  _description_show ctrlSetText "<";

  call _move;
};

_description ctrlCommit 0.3;
