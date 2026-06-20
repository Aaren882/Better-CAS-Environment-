/*
  NAME : BCE_fnc_ATAK_getAPPs_props

  ["_key","_default","_replace"]

  ==========================================
  Get "BCE_ATAK_APPs_HashMap" Values
  from => configFile >> "ATAK_APPs" >> _NAME >> "Menu_Property"

  Return : 
    "[_page, _Opened, _pages]"

    _pages[] =
    [
      // { "CTRL_CLASS" , "OPENED" }
      ["Task_Building", "BCE_fnc_ATAK_mission_SUB_TaskBuilding"],
      ["Task_Result", "BCE_fnc_ATAK_mission_SUB_TaskResult"]
    ];

  ==========================================
  
  Examples :
  [
    "message" : ["ATAK_Message", "BCE_fnc_ATAK_message_Init", []],
    "mission" : []
  ]
*/
params ["_key",["_default",[]],["_replace",false]];

private _map = localNamespace getVariable ["BCE_ATAK_APPs_HashMap", createHashMap];

_map getOrDefault [_key, _default, _replace];
