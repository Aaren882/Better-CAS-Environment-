/*
  NAME : BCE_fnc_UnstuckUnit
*/
// Make AI unstuck. Due to various bugs, the AI can sometimes get stuck.
// Giving them these commands will often get the AI unstuck.

params ["_unit"];

(gunner _unit) doWatch objNull;
// sleep 1;
// _unit doWatch objNull;
// sleep 0.1;
// _unit doArtilleryFire [[0,0,0], "30Rnd_65x39_caseless_mag", 0];
// sleep 0.5;
// _unit doWatch objNull;
// sleep 1;
// _unit doArtilleryFire [[0,0,0], "30Rnd_65x39_caseless_mag", 0];
// sleep 0.5;
// _unit doWatch objNull;
// sleep 0.1;