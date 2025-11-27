/*
	NAME : BCE_fnc_getGroupVehicles
	
	Return : Array of vehicles in the group
		[<OBJECT>...]
*/

params ["_group"];

private _vehs = (units _group) apply {objectParent _x}; 
(_vehs arrayIntersect _vehs) select {alive _x};
