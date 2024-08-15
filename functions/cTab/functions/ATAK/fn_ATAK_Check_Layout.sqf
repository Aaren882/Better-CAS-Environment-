private _bgw = (ctrlPosition _background) # 2;

//- Get Map Type and Arrange
  private _targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
  private _mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
  private _targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
  private _targetMapCtrl = _display displayCtrl _targetMapIDC;
  (ctrlPosition _targetMapCtrl) params ["_MapX","_MapY","_MapW","_MapH"];
  private _result = _bgw / 2 * ([5, 3] select _show);

  _targetMapCtrl ctrlSetPosition [
    _MapX,
    _MapY,
    _result,
    _MapH
  ];
  _targetMapCtrl ctrlCommit 0;
  _targetMapCtrl ctrlMapSetPosition [];

//- Self Info Box
  private _bat = _display displayCtrl 2;
  (ctrlPosition _bat) params ["_batX"];

  {
    private _ctrl = _display displayCtrl (17000 + _x);
    _ctrl ctrlSetPositionX (_MapX + _result - (ctrlPosition _ctrl # 2) + (_MapX - _batX));
    _ctrl ctrlCommit 0;
  } count [
    2620,
    2621,
    2622
  ];
  private _callSign = _display displayCtrl (17000 + 2620);
  _callSign ctrlSetText ([groupId group cTab_player, [cTab_player] call CBA_fnc_getGroupIndex] joinString ":");

//- Marker Tool
  private _tool = _display displayCtrl (17000 + 1300);
  _tool ctrlSetPositionX (_MapX + _result - (ctrlPosition _tool # 2));
  _tool ctrlCommit 0;