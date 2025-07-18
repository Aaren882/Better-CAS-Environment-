/*
  NAME : BCE_fnc_get_BCE_Holder

  Get BCE_Holder Properties from Display Name

  Return :
    [
      "Category Name" (e.g. AIR, GND)

      #NOTE - ["Task Type" , "Task Setups"] ("UI Controls", "Description", "Variable")
      [
        "9Line", "AIR_9_LINE"
      ]
    ]
*/

params ["_input"];

private _key = switch (typeName _input) do {
  case "DISPLAY": {_input getVariable ["BCE_Holder_Name", ""]};
  case "STRING": {_input};
};

//- Get BCE_Holder from localNamespace
private _map = localNamespace getVariable ["#BCE_onLoad_BCE_Holder", createHashMap];

_map getOrDefault [_key, createHashMap];