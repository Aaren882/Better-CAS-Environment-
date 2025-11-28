#include "script_component.hpp"

params ["_ctrlBnts","_ctrlPOS","_subMenu","_interfaceInit"];
_ctrlBnts params ["_bnt_back","_bnt_Ent","_bnt_third","_bnt_result"];

private _vehicle = [] call BCE_fnc_get_TaskCurUnit;

private _cateClass = [] call BCE_fnc_get_BCE_TaskCateClass; //- AIR, GND, OTH
private _width = _ctrlPOS # 2;
private _SelBnts =+ _ctrlBnts;

//- Check for button style
private _condition = switch (_cateClass) do {
  case "GND": {
    _bnt_third ctrlshow false;
    _width = (_ctrlPOS # 2) * 4/3;
    _SelBnts = [_bnt_back,_bnt_Ent,_bnt_result];

		private _curMSN = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
		_curMSN params [["_taskData",""]];
		
		if (
			_taskData == "" || //- #NOTE - mission doesn't exist
			_subMenu != "Task_CFF_Action" //- must be "Task_CFF_Action" menu
		) exitWith {false};

		//- RETURN
		_taskData call BCE_fnc_CFF_Mission_CheckActive;
  };
  default {
    _bnt_third ctrlshow true;

		//- RETURN
		(_vehicle getVariable ["BCE_Task_Receiver",""]) != "";
  };
};

//- Arrange Bottons layout
  {
    _x ctrlSetPositionX (_width * _forEachIndex);
    _x ctrlSetPositionW _width;
    _x ctrlCommit 0;
  } forEach _SelBnts;

//-Style Switching
_bnt_Ent ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select _condition);
_bnt_Ent ctrlSetBackgroundColor ([
  [
    (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
    (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
    (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
    0.8
  ],[
    1,0,0,0.5
  ]
] select _condition);

_bnt_result ctrlSetStructuredText parseText QSTRUCTURE_IMAGE(Core,data\list.paa);
_bnt_result ctrlSetBackgroundColor ((["R","G","B"] apply {1 - (profilenamespace getvariable ('GUI_BCG_RGB_' + _x))}) + [0.5]);
