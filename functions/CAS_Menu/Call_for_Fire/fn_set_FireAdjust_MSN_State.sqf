/*
  NAME : BCE_fnc_set_FireAdjust_MSN_State

  Set CFF mission current value
  [
    "MSN_STATE" : 0,1,2.... #LINK - functions/Task_Type/fn_DataSent_CFF.sqf
  ]
*/
params ["_key","_value",["_Control",controlNull]];

//- Check Task Unit 
private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
if (isnull _taskUnit) exitWith {};

//- Get current CFF mission infos
  private _curMSN = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
  _curMSN params [["_taskData",""]];


private _taskValues = _taskData call BCE_fnc_CFF_Mission_Get_Values;
_taskValues params [
  "_MSN_Type",
  "_TG_Grid",
  "_requester",
  "_MSN_infos",
  ["_MSN_State",0]
];

//- Convert #NOTE - Convert into index
  private _changeIndex = switch (_key) do {
    // case "MSN_STATE": {4}; //- Set "Fire for Effect"
    case "MSN_ADJUST_POLAR": { //- "POLAR ADJUST"
      
      private _cur = ["Adjust", "0,0"] call BCE_fnc_get_FireAdjustValues;
      private _curAdjust = (_cur splitString ",") apply {parseNumber _x};
      _Control call BCE_fnc_CleanFireAdjustValues; //- Clear ADJUST Value

      private _FO = call CBA_fnc_currentUnit;
      private _TG_POS = (_taskValues # 1) call BCE_fnc_Grid2POS;
      private _MSN_infos = _taskValues # 3;
      private _random_POS = _MSN_infos # 2;
      
      private _dirY = _FO getDir _TG_POS;
      private _adjustPOS = [0,0,0];
      {
        private _pos = _random_POS getPos [_x * 10, [_dirY + 90,_dirY] select (_forEachIndex == 1)];
        _adjustPOS set [_forEachIndex, _pos # _forEachIndex];
      } forEach _curAdjust;

      //-Replace POS Value
      _MSN_infos set [2, _adjustPOS];
      _value = _MSN_infos;
      3
    };
		//- #TODO - Add GunLine & Impact Point adjustment medthods
  };

if (isnil{_changeIndex}) exitWith {};

//- Update Value
  if ( //-- Must be set Fire Adjustment
    _changeIndex == 3 &&
    _taskData == (["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value)
  ) then {
    ["ADD_Delay",5,_taskUnit] call BCE_fnc_set_CFF_Value;
  };

_taskValues set [_changeIndex, _value];
[
	"Send",
	_taskUnit,
	[_taskData,_taskValues,_taskUnit]
] call BCE_fnc_Send_MSN_CFF;