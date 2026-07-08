
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_cTab_ATAK_missions_fnc_ATAK_mission_Init
Description:
		Initializes the mission tab control,
		sets up category selections,
		and defines event handlers for mission tasks.

Parameters:
		_group         - The controls group object housing the mission interface.
		_interfaceInit - Array containing interface initialization parameters.
		_isDialog      - Boolean flag indicating if the mission is running in a dialog.
		_settings      - An object containing panel settings, including the target page and component map.

Returns:
		<NONE>

Author:
		Aaren
---------------------------------------------------------------------------- */

//- #NOTE - Colors for Background
	#define AIR_COLOR [0,0,0.5,0.1]
	#define GND_COLOR [0.13,0.35,0.18,0.05]
	#define DEF_COLOR [0,0,0.5,0.1]

params ["_group",["_interfaceInit",false],"_isDialog","_settings"];
TRACE_1("fnc_ATAK_mission_Init",_this);

//- Create the Correct Mission Builder
	private _cateSel = ["Cate",0] call BCE_fnc_get_TaskCurSetup;
	private _bgCtrl = _group controlsGroupCtrl 20;
  private _category = _group controlsGroupCtrl (17000 + 2102);
  _category lbSetCurSel _cateSel;

//- Add ToolBox EH
  _category ctrlAddEventHandler ["ToolBoxSelChanged", {
		params ["_toolBox","_curSel"];
		
    //- Validate Category
    ["Cate", _curSel] call BCE_fnc_set_TaskCurSetup;
		private _controlGroup = ctrlParentControlsGroup _toolBox;
    private _ctrl = [_controlGroup] call FUNC(ATAK_updateTaskControl);

    //- if error return value
    if (isnull _ctrl) then {
			private _cateSel = ["Cate",0] call BCE_fnc_get_TaskCurSetup;
      ["Cate", _cateSel] call BCE_fnc_set_TaskCurSetup;
    } else {
			private _bgColor = switch (_curSel) do {
				case 0: {AIR_COLOR};
				case 1: {GND_COLOR};
				default {DEF_COLOR};
			};

			private _bgCtrl = _controlGroup controlsGroupCtrl 20;
			_bgCtrl ctrlSetBackgroundColor _bgColor;
		};
  }];

//- Setup Background Color
	private _bgColor = switch (_cateSel) do {
		case 0: {AIR_COLOR};
		case 1: {GND_COLOR};
		default {DEF_COLOR};
	};
	_bgCtrl ctrlSetBackgroundColor _bgColor;

//- Update Task controlGroup
  private _ctrl = [_group,_settings] call FUNC(ATAK_updateTaskControl);

//- Update Scroll value
[
  {
    _this ctrlSetScrollValues [localNamespace getVariable ["BCE_ATAK_Scroll_Value",0], -1];
  }, _ctrl
] call CBA_fnc_execNextFrame;
