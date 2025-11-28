class RscDisplayEmpty_BCE
{
	movingEnable = 0;
	idd = 1022553;
};
class RscTitles
{
	titles[] += {"BCE_Task_Receiver","BCE_TGP_View_GUI","BCE_HCAM_View","BCE_PhoneCAM_View","default"};
	class default
	{
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};
	#include "Task_Receiver.hpp"
	
	class BCE_TGP_View_GUI
	{
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 1e+007;
		enableSimulation = 1;
		movingEnable = 0;
		name = "BCE_TGP_View_GUI";
		onLoad = "uiNamespace setVariable ['BCE_TGP', _this # 0]";
		class controls
		{
			#define ABSXL(MUTI) MUTI*(safezoneXAbs + 0.08 * safezoneW)
			#define ABSYD(MUTI,CON) (safezoneY + safezoneH - (0.09 * safezoneW))-(MUTI*(CON))
			
			//info text
			class trckg: RscText
			{
				idc = 1006;
				x = QUOTE(safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2));
				y = QUOTE(ABSYD(0,0));
				w = 0.3;
				h = 0.05;
				text = "TRACKING ON";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//Crew
			class Pilot: RscText
			{
				idc = 1028;
				text = "Pilot:";
				x = QUOTE(safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2));
				y = QUOTE(ABSYD(1.8,0.0275 * safezoneH));
				w = QUOTE(0.123788 * safezoneW);
				h = QUOTE(0.0275 * safezoneH);
				colorText[] = {1,1,1,1};
				sizeEx = QUOTE(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2);
			};
			class Gunner: Pilot
			{
				idc = 1029;
				text = "Gunner:";
				y = QUOTE(ABSYD(2.8,0.0275 * safezoneH));
			};
			
			#define ABSYU(MUTI,CON) (safezoneY + 0.07 * safezoneW) + (MUTI * (CON))
			class uhf: RscText
			{
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYU(0,0));
				w = 0.2;
				h = 0.05;
				text = "UHF ACTIVE";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class navflr: RscText
			{
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYU(1,0.05));
				w = 0.3;
				h = 0.1;
				text = "FLIR ENABLED";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//Engine
			class Engine_State: RscText
			{
				idc = 1025;
				text = "ENG";
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYU(3,0.05));
				w = QUOTE(0.0618939 * safezoneW);
				h = QUOTE(0.044 * safezoneH);
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//Fuel
			class Fuel_State: RscText
			{
				idc = 1026;
				text = "Fuel:100%";
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYU(4,0.05));
				w = QUOTE(0.0618939 * safezoneW);
				h = QUOTE(0.044 * safezoneH);
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
			};
			
			#define ABSYR(MUTI,CON) MUTI * (CON) + (safezoneY + 0.07 * safezoneW)
			
