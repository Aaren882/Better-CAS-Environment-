/*
  NAME : BCE_fnc_Create_ATAK_Custom_DropMenu

  Create Custom Drop Menu for cTab

  param :
    "_tag_Name"   : Class Name of the Tag Group
    "_listGroup"  : controlsGroupCtrl of the Group
    "_isDialog"   : <BOOL>
    "_MenuData"   : HashMap data for creating the list
    "_data"       : IDC Data pool to be stored
      
*/

params [
  "_tag_Name",
  "_listGroup",
  "_isDialog",
  "_MenuData",
  ["_data", []] //- IDC Data pool to be stored
];

//- Check if isn't appending 
  if (count _data == 0) then {[_listGroup] call BCE_fnc_Clear_ATAK_Custom_DropMenu};

private _tag_class = [configFile >> "RscTitles" >> _tag_Name, configFile >> _tag_Name] select _isDialog;

//- Init "_listGroup"
  private _init = [_tag_class,_listGroup] call BCE_fnc_Init_ATAK_Custom_DropMenu;

//- IF INIT FAILED
if !(_init) exitWith {};

private _displayName = cTabIfOpen param [1,""];
private _display = uiNamespace getVariable _displayName;

//- Get List Data
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
  private _cTab_Setting = [_displayName, "Custom_DropMenu"] call cTab_fnc_getSettings;
  private _checkedGroup = _cTab_Setting getOrDefault [_Variable_Name,[]];

private _keyPool = [];
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
  _ctrl setVariable ["Index", _Key]; //- Set Ctrl Index with "KEY"

  _keyPool pushBack _Key; //- Keys that created
  _data pushBack _IDC; //- Push IDC into Data

  //- Expend Control Group
    private _expand = _ctrl getVariable ["Expand_Height", 1];
    private _tag = _ctrl controlsGroupCtrl 15;
    private _tagH = (ctrlPosition _tag) # 3;
    private _ctrlH = _tagH * ([1,_expand] select (_Key in _checkedGroup));
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

//- Clear Checked Keys that don't exist anymore
  private _delChecked = false;
  {
    if !(_x in _keyPool) then {
      _checkedGroup deleteAt _forEachIndex;
      _delChecked = true;
    };
  } forEach _checkedGroup;

  if (_delChecked) then { //- Save variable if there's anything Changed
    _cTab_Setting set [_Variable_Name,_checkedGroup];
    [_displayName,[["Custom_DropMenu",_cTab_Setting]],false] call cTab_fnc_setSettings;
  };

//- Save Data (Convinient to grab)
  _listGroup setVariable ["data", _data];

  _data