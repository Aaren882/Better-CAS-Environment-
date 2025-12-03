#include "Configs\UI_Components.hpp"

//- This is for "RscDisplayMainMap"
#define MAP_TOGGLE_X(INDEX,SPC) QUOTE(safezoneX + safezoneW - INDEX * (2.5 * (((safezoneW / safezoneH) min 1.2) / 40)) - (SPC * 0.015))
#define MAP_TOGGLE_Y(INDEX,SPC) QUOTE((2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)) + INDEX * (0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (SPC * 0.01))
