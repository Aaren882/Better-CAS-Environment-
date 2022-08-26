params ["_unit"];

_idEH = addMissionEventHandler ["EachFrame", {
  if (count IR_LaserLight_UnitList != 0) then {
    IR_LaserLight_UnitList apply {

      if (isLaserOn _x) then {
        _x call BCE_fnc_LaserDesignator;
      } else {
        call BCE_fnc_delete;
      };
      if (currentVisionMode player != 1) then {
        call BCE_fnc_delete;
      };
    };
  };

  if (time > IR_LaserLight_UnitList_LastUpdate + 0.1) then {
    IR_LaserLight_UnitList_LastUpdate = time;
    call BCE_fnc_IR_UnitList;
  };
}];

player setVariable ["IR_LaserLight_EachFrame_EH",_idEH];
