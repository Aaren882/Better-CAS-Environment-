params ["_unit"];

//_spawn_condition = (((_unit getVariable ["IR_LaserLight_EachFrame_EH",-1]) == -1) or (_unit isEqualTo cameraOn));
private _is_Server = (player getVariable ["IR_LaserLight_EachFrame_EH",-1]) != -1;

//Air Vehicles
if (_unit isKindOf "Air") then {

  _var_has_gunner = _unit getvariable ["IR_LaserLight_has_gunner",[false,["","",""],false,1]];
  _vars_turret = _var_has_gunner # 1;

  if (((_unit getVariable ["IR_LaserLight_Source_Air",[]]) isEqualTo []) && (BCE_veh_IR_S_fn) && (_is_Server)) then {

    //-remove object from AIs (Server Side)
    if ((BCE_AIAir_IR_fn) && !(isplayer _unit)) exitWith {
      if !((_unit getVariable ["IR_LaserLight_Source_Air",[]]) isEqualTo []) then {
        {deleteVehicle _x} forEach (_unit getVariable "IR_LaserLight_Source_Air");
        _unit setVariable ["IR_LaserLight_Source_Air",[],true];
      };
    };

    _lightL = "Reflector_Cone_IR_Laser_F" createVehicle [0,0,0];
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

    _unit setVariable ["IR_LaserLight_Source_Air",[_lightL,_light_object],true];
    _unit setVariable ["IR_LaserLight_Source_hide",true,true];

    //Unhide
    [[_lightL,_light_object],_unit] spawn {
      uiSleep 0.15;
      (_this # 0) apply {_x hideObject false};
      (_this # 1) setVariable ["IR_LaserLight_Source_hide",false,true];
    };
  } else {
    //Plane
    (_unit getVariable "IR_LaserLight_Source_Air") params ["_lightL","_light_object"];

    _wRot = if (_var_has_gunner # 0) then {
      ((_unit selectionVectorDirAndUp [(_vars_turret # 0), "Memory"]) # 0);
    } else {
      (_unit getVariable ["BCE_Camera_Info_Air",[[],[0,0,0]]]) # 1
      //((_unit selectionVectorDirAndUp [getText (configOf _unit >> "memoryPointDriverOptics"), "Memory"]) # 0)
    };

    if (BCE_veh_IR_fn) then {
      if !(_unit getVariable "IR_LaserLight_Source_hide") then {
        private _VisionMode = if ((cameraon in vehicles) && (cameraView == "GUNNER")) then {
          (cameraon currentVisionMode (cameraon unitTurret player)) # 0;
        } else {
          if (cameraView == "GUNNER") then {
            (player currentVisionMode (currentWeapon player)) # 0;
          } else {
            currentVisionMode player;
          };
        };

        if (
            (
              (cameraView in ["INTERNAL","GUNNER"]) &&
              ((player in _unit) or (cameraon isEqualTo _unit))
          ) or (_VisionMode == 0)
        ) then {
          _light_object hideObject true;
        } else {
          _light_object hideObject false;
        };
      };

      [_lightL, _wRot, _var_has_gunner # 0] call BCE_fnc_VecRot;
      [_light_object, _wRot, _var_has_gunner # 0] call BCE_fnc_VecRot;
    } else {
      [_lightL,_light_object] apply {_x hideObject true};
    };
  };
} else {
  //Ground Unit
  _binocular = if ((_unit isEqualTo cameraon) && ((currentWeapon cameraon) isKindOf ["Binocular", configFile >> "CfgWeapons"])) then {!(cameraView == "GUNNER")} else {true};
  _condition = if (((vehicle _unit isEqualTo _unit) or (player in vehicle _unit))) then {(speed _unit < 1) && _binocular} else {true};
  _Light_Soure = _unit getVariable ["IR_LaserLight_Source_Inf",objNull];

  _weaponPOS = if (_unit in vehicles) then {
    (
      (allTurrets _unit) select {_unit isLaserOn _x}
    ) apply {
      private _turret = _x;
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
    _Toffset = _weaponLocal vectorAdd _Offset;
    _weaponWorld = _unit modelToWorldWorld _Toffset;

    _dir = if (_turretLocal isEqualTo []) then {
      _unit weaponDirection (currentWeapon _unit)
    } else {
      [_unit,_turretLocal] call BCE_fnc_getTurretDir;
      //_unit weaponDirection (_unit currentWeaponTurret _turretLocal)
    };

    //Light Source
    if ((_Light_Soure isEqualTo objNull) && (_is_Server) && (BCE_inf_IR_Lig_S_fn)) then {
      _light = "Reflector_Cone_IR_LaserDesignator_Light_F" createVehicle [0,0,0];

      if (_turretLocal isEqualTo []) then {
        _light attachTo [_unit, [0.06,0.08,0] vectorAdd _Offset, _LOD];
      } else {
        _light attachTo [_unit, _Offset, _LOD, true];
      };

      _unit setVariable ["IR_LaserLight_Source_Inf",_light,true];
    };

    if (_condition) then {
      //Laser
      if (BCE_inf_IR_fn) then {
        drawLaser [
          _weaponWorld,
          _dir,
          [1000, 1000, 1000],
          [],
          0.05,
          1,
          -1,
          true
        ];
      };

      (_unit getVariable ["IR_LaserLight_Source_Inf",objNull]) hideObject !(BCE_inf_IR_Lig_fn);
    } else {
      (_unit getVariable ["IR_LaserLight_Source_Inf",objNull]) hideObject true;
    };
  };
};
