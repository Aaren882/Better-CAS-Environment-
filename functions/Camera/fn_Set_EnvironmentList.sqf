params ["_ctrl","_end"];

if (isnull _ctrl) exitWith {};

_colors = [[1,0,0,1],[1,1,0,1],[0,1,0,1]];
_exclude = {
  params ["_factor","_titles",["_color",true],["_custom_Txt",""]];
  private ["_index","_text","_result"];
  _index = switch true do {
    case (_factor > 0.5): {
      0
    };
    case (_factor > 0.15): {
      1
    };
    default {
      2
    };
  };

  _text = localize ("STR_BCE_Env_" + (_titles # _index));
  _result = [[
    format["%1 “%2”",_text,_custom_Txt],
    _text
  ] select (_custom_Txt == "")];

  if (_color) then {
    _result pushBack (_colors # _index);
  };
  _result
};

for "_i" from 0 to _end step 1 do {
  private _data = _ctrl lbData _i;
  if (_data != "") then {
    _ctrl lbSetTextRight [_i, format (call compile _data)];
  } else {
    private _var = switch _i do {
      case 2: {
        [windStr,["wind_Strong","wind_Gentle","wind_Calm"],false,(windDir - 180) call BCE_fnc_getAzimuth]
      };
      case 3: {
        [fog,["fog_Haze","fog_Mist","fog_Clear"]]
      };
      default {
        [(fog + (getLighting # 3)) / 2,["vis_Very_Bad","vis_Bad","vis_Good"]]
      };
    };

    if (_var isEqualTo 0) then {continue};

    (_var call _exclude) params ["_txt",["_color",[]]];
    _ctrl lbSetTextRight [_i, _txt];
    if (count _color > 0) then {
      _ctrl lbSetColorRight [_i, _color];
    };
  };
};

[BCE_fnc_Set_EnvironmentList, _this, 5] call CBA_fnc_waitAndExecute;
