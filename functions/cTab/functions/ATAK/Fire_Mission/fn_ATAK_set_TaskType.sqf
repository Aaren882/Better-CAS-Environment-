/*
  NAME : BCE_fnc_ATAK_set_TaskType
  
  "_category" : Task Category IDC (17000 + 2102)

  Update "cTab_fnc_setSettings" Value

  Return : _settings
*/
params ["_lbCurSel"];

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;
// private _category = _group controlsGroupCtrl (17000 + 2102);

/* if (isnull _category) exitWith {
  ["""_category"" Control !! (isEqualTo ControlNull)"] call BIS_fnc_error;

  [] //- Return
}; */

//- Get Correct Mission Builder
  private _cateSel = ["Cate",0] call BCE_fnc_get_TaskCurSetup;
  private _current_Cate = _cateSel call BCE_fnc_get_BCE_TaskCateClass;
	/* private _cateData = _category getVariable ["data",[]];
	private _current_Cate = _cateData param [_cateSel,""]; */
	
private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;

_settings params ["","","_subInfos"];
private _subMenu_Map = _subInfos param [2, createHashMap];

if (_current_Cate == "") exitWith {
	["Cannot found Mission Category : ""%1"" !!", _cateSel] call BIS_fnc_error;
};

//- Set SubMenu Infos (HashMap)
	_subMenu_Map set [_current_Cate, _lbCurSel];
	_subInfos set [2, _subMenu_Map];

//- Don't Update Interface (Save Only)
	_settings set [2, _subInfos];
	["cTab_Android_dlg",[["showMenu",_settings]],false] call cTab_fnc_setSettings;

_settings