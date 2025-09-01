/*
	NAME : BCE_fnc_GetMapClickPOS

	DESCRIPTION : Get the position of the map click and create a marker.
		- If [Alt + left click], create a marker with the position.
		- If right click, open the marker menu for the selected marker.

*/

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt",["_IDC_offset",0]];
private ["_display","_mark","_BCE_MapTool","_task","_ctrlEnter","_curSel","_idc"];
_display = ctrlparent _control;

//- #TODO - Implement BCE Map Control framework !!!!
  // private _HolderName = _display call BCE_fnc_get_BCE_Holder_Name;

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
	private _displayName = cTabIfOpen param [1, ""];
	// private _cTab_show = "cTab_Android_dlg" == _displayName || !isnil {cTabIfOpen};

	private _ctrlCombo = "New_Task_MarkerCombo" call BCE_fnc_getTaskSingleComponent;
	private _type = "New_Task_IPtype" call BCE_fnc_getTaskSingleComponent;
	private _TG_ToolBox = "New_Task_TGT" call BCE_fnc_getTaskSingleComponent;

	private _inMSN_Builder = [_ctrlCombo, _type, _TG_ToolBox] findIf {ctrlShown _x} > -1;

	//- "AV Terminal" or "Andorid Phone" or "cTab Tablet"
	if (_inMSN_Builder) then {

		// private _ctrlCombo = _display displayctrl (_IDC_Offset + 2013);
		// private _type = _display displayctrl (_IDC_Offset + 2012);

		if (
				_alt &&
				!(ctrlshown _ctrlCombo) &&
				(
					ctrlshown _type ||
					ctrlshown _TG_ToolBox
				) &&
				(
					!(ctrlshown _type) ||
					!(_type lbText (lbCurSel _type) == (localize "STR_BCE_Tit_OverHead")) /*||
          ctrlshown (_display displayctrl (_IDC_Offset + 4662))*/
				)
			) then {
			"MAP_ClickPOS" call _mark;
		};

	} else {
    //- BCE cTab click short-cut
		_BCE_MapTool = _display displayctrl (_IDC_offset + 12010);
		if (_alt && (ctrlShown _BCE_MapTool)) then {

			_type = _BCE_MapTool lbText lbCurSel _BCE_MapTool;

			_task = switch ([] call BCE_fnc_get_TaskCurType) do {
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
	
} else {

	//-Right Click

	//- cTab Only
	if (_IDC_offset != 17000) exitWith {};

	_curSel = [_control,cTabMapCursorPos] call cTab_fnc_findUserMarker;
	if (_curSel isNotEqualTo -1) then {
		_idc = switch true do {
			case (_curSel isEqualType 0): {
				localNamespace setVariable ["cTab_BFT_CurSel",_curSel];
				17000 + 3301
			};
			case (_curSel isEqualType objNull): {
				localNamespace setVariable ["cTab_BFT_CurSel",_curSel];
				_curVeh = [] call BCE_fnc_get_TaskCurUnit;

				[_IDC_offset + 3300, _IDC_offset + 33000] select (_curVeh == _curSel);
			};
		};
		[_idc,_this] execVM '\cTab\shared\cTab_markerMenu_load.sqf';
	};
};