// params ["_taskVar","_curLine","_shownCtrls"];
#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid

switch _curLine do {
	//- Game Plan
	case 0:{
		_shownCtrls params [
			"_taskType",
			"_CTAmmo","_CTFuse","_CTFireUnits","_CTRounds","_CTFuzeVal","_fireAngle",
			"_IA_ammo","_IA_fuse","_IA_fireUnits","_IA_rounds","_IA_fuzeVal"
		];

		private _textVal = [];
		private _storeVal = (_taskVar # 0) param [2,[]]; 		//- ["IEs","IAs","fireAngle"]
		private _setUpVal = [];
		private _mapValue = _CTAmmo getVariable ["CheckList",createHashMap];

		{
			_x params ["_lbAmmo","_lbFuse","_lbFireUnits","_editRounds","_editFuzeVal"];

			//-Get Data
				private _fireAmmo = _lbAmmo lbData (lbCurSel _lbAmmo);
				private _fireUnitSel = lbCurSel _lbFireUnits;
				private _FuseSel = lbCurSel _lbFuse;
				private _FuseData = _lbFuse lbData _FuseSel;

				private _fireUnits = 1 max (_lbFireUnits lbValue _fireUnitSel);
				private _setCount = parseNumber (ctrlText _editRounds);
				private _fuzeVal = parseNumber (ctrlText _editFuzeVal);

				private _data = _mapValue get _fireAmmo;
				_data params ["",["_maxMagazine",1],"_count"];

				//- Check Ammo Count
				if (_fireAmmo != "" && _setCount > 0) then {
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
					_setCount = 0;
					_editRounds ctrlSetText "";
				};
			
			//- Save Selections
			_storeVal set [ //- for UI selection recover
				_forEachIndex,
				[
					lbCurSel _lbAmmo,
					_FuseSel,
					_fireUnitSel,
					["", str _setCount] select (_setCount > 0),
					str _fuzeVal
				]
			];

			//- for Data transfer
				private _valueCheck = [
					[_fireAmmo,""],
					[_FuseData,""],
					[_fireUnits,0],
					[_setCount,0],
					[_fuzeVal,0]
				] apply {
					[_x # 0, nil] select (
						(_x # 0) == (_x # 1) &&
						_forEachIndex == 1
					)
				};
				_setUpVal set [ 
					_forEachIndex,
					_valueCheck
				];

			private _text = format [
				"%1 (%2) - x%3:%4",
				_fireAmmo, //- Ammo
				_FuseData, //- Fuze
				_fireUnits,
				_setCount
			];
			_textVal pushBack _text;

		} forEach [
			[_CTAmmo,_CTFuse,_CTFireUnits,_CTRounds,_CTFuzeVal],
			[_IA_ammo,_IA_fuse,_IA_fireUnits,_IA_rounds,_IA_fuzeVal]
		];

		private _taskTypeSel = lbCurSel _taskType;
		private _angleType = _fireAngle getVariable ["Mode", true];
		
		_fireAngle ctrlSetStructuredText parseText localize ([
			"STR_BCE_LO_Angle",
			"STR_BCE_HI_Angle"
		] select _angleType);
		_storeVal set [2, _angleType];

		private _result = [
			_textVal joinString "/",
			[_taskTypeSel, _taskType lbData _taskTypeSel],
			_storeVal,
			_setUpVal,
			_angleType //- "false = Low Angle" / "true = High Angle"
		];
		
		_taskVar set [0,_result];
	};

	//-DESC
	case 3:{
		// #NOTE - Suppression 3mins, 4 rounds per minute, HE in Effect
		_shownCtrls params ["_Checkboxes","","_rounds","","_SkipAdjust","_MinSec","_StructText","_outputText"];
			
		private _taskVar_3 = _taskVar # 3;
		private _varStore = _taskVar_3 param [2, [[],[]]];

		//- ex. ["NA",[],[[8,1,8],[1,1,1,1,0]]]
		_varStore params ["_SUP_vals","_SUP_Checks"];
		_SUP_Checks params ["_duration_C","_rounds_C","_interval_C","_SkipAdjust_C","_MinSec_C"];

		private _taskUnit = [
			nil,
			"GND" call BCE_fnc_get_TaskCateIndex
		] call BCE_fnc_get_TaskCurUnit;

		//- Get weapon info
			private _gunner = gunner _taskUnit;
			private _turret = _taskUnit unitTurret _gunner;
			private _weapon = _taskUnit currentWeaponTurret _turret;
			private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;
		
		private _reloadTime = [ // - Get Reload time from CfgWeapons
			_weaponCfg >> currentWeaponMode _gunner,
			"reloadTime",
			getNumber (_weaponCfg >> "reloadTime")
		] call BIS_fnc_returnConfigEntry;

		//- default reload time
		if (_reloadTime == 0) then {
			_reloadTime = 10;
		};

		//- #NOTE - ["DURATION (min)","ROUNDS","INTERVAL (min)"]
		private _result =+ _SUP_vals;
		private _default_Val = [1,1,([_reloadTime/60, _reloadTime] select (_MinSec_C == 1))];
		{
			if (_x == 1) then {continue};
			_result set [
				_forEachIndex,
				_default_Val # _forEachIndex //- Defaults
			];
		} forEach (_SUP_Checks select [0,3]);

		_result params ["_duration_V","_rounds_V","_interval_V"];

		//- ex. 30 sec => 30/60 = 0.5 min
			private _inval = _interval_V / ([1,60] select (_MinSec_C == 1));
			private _rnds_Cnt = floor (_duration_V / _inval); //- ex. 3 min 3 rounds every 30sec
			private _maxRounds = floor ((_inval * 60) / _reloadTime); //- Max shells for each interval
		
		//- #NOTE - Replace Rounds (if reach maximum)
			if (_rounds_V > _maxRounds) then {
				_result set [1, _rounds_V];
				_rounds ctrlSetText str _rounds_V;
				
				_rounds_V = _maxRounds;
			};
			
		//- Check if the "duration" and "interval" are reasonable.
		if (
			( //- Both duration and Interval have to be checked
				_duration_C == 1 &&
				_interval_C == 1
			) && 
				//- ex. 3mins, per 8 minute => 3/8 = 0.375 [❌]
				_rnds_Cnt < 1
		) exitWith {
			systemChat "Duration and Interval setup doesn't make sense...";
			_outputText ctrlSetText "--";
		};

		_rnds_Cnt = [
			5,
			_rnds_Cnt
		] select (_duration_C == 1);
		_result pushBack _rnds_Cnt; //- PushBack how many rounds will be executed

		_outputText ctrlSetText format [
			"%1 Shell(s)/Rnd -- %2 Rnd(s)",
			round _rounds_V * _rnds_Cnt,
			_rnds_Cnt
		];

		//- Output how many shell will be shot
			private _output = (ctrlText _StructText) + ([""," - FFE"] select (_SkipAdjust_C == 1));
		
		//- Set Values
			_taskVar_3 set [0, _output];
			_taskVar_3 set [1, _result];
		_taskVar set [3, _taskVar_3];
	};

	default { //- By Default
		call BCE_fnc_DataReceive_ADJ;
	};
};