params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _taskUnit = [nil,"CFF" call BCE_fnc_get_TaskIndex] call BCE_fnc_get_TaskCurUnit;
private _taskUnit_Grp = group _taskUnit;

//- Exit If there's no taskUnit Exist
  if (isNull _taskUnit) exitWith {};

//- #NOTE - Setup Adjustment Control Interface
  private _AdjustGrp = _group controlsGroupCtrl 5400;
  private _AdjustBnt = _AdjustGrp controlsGroupCtrl 5100;
  private _AdjustMeter = _AdjustGrp controlsGroupCtrl 5004;

  _AdjustBnt call BCE_fnc_UpdateFireAdjust; //- Refresh UI Values

  private _MeterValue = ["Meter",1] call BCE_fnc_get_FireAdjustValues;
  _AdjustMeter ctrlSetText format ["<-- %1 m -->", _MeterValue * 10];

private _values = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
_values params [["_taskID",""]];

([_taskID] call BCE_fnc_CFF_Mission_Get_Values) params [
  "_MSN_Type",
  "_TG_Grid",
  "_requester",
  "_MSN_infos",
  ["_MSN_State",0]
];

_MSN_infos params [
  "_Wpn_setup_IE",
  "_Wpn_setup_IA",
  "_random_POS",
  "_angleType"
];

_Wpn_setup_IE params ["_lbAmmo_IE","_lbFuse_IE","_fireUnitSel_IE","_setCount_IE","_radius_IE","_fuzeVal_IE"];

//- TOP TITLE
private _PageTitle = _group controlsGroupCtrl 3600;
_PageTitle ctrlSetText ("Mission #" + _taskID);

//- Controls
  private _MissionType_dsp = "New_Task_MissionType_ADJUST_CFF" call BCE_fnc_getTaskSingleComponent;
  _MissionType_dsp lbSetCurSel _MSN_State;

  private _MTO_dsp = "New_Task_MTO_Display" call BCE_fnc_getTaskSingleComponent;
  private _OtherInfo_dsp = "New_Task_OtherInfo_Display" call BCE_fnc_getTaskSingleComponent;

//- MTO (Message to Observer)
  private _default_FUZE = [configFile >> "CfgMagazines" >> _lbAmmo_IE, "displayNameMFDFormat", "NO SPEC"] call BIS_fnc_returnConfigEntry;

  _MTO_dsp ctrlSetStructuredText parseText format [
    "<t color='#FFBC05' size='0.9'>%1</t><br/>""%2 , %3 Guns, %5 ROUNDS, %4 in Effect, TARGET NUMBER %6""",
    "Message to Observer :",
    str groupId _taskUnit_Grp,
    _fireUnitSel_IE,
    [_lbFuse_IE,_default_FUZE] select (_lbFuse_IE == ""),
    _setCount_IE,
    _taskID
  ];

//- #NOTE - Specify WPN setup & Info (TOF...)
  private _wpn_Cate = [_Wpn_setup_IA, _Wpn_setup_IE] # _MSN_State;
  _wpn_Cate params [
    ["_Ammo",_lbAmmo_IE],
    ["_Fuse",""],
    "_fireUnitSel",
    "_setCount",
    ["_fuzeVal",_fuzeVal_IE]
  ];

  call { //- Won't be used twice

    private _wpn_Ctrls = [ //- Get Ctrls
      "WeaponCombo",
      "FuzeCombo",
      "FireUnit_Combo",
      "Round_Box",
      "FuzeValue_Box",
      "FireAngle_Bnt"
    ] apply {("CFF_IE_" + _x) call BCE_fnc_getTaskSingleComponent};
    
    _wpn_Ctrls params [
      "_lbAmmo",
      "_lbFuse",
      "_lbFireUnits",
      "_editRounds",
      "_editFuzeVal",
      "_fireAngle"
    ];

    //- Create Weapon List
      lbClear _lbAmmo;
      [
        _lbAmmo,
        _taskUnit
      ] call BCE_fnc_WPN_List_CFF;

    //- Get Selection functions
      private _GetDataSel = {
        params ["_ctrl", "_value"];
        private _return = 0;
        for "_i" from 0 to (lbSize _ctrl) - 1 do {
          if (_value == (_ctrl lbData _i)) exitWith {_return = _i};
        };
        _return
      };
      private _GetValueSel = {
        params ["_ctrl", "_value"];
        private _return = 0;
        for "_i" from 0 to (lbSize _ctrl) - 1 do {
          if (_value == (_ctrl lbValue _i)) exitWith {_return = _i};
        };
        _return
      };

    //- Select Current Values
      _lbAmmo 	    lbSetCurSel ([_lbAmmo,_Ammo] call _GetDataSel);
      _lbFuse 	    lbSetCurSel ([_lbFuse,_Fuse] call _GetDataSel);
      _lbFireUnits	lbSetCurSel ([_lbFireUnits,_fireUnitSel] call _GetValueSel);
      _fireAngle    setVariable ["Mode", _angleType];
      _fireAngle    ctrlSetStructuredText parseText localize (["STR_BCE_LO_Angle","STR_BCE_HI_Angle"] select _angleType);

      _editRounds	  ctrlSetText str _setCount;
      _editFuzeVal	ctrlSetText str _fuzeVal;
      _editFuzeVal  ctrlshow (_Fuse != "");
      
  };
  
  private _ETA = round (_taskUnit getArtilleryETA [_TG_Grid call BCE_fnc_Grid2POS, _Ammo]);
  _OtherInfo_dsp ctrlSetStructuredText parseText format [
    "TOF - %1 || Fuze - %2",
    [floor (_ETA/60), _ETA % 60] joinString ":",
    _fuzeVal
  ];
  [_OtherInfo_dsp] call BIS_fnc_ctrlFitToTextHeight;