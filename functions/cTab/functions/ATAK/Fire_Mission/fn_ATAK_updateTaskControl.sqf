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
    _group,     //- Group will Attached to
    _isDialog,  //- (MUST) "BOOL"
    true       //- Reset Page (OPTIONAL) : false
  ] call BCE_fnc_ATAK_createSubPage;

//- Save "_ctrl" easier to find
  _group setVariable ["Mission_Control", _MissionCtrl];

//- Init Mission Control for each category
  if !(_MissionCtrl getVariable ["Init",false]) then {
    
    //- Update task type in cTab Variable
      _subSel call BCE_fnc_ATAK_set_TaskType;

    //- New control's Initation Refresh Values
      switch (_cateSel) do {
        case 0: { //- Air Fire Support

          //- Refresh Task Values
            call BCE_fnc_ATAK_Refresh_TaskInfos;
          
          //- Set Task EH + update "MissionType" CurSel
          private _missionType = _MissionCtrl controlsGroupCtrl (17000 + 2107);
          _missionType lbSetCurSel _subSel;
          _missionType ctrlAddEventHandler ["LBSelChanged", BCE_fnc_ATAK_TaskTypeChanged];
        };
        case 1: { //- Ground Fire Support ("Call For Fire")
          private _AdjustGrp = _MissionCtrl controlsGroupCtrl 5400;
          private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5100;
          private _AdjustMeter = _AdjustGrp controlsGroupCtrl 5004;
          
          _AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values

          private _MeterValue = ["Meter",1] call BCE_fnc_get_FireAdjustValues;
          _AdjustMeter ctrlSetText format ["<-- %1 m -->", _MeterValue * 10];
        };
      };
    ctrlSetFocus _MissionCtrl;
    _MissionCtrl setVariable ["Init",true];
  };


//- Maybe Add CBA_EventHandler here


//- Return
  _MissionCtrl