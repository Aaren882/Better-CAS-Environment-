#include "script_component.hpp"

/*
	NAME : BCE_fnc_ATAK_onFireAdjusted
*/

params ["_group","_adjustType","_adjustVec","_isOnLoad"];

switch (true) do {
	case (_adjustType == "POLAR" || _adjustType == "GUNLINE"): {
		private _indecator = _group controlsGroupCtrl 5001;
		private _adjustBnt = _group controlsGroupCtrl 5002;

		_adjustVec params ["_x","_y"];

		private _LR = [1,-1] select (_x < 0);
		private _result = _LR * acos ([0,1] vectorCos _adjustVec); //- Get Vector

		//- Update Vector
		_adjustVec = _adjustVec vectorMultiply 10;
		private _text = format [
			"%3 %1 m | %4 %2 m",
			_adjustVec # 1,
			_adjustVec # 0,
			//- #NOTE : Arrows for Adjust fire
			[
				QSTRUCTURE_IMAGE(Core,data\Arrows\Point_Arrow.paa),
				QSTRUCTURE_IMAGE(Core,data\Arrows\Point_Arrow_D.paa)
			] select (_y < 0),
			[
				QSTRUCTURE_IMAGE(Core,data\Arrows\Point_Arrow_R.paa),
				QSTRUCTURE_IMAGE(Core,data\Arrows\Point_Arrow_L.paa)
			] select (_x < 0)
		];

		_indecator ctrlSetText format [
			QPATHTOEF(Core,data\Arrows\%1.paa),
			["thin_Arrow","center"] select (_adjustVec isEqualTo [0,0])
		];

		//- Update Indications
			_indecator ctrlSetAngle [_result,0.5, 0.5,false];
			_indecator ctrlCommit ([0.15, 0] select _isOnLoad);

			_adjustBnt ctrlSetStructuredText parseText _text;
	};
	case (_adjustType == "IMPACT"): {
		
		if (_isOnLoad) then {
			_adjustVec params [["_dir",""],["_dist",""]];

			private _edit_DIR = _group controlsGroupCtrl 150;
			private _edit_DIST = _group controlsGroupCtrl 160;

			_edit_DIR ctrlSetText _dir;
			_edit_DIST ctrlSetText _dist;
			
			//- Add Eventhandlers
			_edit_DIR ctrlAddEventhandler ["EditChanged", {
				params ["_control", "_newText"];
				
				private _group = ctrlParentControlsGroup _control;
				private _AdjustBnt = _group controlsGroupCtrl 5003;
				
				private _ctrlValues = ["IMPACT"] call BCE_fnc_get_FireAdjustValues;
				_ctrlValues set [0, _newText];

				[_AdjustBnt,_ctrlValues] call BCE_fnc_UpdateFireAdjust;
			}];
			_edit_DIST ctrlAddEventhandler ["EditChanged", {
				params ["_control", "_newText"];
				
				private _group = ctrlParentControlsGroup _control;
				private _AdjustBnt = _group controlsGroupCtrl 5003;
				
				private _ctrlValues = ["IMPACT"] call BCE_fnc_get_FireAdjustValues;
				_ctrlValues set [1, _newText];

				[_AdjustBnt,_ctrlValues] call BCE_fnc_UpdateFireAdjust;
			}];
		};
	};
};
