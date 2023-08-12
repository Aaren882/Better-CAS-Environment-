private ["_display","_vehicle","_var","_ctrlUnit","_ctrlList","_Cfg"];

_display = uiNamespace getVariable "BCE_Task_Receiver";
_vehicle = vehicle cameraOn;
_var = _vehicle getVariable "BCE_Task_Receiver";

_ctrlUnit = _display displayCtrl 101;
_ctrlList = _display displayCtrl 102;

_var params ["_caller","_callerGrp","_type","_taskVar","_time"];

_ctrlUnit ctrlSetText (format ["%1 [%2]",_callerGrp, name _caller]);

//-Set LB
[_ctrlList,_type,_taskVar] call BCE_fnc_SetTaskReceiver;

//-Set UI POS
{
  _x params ["_idc",["_BG",0]];
  private _ctrl = _display displayCtrl _idc;
  private _class = configFile >> "RscTitles" >> "BCE_Task_Receiver" >> ["controls","controlsBackground"] select (_BG > 0) >> ctrlClassName _ctrl;
  private _pos = ["x","y","w","h"] apply {
    call compile getText (_class >> _x)
  };

  _ctrl ctrlSetPosition _pos;
  _ctrl ctrlCommit 0;
} forEach [
  [15110,1],
  [15111,1],
  15112,
  101,
  102
];
