/*
  NAME : BCE_fnc_ATAK_set_TaskType
  
  "_category" : Task Category IDC (17000 + 2102)

  Update "cTab_fnc_setSettings" Value

  Return : _settings
*/
params ["_lbCurSel"];

private _group = (call BCE_fnc_ATAK_getCurrentAPP) # 1;

//- Get Correct Mission Builder
  private _current_Cate = [] call BCE_fnc_get_BCE_TaskCateClass;
	
private _settings = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;

_settings params ["","","_subInfos"];
private _subMenu_Map = _subInfos param [2, createHashMap];

//- Set SubMenu Infos (HashMap)
	_subMenu_Map set [_current_Cate, _lbCurSel];
	_subInfos set [2, _subMenu_Map];

//- Don't Update Interface (Save Only)
	_settings set [2, _subInfos];
	["cTab_Android_dlg",[["showMenu",_settings]],false] call cTab_fnc_setSettings;

_settings