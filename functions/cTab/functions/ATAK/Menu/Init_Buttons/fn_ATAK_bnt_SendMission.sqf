params ["_ctrlBnts","_ctrlPOS","_interfaceInit"];
_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

_vehicle = [] call BCE_fnc_get_TaskCurUnit;
_condition = (_vehicle getVariable ["BCE_Task_Receiver",""]) != "";

_bnt_Ent ctrlSetPositionX (_ctrlPOS # 2);
{
  _x ctrlSetPositionW (_ctrlPOS # 2);
  _x ctrlCommit 0;
} count [
  _bnt_back,
  _bnt_Ent,
  _bnt_result
];

//-Style Switching
_bnt_Ent ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select _condition);
_bnt_Ent ctrlSetBackgroundColor ([
  [
    (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
    (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
    (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
    0.8
  ],[
    1,0,0,0.5
  ]
] select _condition);

_bnt_result ctrlSetStructuredText parseText "<img image='MG8\AVFEVFX\data\list.paa' />";
_bnt_result ctrlSetBackgroundColor ((["R","G","B"] apply {1 - (profilenamespace getvariable ('GUI_BCG_RGB_' + _x))}) + [0.5]);