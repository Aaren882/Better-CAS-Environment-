#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_UI_Anim_fnc_Anim_Init
Description:
    Initializes animation configuration from Extended_Anim_transformation config.
    Processes animation type and parameters, validating spring animation properties.

Parameters:
    _animType  - Animation type identifier <STRING>

Returns:
    Animation data hashmap with "type" and "params" keys, or empty hashmap on error <HASHMAP>

Examples
    (begin example)
        ["spring"] call BCE_UI_Anim_fnc_Anim_Init
    (end)

Author:
    Aaren
---------------------------------------------------------------------------- */

params [["_animType",""]];
TRACE_1("fnc_Anim_Init",_this);

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
        private _mass = _data get "mass";
        private _damping = _data get "damping";
        private _initialPosition = _data get "initialPosition";
        private _initialVelocity = _data get "initialVelocity";

				private _response = _data get "response";
				private _duration = _data get "duration";
        private _frameRate = _data get "frameRate";

      //- Error on "FrameRate <= 0"
        if (_frameRate <= 0) exitwith {
          _errorPop = true;
          ERROR_MSG_1("Invalid Animation frameRate ""frameRate = %1""",_frameRate);
        };

      // _data set ["frequencyResponse", _response * (_frameRate * _duration)];

			//- Register animation into the extension
			private _register = "bce_anim_engine" callExtension ["register", [
					_animType,
					_mass,
					_damping,
					_response,
					_duration,
					_frameRate,
					_initialPosition,
					_initialVelocity
				]
			];
			_register params ["_registerReturn"];
			INFO_1("Animation Registered ""%1"":",_registerReturn);

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
