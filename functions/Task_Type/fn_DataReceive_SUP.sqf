// params ["_taskVar","_curLine","_shownCtrls"];
#define GetGRID(POS,GRID) [POS,GRID] call BCE_fnc_POS2Grid

switch _curLine do {
	//-DESC
	case 3:{
		// #NOTE - Suppression 3mins, 4 rounds per minute, HE in Effect
		_shownCtrls params ["_Checkboxes","","_rounds","","_SkipAdjust","_MinSec","_StructText","_outputText"];
			
		private _taskVar_3 = _taskVar # 3;
		private _varStore = _taskVar_3 param [2, [[],[]]];

		//- ex. ["NA",[],[[8,1,8],[1,1,1,1,0]]]
		_varStore params ["_SUP_vals","_SUP_Checks"];
		_SUP_Checks params ["_duration_C","_rounds_C","_interval_C","_SkipAdjust_C","_MinSec_C"];

		//- Get weapon info (if "_interval_C" is checked)
		private _reloadTime = if (_interval_C == 1) then {

				private _taskUnit = [
					nil,
					"GND" call BCE_fnc_get_TaskCateIndex
				] call BCE_fnc_get_TaskCurUnit;

				private _gunner = gunner _taskUnit;
				private _turret = _taskUnit unitTurret _gunner;
				private _weapon = _taskUnit currentWeaponTurret _turret;
				private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;

				// - Get Reload time from CfgWeapons
					[
						_weaponCfg >> currentWeaponMode _gunner,
						"reloadTime",
						getNumber (_weaponCfg >> "reloadTime")
					] call BIS_fnc_returnConfigEntry;
			} else {
				60
			};

			//- Roll back to default reload time if not exist
			if (_reloadTime == 0) then {
				_reloadTime = 60;
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
			"Total : %1 Shell(s) & %2 Rnd(s)", //- Total (Shots / Rounds)
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

private _taskVar_0 = _taskVar # 0;
private _taskVar_3 = _taskVar # 3;

//- Overwrite the IE round counts
	if (
		_curLine == 3 && 
		((_taskVar_3 # 0) != "NA") && 
		((_taskVar_0 # 0) != "NA")
	) then {
		(_taskVar_3 # 1) params ["","_rounds_V"];
		
		private _setUpVal = _taskVar_0 param [3,[]];
		private _Wpn_setup_IE = _setUpVal param [0,[]];
		
		_Wpn_setup_IE set [3,_rounds_V];
		
			_setUpVal set [0,_Wpn_setup_IE];
			_taskVar_0 set [3,_setUpVal];
		_taskVar set [0, _taskVar_0];
	};