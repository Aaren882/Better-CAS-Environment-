params ["_ctrl",["_POS",[]],["_update_Components",[]]];

if (
  2 != count _POS
) exitwith {
  ["Invalid Input of ""_POS = %1"" for fnc_Anim_CustomOffset",_POS] call BIS_fnc_error;
};

_POS params [["_POS_Start",[]],["_POS_End",[]]];

// -Update In when Custom Offsets are changed
if (_update_Components findIf {true} < 0) exitWith {};
_update_Components params [["_type",""],"_instant",["_BG_IDC",0],["_ignore",[]]];

private _queue = (_ctrl getVariable ["Animation_Queue",[]]) select {!isnull _x};

//- Check Queue (If Not Empty)
private _result = if (_queue findIf {true} > -1) then {
  //- If not Empty
  private _endFlag = _ctrl getVariable ["Animation_EndWithOffset_F", []];
  {
    if !(isNil {_x}) then {
      _endFlag set [_forEachIndex, _x];
    };
  } foreach _POS_End;
  _ctrl setVariable ["Animation_EndWithOffset_F", _endFlag];

  _endFlag
} else {
  //- On Empty
  private _endFlag = ctrlPosition _ctrl;
  {
    if !(isNil {_x}) then {
      _endFlag set [_forEachIndex, _x];
    };
  } foreach _POS_End;

  _endFlag
};

//- Update Interface
[
  _ctrl,
  _type,
  [_POS_Start,_result,_instant,_BG_IDC],
  _ignore
] call BCE_fnc_Anim_Type;