params ["_unit"];

_idEH = addMissionEventHandler ["EachFrame", {
  if (count IR_LaserLight_UnitList != 0) then {
    IR_LaserLight_UnitList apply {

      if (isLaserOn _x) then {
        _x call BCE_fnc_LaserDesignator;
      } else {
        call BCE_fnc_delete;
      };
      /* if (((((player currentVisionMode (currentWeapon player)) # 0) != 1) && (currentVisionMode player != 1)) or !(isLaserOn _x)) then {
        call BCE_fnc_delete;
      } else {
        if (isLaserOn _x) then {
          _x call BCE_fnc_LaserDesignator;
        };
      }; */
    };
  };

  if (time > IR_LaserLight_UnitList_LastUpdate + 0.1) then {
    IR_LaserLight_UnitList_LastUpdate = time;
    call BCE_fnc_IR_UnitList;
    TGP_View_Turret_List = (allunits + vehicles) select {!((_x getVariable ["TGP_View_Turret_Control",[]]) isEqualTo []) or (isUAVConnected _x) or ((_x getVariable ["AHUD_Actived",-1]) != -1)};
  };
}];

player setVariable ["IR_LaserLight_EachFrame_EH",_idEH];
