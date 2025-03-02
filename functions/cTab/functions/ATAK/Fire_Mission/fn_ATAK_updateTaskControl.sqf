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
// private _MissionCtrl = _group getVariable ["Mission_Control", controlNull];

//- if "_MissionCtrl" Exist (Delete Ctrl)
  /* if (!isNull _MissionCtrl) then {
    ctrlDelete _MissionCtrl;
  }; */


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

//- Check if initiated
  if !(_MissionCtrl getVariable ["Init",false]) then {
    //- New control's Initation Refresh Values
    switch (_cateSel) do {
      case 0: {
        call BCE_fnc_ATAK_Refresh_TaskInfos; //- Refresh Values

        //- Set Task EH + update "MissionType" CurSel
        private _missionType = _MissionCtrl controlsGroupCtrl (17000 + 2107);
        _missionType lbSetCurSel _subSel;
        _missionType ctrlAddEventHandler ["LBSelChanged", BCE_fnc_ATAK_TaskTypeChanged];
      };
    };
    _MissionCtrl setVariable ["Init",true];
  };


//- Maybe Add CBA_EventHandler here


//- Return
  _MissionCtrl