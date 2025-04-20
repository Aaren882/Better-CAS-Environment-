/*
  NAME : BCE_fnc_Create_ATAK_Custom_DropMenu
*/

params ["_tag_Name","_listGroup","_isDialog","_MenuData"];

{ctrlDelete _x} count (allControls _listGroup);

private _tag_class = [configFile >> "RscTitles" >> _tag_Name, configFile >> _tag_Name] select _isDialog;

//- Init "_listGroup"
  private _init = [_tag_class,_listGroup] call BCE_fnc_Init_ATAK_Custom_DropMenu;

//- IF INIT FAILED
if !(_init) exitWith {};

private _displayName = cTabIfOpen param [1,""];
private _display = uiNamespace getVariable _displayName;

//- Get List Data
  private _data = _listGroup getVariable ["data", []];
  private _startIndex = count _data;

  private _lastIDC = _data param [_startIndex - 1,-1];
  private _sum_H = if (_lastIDC != -1) then {
    private _lastCtrl = _listGroup controlsGroupCtrl _lastIDC;
    (ctrlPosition _lastCtrl) params ["",["_Ctrl_Y",0],"",["_Ctrl_H",0]];
    
    _Ctrl_Y + _Ctrl_H
  } else {
    0
  };
  
//- Get cTab Variable
  private _Variable_Name = _listGroup getVariable "Variable_Name";
  private _checkedGroup = ([_displayName, "Custom_DropMenu"] call cTab_fnc_getSettings) getOrDefault [
    _Variable_Name,
    []
  ];

//- Create Option Tags
{
  _x params [["_Key",""],["_values",[]]];

  if (_Key == "") then {continue};

  private _index = _startIndex + _forEachIndex; //- Correct Index
  private _IDC = 100 + _index; //- IDC Prefix = 100

  private _ctrl = _display ctrlCreate [
    _tag_class,
    _IDC, 
    _listGroup
  ];
  _data pushBack _IDC; //- Push IDC into Data

  //- Expend Control Group
    private _expand = _ctrl getVariable ["Expand_Height", 1];
    private _tag = _ctrl controlsGroupCtrl 15;
    private _tagH = (ctrlPosition _tag) # 3;
    private _ctrlH = _tagH * ([1,_expand] select (_index in _checkedGroup));
    _ctrl ctrlSetPositionH _ctrlH;

  //- Sorting Position
    _ctrl ctrlSetPositionY _sum_H;
    _ctrl ctrlCommit 0;
    _sum_H = _sum_H + _ctrlH;

  //-Fire up Event #NOTE - "onTagLoad" (Each tag can have their own Info Display)
    [_ctrl,_x] call (
      uiNamespace getVariable [
        _ctrl getVariable ["onTagLoad",""],
        {}
      ]
    );
} forEach _MenuData;

//- Save Data (Convinient to grab)
  _listGroup setVariable ["data", _data];