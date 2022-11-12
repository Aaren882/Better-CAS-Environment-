(allUnits + vehicles) select {
  //Conditions
  (
    (isLaserOn _x) &&
    (alive _x)
  )
};
