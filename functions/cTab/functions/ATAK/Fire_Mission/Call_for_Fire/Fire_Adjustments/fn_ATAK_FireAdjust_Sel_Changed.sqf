/*
	NAME : BCE_fnc_ATAK_FireAdjust_Sel_Changed
*/

params ["_toolBox",["_lbCurSel", ["CurSel", 0] call BCE_fnc_get_FireAdjustValues]];

private _Sel_class = [
	"CFF_ADJUST_POLAR_Group",
	"CFF_ADJUST_IMPACT_Group",
	"CFF_ADJUST_GL_Group"
] # _lbCurSel;

private _AdjustMenuGrp = (ctrlParentControlsGroup _toolBox) controlsGroupCtrl 5400;
private _ctrl = _AdjustMenuGrp getVariable ["ADJUST_CTRL", controlNull];

//- Delete the Adjust control
if (_Sel_class != ctrlclassName _ctrl) then {
	ctrlDelete _ctrl;

	private _displayName = cTabIfOpen param [1,""];
	private _config = [configFile >> "RscTitles" >> _Sel_class, configFile >> _Sel_class] select ([_displayName] call cTab_fnc_isDialog);
	
	private _keyName = ([_toolBox,"AdjustTypes",[]] call BCE_fnc_get_Control_Data) # _lbCurSel;
	["CURRENT", _keyName] call BCE_fnc_set_FireAdjustValues;

	private _default = ([_toolBox,"Default",[]] call BCE_fnc_get_Control_Data) # _lbCurSel;
	[_keyName, _default, true] call BCE_fnc_get_FireAdjustValues;
	
	private _display = ctrlparent _toolBox;
	_ctrl = _display ctrlCreate [_config, 1500, _AdjustMenuGrp];
	_AdjustMenuGrp setVariable ["ADJUST_CTRL", _ctrl];
	["CurSel", _lbCurSel] call BCE_fnc_set_FireAdjustValues;
};