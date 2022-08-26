//Thanks For Killzone_Kid
//Link: http://killzonekid.com/arma-scripting-tutorials-get-zoom/

(
  [0.5,0.5]
  distance2D
  worldToScreen
  positionCameraToWorld
  [0,3,4]
) * (
  getResolution
  select 5
) / 2
