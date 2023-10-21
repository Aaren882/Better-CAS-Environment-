params ["_unit"];

private _is_Server = BCE_SYSTEM_Handler == str player;

//Air Vehicles
if (_unit isKindOf "Air") then {
  private ["_isTurret","_lightL","_light_object","_Attach","_wRot"];

  ([_unit, 1] call BCE_fnc_Check_Optics) apply {
    _x params [["_isTurret",false],["_vars_turret",["","",""]]];
    _isTurret = !isnil {_isTurret};

    if (((_unit getVariable ["IR_LaserLight_Source_Air",[]]) isEqualTo []) && (BCE_veh_IR_S_fn) && (_is_Server)) then {

      //-remove object from AIs (Server Side)
      if ((BCE_AIAir_IR_fn) && !(isplayer _unit)) exitWith {
        if !((_unit getVariable ["IR_LaserLight_Source_Air",[]]) isEqualTo []) then {
          {deleteVehicle _x} forEach (_unit getVariable "IR_LaserLight_Source_Air");
          _unit setVariable ["IR_LaserLight_Source_Air",[],true];
        };
      };

      _lightL = "Reflector_Cone_IR_Laser_F" createVehicle [0,0,0];
      _light_object = createSimpleObject [["A3\data_f\VolumeLight_searchLight.p3d","A3\data_f\VolumeLight_searchLightSmall.p3d"] select (_unit iskindOf "Helicopter"),[0,0,0]];
      [_lightL,_light_object] apply {_x hideObject true};

      _Attach = [_unit, _vars_turret # 1, _vars_turret # 0];

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

      _wRot = if (_isTurret) then {
        (_unit selectionVectorDirAndUp [(_vars_turret # 0), "Memory"]) # 0
        //[_unit,_vars_turret # 2] call BCE_fnc_getTurretDir
      } else {
        [
          (_unit getVariable ["BCE_Camera_Info_Air",[[],[0,0,0]]]) # 1,
          getPilotCameraDirection _unit
        ] select (local _unit);
      };

      if (BCE_veh_IR_fn) then {
        if !(_unit getVariable "IR_LaserLight_Source_hide") then {
          private _VisionMode = if ((cameraon in vehicles) && (cameraView == "GUNNER")) then {
            (cameraon currentVisionMode (cameraon unitTurret player)) # 0;
          } else {
            [
              currentVisionMode player,
              (player currentVisionMode (currentWeapon player)) # 0
            ] select (cameraView == "GUNNER");
          };

          _light_object hideObject (((cameraView in ["INTERNAL","GUNNER"]) && ((player in _unit) or (cameraon isEqualTo _unit))) or (_VisionMode == 0));
        };

        //-Rotate
        {
          [_x, _wRot, _isTurret] call BCE_fnc_VecRot;
        } count [_lightL,_light_object];
      } else {
        [_lightL,_light_object] apply {_x hideObject true};
      };
    };
  };
} else {
  private ["_binocular","_condition","_Light_Soure","_weaponPOS"];
  //Ground Unit
  _binocular = [true, !(cameraView == "GUNNER")] select ((_unit isEqualTo cameraon) && ((currentWeapon cameraon) isKindOf ["Binocular", configFile >> "CfgWeapons"]));
  _condition = [true, (speed _unit < 1) && _binocular] select ((vehicle _unit isEqualTo _unit) or (player in vehicle _unit));

  _Light_Soure = _unit getVariable ["IR_LaserLight_Source_Inf",objNull];

  _weaponPOS = if (_unit in vehicles) then {
    (
      //(allTurrets _unit) select {_unit isLaserOn _x}
      ([_unit,1] call BCE_fnc_Check_Optics) select {_unit isLaserOn (_x # 0)}
    ) apply {
      _x params ["_turret","_LOD","_gunBeg","_offset"];
      private ["_Beg","_POS","_dir","_ASL"];

      //-Correcting Laser
      _Beg = _unit selectionPosition _gunBeg;
      _POS = _unit selectionPosition _LOD;
      _dir = [_unit,_turret] call BCE_fnc_getTurretDir;
      _ASL = (_unit modelToWorldVisualWorld _Beg) vectorAdd (_dir vectorMultiply (_unit distance (_unit laserTarget [0,0])));

      [_POS, (_unit modelToWorldVisualWorld _POS) vectorFromTo _ASL, _turret, _LOD, _offset]
    };
  } else {
    [
      [
        (_unit selectionPosition "proxy:\a3\characters_f\proxies\binoculars.001") vectorAdd [0.06,0,0],
        _unit weaponDirection (currentWeapon _unit),
        [],
        "proxy:\a3\characters_f\proxies\binoculars.001",
        [0,0,0]
      ]
    ]
  };

  _weaponPOS apply {
    _x params ["_weaponLocal", "_dir", "_turretLocal", "_LOD", ["_Offset",[0,0,0],[]]];

    _weaponWorld = _unit modelToWorldVisualWorld (_weaponLocal vectorAdd _Offset);

    //Light Source
    if ((isNull _Light_Soure) && (_is_Server) && (BCE_inf_IR_Lig_S_fn)) then {
      private _light = "Reflector_Cone_IR_LaserDesignator_Light_F" createVehicle [0,0,0];

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
