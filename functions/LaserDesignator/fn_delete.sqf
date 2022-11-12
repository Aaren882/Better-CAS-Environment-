if !((_x getVariable ["IR_LaserLight_Source_Inf",objNull]) isEqualTo objNull) then {
  deleteVehicle (_x getVariable "IR_LaserLight_Source_Inf");
  _x setVariable ["IR_LaserLight_Source_Inf",objNull,true];
};

if !((_x getVariable ["IR_LaserLight_Source_Air",[]]) isEqualTo []) then {
  {deleteVehicle _x} forEach (_x getVariable "IR_LaserLight_Source_Air");
  _x setVariable ["IR_LaserLight_Source_Air",[],true];
};
