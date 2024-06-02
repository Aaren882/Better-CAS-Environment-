//params [""];

//- These codes are Base on "MapTools Remastered" by "POLPOX"              
//- link: https://steamcommunity.com/sharedfiles/filedetails/?id=3032131959 

#define SCALE 0.7

#define GUI_GRID_WAbs ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs (GUI_GRID_WAbs / 1.2)

#define GUI_GRID_W (GUI_GRID_WAbs / 40)
#define GUI_GRID_H (GUI_GRID_HAbs / 25)

cTabUserSelIcon = [[],0,0,0,""];

params ["_mainPop","_sendingCtrlArry"];
_cntrlScreen = _sendingCtrlArry select 0;

_xpos = _sendingCtrlArry # 2;
_ypos = _sendingCtrlArry # 3;

cTabUserPos = [_xpos,_ypos];

_tempWorldPos = _cntrlScreen posScreenToWorld cTabUserPos;
cTabUserSelIcon set [0,[_tempWorldPos # 0,_tempWorldPos # 1]];


private _disp = uiNamespace getVariable [cTabIfOpen # 1, displayNull];
private _cGrp = _disp displayCtrl 3510;
private _items = "true" configClasses (configFile >> "PLP_SMT_Data" >> "RadialMenu");
private _coef = 1-(count _items mod 2);

//- Correction
call cTab_fnc_Menu_Correction;

// add items into the menu
{
  private _ctrl = _disp ctrlCreate ["PLP_SMT_RscTextCenter",-1,_cGrp];
  _ctrl ctrlSetText getText (_x >> "displayName");

  private _dir = _forEachIndex / count _items * 360 + 180;

  _ctrl ctrlSetPosition [
    (sin _dir * (GUI_GRID_W*5*SCALE)) + (GUI_GRID_W*15/2*SCALE) - GUI_GRID_W*5*SCALE/2,
    (cos _dir * (GUI_GRID_H*5*SCALE)) + (GUI_GRID_H*15/2*SCALE) - GUI_GRID_H*2*SCALE/2
  ];
  _ctrl ctrlCommit 0;

  private _dir = (_forEachIndex + ((count _items+_coef) mod 2)/2) / count _items * 360;

  private _ctrl = _disp ctrlCreate ["PLP_SMT_RadialSeparator",-1,_cGrp];
  _ctrl ctrlSetAngle [_dir,0.5,0.5,true];

} forEach _items;

//- Check Selected
private _MEH = addMissionEventHandler ["EachFrame",{
  _thisArgs params ["_disp", "_cGrp", "_items", "_coef"];

  if (isNull _disp) exitWith {removeMissionEventHandler ["EachFrame",_thisEventHandler]};

  getResolution params ["_resW","_resH"];

  // convert safezone into abs
  private _mPos = ctrlMousePosition _cGrp;
  private _center = [GUI_GRID_W*15/2*SCALE,GUI_GRID_H*15/2*SCALE];

  private _mPosSafeZone = [_mPos#0/3,_mPos#1/4];
  private _centerSafeZone = [_center#0/3,_center#1/4];

  private _dist = _centerSafeZone distance2D [0,_centerSafeZone#1];

  _cGrp controlsGroupCtrl 10 ctrlShow (
    _mPosSafeZone distance2D _centerSafeZone < (_dist*0.25) or
    _mPosSafeZone distance2D _centerSafeZone > _dist
  );

  private _relDir = _mPosSafeZone getDir _centerSafeZone;
  private _selected = floor ((_relDir/360*count _items) + ((count _items+_coef) mod 2)/2) mod (count _items);

}, [_disp, _cGrp, _items, _coef]];