params ["_list","_type","_txt"];

private _ctrlMsg = _display ctrlCreate [
  [configFile >> "RscTitles" >>"ATAK_Message", configFile >> "ATAK_Message"] select _isDialog,
  -1,
  _list
];
private _txt = parseText _txt;

switch (_type) do {
  //- Send
  case 2: {
    _txt setAttributes ["align","right"];
    _txt = composeText [_txt];
  };
  //- Time
  case 4: {
    _txt setAttributes ["align","center"];
    _txt = composeText [_txt];
  };
};

_ctrlMsg ctrlSetStructuredText _txt;
_ctrlMsg ctrlSetBackgroundColor ([
  [1,0,0,0.05],
  [0,0,1,0.1],
  [0,1,0,0.05],
  [0,0,0,0]
] # _type);

_ctrlMsg