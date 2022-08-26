class RscTitles
{
	titles[] += {"BCE_TGP_View_GUI","default"};
	class default
	{
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};
	class BCE_TGP_View_GUI
	{
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 99999;
		enableSimulation = 1;
		name = "BCE_TGP_View_GUI";
		onLoad = "uiNamespace setVariable ['BCE_TGP', _this # 0]";
		class controls
		{
			//time
			class cbt: RscInfoBack
			{
				x = safezoneXAbs + 0.077 * safezoneW;
				y = safezoneY + safezoneH - (0.112 * safezoneW);
				w = 0.075 * safezoneW;
				h = 0.062 * safezoneH;
			};
			class time_data: RscText
			{
				idc = 1001;
				x = safezoneXAbs + 0.08 * safezoneW;
				y = safezoneY + safezoneH - (0.12 * safezoneW);
				w = 0.2;
				h = 0.1;
				text = "16:56:34";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//info text
			class cbi: RscInfoBack
			{
				ColorBackground[] = {0,1,0,0.4};
				x = safezoneXAbs + 0.077 * safezoneW;
				y = safezoneY + 0.067 * safezoneW;
				w = 0.067 * safezoneW;
				h = 0.062 * safezoneH;
			};
			class navflr: RscText
			{
				x = safezoneXAbs + 0.08 * safezoneW;
				y = safezoneY + 0.088 * safezoneW;
				w = 0.3;
				h = 0.1;
				text = "FLIR ENABLED";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class cbr: RscInfoBack
			{
				ColorBackground[] = {1,0,0,0.4};
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.21);
				y = safezoneY + safezoneH - (0.09 * safezoneW);
				w = 0.075 * safezoneW;
				h = 0.032 * safezoneH;
			};
			class trckg: RscText
			{
				idc = 1006;
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = safezoneY + safezoneH - (0.09 * safezoneW);
				w = 0.3;
				h = 0.05;
				text = "TRACKING ON";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class uhf: RscText
			{
				x = safezoneXAbs + 0.08 * safezoneW;
				y = safezoneY + 0.07 * safezoneW;
				w = 0.2;
				h = 0.05;
				text = "UHF ACTIVE";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//coordinates
			class cbk: RscInfoBack
			{
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.21);
				y = safezoneY + 0.067 * safezoneW;
				w = 0.07 * safezoneW;
				h = 0.09 * safezoneH;
			};
			class cx: RscText
			{
				idc = 1002;
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = safezoneY + 0.07 * safezoneW;
				w = 0.2;
				h = 0.05;
				text = "Altitude";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			};
			class cy: RscText
			{
				idc = 1003;
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = safezoneY + 0.085 * safezoneW;
				w = 0.2;
				h = 0.05;
				text = "Grid";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			};
			class cz: RscText
			{
				idc = 1004;
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = safezoneY + 0.11 * safezoneW;
				w = 0.2;
				h = 0.05;
				text = "FOV";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//view type
			class nv: RscText
			{
				idc = 1005;
				x = safezoneXAbs + 0.08 * safezoneW;
				y = safezoneY + safezoneH - (0.09 * safezoneW);
				w = 0.3;
				h = 0.05;
				text = "CMODE NORMAL";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//Laser
			class Laseron: RscText
			{
				idc = 1023;
				shadow = 0;
				x = 0.472413 * safezoneW + safezoneX;
				y = 0.242 * safezoneH + safezoneY;
				w = 0.0557045 * safezoneW;
				h = 0.044 * safezoneH;
				colorText[] = {1,0,0,1};
				text = "L T D / R";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//frame
			class frame_left_up_h: RscLine
			{
				x = safezoneXAbs + 0.05 * safezoneW;
				y = safezoneY + 0.05 * safezoneW;
				w = 0.06 * safezoneW;
				h = 0.003;
			};
			class frame_left_up_v: RscLine
			{
				x = safezoneXAbs + 0.05 * safezoneW;
				y = safezoneY + 0.05 * safezoneW;
				w = 0.003;
				h = 0.06 * safezoneW;
			};
			class frame_right_down_h: RscLine
			{
				x = safezoneXAbs + safezoneWAbs - ((0.05 * safezoneW) + (0.06 * safezoneW));
				y = safezoneY + safezoneH - ((0.05 * safezoneW) + 0.003);
				w = 0.06 * safezoneW;
				h = 0.003;
			};
			class frame_right_down_v: RscLine
			{
				x = safezoneXAbs + safezoneWAbs - (0.05 * safezoneW);
				y = safezoneY + safezoneH - ((0.05 * safezoneW) + (0.06 * safezoneW));
				w = 0.003;
				h = 0.06 * safezoneW;
			};
			class frame_left_down_h: RscLine
			{
				x = safezoneXAbs + 0.05 * safezoneW;
				y = safezoneY + safezoneH - ((0.05 * safezoneW) + 0.003);
				w = 0.06 * safezoneW;
				h = 0.003;
			};
			class frame_left_down_v: RscLine
			{
				x = safezoneXAbs + 0.05 * safezoneW;
				y = safezoneY + safezoneH - ((0.05 * safezoneW) + (0.06 * safezoneW));
				w = 0.003;
				h = 0.06 * safezoneW;
			};
			class frame_right_up_h: frame_left_down_h
			{
				x = safezoneXAbs + safezoneWAbs - ((0.05 * safezoneW) + (0.06 * safezoneW));
				y = safezoneY + 0.05 * safezoneW;
			};
			class frame_right_up_v: frame_left_down_v
			{
				x = safezoneXAbs + safezoneWAbs - (0.05 * safezoneW);
				y = safezoneY + 0.05 * safezoneW;
			};
			
			//Middle
			class middle_left: RscLine
			{
				x = 0.39751 * safezoneW + safezoneX;
				y = 0.5 * safezoneH + safezoneY;
				w = 0.08 * safezoneW;
				h = 0.002;
			};
			class middle_right: middle_left
			{
				x = 0.523078 * safezoneW + safezoneX;
			};
			
			class middle_down: RscLine
			{
				x = 0.5 * safezoneW + safezoneX;
				y = 0.540741 * safezoneH + safezoneY;
				w = 0.002;
				h = 0.08 * safezoneW;
			};
			//Status
			class Bearing: RscText
			{
				idc = 1024;
				shadow = 0;
				text = "180";
				x = 0.48 * safezoneW + safezoneX;
				y = 0.12963 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.0356667 * safezoneH;
				colorText[] = {1,1,1,1};
				colorBackground[] = {0,0,0,0.4};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//Engine
			class Engine_State_W: RscText
			{
				idc = 1025;
				text = "ENG";
				x = safezoneXAbs + 0.08 * safezoneW;
				y = 0.210148 * safezoneH + safezoneY;
				w = 0.0618939 * safezoneW;
				h = 0.044 * safezoneH;
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class Engine_State_Y: Engine_State_W
			{
				idc = 1052;
				colorText[] = {0.94,0.7,0,1};
			};
			class Engine_State_R: Engine_State_W
			{
				idc = 1053;
				colorText[] = {1,0,0,1};
			};
			
			class Fuel_State: RscText
			{
				idc = 1026;
				text = "Fuel:100%";
				x = safezoneXAbs + 0.08 * safezoneW;
				y = 0.255555 * safezoneH + safezoneY;
				w = 0.0618939 * safezoneW;
				h = 0.044 * safezoneH;
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
			};
			class Weapon: RscText
			{
				idc = 1027;
				text = "Gatling Gun";
				x = safezoneXAbs + 0.08 * safezoneW;
				y = 0.764815 * safezoneH + safezoneY;
				w = 0.6;
				h = 0.0393706 * safezoneH;
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
			};
			
			//Crew
			class Pilot: RscText
			{
				idc = 1028;
				text = "Pilot:";
				x = 0.857553 * safezoneW + safezoneX;
				y = 0.801853 * safezoneH + safezoneY;
				w = 0.123788 * safezoneW;
				h = 0.0275 * safezoneH;
				colorText[] = {1,1,1,1};
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2);
			};
			class Gunner: RscText
			{
				idc = 1029;
				text = "Gunner:";
				x = 0.857554 * safezoneW + safezoneX;
				y = 0.831482 * safezoneH + safezoneY;
				w = 0.123788 * safezoneW;
				h = 0.0275 * safezoneH;
				colorText[] = {1,1,1,1};
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2);
			};
			class Vehicle_Type: RscText
			{
				idc = 1030;
				text = "Type of Vehicle";
				x = safezoneXAbs + 0.08 * safezoneW;
				y = 0.8 * safezoneH + safezoneY;
				w = 0.6;
				h = 0.1;
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.6);
			};
		};
	};
};