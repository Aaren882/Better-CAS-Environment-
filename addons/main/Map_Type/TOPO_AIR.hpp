drawShaded = 0.1;
altitudeMapColorLow[] = {0,0,0,0};
altitudeMapColorHigh[] = {1,0,0,0.5};
altitudeMapColorMid[] = {1,0,0,0.5};
colorForest[] = {0.56,0.81,0,0};
colorSea[] = {0,0.27,0.5,1};
colorPowerLines[] = {0,1,0,1};
widthPowerLines = 6;
speedCoefSpeed0 = 150;
speedCoefSpeedMax = 60;
sizeExLevel = 0.016;
ptsPerSquareFor = 200;
ptsPerSquareForEdge = 200;
ptsPerSquareForLod1 = 200;
ptsPerSquareForLod2 = 200;
ptsPerSquareObj = 1.25;
ptsPerSquareObjLod1 = 200;
ptsPerSquareRoadSimple = 0.5;
ptsPerSquareTxt = 200;
colorBackground[] = {0.25,0.25,0.25,1};
colorOutside[] = {0,0.18,0.33,1};
colorGrid[] = {0.9,0.9,0.9,1};
colorGridMap[] = {0.9,0.9,0.9,0.3};
colorText[] = {0.9,0.9,0.9,1};
colorNames[] = {0.9,0.9,0.9,1};
colorForestBorder[] = {0.22,0.5,0,0};
colorForestTextured[] = {0.56,0.81,0,0};
colorMainCountlines[] = {0.9,0.9,0.9,1};
colorCountlines[] = {0.9,0.9,0.9,0.5};
colorMainCountlinesWater[] = {0,0.27,0.5,0};
colorCountlinesWater[] = {0,0.27,0.5,0};
colorLevels[] = {0.9,0.9,0.9,1};
colorMainRoads[] = {1,0.48,0.16,1};
colorMainRoadsFill[] = {1,0.48,0.16,1};
colorRoads[] = {1,1,0,1};
colorRoadsFill[] = {1,1,0,1};
colorTracks[] = {0.69,0.69,0.69,1};
colorTracksFill[] = {0.69,0.69,0.69,1};
colorTrails[] = {0.51,0.41,0.33,0};
colorTrailsFill[] = {0.51,0.41,0.33,0};
altitudeMapRange = 50;
class Bunker: Bunker
{
	size = 24;
};
class busstop: busstop
{
	color[] = {0,0,0,0};
};
class Chapel: Chapel
{
	color[] = {0,0,0,0};
};
class church: church
{
	size = 16;
};
class Cross: Cross
{
	color[] = {0,0,0,0};
};
class Fountain: Fountain
{
	color[] = {0,0,0,0};
};
class Fortress: Fortress
{
	size = 24;
};
class fuelstation: fuelstation
{
	color[] = {0,0,0,0};
};
class hospital: hospital
{
	size = 24;
};
class Legend: Legend
{
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
	y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
	colorBackground[] = {0,0,0,0};
	color[] = {0,0,0,0};
};
class lighthouse: lighthouse
{
	size = 16;
};
class power: power
{
	size = 16;
};
class powersolar: powersolar
{
	size = 16;
};
class powerwave: powerwave
{
	color[] = {0,0,0,0};
};
class powerwind: powerwind
{
	size = 16;
};
class quay: quay
{
	color[] = {0,0,0,0};
};
class ruin: Ruin
{
	size = 16;
};
class shipwreck: shipwreck
{
	color[] = {0,0,0,0};
};
class Stack: Stack
{
	size = 16;
};
class Tourism: Tourism
{
	color[] = {0,0,0,0};
};
class transmitter: transmitter
{
	size = 16;
};
class viewtower: ViewTower
{
	size = 16;
};
class watertower: watertower
{
	size = 16;
};