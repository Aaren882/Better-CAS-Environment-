params ["_displayName",["_loop",false]];
private ["_cur_displayName","_display","_windDir","_temperature","_windSpeed","_text"];

_cur_displayName = [cTabIfOpen # 1,""] select isnil{cTabIfOpen};

_display = if (_cur_displayName == "") then {
  displayNull
} else {
  uiNamespace getVariable _cur_displayName
}; 

//-Exit
if ((isnull _display || _displayName != _cur_displayName) && _loop) exitWith {
  private _Weather = [_displayName,"Weather_Condition"] call cTab_fnc_getSettings;
  _Weather set [1, ""];

  [_displayName,[["Weather_Condition",_Weather]],_displayName != (cTabIfOpen # 1)] call cTab_fnc_setSettings;
};

//- Get Info and Icon
_getWeather = {
	private ["_texts","_factors","_factor","_result","_icon"];
	
	_texts = if (_this isEqualType 0) then {
		_factor = _this;
		
		[
      ["wind_Strong","wind_Gentle","wind_Calm"],
      ["","",""]
    ]
	} else {
		_factors = [fog, rain, overcastForecast];
    private _index = _factors findif {_x > 0.1};
		_factor = _factors # _index;

		(
			[
				[
          ["fog_Haze","fog_Fog","fog_Mist"],
          ["haze","mist","mist"]
        ],
				[
          ["Heavy_rain","Moderate_rain","Slight_rain"],
          ["Heavy_Rain","Moderate_rain","drizzle"]
        ],
				[
          ["overcast_Over","overcast_Cloudy","overcast_Clear"],
          ["overcast","clouds_sun","sunny"]
        ]
			] # _index
		)
	};
	
	
	_result = switch true do {
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

  _icon = _texts # 1 # _result;
	//- [Text, Icon]
	[
		localize ("STR_BCE_Env_" + (_texts # 0 # _result)),
		[format ["<img image='MG8\AVFEVFX\data\%1.paa' />", _icon],nil] select (_icon == "")
	]
};

([] call _getWeather) params ["_result","_icon"];
(windStr call _getWeather) params ["_wind",""];

_windDir = [windDir] call cTab_fnc_degreeToOctant;
_temperature = floor (ambientTemperature # 0);
_windIcon = "<img image='MG8\AVFEVFX\data\wind.paa' />";
if (([_displayName,"Weather_Condition"] call cTab_fnc_getSettings) # 0) then {
  //- ACE get Wind Speed
  #if __has_include("\z\ace\addons\weather\config.bin")
    _windSpeed = [eyePos cTab_player, false, true, false] call ace_weather_fnc_calculateWindSpeed;
  #else
    _windSpeed = vectorMagnitude wind;
  #endif

  _text = trim format [
    "
    <t align='center' size='0.75'>%3</t>%1%2 %4<t align='right'>%5°C</t>%1%6%1%7
    ",
    
    "<br/>",
    _icon,
    cTab_player call BIS_fnc_locationDescription,
    _result,
    _temperature,
    format [
      "%1 %2 %3 <t align='right' size='0.8'>”%4“</t>",
      _windIcon,
      _wind,
      format ["<t size='0.8'>- %1m/s</t>", floor _windSpeed],
      _windDir
    ],
    format [
      "<img image='MG8\AVFEVFX\data\umbrella.paa' /> %1%2",
      round ((1 min (linearConversion [0, 1, humidity, 0, 1] + linearConversion [0.5, 0.8, overcastForecast, 0.3, 0.5, true])) * 10) * 10,
      "%"
    ]
  ];

  (_display displayCtrl 26160) ctrlSetStructuredText parseText _text;
};

//- Button
(_display displayCtrl 2616) ctrlSetStructuredText parseText format [
  "<t align='center'>%1 %2°C   %3 ”%4“</t>",
  _icon,
  _temperature,
  "<img size='0.7' image='MG8\AVFEVFX\data\wind_Estimator.paa' />",
  _windDir
];

if (_loop) then {
  [BCE_fnc_cTab_getWeather_Infos, _this, 2] call CBA_fnc_waitAndExecute;
};