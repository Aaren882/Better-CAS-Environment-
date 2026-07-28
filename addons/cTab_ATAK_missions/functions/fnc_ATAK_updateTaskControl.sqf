#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_updateTaskControl
Description:
		Updates and initializes the Mission Control UI within the specified ControlGroup.
		It handles the creation and configuration of mission-related sub pages and controls.

Parameters:
		_group    - The <ControlGroup> object to which the Mission Control will be attached.
		_settings - (OPTIONAL) The settings <ARRAY> of data from `["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings`.
								Containing configuration details for the UI.
								#NOTE : although this parameter is optional better provide it as you can1

		_reset    - (OPTIONAL) flag to determine if the control should be reset upon update <BOOL>.

Returns:
		- <_MissionCtrl / ControlNull>
			Returns the Mission Control object (or controlNull if creation fails).

Author:
		Aaren
---------------------------------------------------------------------------- */

params ["_group","_settings",["_reset",true]];
TRACE_1("fnc_ATAK_updateTaskControl",_this);

//- Get "controlGroup" automatically (this takes time)
  if (isNil "_group") then {
    _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
  };
//- Get ATAK variables (this takes Time)
  if (isNil "_settings") then {
    _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
  };
_settings params ["_page","_show","_subInfos",["_PgComponents",createHashMap]];


//- get SubMenu Infos
([_group, _settings] call FUNC(ATAK_getTaskCategoryInfo)) params ["_taskMenu","_cateSel","_subSel"];
  
  if (_taskMenu == "") exitWith {
		ERROR_MSG("Cannot found Mission UI control !!");
    controlNull; //- Return controlNull
  };

private _isDialog = [(cTabIfOpen # 1)] call cTab_fnc_isDialog;

//- Create Builder
if (!_show) exitWith {_group getVariable ["Mission_Control", controlNull]};

  private _MissionCtrl = [
    _taskMenu,  //- Create Menu className
    21000,   //- Desire IDC
    _group,     //- Group will Attach to
    _isDialog,  //- (MUST) "BOOL"
    _reset       //- Reset Page (OPTIONAL) : false
  ] call BCE_fnc_ATAK_createSubPage;

//- Save "_ctrl" easier to find
  _group setVariable ["Mission_Control", _MissionCtrl];

//- Refresh Task Values #NOTE - Seems like the create Menu will delay one frame 😐
	[FUNC(ATAK_Refresh_TaskInfos),[]] call CBA_fnc_execNextFrame; //- on Next Frame

//- Init Mission Control for each category
  if !(_MissionCtrl getVariable ["Init",false]) then {
    
    //- Update task type in cTab Variable
      _subSel call FUNC(ATAK_set_TaskType);

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
