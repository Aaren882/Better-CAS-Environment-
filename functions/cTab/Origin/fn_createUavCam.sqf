/*
	Name: cTab_fnc_createUavCam

	Author(s):
		Gundy

  Edit:
    Aaren

	Description:
		Set up UAV camera and display on supplied render target
		Modified to include lessons learned from KK's excellent tutorial: http://killzonekid.com/arma-scripting-tutorials-uav-r2t-and-pip/

	Parameters:
		0: STRING - Name of UAV (format used from `str uavObject`)
		1: ARRAY  - List of arrays with seats with render targets
			0: INTEGER - Seat
				0 = DRIVER
				1 = GUNNER
			1: STRING  - Name of render target

	Returns:
		BOOLEAN - If UAV cam could be set up or not

	Example:
		[str _uavVehicle,[[0,"rendertarget8"],[1,"rendertarget9"]]] call cTab_fnc_createUavCam;
*/
params ["_data","_uavCams","_isUAV"];
private ["_veh","_display","_detail_List","_squad_list","_Optic_LODs","_Selected_Optic","_renderTarget","_data","_seat","_veh","_uavCams","_seatName","_camPosMemPt","_cam","_current_optic","_turrets"];

_veh = objNull;
_display = uiNamespace getVariable (cTabIfOpen # 1);
_detail_List = _display displayCtrl 1775;
_squad_list = _display displayCtrl 20116;

// see if given UAV name is still in the list of valid UAVs
{
	if (_data == str _x) exitWith {_veh = _x;};
} count cTabUAVlist;

// remove exisitng UAV cameras
call cTab_fnc_deleteUAVcam;

// exit if requested UAV is not alive/is null
if !(alive _veh) exitWith {false};

_Optic_LODs = _veh getVariable ["TGP_View_Available_Optics",[]];
_turrets = _Optic_LODs apply {((_x # 1) # 0) + 1};
_turret_count = [_turrets # 0,0] select (-1 in _turrets);
_Selected_Optic = cTab_player getVariable ["TGP_View_Selected_Optic",[]];

if !(_isUAV) then {
  if ((cTab_player getVariable ["TGP_View_Selected_Optic",[]]) isEqualTo []) then {
    cTab_player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_veh],true];
  };

  if !(_veh isEqualTo ((cTab_player getVariable ["TGP_View_Selected_Optic",[]]) # 1)) then {
    cTab_player setVariable ["TGP_View_Selected_Optic",[(_Optic_LODs # 0),_veh],true];
  };
};

_uavCams apply {
  _x params ["_seat","_renderTarget"];

  if !(isNil {_seat}) then {
    // check existing cameras
  	_cam = objNull;
  	_camPosMemPt = "";
    _is_Detached = false;
    _turret = [0];

    if ((_seat == 1) && (_isUAV)) then {
      _camPosMemPt = getText (configOf _veh >> "uavCameraDriverPos");
    } else {
			_Selected_Optic = cTab_player getVariable "TGP_View_Selected_Optic";
      _camPosMemPt = (_Selected_Optic # 0) # 0;
      _turret = (_Selected_Optic # 0) # 1;
      _is_Detached = (_Selected_Optic # 0) # 2;
    };

  	// If memory points could be retrieved, create camera
  	if (_camPosMemPt != "") then {
  		_cam = "camera" camCreate [0,0,0];
      _cam attachTo [_veh,[0,0,0],_camPosMemPt,!_is_Detached];

  		// set up cam on render target
  		_cam cameraEffect ["INTERNAL","BACK",_renderTarget];

      //-Set Vision Mode
      private _vision = switch (cTab_player getVariable ["TGP_View_Optic_Mode", 2]) do {
        case 3: {[1]};
        case 4: {[7]};
        case 5: {[2]};
        default {[0]};
      };

      _renderTarget setPiPEffect _vision;
      _cam camSetFov (cTab_player getVariable "TGP_View_Camera_FOV");

  		cTabUAVcams pushBack [_renderTarget,_cam,_camPosMemPt,_turret,_is_Detached];
  	};
  };

  nil
};

cTabActUav = _veh;

//-Update Vehicle Data
private _List_index = [
	["Driver :",{
		[name (driver _veh),"-"] select ((driver _veh) isEqualTo objNull)
	}],
	["Gunner :",{
		if (isNil {_current_turret}) exitWith {"-"};
		[name _turret_Unit,"-"] select ((_turret_Unit isEqualTo objNull) or (_turret_Unit isEqualTo (driver _veh)))
	}],
	["Weapon :",{
		if (isNil {_current_turret}) then {
			getText (configFile >> "CfgWeapons" >> currentWeapon _veh >> "DisplayName")
		} else {
			if (_current_turret isEqualTo []) then {
				[
					getText (configFile >> "CfgWeapons" >> currentWeapon _veh >> "DisplayName"),
					"-"
				] select (getText (configFile >> "CfgWeapons" >> currentWeapon _veh >> "DisplayName") == "");
			} else {
				[
					getText (configFile >> "CfgWeapons" >> _veh currentWeaponTurret _current_turret >> "DisplayName"),
					"-"
				] select (getText (configFile >> "CfgWeapons" >> _veh currentWeaponTurret _current_turret >> "DisplayName") == "");
			};
		};
	}],
	["Fuel :",{
		format ["%1%2",round ((fuel _veh) * 100) , "%"];
	}],
	["Grid :",{
		format ["%1 %2",localize "$str_a3_rscdisplayartillery_artillerygridtext",mapGridPosition _veh]
	}],
	["Heading :",{
		format ["%1°",round (getdir _veh)]
	}],
	["Speed :",{
		format ["%1 km/h",round (speed _veh)]
	}],
	["ASL :",{
		format ["%1 m",round ((getPosASL _veh) # 2)]
	}]
] apply {
	[_detail_List lbAdd _x # 0, _x # 1]
};

[{
	params ["_veh","_detail_List","_List_index"];

	_vehicle_New = cTab_player getvariable ["TGP_View_Selected_Vehicle",objNull];
	_Selected_Optic = (cTab_player getVariable "TGP_View_Selected_Optic") # 0;

	_current_turret = _Selected_Optic param [1,[0]];
	_turret_Unit = _veh turretUnit _current_turret;

	_List_index apply {
		_detail_List lbSetTextRight [_x # 0,call (_x # 1)];
	};

	(isNull _detail_List) or !(_veh isEqualTo _vehicle_New) or !(alive cTab_player) or !(alive _veh)
}, {
}, [_veh,_detail_List,_List_index]
] call CBA_fnc_waitUntilAndExecute;

//-Crew List
lbClear _squad_list;

{
	private ["_unit_x","_seat","_turret_c","_name","_freq","_radioInfo","_add","_turret_info","_squad_param","_squad_param0","_unit_info","_title"];
	_unit_x = _x;
	_turret_c = _veh unitTurret _unit_x;
	_seat = getText ([_veh, _turret_c] call BIS_fnc_turretConfig >> "gunnerName");
	_name = ((name _unit_x) splitString " ") # 0;
	_add = _squad_list lbAdd format ["%1 - %2",[_seat,localize "STR_DRIVER"] select (_seat == ""),_name];

	_turret_info = if (_turret_count == _forEachIndex) then {
		_turret_count = _turret_count + 1;
		(_Optic_LODs # ((_forEachIndex-1) max 0))
	} else {
		nil
	};

	_squad_param = squadParams _unit_x;

	//-UNIT info
	_unit_info = if (_squad_param isNotEqualTo []) then {
		(_squad_param # 0) params ["", "_title", "", "", ["_picture",""], ["_unit",""]];

		[_picture,_unit,_title,_turret_info]
	} else {
		private["_faction","_config","_picture"];
		_faction = getText (configof _unit_x >> "faction");
		_config = configFile >> "CfgFactionClasses" >> _faction;

		_picture = getText(_config >> "icon");
		_unit = getText(_config >> "displayName");
		[_picture,_unit,_unit,_turret_info]
	};

	#if __has_include("\z\tfar\addons\core\script_component.hpp")
		_freq = _unit_x call BCE_fnc_getFreq_TFAR;
		_squad_list lbSetTextRight [_add, "LR-" + ([_freq,"“NA”"] select (isnil {_freq}))];
	#else
		_squad_list lbSetTextRight [_add, _unit_info # 1];
	#endif
	_squad_list lbSetData [_add, str _unit_info];

} forEach flatten ((crew _veh) select {(_veh unitTurret _x) in ([[-1]] + allTurrets _veh)});

//-set selected Turret Unit
_current_optic = _Optic_LODs find (_Selected_Optic # 0);
_squad_list lbSetCurSel ([(_current_optic + 1) min (count _turrets),_current_optic] select (-1 in _turrets));

// set up event handler
if (count cTabUAVcams > 0) exitWith {
	if ((cTab_player getVariable ["cTab_TGP_View_EH",-1]) == -1) then {
		private _EH = addMissionEventHandler ["Draw3D",{
			_veh = _thisArgs # 0;

			cTabUAVcams apply {
				if !(isNil {_x}) then {
          _x params ["","_cam","_camPosMemPt","_turret","_is_Detached"];
					if (alive _veh) then {
            if (_is_Detached) then {
              private _dir = [
                (_veh selectionVectorDirAndUp [_camPosMemPt, "Memory"]) # 0,
                (_veh getVariable ["BCE_Camera_Info_Air",[[],[0,0,0]]]) # 1
    					] select ((_turret # 0) < 0);
              [_cam, _dir, false] call BCE_fnc_VecRot;
            };
					} else {
						_cam call cTab_fnc_deleteUAVcam;
					};
				};
			};
		},[_veh]];
    cTab_player setVariable ["cTab_TGP_View_EH",_EH,true];
	};
	true
};

false
