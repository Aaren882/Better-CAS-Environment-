params ["_group",["_interfaceInit",false],"_settings"];

private _list = _group controlsGroupCtrl 10;
private _tag_Name = "ATAK_Group_Manage_Custom";
private _tag_class = [configFile >> "RscTitles" >> _tag_Name, configFile >> _tag_Name] select _isDialog;
private _sum_H = 0;
private _data = [];

//- Set Variable
private _checkedGroup = ["cTab_Android_dlg", "group_Info"] call cTab_fnc_getSettings;

(ctrlPosition _list) params ["_list_X","","_list_W"];

//- Get All Groups
// private _customTeam = (groups playerSide) apply {
// 	[] 
// };

//- get custom Groups
private _customTeam = ((createHashMapFromArray [["CCT",[group player,"Assault Team", 71.1]],["TACP",[group player,"Platoon", 50]]]) toArray false);
reverse _customTeam;

private _customTeam_Count = count _customTeam;
_customTeam = [["All Groups",98],["My Team",99]] + _customTeam;
_customTeam_Count = (count _customTeam) - _customTeam_Count;

//- Clear List
{ctrlDelete _x} count allControls _list;

//- Create Option Tags
{
  _x params [["_title",""],["_values",[]]];

  if (_title == "") then {continue};

  // - System Values ("_values" = "IDC")
  if (_values isEqualType 0) then {
    private _ctrl = _list controlsGroupCtrl _values;
    private _tag = _ctrl controlsGroupCtrl 15;
    private _tagH = (ctrlPosition _tag) # 3;

    _ctrl setVariable ["Index", _forEachIndex];
    _data pushBack _values; //- Push IDC into Data

    //- Expend Control Group
      private _ctrlH = _tagH * ([1,2] select (_forEachIndex in _checkedGroup));
      _ctrl ctrlSetPositionH _ctrlH;

    _ctrl ctrlSetPositionY _sum_H;
    _ctrl ctrlCommit 0;
    _sum_H = _sum_H + (ctrlPosition _ctrl # 3);
    
    continue
  };
  _values params ["_group","_teamName","_freq"];

  private _IDC = (100 - _customTeam_Count) + _forEachIndex; //- IDC Prefix = 100
  private _ctrl = _display ctrlCreate [
    _tag_class,
    _IDC, 
    _list
  ];
  _ctrl setVariable ["Index", _forEachIndex]; //- Set Ctrl Index
  _data pushBack _IDC; //- Push IDC into Data

  private _tag = _ctrl controlsGroupCtrl 15;
  private _tagH = (ctrlPosition _tag) # 3;
  
  //- Expend Control Group
    private _ctrlH = _tagH * ([1,3] select (_forEachIndex in _checkedGroup));
    _ctrl ctrlSetPositionH _ctrlH;

  //- Sorting Position
    _ctrl ctrlSetPositionY _sum_H;
    _ctrl ctrlCommit 0;
    _sum_H = _sum_H + _ctrlH;

  _tag ctrlSetStructuredText parseText format [
    "<img size='1' image='\MG8\AVFEVFX\data\ExpandList.paa'/> %1<t align='right'>%2 </t>",
    _title,
    _teamName //- Call Sign or something you like
  ];

  private _info_ls = _ctrl controlsGroupCtrl 50;
  
  //- Apply Infos
    {
      (_x splitString "|") params ["_L","_R",["_pic",""]];

      private _row = _info_ls lnbAddRow [_L,""];
      _info_ls lnbSetTextRight [[_row, 0], _R];

      if (_pic != "") then {
        _info_ls lnbSetPictureRight [[_row, 0], _pic];
      };
    } forEach [
      format ["Leader : %1| ”NW” %2°", name leader _group, 160],
      format ["Freq : %1| |%2", _freq, "\cTab\img\icon_signalStrength_ca.paa"]
    ];
} forEach _customTeam;

//- Save Data (Convinient to grab)
  _group setVariable ["data", _data];
_sum_H = 0;
