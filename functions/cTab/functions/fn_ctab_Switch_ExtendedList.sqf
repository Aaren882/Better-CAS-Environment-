params ["_control","_lbCurSel",["_period",0.5]];

if (_period == 0) then {
  _control lbSetCurSel _lbCurSel;
};

_display = ctrlParent _control;
_checkList = _display displayCtrl (17000 + 1787);
_taskList = _display displayCtrl (17000 + 1789);

_all_lists = [[1785,17850,1786],[1787,1788],[1789,1790]];

//-Variables
_veh = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
_origin = uiNameSpace getVariable ["ctab_Extended_List_Sel",[0,_all_lists # 0]];

//-Original Controls
_origin params ["_or_sel","_or_ctrls"];

//-hide all Controls and run animation
{
  _x apply {
    private ["_ctrl","_show"];
    _ctrl = _display displayCtrl (17000 + _x);
    _show = _forEachIndex == _lbCurSel;
    _ctrl ctrlshow _show;
    _ctrl ctrlSetFade ([1,0] select _show);
    _ctrl ctrlCommit _period;
  };
} forEach _all_lists;

if !(isNull _veh) then {

  //-Vic Info
  if (_lbCurSel == 0) then {
    [_veh,[[1,"rendertarget8"]],false] call cTab_fnc_createUavCam;
    #if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
      (_display displayctrl (17000 + 17850)) call BCE_fnc_setRacks_ACRE;
    #endif
  } else {
    call cTab_fnc_deleteUAVcam;
  };

  //-Weapon CheckList
  if (_lbCurSel == 1) then {
    [_display,_checkList,_veh,true] call BCE_fnc_checkList;
  } else {
    lbClear _checkList;
  };

  //-Task List
  if (_lbCurSel == 2) then {
    private _var = _veh getVariable ["BCE_Task_Receiver",[]];
    _var params ["","","_type","_taskVar",""];

    //-Set LB
    [_taskList,_type,_taskVar] call BCE_fnc_SetTaskReceiver;

    if (lbCurSel _taskList == -1) then {
      _taskList lbSetCurSel 0;
    };
  } else {
    lbClear _taskList;
  };

} else {
  call cTab_fnc_deleteUAVcam;
  lbClear _checkList;
  lbClear _taskList;
};

uiNameSpace setVariable ["ctab_Extended_List_Sel",[_lbCurSel,_all_lists # _lbCurSel]];
