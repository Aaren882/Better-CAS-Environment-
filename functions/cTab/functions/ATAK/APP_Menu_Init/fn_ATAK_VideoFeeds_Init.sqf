params ["_group",["_interfaceInit",false],"_settings"];
_settings params ["_page","_show","_line",["_PgComponents",[]]];

private _switch_btn = _group controlsGroupCtrl 5;
private _ListGroup = _group controlsGroupCtrl 10;
private _ViewGroup = _group controlsGroupCtrl 20;
private _commitTime = {[_this, 0] select _interfaceInit};
private _hcam = [_displayName, "hcam"] call cTab_fnc_getSettings;

//- Get Last Selection
  private _SubSel = _PgComponents param [0, [0,1] select (_hcam != "")];

//- Control Components
  private _ctrl_TrackTG = _ViewGroup controlsGroupCtrl 11;
  private _ctrl_TrackInfo = _ViewGroup controlsGroupCtrl 12;
  private _ctrl_Vision = _ViewGroup controlsGroupCtrl 13;
  private _ctrl_Sync = _ViewGroup controlsGroupCtrl 14;
  private _ctrl_View = _ViewGroup controlsGroupCtrl 46310;
  private _ctrl_Turret = _ViewGroup controlsGroupCtrl 46320;
  private _ctrl_PIP = _ViewGroup controlsGroupCtrl 4632;

//- Check if is Sub-Menu
  private _subMenu = _line > 0;

  _ListGroup ctrlEnable _subMenu;
  _ViewGroup ctrlEnable !_subMenu;

  _ListGroup ctrlSetPositionH ([
    0,
    (ctrlPosition _group) # 3
  ] select _subMenu);
  _ListGroup ctrlSetFade ([1,0] select _subMenu);
  _ListGroup ctrlCommit (0.3 call _commitTime);

  {
    _x ctrlSetFade ([0,1] select _subMenu);
    _x ctrlCommit ((0.08 * (1 max _forEachIndex)) call _commitTime);
  } forEach allControls _ViewGroup;

//- Setup View Control Lists
  if (_subMenu) exitWith {
    //- List Controls
      private _toolbox = _ListGroup controlsGroupCtrl 6;
      private _ls = _ListGroup controlsGroupCtrl 7;

    //- Setup Lists Selections
      _toolbox ctrlRemoveAllEventHandlers "ToolBoxSelChanged";
      _ls ctrlRemoveAllEventHandlers "LBSelChanged";

      //- Generate Camera Connectable List
      [_ls,_SubSel] call BCE_fnc_cTab_CreateCameraList;
      _toolbox lbSetCurSel _SubSel;

      _toolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
        [_this # 0,3,_this # 1] call BCE_fnc_ATAK_Camera_Controls
      }];
      _ls ctrlAddEventHandler ["LBSelChanged", {
        [_this # 0,4,_this # 1] call BCE_fnc_ATAK_Camera_Controls
      }];

    _switch_btn ctrlSetStructuredText parseText localize "STR_BCE_Select_Camera";
    _ctrl_View ctrlRemoveAllEventHandlers "MouseEnter";
    _ctrl_View ctrlRemoveAllEventHandlers "MouseExit";
  };

// if (_interfaceInit) exitWith {};

//- View Box Status
  private _veh = cTab_player getVariable ["TGP_View_Selected_Vehicle",objNull];
  private _isHcam = _SubSel == 1;
  //- exit if display is on
  private _displayOn = (
    !isnull(uiNamespace getVariable ["BCE_HCAM_View",displayNull]) || 
    ((player getVariable ["TGP_View_EHs", -1]) != -1)
  );

//- Setup PIP Camera
  call {
    //- Helmet CAM
    if (_isHcam) exitWith {
      _ctrl_Turret ctrlSetText localize "STR_BCE_Helmet_CAM";
      call cTab_fnc_deleteUAVcam;
      player setVariable ["TGP_View_Selected_Optic",[[],objNull],true];
      _veh = ["rendertarget9",_hcam, !_displayOn] call cTab_fnc_createHelmetCam;
    };
    //- AV CAM
    if (!isnull _veh && !_displayOn) exitWith {
      call cTab_fnc_deleteHelmetCam; //- delete Hcam PIP
      [_veh,[[1,"rendertarget9"]],false] call cTab_fnc_createUavCam;
    };
  };

private _null_Connected = isnull _veh;

//- PIP Control
  _ctrl_PIP ctrlShow ((!_null_Connected || _isHcam) && !_displayOn);
//- Button Control
  _ctrl_View ctrlEnable (!_null_Connected && !_displayOn);
//- Widget Control
  {_x ctrlEnable (!_null_Connected && !_isHcam && !_displayOn)} count [_ctrl_TrackTG,_ctrl_Vision,_ctrl_Sync,_ctrl_Turret];

//- Create PIP camera if mode is "UAV"
  private _title = if (_null_Connected) then {
    _ctrl_Turret ctrlSetText "- -";
    
    _ctrl_View ctrlSetText localize "STR_BCE_No_Signal";
    
    if (_isDialog) then {
      _ctrl_View ctrlSetFade 0;
      _ctrl_View ctrlcommit (0.2 call _commitTime);
      _ctrl_View ctrlRemoveAllEventHandlers "MouseEnter";
      _ctrl_View ctrlRemoveAllEventHandlers "MouseExit";
    } else {
      _ctrl_View ctrlSetBackgroundColor [0,0,0,0.08];
    };

    "  - - <img image='\MG8\AVFEVFX\data\ExpandList.paa'/>"
  } else {
    _ctrl_TrackTG ctrlSetBackgroundColor ([[0.5,0,0,0.3],[0,0,0.5,0.3]] select (uiNamespace getVariable ['BCE_ATAK_TRACK_Focus',false]));
    
    if (_isDialog) then {
      _ctrl_View ctrlSetText localize "STR_BCE_Live_Feed";
      _ctrl_View ctrlSetFade 1;
      _ctrl_View ctrlcommit 0;
      _ctrl_View ctrlAddEventHandler ["MouseEnter", {(_this # 0) ctrlSetFade 0.5; (_this # 0) ctrlcommit 0.2;}];
      _ctrl_View ctrlAddEventHandler ["MouseExit", {(_this # 0) ctrlSetFade 1; (_this # 0) ctrlcommit 0.2;}];
    } else {
      _ctrl_View ctrlSetText "";
      _ctrl_View ctrlSetBackgroundColor [0,0,0,0];
    };
      
    [groupId group _veh, [_veh] call CBA_fnc_getGroupIndex] joinString " : "
  };

//- Set Title Text
  _switch_btn ctrlSetStructuredText parseText _title;
  _ctrl_TrackInfo ctrlSetText localize "STR_BCE_None"; //- Rewrite the Focus Point (Relative Info)

//- Update Vision Mode (after Camera is Generated)
  [_ctrl_TrackTG,0,false] call BCE_fnc_ATAK_Camera_Controls;
  [_ctrl_Vision,1,false] call BCE_fnc_ATAK_Camera_Controls;
  [_ctrl_Sync,2,false] call BCE_fnc_ATAK_Camera_Controls;
  
