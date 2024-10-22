params [["_animType",""]];

private _return = createHashMap;
private _config = configFile >> "Extended_Anim_transform" >> _animType;
// private _config_Props = _config >> "Config";

if (isclass _config) then {
  private _type = toLowerANSI getText (_config >> "type");
  private _props = configProperties [_config, "true", false];

  private _data = createHashMapFromArray (_props apply {
    private _name = configname _x;
    private _value = call {
      if (isText _x) exitWith {getText _x};
      if (isNumber _x) exitWith {getNumber _x};
    };
    [_name,_value]
  });

  //- Tweak values
  switch (_type) do {
    case "spring": {
      //- Components
        private _d = _data get "duration";
        private _f = _data get "frameRate";
        private _r = _data get "response";

      //- frequencyResponse = points_Count * response;
      _data set ["arange", _f * _d];
      _data set ["frequencyResponse", _r * (_f * _d)];

      _data deleteAt "frameRate";
      _data deleteAt "response";
    };
  };

  _return = createHashMapFromArray ([
    ["type",_type]
  ] + [
    ["params", _data]
  ]);
};

_return