(allUnits + vehicles) select {
	//Conditions
	(
		(_x call BCE_fnc_isLaserOn) &&
		(alive _x)
	)
};
