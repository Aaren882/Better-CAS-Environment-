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

private _taskUnit_Grp = group _taskUnit;
private _CFF_Map = _taskUnit_Grp getVariable ["BCE_CFF_Task_Pool", createHashMap];

//- Get current CFF mission infos
  private _curMSN = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
  _curMSN params [["_taskData",""]];

/* (_CFF_Map get _taskData) params [
  "_MSN_Type",
  "_TG_Grid",
  "_requester",
  "_MSN_infos",
  ["_MSN_State",0]
]; */
private _taskValues = _CFF_Map get _taskData;

/* _MSN_infos params [
  "_Wpn_setup_IE",
  "_Wpn_setup_IA",
  "_random_POS"
]; */

//- Convert #NOTE - Convert into index
  private _result = switch (_key) do {
    case "MSN_STATE": {4};
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
  };

if (isnil{_result}) exitWith {};

//- Update Value
  _taskValues set [_result, _value];
  _CFF_Map set [_taskData, _taskValues];

  _taskUnit_Grp setVariable ["BCE_CFF_Task_Pool", _CFF_Map];