			//coordinates
			class cx: RscText
			{
				idc = 1002;
				x = QUOTE(safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2));
				y = QUOTE(ABSYR(0,0));
				w = 0.2;
				h = 0.05;
				text = "Altitude";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			};
			class cy: cx
			{
				idc = 1003;
				y = QUOTE(ABSYR(1,0.05));
				text = "Grid";
			};
			class Zoom: cx
			{
				idc = 1004;
				y = QUOTE(ABSYR(2,0.05));
				text = "Zoom";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//view type
			class nv: RscText
			{
				idc = 1005;
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYD(0,0));
				w = 0.3;
				h = 0.05;
				text = "CMODE NORMAL";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//time
			class time_data: RscText
			{
				idc = 1001;
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYD(0.8,0.1));
				w = 0.3;
				h = 0.1;
				text = "16:56:34";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class Vehicle_Type: RscText
			{
				idc = 1030;
				text = "Type of Vehicle";
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYD(1.6,0.1));
				w = 0.6;
				h = 0.1;
				sizeEx = QUOTE(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.6);
			};
			//-Weapon Info
			class Weapon: RscText
			{
				idc = 1027;
				text = "Gatling Gun";
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYD(2.4,0.1));
				w = 0.6;
				h = QUOTE(0.0393706 * safezoneH);
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
			};
			#define ABSYW(MUTI) ((ABSYD(2.4,0.1)) - (MUTI*(0.0393706 * safezoneH)))
			class Ammo: Weapon
			{
				idc = 1031;
				text = "AMMO TYPE: HEAT";
				y = QUOTE(ABSYW(0.8));
			};
			class FiringMode: Weapon
			{
				idc = 1032;
				text = "Mode";
				y = QUOTE(ABSYW(1.6));
			};
			class GunDelayX: RscPictureKeepAspect
			{
				idc = 1033;
				x = QUOTE(0.436905 * safezoneW + safezoneX);
				y = QUOTE(0.387963 * safezoneH + safezoneY);
				w = QUOTE(0.126601 * safezoneW);
				h = QUOTE(0.225 * safezoneH);
				text = "A3\Ui_f\data\IGUI\RscIngameUI\RscOptics\laser_icon_X.paa";
			};
			
			//Laser
			class Laseron: RscText
			{
				idc = 1023;
				style = 2;
				shadow = 0;
				x = QUOTE(safezoneX);
				y = QUOTE(0.242 * safezoneH + safezoneY);
				w = QUOTE(safezoneW);
				h = QUOTE(0.044 * safezoneH);
				colorText[] = {1,0,0,1};
				text = "L T D / R";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//frame
			class frame_left_up_h: BCE_RscLine
			{
				x = QUOTE(safezoneXAbs + 0.05 * safezoneW);
				y = QUOTE(safezoneY + 0.05 * safezoneW);
				w = QUOTE(0.06 * safezoneW);
				h = QUOTE(0.003);
			};
			class frame_left_up_v: BCE_RscLine
			{
				x = QUOTE(safezoneXAbs + 0.05 * safezoneW);
				y = QUOTE(safezoneY + 0.05 * safezoneW);
				w = QUOTE(0.003);
				h = QUOTE(0.06 * safezoneW);
			};
			class frame_right_down_h: BCE_RscLine
			{
				x = QUOTE(safezoneXAbs + safezoneWAbs - ((0.05 * safezoneW) + (0.06 * safezoneW)));
				y = QUOTE(safezoneY + safezoneH - ((0.05 * safezoneW) + 0.003));
				w = QUOTE(0.06 * safezoneW);
				h = QUOTE(0.003);
			};
			class frame_right_down_v: BCE_RscLine
			{
				x = QUOTE(safezoneXAbs + safezoneWAbs - (0.05 * safezoneW));
				y = QUOTE(safezoneY + safezoneH - ((0.05 * safezoneW) + (0.06 * safezoneW)));
				w = QUOTE(0.003);
				h = QUOTE(0.06 * safezoneW);
			};
			class frame_left_down_h: BCE_RscLine
			{
				x = QUOTE(safezoneXAbs + 0.05 * safezoneW);
				y = QUOTE(safezoneY + safezoneH - ((0.05 * safezoneW) + 0.003));
				w = QUOTE(0.06 * safezoneW);
				h = QUOTE(0.003);
			};
			class frame_left_down_v: BCE_RscLine
			{
				x = QUOTE(safezoneXAbs + 0.05 * safezoneW);
				y = QUOTE(safezoneY + safezoneH - ((0.05 * safezoneW) + (0.06 * safezoneW)));
				w = QUOTE(0.003);
				h = QUOTE(0.06 * safezoneW);
			};
			class frame_right_up_h: frame_left_down_h
			{
				x = QUOTE(safezoneXAbs + safezoneWAbs - ((0.05 * safezoneW) + (0.06 * safezoneW)));
				y = QUOTE(safezoneY + 0.05 * safezoneW);
			};
			class frame_right_up_v: frame_left_down_v
			{
				x = QUOTE(safezoneXAbs + safezoneWAbs - (0.05 * safezoneW));
				y = QUOTE(safezoneY + 0.05 * safezoneW);
			};
			
			//Middle
			class middle_left: BCE_RscLine
			{
				x = QUOTE(0.39751 * safezoneW + safezoneX);
				y = QUOTE(0.5 * safezoneH + safezoneY);
				w = QUOTE(0.08 * safezoneW);
				h = QUOTE(0.002);
			};
			class middle_right: middle_left
			{
				x = QUOTE(0.523078 * safezoneW + safezoneX);
			};
			
			class middle_down: BCE_RscLine
			{
				x = QUOTE(0.5 * safezoneW + safezoneX);
				y = QUOTE(0.540741 * safezoneH + safezoneY);
				w = QUOTE(0.002);
				h = QUOTE(0.08 * safezoneW);
			};
			
			//Status
			class Bearing: RscText
			{
				idc = 1024;
				shadow = 0;
				style = 2;
				text = "180";
				x = QUOTE(0.48 * safezoneW + safezoneX);
				y = QUOTE(0.12963 * safezoneH + safezoneY);
				w = QUOTE((((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5) * safezoneH);
				h = QUOTE(0.0356667 * safezoneH);
				colorText[] = {1,1,1,1};
				colorBackground[] = {0,0,0,0.4};
				font = "RobotoCondensed_BCE";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//-Exit Hint
			class Exit_hint: time_data
			{
				idc = 2025;
				style = 2;
				x = QUOTE(safezoneX);
				y = QUOTE(ABSYD(0.8,0.1));
				w = QUOTE(safezoneW);
				h = 0.1;
				text = "Press “Space” to Exit Camera";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			};
			
			//-Widgets
			class widget: RscControlsGroupNoScrollbars
			{
				idc = 2000;
				text = "";
				x = QUOTE(safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2));
				y = QUOTE((0.801853 * safezoneH + safezoneY) - (10 * (0.0275 * safezoneH)));
				w = QUOTE(0.123788 * safezoneW);
				h = QUOTE(7 * (0.0275 * safezoneH));
				class controls
				{
					class NameList: RscListBox
					{
						IDC = 100;
						text = "";
						x = QUOTE(0);
						y = QUOTE(0.025);
						w = QUOTE(0.123788 * safezoneW);
						h = QUOTE(10 * (0.0275 * safezoneH));
						colorBackground[] = {0,0,0,0};
						sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
						shadow = 1;
					};
				};
			};
			
			//-Environment
			class Environment: RscListBox
			{
				idc = 101;
				text = "";
				x = QUOTE(ABSXL(1));
				y = QUOTE(ABSYU(4.1,0.1));
				w = QUOTE(0.123788 * safezoneW);
				h = QUOTE(5 * (0.0275 * safezoneH));
				colorBackground[] = {0,0,0,0};
				sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				shadow = 2;
				class Items
				{
					class temp
					{
						text = "$STR_BCE_Env_temp";
						data = "['%1°C', round (ambientTemperature # 0)]";
					};
					class humidity
					{
						text = "$STR_BCE_Env_humidity";
						data = "['%1%2', round (humidity * 10) * 10, '%']";
					};
					class wind
					{
						text = "$STR_BCE_Env_wind";
					};
					class fog
					{
						text = "$STR_BCE_Env_fog";
					};
					class visibility
					{
						text = "$STR_BCE_Env_visibility";
						textright = "Good";
					};
				};
			};
		};
	};
};