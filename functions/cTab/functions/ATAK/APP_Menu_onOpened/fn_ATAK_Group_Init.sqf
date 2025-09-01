params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _listGroup = _group controlsGroupCtrl 10;
/* private _tag_Name = "ATAK_Group_Manage_Custom";
private _tag_class = [configFile >> "RscTitles" >> _tag_Name, configFile >> _tag_Name] select _isDialog;

(ctrlPosition _listGroup) params ["_list_X","","_list_W"]; */

//- Get All Groups
// private _customTeam = (groups playerSide) apply {
// 	[] 
// };



// private _customTeam_Count = count _customTeam;
// _customTeam = [["All Groups",98],["My Team",99]] + _customTeam;
// _customTeam_Count = (count _customTeam) - _customTeam_Count;

//- Set Variable
// private _sum_H = 0;
// private _data = (allControls _listGroup) apply {ctrlIDC _x};
// private _checkedGroup = ["cTab_Android_dlg", "group_Info"] call cTab_fnc_getSettings;


//- Save Data (Convinient to grab)
  // _listGroup setVariable ["data", [100,101]];

//- Create DropMenu
  private _customTeam = (
    createHashMapFromArray [
      [
        "All Groups",[
          "\a3\3den\data\displays\display3den\toolbar\widget_global_ca.paa",
          count groups playerSide
        ]
      ],[
        "My Team",
        [
          "\a3\3den\data\displays\display3den\panelright\modegroups_ca.paa",
          count units player
        ]
      ]
    ]
  ) toArray false;
  reverse _customTeam;

  private _returnIDCs = [
    "ATAK_Group_Manage_System",
    _listGroup,
    _isDialog,
    _customTeam
  ] call BCE_fnc_Create_ATAK_Custom_DropMenu;

  
  //- get custom Groups
    _customTeam = ((createHashMapFromArray [["CCT",[group player,"Assault Team", 71.1]],["TACP",[group player,"Platoon", 50]]]) toArray false);
    reverse _customTeam;
  
  [
    "ATAK_Group_Manage_Custom",
    _listGroup,
    _isDialog,
    _customTeam,
    _returnIDCs //- IDC Data pool to be stored
  ] call BCE_fnc_Create_ATAK_Custom_DropMenu;
