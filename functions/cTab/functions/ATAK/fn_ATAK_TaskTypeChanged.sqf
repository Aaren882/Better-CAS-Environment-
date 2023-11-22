params ["_control","_lbCurSel"];
private ["_display","_group","_vehicle","_ctrls","_last_CtrlPOS","_idc"];

_display = ctrlParent _control;
_group = _display displayCtrl (17000 + 4661);
_IDCs = getArray (configFile >> "cTab_Android_dlg" >> "TaskIDCs_List");
_vehicle = player getVariable ["TGP_View_Selected_Vehicle",objNull];
uiNameSpace setVariable ["BCE_Current_TaskType",_lbCurSel];

// - ["_9line","_5line"]
// - Output all + hide them all
_ctrls = [];
{
  _ctrls pushback (_x apply {
    private _ctrl = _group controlsGroupCtrl _x;
    _ctrl ctrlShow (_forEachIndex == _lbCurSel);
    _ctrl
  });
} foreach _IDCs;

if (_lbCurSel == 1) then {
  (_group controlsGroupCtrl (17000 + 2040)) ctrlSetStructuredText parseText format ["“%1” / “%2”", [groupId group _vehicle, "None"] select isnull _vehicle, groupId group player];
};

//-Setup Remarks POS on ATAK Mission Builder
_last_CtrlPOS = ctrlPosition (_ctrls # _lbCurSel # -1);
{
  _x params ["_offset","_H"];
  private _ctrl = _group controlsGroupCtrl (3000 + _offset);
  _ctrl ctrlSetPositionY ((_last_CtrlPOS # 1) + ((_last_CtrlPOS # 3) * (_H + 0.25)));
  _ctrl ctrlcommit 0;
} count [[0,1.05],[1,1.1],[2,2.35]];

//-Update DESC Selection
_idc = [2027,2043] # _lbCurSel;
private _ctrl = (_display displayCtrl (17000 + 4661)) controlsGroupCtrl (17000 + _idc);
_ctrl lbSetCurSel (uiNamespace getVariable ["BCE_ATAK_Desc_Type",0]);