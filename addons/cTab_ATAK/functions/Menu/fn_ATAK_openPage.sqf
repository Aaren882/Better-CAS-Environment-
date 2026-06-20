/*
	NAME : BCE_fnc_ATAK_openPage

*/
params ["_display","_page",["_isHome", false],"_settings"];
private ["_group","_ctrls","_currentPage","_ctrlPOS_BG","_ctrlPOS"];

// _currentPage = _page;
_ctrlPOS_BG = ctrlPosition _background;

//- Menu Elements
	//- Get Sub-Menu
		_subInfos params ["_subMenu","_curLine"];

//- Rearrange Buttons
	[_settings,_interfaceInit] call BCE_fnc_ATAK_Invoke_ButtonLayoutArrange;

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
