params ["_ctrl","_conifg"];

private _steps = getArray (_conifg >> "Animation_Steps");
_steps = _steps apply {
  _x apply {
    if (_x isEqualType "") then {
      call compile _x
    } else {
      _x
    };
  };
};
_ctrl setVariable ["Animation_Steps",_steps];