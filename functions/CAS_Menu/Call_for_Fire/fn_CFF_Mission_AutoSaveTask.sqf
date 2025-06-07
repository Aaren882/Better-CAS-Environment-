/*
  NAME : BCE_fnc_CFF_Mission_AutoSaveTask
*/
params ["_Key","_control",""];

//- If not initiated
if !((ctrlParentControlsGroup _control) getVariable ["Init",false]) exitWith {};

if !(_Key isEqualType "") exitWith {
  ["Unable to Update CFF Value ""invalid _Key = %1""",_Key] call BIS_fnc_error;
};

[{
	params ["_Key","_control","_input"];

  private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;

  private _values = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
  private _taskID = _values # 0;

  //- Update Inner values
  private _curValues = [_taskID] call BCE_fnc_CFF_Mission_Get_Values;
  _curValues params [
    "_MSN_Type",
    "_TG_Grid",
    "_requester",
    "_MSN_infos",
    ["_MSN_State",0]
  ];
  /*
    _MSN_infos params [
      "_Wpn_setup_IE",
      "_Wpn_setup_IA",
      "_random_POS",
      "_angleType"
    ];
  */

  (_Key splitString "|") params ["_Key",["_index_Str",""]];

  private _result = switch (_Key) do {
    case "MSN_TYPE": {
      //- Update ATAK Interface after value updated
      [{
        [nil,"Task_CFF_Action",-1] call BCE_fnc_ATAK_ChangeTool;
        },[]
      ] call CBA_fnc_execNextFrame;

      [4,_input]
    };
    case "MSN_WPN": { //- #NOTE - "_MSN_infos" only takes [0,1], "Don't use [2]"
      /*
        _lbAmmo 	    <STRING | LB_DATA>
        _lbFuse 	    <STRING | LB_DATA>
        _lbFireUnits	<NUMBER | LB_VALUE>
        _editRounds	  <NUMBER | editText>
        _editFuzeVal	<NUMBER | editText>
      */
      private _index = parseNumber _index_Str;
      private _WPN_Set = _MSN_infos # (1 - _MSN_State);

      private _r = call {
        if (_index == 0 || _index == 1) exitWith { //- Ammo/Fuze
          private _v = _control lbData _input;

          //- Fuze editBox setup
          if (_index == 1) then {
            private _editFuzeVal = "CFF_IE_FuzeValue_Box" call BCE_fnc_getTaskSingleComponent;

            //-  0 : Impact Fuze
            //-  1 : VT Fuze
            //-  2 : Delay Fuze
            private _tip = call {
              if (_v == "VT") exitWith {
                "Burst Height (m)"
              };
              if (_v == "DELAY") exitWith {
                "Delay Time (Sec)"
              };
              ""
            };
            
            _editFuzeVal ctrlSetTooltip _tip;
            _editFuzeVal ctrlShow (_tip != "");
          };

          _v
        };
        if (_index == 2) exitWith { //- fireUnits
          _control lbValue _input
        };
        if (_index == 3) exitWith { //- Rounds
          _WPN_Set params ["_fireAmmo","","_fireUnits","","",""];
        
          private _fireUnits = 1 max _fireUnits;
          private _setCount = 1 max (parseNumber _input); //- #NOTE - Input from here

          //- Check Ammo Count
            if (_fireAmmo != "") then {
              private _lbAmmo = "CFF_IE_WeaponCombo" call BCE_fnc_getTaskSingleComponent;
              private _editRounds = "CFF_IE_Round_Box" call BCE_fnc_getTaskSingleComponent;
              private _mapValue = _lbAmmo getVariable ["CheckList",createHashMap];

              private _data = _mapValue get _fireAmmo;
              _data params ["",["_maxMagazine",1],"_count"];

              private _maxFireEach = floor (_count / _maxMagazine);
              private _maxFireCount = floor (_count / _fireUnits);
              
              if (
                _setCount > _maxFireEach ||
                _setCount > _maxFireCount
              ) then {
                _setCount = _maxFireEach;
                _editRounds ctrlSetText (str _setCount);
              };
            } else {
              _setCount = 1;
              _editRounds ctrlSetText "";
            };
          
          _setCount //- Return
        };

        parseNumber _input //- Return
      };
      _WPN_Set set [_index, _r];
      _MSN_infos set [(1 - _MSN_State), _WPN_Set];
      
      [3,_MSN_infos]
    };
    case "FIRE_ANGLE": { //- Angle of Fire
      //- #NOTE - "false = Low Angle" / "true = High Angle"
      private _angleType = !(_MSN_infos # 3);
      _control ctrlSetStructuredText parseText localize (["STR_BCE_LO_Angle","STR_BCE_HI_Angle"] select _angleType);
      _control setVariable ["Mode", _angleType];
      _MSN_infos set [3, _angleType];

      [3, _MSN_infos]
    };
    default {
      []
    };
  };

  if (count _result == 0) exitWith {};

  //- Update Value
    _curValues set _result;
    [_taskID,_curValues,_taskUnit] call BCE_fnc_CFF_Mission_Set_Values;
  
	}, _this
] call CBA_fnc_execNextFrame;