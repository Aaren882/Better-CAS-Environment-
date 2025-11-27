params ["_taskUnit","_taskVar","_curLine","_shownCtrls"];
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
			_x params ["_lbAmmo","_lbFuze","_lbFireUnits","_editRounds","_editFuzeVal"];

			if (isNull _lbAmmo) then {continue};
			
			//-Get Data
				private _fireAmmo = _lbAmmo lbData (lbCurSel _lbAmmo);
				private _data = _mapValue getOrDefault [_fireAmmo, []];
				_data params ["",["_maxMagazine",1],"_count", "",["_ammoType",""]];

				private _fireUnitSel = lbCurSel _lbFireUnits;
				private _FuseSel = lbCurSel _lbFuze;

				private _fireUnits = 1 max (_lbFireUnits lbValue _fireUnitSel);

				//- #NOTE - They will keep shooting
				private _setCount = floor (_count / _maxMagazine);

				//- #TODO - Check ordnance available fuzes
					private _fuzeInfos = if (_ammoType == "HE") then {
						_lbFuze ctrlShow true;
						// _editFuzeVal ctrlShow true; #LINK - functions/Task_Type/fn_SelChanged_ADJ.sqf

						[_lbFuze lbData _FuseSel, parseNumber (ctrlText _editFuzeVal)];
					} else {
						_lbFuze ctrlShow false;
						_editFuzeVal ctrlShow false;

						[_ammoType, 0]
					};
				_fuzeInfos params ["_FuseData", "_fuzeVal"];
			
			//- Save Selections
			_storeVal set [ //- for UI selection recover
				_forEachIndex,
				[lbCurSel _lbAmmo,_FuseSel,_fireUnitSel,str _setCount,str _fuzeVal]
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
				"%1%2 - x%3:%4",
				_fireAmmo, //- Ammo
				[
					format [" (%1)", _FuseData],
					""
				] select (_FuseData == ""), //- Fuze
				_fireUnits,
				_setCount
			];
			_textVal pushBack _text;

		} forEach [
			[_CTAmmo,_CTFuse,_CTFireUnits,_CTRounds,_CTFuzeVal],
			[_IA_ammo,_IA_fuse,_IA_fireUnits,_IA_rounds,_IA_fuzeVal]
		];

		private _angleType = _fireAngle getVariable ["Mode", true];
		
		_fireAngle ctrlSetStructuredText parseText localize ([
			"STR_BCE_LO_Angle",
			"STR_BCE_HI_Angle"
		] select _angleType);
		_storeVal set [2, _angleType];
		
		private _result = [
			_textVal joinString "/",
			_taskType lbData (lbCurSel _taskType),
			_storeVal,
			_setUpVal,
			_angleType //- "false = Low Angle" / "true = High Angle"
		];
		
		_taskVar set [0,_result];
	};

	default BCE_fnc_DataReceive_SUP;
};
