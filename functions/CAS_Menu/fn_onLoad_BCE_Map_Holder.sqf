/*
  NAME : BCE_fnc_onLoad_BCE_Map_Holder

  #LINK - Mission_Property.hpp
    >> "Rsc_BCE_MapControl"
  
  #NOTE - 
  Initiation for "BCE_MapControl" property
  For Custom-ability can use different event setups => "BCE_Map_Events"

  params :
    _Ctrl_Holder : IMPROTANT on display "onload" only
    _config  : The Config of the "Rsc_BCE_MapControl"
*/

params ["_Ctrl_Holder","_config"];

//- Register
  call BCE_fnc_RegisterMissionControls;

//- Add Event Handler
  private _events = configProperties [_config >> "BCE_Map_Events", "true", true];
  {
    private _eventFunction = getText _x;
    if (_eventFunction == "") then {continue}; //- Check function exist

    private _eventName = (configName _x) select [2]; //- remove prefix "on"
    
    //- Save Event Handler ID into "_Ctrl_Holder"
      private _ehId = _Ctrl_Holder ctrlAddEventHandler [_eventName, compile _eventFunction];
      if (_ehId < 0) then {continue}; //- Vaildate Event
    
      _Ctrl_Holder setVariable ["BCE_Map_Event_" + _eventName, _ehId];
  } forEach _events;