/*
  NAME : BCE_fnc_Add_CountDown

  Params :
    [
      _TimerName : Name of the timer
      _InputTime : <ARRAY/STRING>
          <ARRAY>  - [HH,MM,SS,...]
          <STRING> - Clock Time in 24hr "1330"
      _callBack  : when time is up this Function will be called (not Suspendible)
      _baseTime  : Timer will base on this
    ]

  Return : 
    Nil
*/
params ["_TimerName","_InputTime",["_callBack",""],["_baseTime",dayTime]];

private _map = localNamespace getVariable ["#BCE_COUNTDOWN_HashMap",createHashMap];
private _currentTime =+ _baseTime;

private _time = switch (typeName _InputTime) do {
  case "STRING": {
    private __time = [];
    for "_i" from 0 to 2 do {
      __time set [_i, parseNumber (_InputTime select [2 * _i, 2])];
    };
    
    __time
  };
  default {
    _InputTime
  };
};

//- Set up-time
{
  _currentTime = _currentTime + (_x/ 60^_forEachIndex);
} forEach _time;

_map set [_TimerName, [_currentTime, _callBack] joinString "|"];
localNamespace setVariable ["#BCE_COUNTDOWN_HashMap",_map];

//- Check Variable exist
if (count _map > 1) exitWith {};

[
  {
    private _map = localNamespace getVariable ["#BCE_COUNTDOWN_HashMap",createHashMap];

    //- Check Any Timer Exist
      if (count _map == 0) then {
        [_this # 1] call CBA_fnc_removePerFrameHandler;
      };

    {
      (_y splitString "|") params ["_dateStr","_callBack"];

      private _time = dayTime - parseNumber _dateStr;
      if (_time >= 0) then {
        
        //- Fire Event
          [_x, parseNumber _dateStr] call {
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
