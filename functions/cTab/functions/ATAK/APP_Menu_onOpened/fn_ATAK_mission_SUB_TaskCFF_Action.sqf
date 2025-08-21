params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _taskUnit = [nil,"GND" call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit;
private _taskUnit_Grp = group _taskUnit;

//- Exit If there's no taskUnit Exist
  if (isNull _taskUnit) exitWith {};

private _values = ["CFF_Mission",[]] call BCE_fnc_get_TaskCurSetup;
_values params [["_taskID",""]];

(_taskID call BCE_fnc_CFF_Mission_Get_Values) params [
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

//- Controls
	//- #NOTE - Initiate Interface
		//- TOP TITLE
			private _PageTitle = _group controlsGroupCtrl 3600;
			_PageTitle ctrlSetText format [localize "STR_BCE_CFF_MSN_TITLE", _taskID];

		//- ToolBoxes
			private _AdjustToolbox = "New_Task_Adjust_Method_CFF" call BCE_fnc_getTaskSingleComponent;
			_AdjustToolbox lbSetCurSel (["CurSel", 0] call BCE_fnc_get_FireAdjustValues);
			[_AdjustToolbox] call BCE_fnc_ATAK_FireAdjust_Sel_Changed;

			private _MissionType_dsp = "New_Task_MissionType_ADJUST_CFF" call BCE_fnc_getTaskSingleComponent;
			_MissionType_dsp lbSetCurSel _MSN_State;

  private _MTO_dsp = "New_Task_MTO_Display" call BCE_fnc_getTaskSingleComponent;
  private _OtherInfo_dsp = "New_Task_OtherInfo_Display" call BCE_fnc_getTaskSingleComponent;

//- MTO (Message to Observer)
	private _ammo = [_lbAmmo_IE] call BCE_fnc_getMagazineAmmo;
	private _default_FUZE = _ammo call BCE_fnc_CFF_getAmmoType; 

  _MTO_dsp ctrlSetStructuredText parseText format [
    localize "STR_BCE_CFF_MSG_MTO_STRUCTURED",
    localize "STR_BCE_CFF_MTO_TITLE",
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
    ["_fuzeVal",0]
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
      "_lbFuze",
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
      _lbFuze 	    lbSetCurSel ([_lbFuze,_Fuse] call _GetDataSel);
      _lbFireUnits	lbSetCurSel ([_lbFireUnits,_fireUnitSel] call _GetValueSel);
      _fireAngle    setVariable ["Mode", _angleType];
      _fireAngle    ctrlSetStructuredText parseText localize (["STR_BCE_LO_Angle","STR_BCE_HI_Angle"] select _angleType);
		
      _editRounds	  ctrlSetText str _setCount;
      _editFuzeVal	ctrlSetText str _fuzeVal;
			
		//- #ANCHOR - Check Ammo Fuze
			private _fireAmmo = _lbAmmo lbData (lbCurSel _lbAmmo);
			private _mapValue = _lbAmmo getVariable ["CheckList",createHashMap];
			private _data = _mapValue getOrDefault [_fireAmmo, []];
			_data params ["","","", "",["_ammoType",""]];

			//- #TODO - Check ordnance available fuzes
				if (_ammoType == "HE") then {
					_lbFuze ctrlShow true;

					private _value = _lbFuze lbValue (lbCurSel _lbFuze);
					_editFuzeVal ctrlShow (_value > 0); // #LINK - functions/Task_Type/fn_SelChanged_ADJ.sqf
				} else {
					_lbFuze ctrlShow false;
					_editFuzeVal ctrlShow false;
				};
  };
  
  private _chargeInfo = [
    _taskUnit,
    _Ammo,
    _TG_Grid call BCE_fnc_Grid2POS,
    _angleType
  ] call BCE_fnc_getCharge;
  _chargeInfo params ["", "", ["_ETA", 0]];

  if (_ETA == 0) exitWith {};

  private _ETA_txt = format [
    "ETA - %1",
    [floor (_ETA/60), round (_ETA % 60)] joinString ":"
  ];

  _OtherInfo_dsp ctrlSetStructuredText parseText format [
    "%1 %2",
    _ETA_txt,
    [
      format ["|| Fuze - %1",_fuzeVal],
      ""
    ] select (_fuzeVal == 0)
  ];
  [_OtherInfo_dsp] call BIS_fnc_ctrlFitToTextHeight;