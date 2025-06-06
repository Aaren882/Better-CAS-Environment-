/*
  NAME : BCE_fnc_Add_CountDown

  Params :
    [
      _TimerName : Name of the timer
      _InputTime : <NUM/STRING>
          <NUM>    - in Minutes
          <STRING> - Clock Time in 24hr "1330"
      _callBack  : when time is up this Function will be called (not Suspendible)
    ]

  Return : 
    Nil
*/
params ["_TimerName","_InputTime",["_callBack",""]];

private _map = localNamespace getVariable ["#BCE_COUNTDOWN_HashMap",createHashMap];
private _currentDate = date;

private _time = switch (typeName _InputTime) do {
  case "STRING": {
    private _date =+ _currentDate;
    {
      //- minus 1 minute to make sure it timer can be trigger on time
      _date set [3 + _forEachIndex, (parseNumber (_InputTime select _x)) - _forEachIndex];
    } forEach [
      [0,2],
      [2,2]
    ];

    _date
  };
  default {
    [_currentDate, _InputTime - 1, "m"] call BIS_fnc_calculateDateTime;
  };
};

_map set [_TimerName, [dateToNumber _time, _callBack] joinString "|"];
localNamespace setVariable ["#BCE_COUNTDOWN_HashMap",_map];

//- Check Variable exist
if (count _map > 1) exitWith {};

[
  {
    params ["","_handlerID"];
    private _map = localNamespace getVariable ["#BCE_COUNTDOWN_HashMap",createHashMap];

    //- Check Any Timer Exist
      if (count _map == 0) then {
        [_handlerID] call CBA_fnc_removePerFrameHandler;
      };

    {
      (_y splitString "|") params ["_dateStr","_callBack"];

      if ((dateToNumber date - parseNumber _dateStr) > 0) then {

        //- Fire Event
          [_x] call {
            privateAll;
            import ["_callBack"];
            _this call (compile _callBack);
          };

        //- Remove Counter
          _map deleteAt _x;
          localNamespace setVariable ["#BCE_COUNTDOWN_HashMap", _map];
      };
    } forEach _map;
  }, 1, []
] call CBA_fnc_addPerFrameHandler;

nil