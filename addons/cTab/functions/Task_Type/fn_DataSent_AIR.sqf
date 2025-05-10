/*
  NAME : BCE_fnc_DataSent_AIR
*/

params ["_taskUnit","_data"];

if (
	!canMove _taskUnit ||
	!alive driver _taskUnit ||
	fuel _taskUnit == 0 ||
	unitIsUAV _taskUnit
) exitWith {false};

_data params [["_IP_POS",[]],["_FAD_POS",[]],"_posTarget",["_EGRS",-1],"_weaponInfo","_taskVar","_type","_drawT_Compon"];
_weaponInfo params ["_WPNclass","_WPN_Mode","_WPN_turret","_WPN_count","_muzzle","_ATK_range","_ATK_height"];

//- Draw T Function (IF FADH doesn't exist)
  if (_FAD_POS findIf {true} < 0) then {
    private _drawT = {
      params ["_from","_FRPOS","_TGPOS"];

      private _HDG = _FRPOS getDirVisual _TGPOS;
      private _POSs = [-90,90] apply {
        _TGPOS getPos [
          3000,
          _HDG + _x
        ]
      };
      // private _dis = _POSs apply {_from distance2D _x};

      (_POSs select ((_from distance (_POSs # 0)) > (_from distance (_POSs # 1))))
    };

    _FAD_POS = _drawT_Compon call _drawT;
    _data set [1, _FAD_POS]; 
  };

//- Fix Egress Heading (if the is invaild)
  if (_EGRS < 0) then {
    _EGRS = round (_posTarget getDirVisual _FAD_POS);
    _data set [3, _EGRS]; 
  };

//- #SECTION - Execution  
private ["_isAVT","_isGunShip","_has_IP","_remarks","_task_info","_grp"];

//- Hint
  _isAVT = !isnull (finddisplay 160);
  if ((_taskUnit getVariable ["BCE_Task_Receiver", ""]) != "") exitWith {
    if (_isAVT) then {
      hint localize "STR_BCE_Error_Unavailable";
    } else {
      [
        "TASK_Builder",
        localize "STR_BCE_Error_Unavailable",
        5
      ] call cTab_fnc_addNotification;
    };
  };

  if (_isAVT) then {
    hint localize "STR_BCE_DataSent";
  } else {
    [
      "TASK_Builder",
      localize "STR_BCE_DataSent",
      5
    ] call cTab_fnc_addNotification;
  };

  //- Receiver
  //-- MP && is Player
  if ((isMultiplayer) && (isplayer _taskUnit)) then {
    [["BCE", "Task_Received"],15,"",35,"",true,false,true] remoteExec ["BIS_fnc_advHint",_taskUnit,true];
  };

_isGunShip = (typeof _taskUnit) in ["B_T_VTOL_01_armed_F","USAF_AC130U"];

//-GunShip #NOTE - Gunship
if (_isGunShip) then {
	[_taskUnit,_posTarget,_ATK_range,_ATK_height] call BCE_fnc_GunShip_Loiter;
};

//-have IP/BP
_has_IP = _IP_POS isNotEqualTo [];

_remarks = switch _type do {
	case 5: {_taskVar # -1};
	case 9:{_taskVar # -1};
};

//-Fix FAD/H if there's nothing
if (((_remarks # 0) == "NA") && !(_has_IP)) then {
	private ["_HDG","_To_Dir","_text"];
	_HDG = round(_posTarget getDirVisual _FAD_POS);
	_To_Dir = [_HDG - 180,360 + (_HDG - 180)] select ((_HDG - 180) < 0);
	_text = format ["“%1” to “%2”",_HDG call BCE_fnc_getAzimuth,_To_Dir call BCE_fnc_getAzimuth];

	_remarks set [0,_text];
	_remarks set [1,_HDG];

  //- Update Device Value
  private _return = ["BCE_TaskBuilding_Enter", [-1]] call CBA_fnc_localEvent;
};

//- Send over Task
  _task_info = str [
    format ["%2 [%3]", localize "STR_BCE_Caller", name player, groupId group player],
    _type,
    _taskVar,
    [daytime] call BIS_fnc_timeToString
  ];
  _taskUnit setVariable ["BCE_Task_Receiver", _task_info, true];

//- #!SECTION

if ((_taskUnit isKindOf "Helicopter") || !(BCE_AI_CAS_Support_fn) || (isplayer _vehicle) || (_isGunShip)) exitWith {};

//- #ANCHOR - For AIs
//- Execute CAS Mission (Execute)
  _data insert [0, [_taskUnit]];
  _data call BCE_fnc_Plane_CASEvent;
