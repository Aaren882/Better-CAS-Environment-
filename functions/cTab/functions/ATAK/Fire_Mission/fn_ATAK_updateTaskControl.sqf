/* 
  NAME : BCE_fnc_ATAK_updateTaskControl

  ["_group","_settings"]
  
  Update Task ControlGroup for each Mission

  Return : ControlNull or "_MissionCtrl"
*/

params ["_group","_settings"];

//- Get "controlGroup" automatically (this takes time)
  if (isNil "_group") then {
    _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
  };
//- Get ATAK variables (this takes Time)
  if (isNil "_settings") then {
    _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
  };


//- get SubMenu Infos
([_group, _settings] call BCE_fnc_ATAK_getTaskCategoryInfo) params ["_taskMenu","_cateSel","_subSel"];
  
  if (_taskMenu == "") exitWith {
    ["Cannot found Mission UI control !!"] call BIS_fnc_error;
    controlNull; //- Return controlNull
  };

private _isDialog = [(cTabIfOpen # 1)] call cTab_fnc_isDialog;

//- Create Builder
  private _MissionCtrl = [
    _taskMenu,  //- Create Menu className
    21000,   //- Desire IDC
    _group,     //- Group will Attach to
    _isDialog,  //- (MUST) "BOOL"
    true       //- Reset Page (OPTIONAL) : false
  ] call BCE_fnc_ATAK_createSubPage;

//- Save "_ctrl" easier to find
  _group setVariable ["Mission_Control", _MissionCtrl];

//- Init Mission Control for each category
  if !(_MissionCtrl getVariable ["Init",false]) then {
    
    //- Update task type in cTab Variable
      _subSel call BCE_fnc_ATAK_set_TaskType;

    //- Refresh Task Values #NOTE - Seems like the create Menu will delay one frame 😐
			[BCE_fnc_ATAK_Refresh_TaskInfos,[]] call CBA_fnc_execNextFrame; //- on Next Frame

    //- Rearrange Buttons
      [_settings,true] call BCE_fnc_ATAK_Invoke_ButtonLayoutArrange;

    //- New control's Initation Refresh Values
      switch (_cateSel) do {
        case 0: { //- Air Fire Support
          private _missionType = "TaskType" call BCE_fnc_getTaskSingleComponent;

          //- Set Task EH + update "MissionType" CurSel
            _missionType lbSetCurSel _subSel;
            _missionType ctrlAddEventHandler ["LBSelChanged", BCE_fnc_onLBTaskTypeChanged];
        };
        case 1: { //- Ground Fire Support ("Call For Fire")

          //- Get Avaliable Arty Units
            private _artyGrp = "Vehicle_Grp_Sel" call BCE_fnc_getTaskSingleComponent;
            _artyGrp ctrlAddEventHandler ["LBSelChanged", BCE_fnc_onLBTaskUnitChanged];
            
            //- Create ARTY List
              private _vehicle = [] call BCE_fnc_get_TaskCurUnit;
              private _vehSel = 0;
              {
                private _add = _artyGrp lbAdd (groupId group _x);
                _artyGrp lbSetData [_add, str _x];
                if (_vehicle == _x) then {
                  _vehSel = _add;
                };
              } forEach cTabARTYlist;
              _artyGrp lbSetCurSel _vehSel;
          
          //- CFF TaskType Eventhandler
          private _missionType = "TaskType_GND" call BCE_fnc_getTaskSingleComponent;

          //- Set Task EH + update "MissionType" CurSel
            _missionType lbSetCurSel _subSel;
            _missionType ctrlAddEventHandler ["LBSelChanged", BCE_fnc_onLBTaskTypeChanged];
        };
      };
    ctrlSetFocus _MissionCtrl;
    _MissionCtrl setVariable ["Init",true];
  };


//- Maybe Add CBA_EventHandler here


//- Return
  _MissionCtrl