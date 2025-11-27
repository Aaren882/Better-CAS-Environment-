alphaFadeStartScale = 10;
alphaFadeEndScale = 10;
ptsPerSquareTxt = 500;
ptsPerSquareFor = 15;
ptsPerSquareForEdge = 15;
ptsPerSquareRoad = 6;
ptsPerSquareMainRoad = 6;
ptsPerSquareObjLod1 = 2;
ptsPerSquareForLod1 = 4;
ptsPerSquareForLod2 = 1;
ptsPerSquareRoadSimple = 0.01;
ptsPerSquareMainRoadSimple = 0.01;
compassPos[] = {-0.04,0};
compassSize[] = {0.08,0.08};
colorBackground[] = {0.92,0.92,0.9,1};
colorSea[] = {0,0.27,0.5,0.3};
colorForest[] = {0.56,0.81,0,0.5};
colorForestBorder[] = {0.22,0.5,0,0.5};
colorRocks[] = {0.33,0.33,0.33,1};
colorRocksBorder[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])",0.5};
colorLevels[] = {0.68,0.43,0.27,1};
colorMainCountlines[] = {0.73,0.48,0.31,1};
colorCountlines[] = {0.73,0.48,0.31,0.5};
colorMainCountlinesWater[] = {0,0.27,0.5,1};
colorCountlinesWater[] = {0,0.27,0.5,0.25};
colorPowerLines[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])",0.5};
colorRailWay[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])",1};
colorTracks[] = {0,0,0,1};
colorTracksFill[] = {0.69,0.69,0.69,1};
colorRoads[] = {0.74,0.59,0,1};
colorRoadsFill[] = {1,1,0,1};
colorMainRoads[] = {0.88,0.31,0,1};
colorMainRoadsFill[] = {1,0.48,0.16,1};
colorGrid[] = {0.1,0.1,0.1,1};
colorGridMap[] = {0.1,0.1,0.1,0.275};
showCountourInterval = 1;
scaleMax = 1.3;
scaleDefault = 0.095;
speedCoefSpeed0 = 300;
speedCoefSpeedMax = 55;
maxSatelliteAlpha = 0;
sizeEx = 0.04;
sizeExGrid = 0.025;
sizeExLevel = 0.025;
drawShaded = 0;
shadedSea = 0;
ptsPerSquareObj = 5.5;
colorOutside[] = {0,0.18,0.33,1};
colorNames[] = {0.1,0.1,0.1,1};
colorForestTextured[] = {0.56,0.81,0,0.5};
widthRailWay = 10;
colorTrails[] = {0.51,0.41,0.33,0};
colorTrailsFill[] = {0.51,0.41,0.33,1};

class tree
{
	coefMax = 4;
	coefMin = 0.25;
	color[] = {0,0,0,0};
	icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
	importance = "0.2 * 14 * 0.05 * 0.05";
	size = "14/2";
};

class smalltree
{
	coefMax = 4;
	coefMin = 0.25;
	color[] = {0,0,0,0};
	icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
	importance = "0.2 * 14 * 0.05 * 0.05";
	size = "14/2";
};

class bush
{
	coefMax = 4;
	coefMin = 0.25;
	color[] = {0,0,0,0};
	icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
	importance = "0.2 * 14 * 0.05 * 0.05";
	size = "14/2";
};

class rock
{
	coefMax = 4;
	coefMin = 0.25;
	color[] = {0,0,0,0};
	icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
	importance = "0.2 * 14 * 0.05 * 0.05";
	size = "14/2";
};

class Legend
{
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
	y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
	font = "RobotoCondensed";
	colorBackground[] = {0,0,0,0};
	color[] = {0,0,0,0};
};