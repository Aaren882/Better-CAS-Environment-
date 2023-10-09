class RscDisplayEmpty_BCE
{
	movingEnable = 0;
	idd = 1022553;
};
class RscTitles
{
	titles[] += {"BCE_Task_Receiver","BCE_TGP_View_GUI","default"};
	class default
	{
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};
	#include "Task_Receiver.hpp"
	
	#ifdef cTAB_Installed
		#include "cTab\cTab_classes.hpp"
		#define PHONE_CLASS class cTab_Android_dsp
		
		#define phoneSizeX (((452)) / 2048 * (0.86) + (safezoneX - (0.86) * 0.17))
		#define phoneSizeY ((((713) + (60))) / 2048 * ((0.86) * 4/3) + (safezoneY + safezoneH * 0.88 - ((0.86) * 4/3) * 0.72))
		#define phoneSizeW ((((PHONE_MOD))) / 2048 * (0.86))
		#define phoneSizeH ((((626) - (60) - (0))) / 2048 * ((0.86) * 4/3))
		
		#define MOUSE_CLICK_EH ""
		
		#define PhoneH (safezoneH * 0.8)
		#define PhoneW (0.86)
		#define TextSize (((38)) / 2048 * (PhoneW * 4/3))
		
		#define cTab_Set_SubMenu \
			DUMMY_CLASS
		
		#if MAP_MODE > 0
			class cTab_android_RscMapControl: RscMapControl{};
			class cTab_microDAGR_RscMapControl: RscMapControl{};
			class cTab_TAD_RscMapControl: RscMapControl{};
		#endif
		
		#if MAP_MODE > 2
			class cTab_TAD_dsp
			{
				class controlsBackground
				{
					class screen: cTab_TAD_RscMapControl{}; 
					class screenTopo: screen
					{
						#include "Map_Type\TOPO_AIR.hpp"
					};
				};
			};
			class cTab_microDAGR_dsp
			{
				class controlsBackground
				{
					class screen: cTab_microDAGR_RscMapControl{}; 
					class screenTopo: screen
					{
						#include "Map_Type\TOPO_GRD.hpp"
					};
				};
			};
		#endif
		
		//-Phone display
		#include "cTab\cTab_Android.hpp"
	#endif
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
			#define ABSYD(MUTI,CON)(safezoneY + safezoneH - (0.09 * safezoneW))-(MUTI*(CON))
			
