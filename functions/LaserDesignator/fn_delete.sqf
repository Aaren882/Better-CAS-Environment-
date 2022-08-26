if !(_x getVariable ["IR_LaserLight_Souce_Inf",objNull] isEqualTo objNull) then {
  deleteVehicle (_x getVariable "IR_LaserLight_Souce_Inf");
  _x setVariable ["IR_LaserLight_Souce_Inf",objNull];
};

if !(_x getVariable ["IR_LaserLight_Souce_Air",[]] isEqualTo []) then {
  {deleteVehicle _x} forEach (_x getVariable "IR_LaserLight_Souce_Air");
  _x setVariable ["IR_LaserLight_Souce_Air",[]];
};
