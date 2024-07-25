params ["_display","_page",["_Back", false]];
private ["_group","_ctrls","_ctrlPOS"];

_group = _display displayCtrl 46600;
_ctrls = allControls _group;
_group ctrlShow _Back;

_ctrlPOS = ctrlPosition _group;
_ctrlPOS set [2, (_ctrlPOS # 2) / 4];

private _return = switch _page do {
	case "mission": {
		_vehicle = player getVariable ['TGP_View_Selected_Vehicle',objNull];
		_condition = (_vehicle getVariable ["BCE_Task_Receiver",""]) != "";

		_bnt_back = _ctrls # 0;
		_bnt_Ent = _ctrls # 1;
		_bnt_result = _ctrls # 3;

		_bnt_Ent ctrlSetPositionX (_ctrlPOS # 2);
		{
			_x ctrlSetPositionW (_ctrlPOS # 2);
			_x ctrlCommit 0;
		} count [
			_bnt_back,
			_bnt_Ent,
			_bnt_result
		];
		
		//-Style Switching
		_bnt_Ent ctrlSetText localize (["STR_BCE_SendData","STR_BCE_Abort_Task"] select _condition);
		_bnt_Ent ctrlSetBackgroundColor ([
			[
				(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
				(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
				(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
				0.8
			],[
				1,0,0,0.5
			]
		] select _condition);

		_bnt_result ctrlSetStructuredText parseText "<img image='a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa' />";
		_bnt_result ctrlSetBackgroundColor ((["R","G","B"] apply {1 - (profilenamespace getvariable ('GUI_BCG_RGB_' + _x))}) + [0.5]);

		4661
	};
	case "mission_Build": {
		_display call BCE_fnc_ATAK_TaskCreate;
		
		_bnt_back = _ctrls # 0;
		_bnt_Ent = _ctrls # 1;
		_bnt_result = _ctrls # 3;
		
		_bnt_Ent ctrlSetPositionX (_ctrlPOS # 2);
		{
			_x ctrlSetPositionW (_ctrlPOS # 2);
			_x ctrlCommit 0;
		} count [
			_bnt_back,
			_bnt_Ent,
			_bnt_result
		];

		_bnt_Ent ctrlSetText localize "STR_BCE_Enter";
		_bnt_Ent ctrlSetBackgroundColor [0,0,0,0.5];

		_bnt_result ctrlSetStructuredText parseText localize "STR_BCE_ClearTaskInfo";
		_bnt_result ctrlSetBackgroundColor [1,0,0,0.5];

		nil
	};
	case "Task_Result": {
		4663
	};
	case "message": {

		//- Arrange Bottons layout
			{
				_x ctrlShow false;
				false
			} count (_ctrls select [2]);

			_bnt_back = _ctrls # 0;
			_bnt_Ent = _ctrls # 1;

			_size = (2 * (_ctrlPOS # 2));

			_bnt_back ctrlSetPositionW _size;
			
			_bnt_Ent ctrlSetPositionX _size;
			_bnt_Ent ctrlSetPositionW _size;

			_bnt_back ctrlCommit 0;
			_bnt_Ent ctrlCommit 0;

		//- Set Color
			_bnt_Ent ctrlSetBackgroundColor [
				(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
				(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
				(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
				0.8
			];
		
		//- Botton Text
			_bnt_Ent ctrlSetText localize "STR_BCE_SendData";

		
				/*_plrList = playableUnits;

				// since playableUnits will return an empty array in single player, add the player if array is empty
				if (_plrList findIf {true} < 0) then {_plrList pushBack cTab_player};
				_validSides = call cTab_fnc_getPlayerSides;

				// turn this on for testing, otherwise not really usefull, since sending to an AI controlled, but switchable unit will send the message to the player himself
				// if (count _plrList < 1) then { _plrList = switchableUnits;};

				uiNamespace setVariable ['cTab_msg_playerList', _plrList];*/
		4650
	};
	default {
		4660
	};
};

// - Return "nil" or "Control Group"
if (isnil {_return}) exitWith {};
_display displayCtrl (17000 + _return)