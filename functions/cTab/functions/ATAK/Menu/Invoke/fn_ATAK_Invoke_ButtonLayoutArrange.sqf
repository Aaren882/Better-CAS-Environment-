/* 
  NAME : BCE_fnc_ATAK_Invoke_ButtonLayoutArrange
  
*/

private _displayName = cTabIfOpen # 1;

params [
  ["_settings", [_displayName, "showMenu"] call cTab_fnc_getSettings],
  ["_interfaceInit",false]
];

_settings params ["_page","_show","_subInfos",["_PgComponents",createHashMap]];

private _display = uiNamespace getVariable [_displayName,displayNull];

private _backgroundGroup = _display displayCtrl 4660;
private _background = _backgroundGroup controlsGroupCtrl 9;

private _buttonGrp = _display displayCtrl 46600;
private _ctrls = allControls _buttonGrp;

_buttonGrp ctrlShow !_isHome;
_buttonGrp ctrlEnable true;

private _ctrlPOS = ctrlPosition _background;
_ctrlPOS set [2, (_ctrlPOS # 2) / 4];

//- Menu Elements
	//- Get Sub-Menu
		_subInfos params ["_subMenu","_curLine"];

//- Invoke Layout Function #NOTE - Get "ATAK_Buttons"
[_ctrls,_ctrlPOS,_interfaceInit] call {

	//- Get "ATAK_Buttons" from Config
		(_page call BCE_fnc_ATAK_getAPPs_props) params ["","","_subMenus","_config"];
		if (_subMenu != "") then {
			_config = (_subMenus get _subMenu) param [1,configNull];
		};
	private _BntName = getText (_config >> "ATAK_Buttons");
	private _function = getText (configFile >> "ATAK_Buttons" >> _BntName >> "onLoad");

	//- #LINK - functions/cTab/functions/ATAK/fn_ATAK_bnt_clickEvent.sqf
		private _clickEvents = getArray (configFile >> "ATAK_Buttons" >> _BntName >> "clickEvents");
		{
			if (_forEachIndex == 0) then {continue}; //- Skip "LastPage" button
			private _e = _clickEvents param [_forEachIndex - 1, ""];
			_x setVariable ["clickEvent",_e];
		} forEach _ctrls;

	//- call Function
	privateAll;
	import ["_function"];
	_this call (missionNamespace getVariable [_function,{}]);
};