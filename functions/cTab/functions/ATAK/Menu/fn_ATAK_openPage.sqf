/*
	NAME : BCE_fnc_ATAK_openPage

*/
params ["_display","_page",["_isHome", false],"_settings"];
private ["_group","_ctrls","_currentPage","_ctrlPOS_BG","_ctrlPOS"];

_group = _display displayCtrl 46600;
_ctrls = allControls _group;
_group ctrlShow !_isHome;
_group ctrlEnable true;

_currentPage = _page;
_ctrlPOS_BG = ctrlPosition _background;
_ctrlPOS =+ _ctrlPOS_BG; // - Copy Value
_ctrlPOS set [2, (_ctrlPOS # 2) / 4];

//- Menu Elements
	//- Get Sub-Menu
		_subInfos params ["_subMenu","_curLine"];

	//- Get Sub-List
		private _PG_data = _PgComponents getOrDefault [_page,[]];
		_PG_data params ["_line"];

//- Overwrite (--temporary--)
	if (_subMenu != "") then {
		_currentPage = _subMenu;
	};

//- Get "ATAK_Buttons"
	[_ctrls,_ctrlPOS,_interfaceInit] call {

		//- Get "ATAK_Buttons" from Config
			(_page call BCE_fnc_ATAK_getAPPs_props) params ["","","_subMenus","_config"];
			if (_subMenu != "") then {
				_config = (_subMenus get _subMenu) param [1,configNull];
			};
		private _BntName = getText (_config >> "ATAK_Buttons");
		private _functionName = getText (configFile >> "ATAK_Buttons" >> _BntName >> "onLoad");

		privateAll;
		import ["_functionName"];
		_this call (uiNamespace getVariable [_functionName,{}]);
	};

//- The return value
	private _returnIDC = [4650, 4660] select _isHome;
	private _return = _display displayCtrl (17000 + _returnIDC);
	_return ctrlShow true;

//- Init State
	{
		if (_returnIDC != _x) then {
			private _ctrl = _display displayCtrl (17000 + _x);
			_ctrl ctrlShow false;
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
		};
	} forEach [
		4660,
		4650
	];

[_page,_subMenu,_isHome] call BCE_fnc_ATAK_openMenu;

// - Return "nil" or "Control Group"
_return