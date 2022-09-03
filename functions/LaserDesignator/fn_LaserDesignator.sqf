params ["_unit"];

//Air Vehicles
if ((_unit in vehicles) && !(_unit isKindOf "LandVehicle")) then {

  if !(BCE_veh_IR_fn) exitWith {};

  _var_has_gunner = _unit getvariable ["IR_LaserLight_has_gunner",[false,["","",""],false,1]];
  _vars_turret = _var_has_gunner # 1;

  _wRot = getPilotCameraDirection _unit;

  if (_var_has_gunner # 0) then {
    _wRot = (_unit selectionVectorDirAndUp [(_vars_turret # 1), "Memory"]) # 0;
  };

  if (_unit getVariable ["IR_LaserLight_Souce_Air",[]] isEqualTo []) then {
    _lightL = "Reflector_Cone_IR_Laser_F" createVehicleLocal [0,0,0];
    if (_unit iskindOf "Air") then {

      _light_object =  if (_unit iskindOf "Helicopter") then {
        createSimpleObject ["A3\data_f\VolumeLight_searchLightSmall.p3d",[0,0,0]];
      } else {
        createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d",[0,0,0]];
      };
      [_lightL,_light_object] apply {_x hideObject true};

      private _Attach = if (_var_has_gunner # 0) then {
        [_unit, [0,0,0], (_vars_turret # 0)];
      } else {
        [_unit, [0,0,0], getText(configFile >> "CfgVehicles" >> typeOf _unit >> "memoryPointDriverOptics")];
      };

      _lightL attachTo _Attach;
      _light_object attachTo _Attach;

      _unit setVariable ["IR_LaserLight_Souce_Air",[_lightL,_light_object],true];
      _unit setVariable ["IR_LaserLight_Souce_Air_hide",true];

      //Unhide
      [[_lightL,_light_object],_unit] spawn {
        uiSleep 0.15;
        (_this # 0) apply {_x hideObject false};
        (_this # 1) setVariable ["IR_LaserLight_Souce_Air_hide",false];
      };
    };
  } else {
    //Plane
    (_unit getVariable "IR_LaserLight_Souce_Air") params ["_lightL","_light_object"];

    if !(_unit getVariable "IR_LaserLight_Souce_Air_hide") then {
      if ((cameraView in ["INTERNAL","GUNNER"]) && (player in _unit)) then {
        _light_object hideObject true;
      } else {
        _light_object hideObject false;
      };
    };
    [_lightL, _wRot, _var_has_gunner # 0] call BCE_fnc_VecRot;
    [_light_object, _wRot, _var_has_gunner # 0] call BCE_fnc_VecRot;
  };
} else {
  //Ground Unit
  if !(BCE_inf_IR_fn) exitWith {};
  _condition = if ((vehicle _unit == _unit) or (player in vehicle _unit)) then {(speed _unit == 0) && !(cameraView == "GUNNER")} else {true};

  if (_condition) then {
    _weaponPOS = if (_unit in vehicles) then {
      (
        (allTurrets _unit) apply {
          private _turret = _x;
          [(_unit weaponsTurret _turret) select {_x isKindOf ["Laserdesignator_mounted", configFile >> "CfgWeapons"]},_turret]
        } select {
          !((_x # 0) isEqualTo [])
        }
      ) apply {
        private _turret = _x # 1;
        Private _LOD = getText ([_unit, _turret] call BIS_fnc_turretConfig >> "memoryPointGunnerOptics");
        Private _offset = if (isArray ([_unit, _turret] call BIS_fnc_turretConfig >> "LaserDesignator_Offset")) then {
          getArray ([_unit, _turret] call BIS_fnc_turretConfig >> "LaserDesignator_Offset")
        } else {
          [0,0,0]
        };
        [_unit selectionPosition _LOD, _turret, _LOD, _offset];
      };
    } else {
      [[(_unit selectionPosition "proxy:\a3\characters_f\proxies\binoculars.001") vectorAdd [0.06,0,0],[],"proxy:\a3\characters_f\proxies\binoculars.001",[0,0,0]]];
    };

    _weaponPOS apply {
      _x params ["_weaponLocal", "_turretLocal", "_LOD", ["_Offset",[0,0,0],[]]];
      _weaponWorld = _unit modelToWorldWorld (_weaponLocal vectorAdd _Offset);
      _Light_Soure = _unit getVariable ["IR_LaserLight_Souce_Inf",objNull];

      _dir = _unit weaponDirection (currentWeapon _unit);
      if !(_turretLocal isEqualTo []) then {
        _dir = _unit weaponDirection (_unit currentWeaponTurret _turretLocal);
      };

      //Light Source
      if (_Light_Soure isEqualTo objNull) then {
        _light = "Reflector_Cone_IR_LaserDesignator_Light_F" createVehicleLocal [0,0,0];

        if (_turretLocal isEqualTo []) then {
          _light attachTo [_unit, [0.06,0.08,0] vectorAdd _Offset, _LOD];
        } else {
          _light attachTo [_unit, _Offset, _LOD, true];
        };

        _unit setVariable ["IR_LaserLight_Souce_Inf",_light];
      } else {
        _Light_Soure setVectorDir _dir;
      };

      //Laser
      drawLaser [
        _weaponWorld,
        _dir,
        [250, 0, 0],
        [],
        0.05,
        1,
        -1,
        true
      ];
    };

    (_unit getVariable ["IR_LaserLight_Souce_Inf",objNull]) hideObject false;
  } else {
    (_unit getVariable ["IR_LaserLight_Souce_Inf",objNull]) hideObject true;
  };
};
