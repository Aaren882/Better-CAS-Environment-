/*
  NAME : BCE_fnc_CFF_Action

  PARAMS :
    "_unit"     - Unit to perform the action
    "_weapon"   - Weapon to use for the mission
    "_MSN_Key"  - Key for the mission
    "_delay"    - Delay before executing the mission (default 2 seconds)
		"_isMsger"  - Is the unit the messager (default true)

  Description:
    Do Artillery Mission for individuals
    
    Handles the logic for an Adjust Fire mission in Call for Fire.
    This includes setting up the initial shot, handling subsequent shots based on sheaf information,
    and managing the mission progress.
*/
params ["_unit","_weapon","_MSN_Key",["_delay",10 + (random 3)],["_isMsger",true]];

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

// #SECTION Vailding mission can be executed
	//- Check _taskUnit
		if !(alive _taskUnit) exitWith {
			["""_taskUnit"" doesn't exist."] call BIS_fnc_error;
		};

	//- Check Mission exist
		if (0 > (["MSN_PROG", -1, _taskUnit] call BCE_fnc_get_CFF_Value)) exitWith {
			if (_isMsger) then {
				[_taskUnit, localize "STR_BCE_CFF_MSG_MISSION_PROGRESS", "CFF_IN_PROGRESS"] call BCE_fnc_Send_Task_RadioMsg;
			};
		};

	//- Save Mission Values
		["CFF_MSN", _MSN_Key, _taskUnit] call BCE_fnc_set_CFF_Value;
		["CFF_STATE", true, _taskUnit] call BCE_fnc_set_CFF_Value;
		["MSN_PROG", 0, _taskUnit] call BCE_fnc_set_CFF_Value; //- Make sure the Mission is applied.
		["CFF_Action", _thisScript, _taskUnit] call BCE_fnc_set_CFF_Value;
		["CFF_MSGER", _isMsger, _taskUnit] call BCE_fnc_set_CFF_Value; //- #NOTE - Set Messager

	//- #ANCHOR - Send Msg
		if (_isMsger) then {
			[_taskUnit, localize "STR_BCE_CFF_MSG_RECEIVED", "CFF_RECEIVED"] call BCE_fnc_Send_Task_RadioMsg;
		};

//#!SECTION
//- Additional Delay time
  private _customDelay = ["ADD_Delay", 0, _taskUnit] call BCE_fnc_get_CFF_Value;
  if (_customDelay > 0) then {
    ["ADD_Delay", nil, _taskUnit] call BCE_fnc_set_CFF_Value;
    _delay = _delay + _customDelay;
  };

//- Add Fired EH
	if (0 > ["MSN_FIRE_EH",-1,_taskUnit] call BCE_fnc_get_CFF_Value) then {
		private _ehID = _taskUnit addEventHandler ["Fired", {
			params ["_taskUnit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

			//- Check rounds completed 
				private _MSN_Key = ["CFF_MSN","",_taskUnit] call BCE_fnc_get_CFF_Value;
				private _MSN_NAME = ["CFF_MSN",_MSN_Key] joinString ":";
				private _CFF_info = [_taskUnit,_MSN_Key] call BCE_fnc_getCurUnit_CFF;
				private _isMsger = ["CFF_MSGER", false, _taskUnit] call BCE_fnc_get_CFF_Value;
				_CFF_info params [
					"_random_POS",
					"_lbAmmo",
					"_setCount",
					"_angleType",
					"_fuzeData",
					"_MOC_Function",
					"_Sheaf_Info",
					["_MSN_RECUR",[0,60]] //- #NOTE - [ROUNDS, Interval]
				];

			//- Check Ammo
				private _AmmoCount = _taskUnit magazineTurretAmmo [_magazine, _taskUnit unitTurret _gunner];
				private _hasAmmo = _AmmoCount > 0;

			//- "MSN_PROG" Progression of Mission
			private _current = ["MSN_PROG", 0, _taskUnit] call BCE_fnc_get_CFF_Value;
			_current = _current + 1;
			
			//- on Fired first round
				if (_current == 1 && _isMsger) then {
					[_taskUnit,format [localize "STR_BCE_CFF_MSG_SHOT", _MSN_Key], "CFF_SHOT"] call BCE_fnc_Send_Task_RadioMsg;

					private _chargeInfo = ["chargeInfo",[],_taskUnit] call BCE_fnc_get_CFF_Value;
					[_taskUnit,_chargeInfo param [2,-1],_MSN_Key] spawn {
						params ["_taskUnit", "_ETA","_MSN_Key"];
						if (_ETA < 0) exitWith {};
						sleep (_ETA - 5); //- Wait
						if (!alive _taskUnit) exitWith {};
						[_taskUnit, format [localize "STR_BCE_CFF_MSG_SPLASH", _MSN_Key], "CFF_SPLASH"] call BCE_fnc_Send_Task_RadioMsg;
					};
				};

			private _pos = _random_POS getPos (_Sheaf_Info param [_current, [0,0]]);
			_pos set [2,0];
			
			//- set Fuze trigger
				[_projectile, _fuzeData] call BCE_fnc_FuzeInit;

				//- #NOTE - Check "TRANS" (Transform) Ammo type
					if ("TRANS" == (_ammo call BCE_fnc_getAmmoType)) then {
						_projectile addEventHandler ["SubmunitionCreated", {
							params ["_projectile", "_submunitionProjectile"];
							(getShotParents _projectile) params ["_taskUnit", ""];

							[
								_taskUnit,
								_submunitionProjectile,
								_projectile
							] call BCE_fnc_FuzeTrigger;
						}];
					} else {
						[_taskUnit, _projectile] call BCE_fnc_FuzeTrigger;
					};
				
			//- Next round
			if (
				_current < _setCount &&
				_CFF_info findIf {true} > -1 &&
				_hasAmmo
			) then {
				["MSN_PROG", _current, _taskUnit] call BCE_fnc_set_CFF_Value;

				//- Prepare next round
					private _chargeInfo = [_taskUnit, _lbAmmo, AGLToASL _pos, _angleType, _weapon] call BCE_fnc_getCharge;
					[_taskUnit, _chargeInfo] call BCE_fnc_doAim_CFF;
			} else {
				_MSN_RECUR params [["_RECUR_COUNT",0],["_RECUR_INTERVAL",60]];
				
				//- Finish CFF MSN
				[["MSN_PROG","CFF_STATE"], nil, _taskUnit] call BCE_fnc_set_CFF_Value;

				//- Recursion (FOR SUPPRESSION)
					if (_RECUR_COUNT > 0 && _hasAmmo) then {
						_MSN_RECUR set [0, _RECUR_COUNT - 1];
						_CFF_info set [7, _MSN_RECUR];
						[_MSN_NAME, _CFF_info, _taskUnit] call BCE_fnc_set_CFF_Value;
						
						[
							_taskUnit,
							_weapon,
							_MSN_Key,
							_RECUR_INTERVAL,
							_isMsger
						] spawn BCE_fnc_CFF_Action;
					} else {
						/* //- Remove Stored infos
						[["chargeInfo","MSN_FIRE_EH"], nil, _taskUnit] call BCE_fnc_set_CFF_Value; */
						
						//- #LINK - functions/CAS_Menu/Call_for_Fire/fn_CFF_Mission_STOP.sqf
						//- Remove Task From Unit (FULL DELETE)
							_taskUnit removeEventHandler [_thisEvent, _thisEventHandler];
							[{
								_this setVariable ["#CFF_MSN_Data", nil];
							}, _taskUnit] call CBA_fnc_execNextFrame;
							
							_taskUnit call BCE_fnc_UnstuckUnit;

						if (_isMsger) then {
							[_taskUnit, format [localize "STR_BCE_CFF_MSG_COMPLETED", _MSN_Key], "CFF_COMPLETED"] call BCE_fnc_Send_Task_RadioMsg;
						};
					};
			};
		}];

		//- Save EH ID
		["MSN_FIRE_EH", _ehID, _taskUnit] call BCE_fnc_set_CFF_Value;
	};

  

sleep _delay;
//- #SECTION - Setup CFF Mission
  private _CFF_info = [_taskUnit, _MSN_Key] call BCE_fnc_getCurUnit_CFF;
    if (count _CFF_info == 0) exitWith {};

  _CFF_info params ["_random_POS","_lbAmmo","_setCount","_angleType","","_MOC_Function","_Sheaf_Info"];

//- Replace MOC with "At-Ready"
  if (
    _MOC_Function != "BCE_fnc_CFF_AT_READY"
  ) then {
		private _MSN_NAME = ["CFF_MSN",_MSN_Key] joinString ":";
    _CFF_info set [5, "BCE_fnc_CFF_AT_READY"]; //- So the shells can rain like crazy
    [_MSN_NAME, _CFF_info, _taskUnit] call BCE_fnc_set_CFF_Value;
  };

//- #NOTE - Specify TG POS
	private _TGPOS = _random_POS getPos (_Sheaf_Info param [0, [0,0]]); //- Starts from first Sheaf POS;
	_TGPOS set [2,0];

//- Setup First Round
	private _chargeInfo = [
		_taskUnit,
		_lbAmmo,
		AGLToASL _TGPOS,
		_angleType,
		_weapon
	] call BCE_fnc_getCharge;

//- #ANCHOR - Start aimming
	[_taskUnit, _chargeInfo] call BCE_fnc_doAim_CFF;

// #!SECTION