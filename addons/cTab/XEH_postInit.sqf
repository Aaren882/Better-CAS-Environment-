[] spawn {
waitUntil {!isnil {cTabSettings}};
call BCE_fnc_cTab_postInit;
};

//- Phone Camera
[
  "Better CAS Environment (cTab ATAK Camera)","ScreenShot",
  localize "STR_BCE_Take_ScreenShot",
  {
    if (IsPhoneCAM_ON && isnil{ctabifopen}) then {
      call BCE_fnc_ATAK_TakePicture;
    };
  },
  "",
  [0xF0, [false, false, false]]
] call cba_fnc_addKeybind;
//- Flash Light
[
  "Better CAS Environment (cTab ATAK Camera)","FlashLight",
  localize "STR_BCE_ATAK_FlashLight",
  {
    if (IsPhoneCAM_ON && isnil{ctabifopen}) then {
      private _light = localNamespace getVariable ["BCE_ATAK_Camera_FlashLight",objNull];
      if (isnull _light) then {
        _light = "Reflector_Cone_Phone_FlashLight_BCE_F" createVehicle [0,0,0]; //- As Global object
        localNamespace setVariable ["BCE_ATAK_Camera_FlashLight",_light];

        //- Attach to player's head
        private _unit = player;
        if (vehicle _unit != _unit) then {
          private _veh = vehicle _unit;
          private _offset = _veh worldToModelVisual (ASLToAGL (eyePos _unit));
          _light attachTo [_veh,_offset vectorAdd [0,0.4,0]];
        } else {
          _light attachTo [_unit, [0,0.4,0.2], "head"];
        };

      } else {
        deleteVehicle _light;
        localNamespace setVariable ["BCE_ATAK_Camera_FlashLight",nil];
      };
    };
  },
  "",
  [0xF1, [false, false, false]]
] call cba_fnc_addKeybind;
