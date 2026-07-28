#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_UI_Anim_fnc_Anim_Init
Description:
		Initializes and configures an animation based on the provided animation type.
		Processes specific animation types (e.g., "spring") to derive final parameters.

Parameters:
		_animType  - string - The key used to look up the animation configuration in the file.

Returns:
		<ARRAY> - An array containing the resulting configuration map (['type', type], ['params', data])
		<NONE>  - If an error occurs during initialization or the type is invalid.

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_animType",""]];
TRACE_1("fn_Anim_Init",_this);

private _return = createHashMap;
private _config = configFile >> "Extended_Anim_transformation" >> _animType;
private _errorPop = false;

if (isclass _config) then {
  private _type = toLowerANSI getText (_config >> "type");
  private _props = configProperties [_config, "true"];

  private _data = createHashMapFromArray (_props apply {
    private _name = configname _x;
    private _value = call {
      if (isText _x) exitWith {getText _x};
      if (isNumber _x) exitWith {getNumber _x};
    };
    [_name,_value]
  });

  //- Check Type + Tweak values
  private _case = switch (_type) do {
    case "spring": {
      //- Components
        private _d = _data get "duration";
        private _f = _data get "frameRate";
        private _r = _data get "response";

      //- Error on "FrameRate <= 0"
        if (_f <= 0) exitwith {
          _errorPop = true;
					ERROR_MSG_1("Invalid Animation frameRate ""frameRate = %1""",_f);
        };

      _data set ["frequencyResponse", _r * (_f * _d)];
      0
    };
    default {
      -1
    };
  };

  //- If invalid type
  if (_case < 0) then {
    _errorPop = true;
		ERROR_MSG_1("Invalid Animation Type ""type = %1""",_type);
  } else {
    //- Valid Animation Type
    _return = createHashMapFromArray ([
      ["type",_type]
    ] + [
      ["params", _data]
    ]);
  };
};

[_return,nil] select _errorPop
