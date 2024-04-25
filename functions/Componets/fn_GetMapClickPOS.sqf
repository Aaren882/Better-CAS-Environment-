params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt",["_IDC_offset",0]];
private ["_display","_mark","_BCE_MapTool","_cTab_show","_IDC_Offset","_type","_task","_ctrlEnter","_curSel","_idc"];
_display = ctrlparent _control;

_mark = {
	params ["_id",["_color","ColorYellow"]];
	private ["_POS","_marker"];
	_POS = _control ctrlMapScreenToWorld [_xPos, _yPos];
	_marker = createMarkerLocal ["BCE_ClickPOS_Marker", _POS];

	//-Marker Hint
	_marker setMarkerColorLocal _color;
	_marker setMarkerTypeLocal "mil_end";
	_marker setMarkerPosLocal _POS;
	[{
		params ["_marker","_time"];

		private _size = _time-time;
		_marker setMarkerSizeLocal [_size*0.8, _size*0.8];

		(time >= _time)
	},{
		params ["_marker","_time"];
		deleteMarkerLocal _marker;

		}, [_marker,time+1]
	] call CBA_fnc_waitUntilAndExecute;
	uinamespace setVariable ["BCE_" + _id, _POS];
};

if (_button == 0) then {
	_cTab_show = ["cTab_Android_dlg" in cTabIfOpen, true] select (isnil {cTabIfOpen});
	
	//- "AV Terminal" or "Andorid Phone" or "cTab Tablet"
	if ((!(isnull findDisplay 160) || (_IDC_Offset > 0)) && _cTab_show) then {

		_ctrlCombo = _display displayctrl (_IDC_Offset + 2013);
		_type = _display displayctrl (_IDC_Offset + 2012);
		if (
				(_alt) &&
				!(ctrlshown _ctrlCombo) &&
				([(
					(ctrlshown _type) ||
					(ctrlshown (_display displayctrl (_IDC_Offset + 20121)))
				), true] select (17000 == _IDC_Offset)) &&
				(
					!(ctrlshown _type) ||
					!(_type lbText (lbCurSel _type) == (localize "STR_BCE_Tit_OverHead"))
				)
			) then {
			"MAP_ClickPOS" call _mark;
		};

	//-Others
	} else {
		_BCE_MapTool = _display displayctrl (_IDC_offset + 12010);
		if (_alt && (ctrlShown _BCE_MapTool)) then {

			_type = _BCE_MapTool lbText lbCurSel _BCE_MapTool;

			_task = switch (uiNameSpace getVariable ["BCE_Current_TaskType",0]) do {
				//- 5 line
				case 1: {
					[-1,2,1]
				};
				//- 9 line
				default {
					[1,6,8]
				};
			};

			_info = switch _type do {
				case "IP/BP": {
					["ColorYellow",_task # 0]
				};
				case "GRID": {
					["colorOPFOR",_task # 1]
				};
				case "FRND": {
					["colorBLUFOR",_task # 2]
				};
			};

			//-Exit if is not support
			if ((_info # 1) < 0) exitWith {
				["Task_Builder",localize "STR_BCE_Error_TaskSupport",3] call cTab_fnc_addNotification;
			};

			[_type,_info # 0] call _mark;

			_ctrlEnter = _display displayctrl (_IDC_offset + 21051);
			[_ctrlEnter, 17000, true,_info # 1] call BCE_fnc_DataReceiveButton;

			private _list = _display displayCtrl (17000 + 12010);
			[_list, lbCurSel _list] call BCE_fnc_ctab_BFT_ToolBox;
		};
	};

	//- cTab Only
	// if (_IDC_offset != 17000) exitWith {};

	// //- Get Current Selected Marker
	// _curSel = [_control,cTabMapCursorPos] call cTab_fnc_findUserMarker;
	// if (_curSel isNotEqualTo -1) then {
	// 	uiNameSpace setVariable ["cTab_BFT_CurSel",_curSel];
	// };
} else {

	//-Right Click

	//- cTab Only
	if (_IDC_offset != 17000) exitWith {};

	_curSel = [_control,cTabMapCursorPos] call cTab_fnc_findUserMarker;
	if (_curSel isNotEqualTo -1) then {
		_idc = switch true do {
			case (_curSel isEqualType 0): {
				uiNameSpace setVariable ["cTab_BFT_CurSel",_curSel];
				17000 + 3301
			};
			case (_curSel isEqualType objNull): {
				uiNameSpace setVariable ["cTab_BFT_CurSel",_curSel];
				_curVeh = player getVariable ["TGP_View_Selected_Vehicle",objNull];

				[_IDC_offset + 3300, _IDC_offset + 33000] select (_curVeh == _curSel);
			};
		};
		[_idc,_this] execVM '\cTab\shared\cTab_markerMenu_load.sqf';
	};
};