/*
  NAME : BCE_fnc_Send_Task_RadioMsg

  params :
    _unit : <OBJECT> Task Unit
    _msg      : <STRING> Message to send
    _MsgID    : <STRING> Message ID (default: "")

  Description : Send Task Radio Message to the Task Unit
*/

params ["_unit","_msg",["_MsgID",""]];

_unit sideChat _msg;

if (_MsgID != "") then { //- if MsgID is not empty
  ["BCE_Task_RadioMsg", [_unit,_MsgID]] call CBA_fnc_LocalEvent; //- Trigger CBA Event
};