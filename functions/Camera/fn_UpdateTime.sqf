_hour = (daytime - (daytime % 1));
_minute = ((daytime % 1) * 60) - ((daytime % 1) * 60) % 1;
_second = (((daytime % 1) * 3600) - ((daytime % 1) * 3600) % 1) - (_minute * 60);

_hourHour = "";
if (_hour < 10) then {_hourHour = "0"};

_minuteMinute = "";
if (_minute < 10) then {_minuteMinute = "0"};

_secondSecond = "";
if (_second < 10) then {_secondSecond = "0"};

_playtimeHMS = format ["%1%2:%3%4:%5%6",_hourHour,_hour,_minuteMinute,_minute,_secondSecond,_second];

_playtimeHMS;
