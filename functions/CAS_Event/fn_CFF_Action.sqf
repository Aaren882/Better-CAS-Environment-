/*
  NAME : BCE_fnc_CFF_Action

  Do Artillery Mission for individuals
*/
params ["_unit","_weapon","_MSN_Key",["_delay",2 + (random 0.2)]];

private _taskUnit = switch (typeName _unit) do {
  case "STRING": {
    private _obj = objNull;
    {
      if (_unit == str _x) exitWith {_obj = _x};
    } count vehicles;
    _obj
  };
  case "OBJECT": {_unit};
  default {objNull};
};

//- #TODO - Integrate 
/* private _abort = false;
private _endMission = false;
private _checkFire = false; */

//- FROM "StartMission.sqf"

//- Check _taskUnit
  if (isNull _taskUnit) exitWith {
    ["_taskUnit doesn't exist."] call BIS_fnc_error;
  };

//- Check Mission exist
  if (!isNil{_taskUnit getVariable "BCE_CFF_MISSION_PROGRESS"}) exitWith {
    systemChat "MISSION PROGRESS !!";
  };

//- Execute Fire Mission (wait 2 Seconds)
  [
    {
      params ["_taskUnit","_weapon","_MSN_Key"];

      //- Get CFF Mission Info
      private _CFF_info = [["CFF_MSN",_MSN_Key] joinString ":",[],_taskUnit] call BCE_fnc_get_CFF_Value;
        if (count _CFF_info == 0) exitWith {};

      _CFF_info params ["_random_POS","_lbAmmo","_setCount","_angleType","","","_Sheaf_Info"];
      
      _taskUnit setVariable ["BCE_CFF_MISSION_PROGRESS",0];
      
      //- Save Mission Values
        ["CFF_MSN", _MSN_Key, _taskUnit] call BCE_fnc_set_CFF_Value;

      //- #NOTE - Specify TG POS
      private _TGPOS = _random_POS getPos (_Sheaf_Info param [0, [0,0]]); //- Starts from first Sheaf POS;
      _TGPOS set [2,0];
      
      //- Setup First Round
      private _chargesArray = [_taskUnit, _lbAmmo, AGLToASL _TGPOS, _angleType, _weapon] call BCE_fnc_GetAllCharges;
      [_taskUnit, AGLToASL _TGPOS, _chargesArray] call BCE_fnc_findCharge;

      //- Add Fired EH
        _taskUnit addEventHandler ["Fired", {
          params ["_taskUnit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

          //- Check rounds completed 
            private _MSN_Key = ["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value;
            private _CFF_info = [["CFF_MSN",_MSN_Key] joinString ":", [], _taskUnit] call BCE_fnc_get_CFF_Value;
            _CFF_info params ["_random_POS","_lbAmmo","_setCount","_angleType","_fuzeData","_MOC_Function","_Sheaf_Info"];

          private _current = _taskUnit getVariable ["BCE_CFF_MISSION_PROGRESS",0];
          private _pos = _random_POS getPos (_Sheaf_Info param [_current, [0,0]]);
          _pos set [2,0];
          _current = _current + 1;
            
          //- #NOTE - Save fuzeData
            /* _pos = [
              [
                [_pos, 0] //- ["POS", "CEP"]
              ],
              []
            ] call BIS_fnc_randomPos; */

            //- set Fuze trigger
              [_taskUnit, _fuzeData, _pos] call BCE_fnc_FuzeInit;
              call BCE_fnc_FuzeTrigger;

          //- Next round
          if (_current < _setCount && _CFF_info findIf {true} > -1) then {
            _taskUnit setVariable ["BCE_CFF_MISSION_PROGRESS",_current];

            //- Prepare next round
              private _chargesArray = [_taskUnit, _lbAmmo, AGLToASL _pos, _angleType, _weapon] call BCE_fnc_GetAllCharges;
              [_taskUnit, AGLToASL _pos, _chargesArray] call BCE_fnc_findCharge;
          } else {
            //- Finish CFF MSN
            ["NextFuze",nil,_taskUnit] call BCE_fnc_set_CFF_Value;
            (gunner _taskUnit) doWatch objNull;
            _taskUnit setVariable ["BCE_CFF_MISSION_PROGRESS",nil];
            _taskUnit removeEventHandler [_thisEvent, _thisEventHandler];
            _taskUnit sideChat "Rounds Completed."
          };
        }];
    },
    [_taskUnit,_weapon,_MSN_Key],
    _delay
  ] call CBA_fnc_waitAndExecute;