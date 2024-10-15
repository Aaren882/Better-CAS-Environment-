params ["_control","_ID",["_component",true]];

switch _ID do {

  //- Skip Map animation and Get Map -- [_component: ("Scale Down Scaling", true)]
  case -1: {
    cTabMapScale = if (uiNamespace getVariable ['BCE_ATAK_TRACK_Focus',false]) then {
      (ctrlMapScale _control) + ([-0.041428,0.041428] select _component);
    } else {
      ctrlMapScale _control;
    };
  };

  //- Toggle Track Mode -- [_component: ("update", true)]
  case 0: {
    private _state = uiNamespace getVariable ['BCE_ATAK_TRACK_Focus',false];
    if (_component) then {
      _state = !_state;
      uiNamespace setVariable ['BCE_ATAK_TRACK_Focus',_state];
    };
    if !(_state) then {
      private _group = ctrlParentControlsGroup _control;
      (_group controlsGroupCtrl 12) ctrlSetText "NA";
    };
    _control ctrlSetBackgroundColor ([[0.5,0,0,0.3],[0,0,0.5,0.2]] select _state);
  };

  //- Change Vision Mode -- [_component: ("update", true)]
  case 1: {
    private _type = if (_component) then {
      private _t = call BCE_fnc_Next_VisionMode;
      //- Update Interface
      "showMenu" call BCE_fnc_cTab_UpdateInterface;
      _t
    } else {
      focusOn getVariable ["TGP_View_Optic_Mode", 2];
    };

    private _text = switch (_type) do
    {
      #if __has_include("\A3TI\functions.hpp")
        case 0: {
          call A3TI_fnc_getA3TIVision;
        };
        case 1: {
          call A3TI_fnc_getA3TIVision;
        };
      #endif
      case 3:	{"NVG"};
      case 4:	{"W-FLIR"};
      case 5:	{"T-FLIR"};
      default	{"NORMAL"};
    };
    _control ctrlSetText _text;
  };

  //- Toggle Camera Synchronization -- [_component: ("update", true)]
  case 2: { 
    private _state = uiNamespace getVariable ["cTab_Sync_CameraView",false];

    if (_component) then {
      _state = !_state;
      uiNamespace setVariable ["cTab_Sync_CameraView", _state];
    };

    private _Var = focusOn getVariable ["TGP_View_Selected_Optic",[[],objNull]];
    private _vehicle = _Var # 1;
    private _turret = (_Var # 0) param [1,[]];
    private _camIndex = cTabUAVcams findIf {(_x # 3) isEqualTo _turret};

    _control ctrlSetBackgroundColor ([[0.5,0,0,0.3],[0,0,0.5,0.2]] select _state);

    //- Loop
      if (
        _state && 
        !isnull _vehicle && 
        _camIndex > -1
      ) then {
        [{
          params ["_player","_cam","_camIndex"];
          private _Var = _player getVariable ["TGP_View_Selected_Optic",[[],objNull]];
          private _vehicle = _Var # 1;
          private _turret = (_Var # 0) param [1,[]];
          private _cam_Var = cTabUAVcams # _camIndex;
          private _FOV = rad ((_vehicle getVariable "BCE_Cam_FOV_Angle") get (str _turret));
          
          if (
            !isnull _cam && 
            _FOV != (_cam_Var param [5, -1])
          ) then {
            _cam_Var set [5,_FOV];
            cTabUAVcams set [_camIndex,_cam_Var];

            private _config = if ((_turret # 0) < 0) then {
              configOf _vehicle >> "PilotCamera" >> "OpticsIn"
            } else {
              [_vehicle, _turret] call BIS_fnc_turretConfig >> "OpticsIn"
            };
            
            private _FOVs = ("true" configClasses _config) apply {
              if (isText (_x >> "initFov")) then {
                call compile getText (_x >> "initFov")
              } else {
                getNumber (_x >> "initFov")
              };
            };

            private _find = _FOVs apply {abs (_FOV - _x)};
            _find = _find find (selectMin _find);
            _FOV = _FOVs # _find;
            _cam camSetFov _FOV;

            //- Update FOV for Next time having Live Feeds
              localNamespace setVariable ["TGP_View_Camera_FOV", _FOV];
          };

          _turret findIf {true} < 0 || 
          isnull _vehicle || 
          isnull _cam || 
          !(uiNamespace getVariable ["cTab_Sync_CameraView",false])
        }, {

        }, [ //- Params
          focusOn,
          cTabUAVcams # _camIndex # 1,
          _camIndex
        ]] call CBA_fnc_waitUntilAndExecute;
      };
  };
  
  // --- Camera Controllers -- [_component: ("lsCurSel", 0)] --- \\
    //- Get Camera Sel List (ToolBox)
    case 3: {
      private _setting = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
      
      //-Update List Select Value
        private _c = _setting param [3,[]];
        _c set [0,_component];
        _setting set [3,_c];

      //- HCam Update
        private _hcam = ["cTab_Android_dlg", "hcam"] call cTab_fnc_getSettings;
        if (_hcam != "" && _component != 1) then {
          ["cTab_Android_dlg",[["hcam",""]],false] call cTab_fnc_setSettings;
        };

      //- Update Interface
        ["cTab_Android_dlg",[["showMenu",_setting]],true,true] call cTab_fnc_setSettings;
    };
    //- Update Hcam Selection (LIST)
    case 4: {
      private _setting = ["cTab_Android_dlg", "showMenu"] call cTab_fnc_getSettings;
      private _data = _control lbData _component;
      private _c = _setting param [3,[]];
      _c = _c param [0,0];

      call {
        if (_c == 0) exitWith {
          private _veh = objNull;
          if (_data != str objNull) then {
            {
              if (str _x == _data) exitWith {_veh = _x};
            } count vehicles;
          };
          focusOn setVariable ["TGP_View_Selected_Vehicle",_veh];
          
          "showMenu" call BCE_fnc_cTab_UpdateInterface;
        };
        //- Only update the Value when Selecting "hcam"
        if (_c == 1) exitWith {
          if (_data == str objNull) then {
            _data = "";
          };
          ["cTab_Android_dlg",[["hcam",_data]],false] call cTab_fnc_setSettings;
        };
      };
    };
};