			//info text
			class trckg: RscText
			{
				idc = 1006;
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = ABSYD(0,0);
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
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = ABSYD(1.8,0.0275 * safezoneH);
				w = 0.123788 * safezoneW;
				h = 0.0275 * safezoneH;
				colorText[] = {1,1,1,1};
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2);
			};
			class Gunner: Pilot
			{
				idc = 1029;
				text = "Gunner:";
				y = ABSYD(2.8,0.0275 * safezoneH);
			};
			
			#define ABSYU(MUTI,CON)(safezoneY + 0.07 * safezoneW)+(MUTI*(CON))
			class uhf: RscText
			{
				x = ABSXL(1);
				y = ABSYU(0,0);
				w = 0.2;
				h = 0.05;
				text = "UHF ACTIVE";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class navflr: RscText
			{
				x = ABSXL(1);
				y = ABSYU(1,0.05);
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
				x = ABSXL(1);
				y = ABSYU(3,0.05);
				w = 0.0618939 * safezoneW;
				h = 0.044 * safezoneH;
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//Fuel
			class Fuel_State: RscText
			{
				idc = 1026;
				text = "Fuel:100%";
				x = ABSXL(1);
				y = ABSYU(4,0.05);
				w = 0.0618939 * safezoneW;
				h = 0.044 * safezoneH;
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
			};
			
			#define ABSYR(MUTI,CON) (MUTI*(CON)+(safezoneY + 0.07 * safezoneW))
			
			//coordinates
			class cx: RscText
			{
				idc = 1002;
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = ABSYR(0,0);
				w = 0.2;
				h = 0.05;
				text = "Altitude";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			};
			class cy: cx
			{
				idc = 1003;
				y = ABSYR(1,0.05);
				text = "Grid";
			};
			class Zoom: cx
			{
				idc = 1004;
				y = ABSYR(2,0.05);
				text = "Zoom";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//view type
			class nv: RscText
			{
				idc = 1005;
				x = ABSXL(1);
				y = ABSYD(0,0);
				w = 0.3;
				h = 0.05;
				text = "CMODE NORMAL";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			//time
			class time_data: RscText
			{
				idc = 1001;
				x = ABSXL(1);
				y = ABSYD(0.8,0.1);
				w = 0.3;
				h = 0.1;
				text = "16:56:34";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			class Vehicle_Type: RscText
			{
				idc = 1030;
				text = "Type of Vehicle";
				x = ABSXL(1);
				y = ABSYD(1.6,0.1);
				w = 0.6;
				h = 0.1;
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.6);
			};
			//-Weapon Info
			class Weapon: RscText
			{
				idc = 1027;
				text = "Gatling Gun";
				x = ABSXL(1);
				y = ABSYD(2.4,0.1);
				w = 0.6;
				h = 0.0393706 * safezoneH;
				colorText[] = {1,1,1,1};
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
			};
			#define ABSYW(MUTI) (ABSYD(2.4,0.1))-(MUTI*(0.0393706 * safezoneH))
			class Ammo: Weapon
			{
				idc = 1031;
				text = "AMMO TYPE: HEAT";
				y = ABSYW(0.8);
			};
			class FiringMode: Weapon
			{
				idc = 1032;
				text = "Mode";
				y = ABSYW(1.6);
			};
			class GunDelayX: RscPictureKeepAspect
			{
				idc = 1033;
				x = 0.436905 * safezoneW + safezoneX;
				y = 0.387963 * safezoneH + safezoneY;
				w = 0.126601 * safezoneW;
				h = 0.225 * safezoneH;
				text = "A3\Ui_f\data\IGUI\RscIngameUI\RscOptics\laser_icon_X.paa";
			};
			
			//Laser
			class Laseron: RscText
			{
				idc = 1023;
				style = 2;
				shadow = 0;
				x = safezoneX;
				y = 0.242 * safezoneH + safezoneY;
				w = safezoneW;
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
				font = "RobotoCondensed_BCE";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			};
			
			//-Exit Hint
			class Exit_hint: time_data
			{
				idc = 2025;
				style = 2;
				x = safezoneX;
				y = ABSYD(0.8,0.1);
				w = safezoneW;
				h = 0.1;
				text = "Press “Space” to Exit Camera";
				SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			};
			
			//-Widgets
			class widget: RscControlsGroupNoScrollbars
			{
				idc = 2000;
				text = "";
				x = safezoneXAbs + safezoneWAbs - ((0.06 * safezoneW) + 0.2);
				y = (0.801853 * safezoneH + safezoneY) - (10 * (0.0275 * safezoneH));
				w = 0.123788 * safezoneW;
				h = 7 * (0.0275 * safezoneH);
				class controls
				{
					class NameList: RscListBox
					{
						IDC = 100;
						text = "";
						x = 0;
						y = 0.025;
						w = 0.123788 * safezoneW;
						h = 10 * (0.0275 * safezoneH);
						colorBackground[] = {0,0,0,0};
						sizeEx = 0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18);
						shadow = 1;
					};
				};
			};
			
			//-Environment
			class Environment: RscListBox
			{
				idc = 101;
				text = "";
				x = ABSXL(1);
				y = ABSYU(4.1,0.1);
				w = 0.123788 * safezoneW;
				h = 5 * (0.0275 * safezoneH);
				colorBackground[] = {0,0,0,0};
				sizeEx = 0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18);
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