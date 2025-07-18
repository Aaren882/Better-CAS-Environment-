/*
  NAME : BCE_fnc_onLoad_BCE_Holder

  #LINK - Mission_Property.hpp
  
  #NOTE - 
  Initiation for "BCE_Mission" property
  For Custom-ability can use different setups => "BCE_Mission_Property"

  params :
    _display : IMPROTANT on display "onload" only
    _config  : The Config of the BCE_Holder
*/

params ["_Ctrl_Holder","_config"];

//- Register
  call BCE_fnc_RegisterMissionControls;

private _display = ctrlParent _Ctrl_Holder;
private _map = localNamespace getVariable ["#BCE_onLoad_BCE_Holder", createHashMap];

//- Get Display Name
private _KeyName = [_config, "displayName", ""] call BIS_fnc_returnConfigEntry;
if (_KeyName == "") then { //- if displayName is not set
  _KeyName = "display#" + str CtrlIDD _display;
};

// if _KeyName haven't register yet
  if !(_KeyName in _map) then {
    private _missionCfg = _config >> "BCE_Mission";

    //- Get Default Vaule
      if (isnull _missionCfg) then {
        _missionCfg = configFile >> "BCE_Mission_Default";
      };

    private _missionProps = configProperties [_missionCfg];
    private _result = _missionProps apply {
      private _cate = _x;
      private _return = (configProperties [_x]) apply {
        private _taskName = configName _x; //- 9Line, 5Line, CFF ...
        private _entry = [_cate, _taskName, ""] call BIS_fnc_returnConfigEntry;

        [toUpperANSI _taskName, _entry]
      };

      /* 
        #SECTION - Return Format
        [
          "Category Name" (e.g. AIR, GND)

          #NOTE - ["Task Type" , "Task Setups"] ("UI Controls", "Description", "Variable")
          [
            "9Line", "AIR_9_LINE"
          ]
        ]
       */
      [toUpperANSI (configName _cate), createHashMapFromArray _return]
    };

    _map set [_KeyName, createHashMapFromArray _result];
    localNamespace setVariable ["#BCE_onLoad_BCE_Holder", _map];
  };

//- Store into _display Object
  _display setVariable ["BCE_Holder_Name", _KeyName];