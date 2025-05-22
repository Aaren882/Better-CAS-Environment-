/*
  NAME : BCE_fnc_CFF_Action
*/
params ["_taskUnit","_gunner","_weapon","_turret","_magsToAdd","_otherMags","_CFF_info"];

//- #TODO - Integrate 
/* private _abort = false;
private _endMission = false;
private _checkFire = false; */

//- FROM "StartMission.sqf"

//- Check Mission exist
  if (!isNil{_taskUnit getVariable "BCE_CFF_MISSION_PROGRESS"}) exitWith {
    hint "MISSION PROGRESS !!";
  };

// Set crew properties.
  /* {
    _x disableAI "TARGET";
    _x disableAI "AUTOTARGET";
  } forEach crew _taskUnit; */

//- Execute Fire Mission (wait 2 Seconds)
  [
    {
      params ["_taskUnit","_weapon","_CFF_info"];
      _CFF_info params ["_random_POS","_lbAmmo","_setCount","_angleType"/*,"_radius","_fuzeData","_Control_Function"*/];
      
      // private _group = group _taskUnit;
      _taskUnit setVariable ["BCE_CFF_MISSION_PROGRESS",0];
      ["CFF_MSN",_CFF_info,_taskUnit] call BCE_fnc_set_CFF_Value;

      //- Setup First Round
      private _chargesArray = [_taskUnit, _lbAmmo, AGLToASL _random_POS, _angleType, _weapon] call BCE_fnc_GetAllCharges;
      [_taskUnit, AGLToASL _random_POS, _chargesArray] call BCE_fnc_findCharge;

      //- Add Fired EH
        _taskUnit addEventHandler ["Fired", {
          params ["_taskUnit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

          //- Check rounds completed 
            private _CFF_info = ["CFF_MSN",[],_taskUnit] call BCE_fnc_get_CFF_Value;
            _CFF_info params ["_random_POS","_lbAmmo","_setCount","_angleType","_radius","_fuzeData","_Control_Function"];

          private _current = _taskUnit getVariable ["BCE_CFF_MISSION_PROGRESS",0];
          _current = _current + 1;

          //- #NOTE - Save fuzeData
            private _pos = [
              [
                [_random_POS, _radius max 0]
              ],
              []
            ] call BIS_fnc_randomPos;

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
            _taskUnit setVariable ["BCE_CFF_MISSION_PROGRESS",nil];
            _taskUnit removeEventHandler [_thisEvent, _thisEventHandler];
          };
        }];
    },
    [_taskUnit,_weapon,_CFF_info],
    2 + (random 0.2)
  ] call CBA_fnc_waitAndExecute;