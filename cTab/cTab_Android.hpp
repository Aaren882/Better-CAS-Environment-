#define Android_BR_InfoY(HEIGHT) ((-(0) + (713) + (626)) - (20) - ((60) - (20))) / 2048  * (PhoneW * 4/3) + (safezoneY + (safezoneH - (PhoneW * 4/3)) / 2) - (HEIGHT * (((32)) / 2048 * PhoneW))
#ifdef MOUSE_CLICK_EH
	class cTab_android_on_screen_hookGrid: cTab_RscText_Android
	{
		x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (1 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX;
		y = Android_BR_InfoY(3);
		h = (((42) - (10))) / 2048 * PhoneW;
		colorText[] = {0.95,0.95,0.95,1};
		sizeEx = ((27)) / 2048 * PhoneW;
	};
	class cTab_android_on_screen_hookElevation: cTab_android_on_screen_hookGrid
	{
		y = Android_BR_InfoY(2);
	};
	class cTab_android_on_screen_hookDst: cTab_android_on_screen_hookGrid
	{
		y = Android_BR_InfoY(1);
	};
#endif

//-Edited Origins
class cTab_android_on_screen_dirOctant: cTab_Tablet_OSD_dirOctant
{
	x = ((((10) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (0.35))) / 2048 * PhoneW + CustomPhoneX;
	y = ((713) + ((60) - (38)) / 2) / 2048 * CustomPhoneH + CustomPhoneY;
	w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
	h = ((40)) / 2048 * CustomPhoneH;
	
	action = "['cTab_Android_dlg'] call cTab_fnc_toggleWeather";
	
	size = 0.8 * ((((60) - (20))) / 2048 * CustomPhoneH);
	
	class TextPos
	{
		left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
		top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
		right = 0;
		bottom = 0;
	};
	
	class Attributes: Attributes
	{
		size = TextMenu(0.9);
	};
};

//-ATAK Menu W
#define ATAK_POS_H (((60)) / 2048 * CustomPhoneH)
#define ATAK_POS_W ((phoneSizeW * 2/5)/3)
#define PhoneBFTContainerW(AxisX) AxisX * ATAK_POS_W

#define ATAK_POS(XPOS,YPOS,WPOS,HPOS) \
	x = PhoneBFTContainerW(XPOS); \
	y = YPOS * ATAK_POS_H; \
	w = PhoneBFTContainerW(WPOS); \
	h = HPOS * ATAK_POS_H

//- Custom Controls
#include "cTab_Custom_Controls.hpp"

//- BCE Frameworks for ATAK
#include "ATAK_Tools\cTab_ATAK_APP.hpp"
#include "ATAK_Tools\cTab_ATAK_Tools.hpp"

PHONE_CLASS
{
	/* #define GLUE(A,B) #A;##B
	#define IS_DSP true */
	#ifdef MOUSE_CLICK_EH
		/* TaskIDCs_List[] = {
			//- 9 Line
			{93,94,95,96,97,98,99,idc_D(2025),idc_D(2026),idc_D(20260),idc_D(2027),idc_D(20270),idc_D(2015),idc_D(2029),idc_D(2030),idc_D(2031),idc_D(2032)},
			//- 5 Line
			{51,52,53,54,idc_D(2040),idc_D(2041),idc_D(2042),idc_D(2027),idc_D(20430),idc_D(2015),idc_D(2016)}
			//- Call For Fire
			// {51,52,53,54,idc_D(2040),idc_D(2041),idc_D(2042),idc_D(2027),idc_D(20430),idc_D(2015),idc_D(2016)}
		}; */
		onMouseZChanged = "call BCE_fnc_ATAK_getScrollValue";
		// #define IS_DSP false
	#endif

	/* #define ONLOAD_FNC \
		#call BCE_fnc_onLoad_Display
	#define ONLOAD_FNC_BCE \
		#[_this # 0, PHONE_CLASS, IS_DSP] call cTab_fnc_onIfOpen
	onLoad = GLUE(ONLOAD_FNC,ONLOAD_FNC_BCE); //- when the phone is opened

	#undef GLUE
	#undef ONLOAD_FNC
	#undef ONLOAD_FNC_BCE
	#undef IS_DSP */
	class controlsBackground: BCE_Mission_Build_Controls
	{
		//- BCE Mission Holder (Init BCE Properties)
			class BCE_Holder: BCE_Holder
			{
				// #LINK - Mission_Property.hpp
				class BCE_Mission: BCE_Mission
				{
					class Air: Air //- Change UI Setups
					{
						9Line = "AIR_9_LINE_ATAK";
						5Line = "AIR_5_LINE_ATAK";
					};
					class GND: GND //- Change UI Setups
					{
						CFF = "CFF_ATAK";
					};
				};
			};
		class screen: cTab_android_RscMapControl
		{
			#ifdef MOUSE_CLICK_EH
				style = 48 + 512;
				onMouseButtonClick = MOUSE_CLICK_EH;
				onMouseButtonDblClick = "call cTab_fnc_onMapDoubleClick";
				onMouseZChanged = "[_this#0,-1,(_this#1) < 0] call BCE_fnc_ATAK_Camera_Controls";
			#endif
		};
		
		#if MAP_MODE > 2
			class screenTopo: screen
			{
				#include "..\Map_Type\TOPO_GRD.hpp"
			};
		#endif
		class AVmainFrame: cTab_RscFrame
		{
			idc = idc_D(4630);
			text = "$STR_BCE_AV_Camera";
			x = phoneSizeX + (((((452) + (20))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((713) + (60) + (10))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
			w = (((PHONE_MOD) - (20) * 2)) / 2048 * PhoneW;
			h = (((626) - (60) - (10) * 2)) / 2048 * (PhoneW * 4/3);
		};
		class AVCamFrame: cTab_RscFrame
		{
			idc = idc_D(4631);
			x = phoneSizeX + (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
		};
		class Vic_PIP_No_Signal: RscText
		{
			idc = idc_D(46310);
			style = 2;
			text = "$STR_BCE_No_Signal";
			sizeEx = TextSize;

			colorBackground[]={0,0,0,0.8};

			x = phoneSizeX + (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
		};
		class Vic_PIP_Display: RscPicture
		{
			idc = idc_D(4632);
			text = "";
			x = phoneSizeX + (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
		};
		
	};
	class controls
	{
		#ifdef MOUSE_CLICK_EH
		
			//-SubMenu + lerGTD SubMenu + BCE Submenu
			cTab_Set_SubMenu(SubMenuH_P);
		
			delete menuContainer;
			//-BFT
			class Map_Tool_Show: ctrlButton
			{
				idc = idc_D(1200);
				style = "0x02 + 0x30 + 0x800";
				text = "a3\3den\data\displays\display3den\toolbar\map_off_ca.paa";
				colorBackground[] = {0,0,0,0.3};
				x = sizeX + ((((((1341)) - (10) * 8) / 7)) / 2048 * (PhoneW * 3/4)) - (sizeW * (PhoneW * 3/4));
				Y = sizeY(0) - (sizeW * PhoneW);
				w = sizeW * (PhoneW * 3/4);
				h = sizeW * PhoneW;
				tooltip = "Toggle Map Tools";
				action = "['cTab_Android_dlg'] call cTab_fnc_toggleMapTools";
			};
			
			//- Marker
			#define MARKER_HEIGHT 8
			#define MARKER_W 1.5 * ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW
			#define MARKER_H (((42) - (10))) / 2048 * PhoneW
			class Marker_Edit: cTab_RscControlsGroup
			{
				idc = idc_D(1301);
				x = (452 / 2048 * PhoneW + CustomPhoneX) + ((PHONE_MOD / 2048 * PhoneW) / 2) - (MARKER_W /2);
				y = Android_BR_InfoY(7);
				w = MARKER_W;
				h = MARKER_HEIGHT * MARKER_H;

				class VScrollbar: VScrollbar
				{
					width = 0;
					scrollSpeed = 0;
				};
				class HScrollbar: HScrollbar
				{
					height = 0;
					scrollSpeed = 0;
				};
				class controls
				{
					class mainbg: cTab_IGUIBack
					{
						idc = -1;
						x = 0;
						y = 0;
						w = MARKER_W;
						h = MARKER_HEIGHT * MARKER_H;
						colorbackground[] = {0.2,0.2,0.2,0.4};
					};
					class Title: RscStructuredText
					{
						idc = -1;
						text = "Edit Marker <img image='\a3\3DEN\Data\Displays\Display3DEN\PanelRight\modeMarkers_ca.paa'/>";
						x = 0;
						y = 0;
						w = MARKER_W;
						h = MARKER_H;
						size = MARKER_H;
						colorBackground[] = 
						{
							"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.5
						};

						class Attributes
						{
							font = "RobotoCondensed_BCE";
							color = "#E5E5E5";
							align = "center";
							valign = "middle";
							size = "0.95";
						};
					};
					class DESC_Title: RscStructuredText
					{
						idc = -1;
						text = "$STR_LIB_LABEL_DESCRIPTION";
						x = 0;
						y = MARKER_H;
						w = MARKER_W;
						h = MARKER_H;
						colorBackground[] = {0,0,0,0};
						style = 0;
						shadow = 1;

						class Attributes
						{
							font = "RobotoCondensed_BCE";
							valign = "middle";
							shadow = "1";
						};
					};
					class DESC_Edit: RscEdit
					{
						idc = 10;
						text = "";
						x = 0.05 * MARKER_W;
						y = 2 * MARKER_H;
						w = 0.9 * MARKER_W;
						h = MARKER_H;
					};
					//- 2 Line Sliders
						class MarkerType: RscCombo
						{
							idc = 50;
							x = 0.05 * MARKER_W;
							y = 3 * MARKER_H;
							w = 0.425 * MARKER_W;
							h = MARKER_H;
							
							shadow=1;
							colorBackground[]={0.3,0.3,0.3,1};
							colorSelect[]={1,1,1,1};
							colorSelectBackground[]={0.2,0.2,0.2,1};
							wholeHeight=0.25;
						};
						class MarkerColor: MarkerType
						{
							idc = 51;
							x = 0.525 * MARKER_W;
						};

					//- from 3 line
						class Place_Desc: DESC_Title
						{
							idc = 100;
							text = "NW of Something Town";
							y = 4 * MARKER_H;

							colorBackground[] = {0,0,0,0.2};

							class Attributes: Attributes
							{
								size = "0.8";
								underline= "1";
								align = "center";
							};
						};
					//- Left Panel
						class Channel: MarkerType
						{
							idc = 110;
							x = 0;
							y = 5 * MARKER_H;
							w = 0.5 * MARKER_W;
							wholeHeight=0.15;
							class Items
							{
								class NA
								{
									text = "$STR_BCE_Widgets_System_Value";
									default = 1;
								};
							};
						};
						class Direction: Place_Desc
						{
							idc = 120;
							text = "$STR_A3_RscDisplayAVTerminal_AVT_Text_AZT";
							y = 6 * MARKER_H;
							w = 0.5 * MARKER_W;

							style = 0;
							class Attributes: Attributes
							{
								underline= "0";
								align = "left";
							};
						};
						class GRID: Direction
						{
							idc = 121;
							text = "$STR_A3_RscDisplayAVTerminal_AVT_Text_POS";
							y = 7 * MARKER_H;
						};
					//- Right Panel
						class Enter: BCE_RscButtonMenu
						{
							idc = 15;

							text = "$STR_DISP_OK";

							x = 0.5 * MARKER_W;
							y = 5 * MARKER_H;
							w = 0.5 * MARKER_W;
							h = 1.5 * MARKER_H;

							onButtonClick = "call cTab_fnc_FinishEDIT_Marker";

							colorBackground[] = {0.117647,0.968628,0.286275,0.3};
							size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

							colorBackground2[] = {0,0,0,0};
							colorBackgroundFocused[] = {0,0,0,0};

							animTextureDefault="#(argb,8,8,3)color(0,0,0,0)";
							animTextureNormal="#(argb,8,8,3)color(1,1,1,1)";
							animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
							animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
							animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.3)";
							class TextPos
							{
								left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
								top = 1.5 * MARKER_H / 2 - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / 2);
								right = 0;
								bottom = 0;
							};
							class Attributes: Attributes
							{
								align = "center";
							};
						};
						class Cancel: Enter
						{
							idc = -1;
							y = 6.5 * MARKER_H;

							text = "$STR_DISP_CANCEL";

							colorBackground[] = {1,0.25,0.25,0.3};
							onButtonClick = "[cTabIfOpen # 1,[['MarkerEDIT','']]] call cTab_fnc_setSettings;";
						};
				};
			};
			#undef MARKER_HEIGHT
			#undef MARKER_W
			#undef MARKER_H
			
			//-POLPOX Map Tools Widgets
			#if PLP_TOOL == 1
				class Map_Tool_Show_PLP_widgets: Map_Tool_Show
				{
					idc = idc_D(1202);
					text = "a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa";
					toolTip = "MapTools Remastered";
					Y = sizeY(2.25) - (sizeW * PhoneW);
					action = "['cTab_Android_dlg','PLP_mapTools'] call cTab_fnc_toggleMapTools;";
				};
				class Map_Tool_PLP_widgets: RscToolbox
				{
					idc = idc_D(12012);
		
					Y = sizeY(5.25 + 2.25) - (sizeW * PhoneW);
					w = sizeW * (PhoneW * 3/4);
					h = 3.5 * (sizeW * PhoneW);
		
					rows = 7;
					columns = 1;
					strings[] =
					{
						"$STR_BCE_PLP_Title_Distance",
						"$STR_BCE_PLP_Title_Mark_House",
						"$STR_BCE_PLP_Title_Height",
						"$STR_BCE_PLP_Title_Compass",
						"$STR_BCE_PLP_Title_Edit_Grid",
						"$STR_BCE_PLP_Title_Find_Flat",
						"$STR_BCE_PLP_Title_Line_of_Sight"
					};
					tooltips[] =
					{
						"$STR_BCE_PLP_Tip_Distance",
						"$STR_BCE_PLP_Tip_Mark_House",
						"$STR_BCE_PLP_Tip_Height",
						"$STR_BCE_PLP_Tip_Compass",
						"$STR_BCE_PLP_Tip_Edit_Grid",
						"$STR_BCE_PLP_Tip_Find_Flat",
						"$STR_BCE_PLP_Tip_Line_of_Sight"
					};
					colorBackground[] = {0,0,0,0.25};
					onToolBoxSelChanged = "call BCE_fnc_ctab_BFT_ToolBox";
				};
				
				//-Tool Description
				class BCE_MapTools_Tooltip: PLP_SMT_Description{};
			#endif
			
			//-Home Button
			class btnHome: cTab_android_btnHome
			{
				action = "['cTab_Android_dlg',[['mode','DESKTOP']]] call cTab_fnc_setSettings;";
				tooltip = "Desktop";
			};
		#endif
		//- Remove the Headers
			delete grid;
			delete dirDegree;
			// delete dirOctant;
		//- Add Compass
			class Compass: cTab_android_on_screen_battery
			{
				idc = idc_D(2615);
				style = "0x02 + 0x30 + 0x800";
				text = "\MG8\AVFEVFX\data\Compass.paa";
				y = ((713)) / 2048 * CustomPhoneH + CustomPhoneY + (((60)) / 2048 * CustomPhoneH);
				w = 1.3 * sizeW * (PhoneW * 3/4);
				h = 1.3 * sizeW * PhoneW;
			};
			class compass_Dir: cTab_RscText_Android
			{
				idc = idc_D(2616);
				style = 2;
				shadow = 1;
				text = "N";
				sizeEx = 0.6 * sizeW * PhoneW;
				x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (1 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX;
				y = ((713)) / 2048 * CustomPhoneH + CustomPhoneY + (((60)) / 2048 * CustomPhoneH);
				w = 1.3 * sizeW * (PhoneW * 3/4);
				h = 1.3 * sizeW * PhoneW;
			};
		//- Self Info Box (Bottom Right)
			#ifdef MOUSE_CLICK_EH
				#define BOX_SIZE_H (0.65 * TextSize)
			#else
				#define BOX_SIZE_H (0.75 * TextSize)
			#endif
			#define BOX_POS_Y(SET) ((((-(0) + (713) + (626)) - (20) - ((60) - (20))) / 2048 * CustomPhoneH + CustomPhoneY) + ((32) / 2048 * PhoneW) - SET * (BOX_SIZE_H))
			class CallSign_Box: cTab_RscText_Android
			{
				idc = idc_D(2620);

				font = "EtelkaMonospacePro";
				colorText[] = {0.95,0.95,0.95,1};
				colorBackground[] = {0,0,0,0.3};
				sizeEx = BOX_SIZE_H;
				text = "CallSign : Watt";

				x = (((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (5 - 1)) + (((PHONE_MOD) - (20) * 6) / 5) - (42)) / 2048 * PhoneW + CustomPhoneX)+ ((42)) / 2048 * PhoneW - ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
				y = BOX_POS_Y(3);
				w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
				h = BOX_SIZE_H;
			};
			class Heading_Box: CallSign_Box
			{
				idc = idc_D(2621);
				text = "343° M";
				y = BOX_POS_Y(2);
			};
			class GRID_Box: CallSign_Box
			{
				idc = idc_D(2622);
				text = "GRID :";
				y = BOX_POS_Y(1);
			};
		#undef BOX_SIZE_H
		#undef BOX_POS_Y
		//- Pages for ATAK
			//- Back Ground
				class ATAK_MenuBG: cTab_RscControlsGroup
				{
					idc = 4660;
					x = phoneSizeX + (phoneSizeW * 3/5);
					y = phoneSizeY;
					w = phoneSizeW * 2/5;

					// - Check if it's "1erGTD"
					#if PHONE_MOD <= 1134
						h = phoneSizeH - 0.11 * (((60)) / 2048 * CustomPhoneH);
					#else
						h= phoneSizeH;
					#endif
					class VScrollbar{};
					class HScrollbar{};
					class Scrollbar{};
					class controls
					{	
						class menuBackground: RscBackground
						{
							idc = 9;
							colorBackground[] = {0.4,0.4,0.4,0.8};
							
							w = phoneSizeW * 2/5;
							// - Check if it's "1erGTD"
							#if PHONE_MOD <= 1134
								h = phoneSizeH - 0.11 * (((60)) / 2048 * CustomPhoneH);
							#else
								h= phoneSizeH;
							#endif
						};
					};
				};
			//- Home page of ATAK (Applications)
				class ATAK_APPs_Menu: ATAK_MenuBG
				{
					idc = idc_D(4660);
					h = phoneSizeH - 0.75 * (((60)) / 2048 * CustomPhoneH);
					class controls
					{
						/*class actMSGtxt: BCE_RscButtonMenu
						{
							idc = 4660 + 100;
							style = "0x02 + 0x0C + 0x0100";
							shadow = 1;
							text = ATAK_APP(Messages);
			
							x = 0;
							y = 0;
							w = PhoneBFTContainerW(1);
							h = (phoneSizeW * 3/5)/3;
							
							//-Style
							colorBackground[] = {0,0,0,0.5};
							colorBackground2[] = {0,0,0,0};
							colorBackgroundFocused[] = {0,0,0,0};

							animTextureDefault="#(argb,8,8,3)color(0,0,0,0)";
							animTextureNormal="#(argb,8,8,3)color(0,0,0,0)";
							animTextureOver = "#(argb,8,8,3)color(0,0,0,0.5)";
							animTextureFocused = "#(argb,8,8,3)color(0,0,0,0)";
							animTexturePressed = "#(argb,8,8,3)color(0,0,0,0.3)";
							
							size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
							onButtonClick = "[_this # 0, 'message'] call BCE_fnc_ATAK_ChangeTool;";
							
							textureNoShortcut=APP_MSG;
							class ShortcutPos
							{
								left = 0.75 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
								top = (phoneSizeW * 3/5)/3*0.18;
								w = (phoneSizeW * 2/5)/5*1.1;
								h = (phoneSizeW * 3/5)/5;
							};

							class TextPos
							{
								left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
								top = ((phoneSizeW * 3/5)/3*0.18) + ((phoneSizeW * 3/5)/5);
								right = 0;
								bottom = 0;
							};
							
							class Attributes
							{
								font = "RobotoCondensed_BCE";
								color = "#E5E5E5";
								align = "center";
								shadow = 1;
								size = __EVAL(3/TextTimes);
							};
						};
						class actTKBtxt: actMSGtxt
						{
							idc = 4660 + 101;
							text = ATAK_APP(Missions);
							x = PhoneBFTContainerW(1);
							onButtonClick = "[_this # 0, 'mission'] call BCE_fnc_ATAK_ChangeTool;";

							textureNoShortcut="MG8\AVFEVFX\data\missions.paa";
						};
						class actUAVtxt: actMSGtxt
						{
							idc = 4660 + 102;
							x = PhoneBFTContainerW(2);
							text = ATAK_APP(Video Feeds);
							onButtonClick = "[_this # 0, 'VideoFeeds'] call BCE_fnc_ATAK_ChangeTool;";
							
							textureNoShortcut="MG8\AVFEVFX\data\Hcam.paa";
						};
						//-Second Line
						class actPhototxt: actMSGtxt
						{
							idc = 4660 + 103;
							y = (phoneSizeW * 3/5)/3;
							text = ATAK_APP(Quick Pictures);
							onButtonClick = "558 cutRsc ['BCE_PhoneCAM_View','PLAIN',0.3,false];";
							
							textureNoShortcut="MG8\AVFEVFX\data\photo.paa";
						};
						class actGrouptxt: actPhototxt
						{
							idc = 4660 + 104;
							x = PhoneBFTContainerW(1);
							text = ATAK_APP(Groups);
							onButtonClick = "[_this # 0, 'Group'] call BCE_fnc_ATAK_ChangeTool;";
							
							textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
						};
						class actHCamtxt: actPhototxt
						{
							idc = 4660 + 105;
							text = ATAK_APP(Route);
							x = PhoneBFTContainerW(2);
							onButtonClick = "";
							
							textureNoShortcut="MG8\AVFEVFX\data\route.paa";
						};
						
						//-Thired Line
						class actWeathertxt: actMSGtxt
						{
							idc = 4660 + 106;
							y = 2*((phoneSizeW * 3/5)/3);
							text = ATAK_APP(Weather);
							onButtonClick = "";
							
							textureNoShortcut="a3\3den\data\displays\display3den\toolbar\intel_ca.paa";
						};
						class actBDAtxt: actWeathertxt
						{
							idc = 4660 + 107;
							x = PhoneBFTContainerW(1);
							text = ATAK_APP(BDA Report);
							onButtonClick = "";
							
							textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
						};
						
						class actSettingtxt: actUAVtxt
						{
							idc = 4660 + 108;
							y = 2*((phoneSizeW * 3/5)/3);
							x = PhoneBFTContainerW(2);
							text = ATAK_APP(Settings);
							onButtonClick = "";
							
							textureNoShortcut="MG8\AVFEVFX\data\settings.paa";
						};*/
					};
				};
			//- Functional page of ATAK (Application)
				class ATAK_Tool_Menu: ATAK_APPs_Menu
				{
					idc = idc_D(4650);
				};
		////- Bottons for ATAK Tools
			class InputButtons: ATAK_MenuBG
			{
				idc = 46600;
				y = phoneSizeY + phoneSizeH - (0.75 * (((60)) / 2048 * CustomPhoneH));
				
				// - Check if it's "1erGTD"
				#if PHONE_MOD <= 1134
					h = 0.64 * (((60)) / 2048 * CustomPhoneH);
				#else
					h = 0.75 * (((60)) / 2048 * CustomPhoneH);
				#endif
				class controls
				{
					class Back: BCE_RscButtonMenu
					{
						idc = 10;
						
						text = "$STR_disp_Back";
						
						colorBackground[] = {0,0,0,0.5};
						colorBackground2[] = {0,0,0,0.5};
						colorBackgroundFocused[] = {0,0,0,0.8};

						animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
						animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
						animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.35)";
						
						size = 0.64 * (((60) - (20))) / 2048 * CustomPhoneH;
						
						// - Check if it's "1erGTD"
						#if PHONE_MOD <= 1134
							ATAK_POS(0,0,0.75,0.64);
						#else
							ATAK_POS(0,0,0.75,0.75);
						#endif
						
						onButtonClick = "call BCE_fnc_ATAK_LastPage";
						
						class TextPos
						{
							left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
							top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
							right = 0;
							bottom = 0;
						};
		
						class Attributes: Attributes
						{
							align="center";
							size = TextMenu(1);
						};
					};
					class Send: Back
					{
						idc = 11;
						
						text = "$STR_BCE_Enter";
						
						// - Check if it's "1erGTD"
						#if PHONE_MOD <= 1134
							ATAK_POS(0.75,0,0.75,0.64);
						#else
							ATAK_POS(0.75,0,0.75,0.75);
						#endif

						onButtonClick = "call BCE_fnc_ATAK_DataReceiveButton";
					};
					
					class Live_Feed: Back
					{
						idc = 12;
						
						text = "$STR_BCE_Live_Feed";

						// - Check if it's "1erGTD"
						#if PHONE_MOD <= 1134
							ATAK_POS(1.5,0,0.75,0.64);
						#else
							ATAK_POS(1.5,0,0.75,0.75);
						#endif
						
						action = "call cTab_Tablet_btnACT";
						onButtonClick = "";
					};
					class Show_Result: Back
					{
						idc = 13;
						
						text = "<img image='a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa' />";
						
						colorBackground[] = 
						{
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.5
						};
						colorBackground2[] = 
						{
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.5
						};
						colorBackgroundFocused[] = 
						{
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.8
						};

						// - Check if it's "1erGTD"
						#if PHONE_MOD <= 1134
							ATAK_POS(2.25,0,0.75,0.64);
						#else
							ATAK_POS(2.25,0,0.75,0.75);
						#endif
						
						onButtonClick = "[] call BCE_fnc_ATAK_ShowTaskResult";
					};
				};
			};

		//- Map tools 
			#define PhoneMarkerColor \
				x = #((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (3.8))) / 2048 * PhoneW + CustomPhoneX; \
				y = #((713) + ((60) - (42)) / 2) / 2048 * CustomPhoneH + CustomPhoneY; \
				w = #2.5 * (((42)) / 2048 * PhoneW); \
				h = #((42)) / 2048 * CustomPhoneH
			#define PhoneMarkerWidget_X \
				((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (3.8))) / 2048 * PhoneW + CustomPhoneX - (((60) - (20))) / 2048 * CustomPhoneH
			class Marker_Widget_Show: ctrlButton
			{
				idc = 1300;
				
				style = "0x02 + 0x30 + 0x800";
				colorBackground[]={0.3,0.3,0.3,0.5};
				text = "MG8\AVFEVFX\data\locating.paa";
				
				x = PhoneMarkerWidget_X;
				y = ((713) + ((60) - (38)) / 2) / 2048 * CustomPhoneH + CustomPhoneY;
				w = 40 / 2048 * PhoneW;
				h = 40 / 2048 * CustomPhoneH;
				
				tooltip = "$STR_BCE_Toggle_Marker_Widget";
				action = "['cTab_Android_dlg', 17000 + 1300] call cTab_fnc_toggleMarkerWidget";
			};
			class Marker_Widgets: cTab_RscControlsGroup
			{
				class VScrollbar{};
				class HScrollbar{};
				class Scrollbar{};

				#define MARKER_WIDGET_W (phoneSizeX + phoneSizeW - (PhoneMarkerWidget_X))
				#define MARKER_WIDGET_H (30 / 2048 * CustomPhoneH)
				#define MAKRER_WIDGET_MULT 3.5
				#define MAKRER_WIDGET_CONTENT_W (40 / 2048 * PhoneW)
				#define MARKER_WIDGET_BORDER (0.9 * (MAKRER_WIDGET_MULT - 1) * MAKRER_WIDGET_CONTENT_W)

				// onLoad = "call BCE_fnc_Anim_getConfigSteps";
				// Animation_Steps[] = {
				// 	{"","","",0},
				// 	{"","","",(MAKRER_WIDGET_MULT + 1.5) * MARKER_WIDGET_H},
				// 	{phoneSizeX + (phoneSizeW * 3/5) - MARKER_WIDGET_W,"","",""}
				// };

				idc = idc_D(1300);
				x = PhoneMarkerWidget_X;
				y = ((713)) / 2048  * CustomPhoneH + CustomPhoneY + (((60)) / 2048  * CustomPhoneH);
				w = MARKER_WIDGET_W;
				h = (MAKRER_WIDGET_MULT + 1.5) * MARKER_WIDGET_H;
				class controls
				{
					class Marker_Widget_BG: RscBackground
					{
						colorBackground[] = {0,0,0,0.3};
						x = MARKER_WIDGET_BORDER;
						y = MARKER_WIDGET_H;
						w = MARKER_WIDGET_W - MARKER_WIDGET_BORDER;
						h = (MAKRER_WIDGET_MULT - 1) * MARKER_WIDGET_H;
					};
					
					//- Top Buttons
					class Marker_Widget_Retract: ctrlButton
					{
						style = "0x02 + 0x30 + 0x800";
						colorBackground[]={1,0,0,0.5};
						colorBackgroundActive[] = {1,0,0,0.2};
						colorFocused[] = {1,0,0,0.3};
						text = "MG8\AVFEVFX\data\retract.paa";
						
						x = 0;
						y = 0;
						w = MAKRER_WIDGET_CONTENT_W;
						h = MARKER_WIDGET_H;
						
						tooltip = "$STR_BCE_Toggle_Marker_Widget";
						action = "['cTab_Android_dlg',17000 + 1300] call cTab_fnc_toggleMarkerWidget";
					};
					class Mode_Switch: BCE_RscButtonMenu
					{
						idc = 100;
						text = "";
						
						x = MAKRER_WIDGET_CONTENT_W;
						y = 0;
						w = MARKER_WIDGET_W - MAKRER_WIDGET_CONTENT_W;
						h = MARKER_WIDGET_H;
						
						size = 0.8 * (MARKER_WIDGET_H);
						
						action = "['cTab_Android_dlg'] call cTab_fnc_SwitchMarkerWidget";
						
						animTextureOver = "#(argb,8,8,3)color(1,1,1,0.8)";
						animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
						animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";
						
						colorBackground[] = 
						{
							"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.8
						};
						colorBackground2[] = 
						{
							"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.8
						};
						colorBackgroundFocused[] = 
						{
							"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.5
						};
						
						class Attributes
						{
							font = "RobotoCondensed_BCE";
							color = "#E5E5E5";
							align = "center";
							valign = "middle";
							shadow = "false";
						};
					};
					
					//- Marker Controls
					class Icon_Sel: RscCombo
					{
						idc = 10;
						style="0x10 + 0x200";
						
						sizeEx = MARKER_WIDGET_H;
						
						x = 0;
						y = MARKER_WIDGET_H;
						w = MARKER_WIDGET_BORDER;
						h = (MAKRER_WIDGET_MULT - 1) * MARKER_WIDGET_H;
						
						arrowEmpty="";
						arrowFull="";
						colorSelect[]={1,1,1,1};
						colorText[]={1,1,1,1};
						
						colorBackground[]={0,0,0,0.5};
						colorSelectBackground[]={0,0,0,0.5};
					};
					
					//- Marker text edittors
					class PreFix: RscText
					{
						text = "Prefix :";
						x = MARKER_WIDGET_BORDER;
						y = MARKER_WIDGET_H;
						w = MARKER_WIDGET_W / 5;
						h = MARKER_WIDGET_H;
						
						sizeEx = 0.8 * MARKER_WIDGET_H;
					};
					class Prefix_Edit: RscEdit
					{
						idc = 15;
						
						x = MARKER_WIDGET_BORDER + MARKER_WIDGET_W / 5;
						y = 1.1 * MARKER_WIDGET_H;
						w = 0.95 * MARKER_WIDGET_W / 5;
						h = 0.8 * MARKER_WIDGET_H;
						
						sizeEx = 0.7 * MARKER_WIDGET_H;
						colorBackground[] = {0,0,0,0};

						onEditChanged = "call cTab_fnc_onMarkerTextEditted";
					};
					
					class Index: PreFix
					{
						text = "Index :";
						x = MARKER_WIDGET_BORDER + MARKER_WIDGET_W * 2/5;
					};
					class Index_Edit: Prefix_Edit
					{
						idc = 16;
						
						x = MARKER_WIDGET_BORDER + MARKER_WIDGET_W * 3/5;
						w = MARKER_WIDGET_W / 10;
					};

					//- DESC
					class DESC_Edit: Prefix_Edit
					{
						idc = 17;
						
						x = 1.05 * MARKER_WIDGET_BORDER + 0.5 * (MARKER_WIDGET_W * 3/5 + MARKER_WIDGET_W /10);
						y = (MAKRER_WIDGET_MULT - 1.1) * MARKER_WIDGET_H;
						w = 0.95 * 0.5 * (MARKER_WIDGET_W - MARKER_WIDGET_BORDER);
					};

					//- DESC Preview
					class DESC_Preview: RscStructuredText
					{
						idc = 18;
						text = "";
						
						size = 0.8 * MARKER_WIDGET_H;
						x = 1.05 * MARKER_WIDGET_BORDER;
						y = (MAKRER_WIDGET_MULT - 1.1) * MARKER_WIDGET_H;
						w = 0.95 * 0.5 * (MARKER_WIDGET_W - MARKER_WIDGET_BORDER);
						h = 0.8 * MARKER_WIDGET_H;
						
						colorBackground[] = {1,1,1,0.2};
						class Attributes
						{
							align = "center";
							valign = "middle";
						};
					};

					//- for Drawing Tools
						class Area_Widget_BG: Marker_Widget_BG
						{
							idc = 20;
							y = MAKRER_WIDGET_MULT * MARKER_WIDGET_H;
							h = 1.4 * MARKER_WIDGET_H;
						};
						class Area_Widget_Frame: Area_Widget_BG
						{
							idc = 201;
							style = "0x40";
							colorText[] = {1,1,1,1};
						};
						
						class AreaBrush: Icon_Sel
						{
							idc = 21;
							
							style="0x10 + 0x200";
							y = MAKRER_WIDGET_MULT * MARKER_WIDGET_H;
							h = 1.5 * MARKER_WIDGET_H;
							
							onLBSelChanged = "(_this + [5]) call cTab_fnc_onMarkerSelChanged";
						};
						class AreaOpacity_Title: PreFix
						{
							idc = 22;
							text = "$STR_BCE_OPACITY_FORMAT";

							style = "0x02";

							sizeEx = 0.8 * (1.5 / 2) * MARKER_WIDGET_H;
							y = (MAKRER_WIDGET_MULT - 0.1) * MARKER_WIDGET_H;
							w = 0.95 * (MARKER_WIDGET_W - MARKER_WIDGET_BORDER);
							h = 1.5 / 2 * MARKER_WIDGET_H;
						};
						class Area_OpacitySlider: RscXSliderH
						{
							idc = 23;

							sliderRange[] = {0, 100};
							sliderStep = 5;
							
							x = 1.05 * MARKER_WIDGET_BORDER;
							y = (MAKRER_WIDGET_MULT + (1.5 / 2) - 0.1) * MARKER_WIDGET_H;
							w = 0.95 * (MARKER_WIDGET_W - MARKER_WIDGET_BORDER);
							h = 0.8 * (1.5 / 2) * MARKER_WIDGET_H;

							onSliderPosChanged = "call cTab_fnc_onMarkerOpacityChanged";
						};
					
					//- Category
					class category: ctrlToolboxPictureKeepAspect
					{
						idc = 11;
						x = 0;
						y = MAKRER_WIDGET_MULT * MARKER_WIDGET_H;
						w = MARKER_WIDGET_W;
						h = 1.5 * MARKER_WIDGET_H;
						
						onToolBoxSelChanged = "call cTab_fnc_Update_MarkerItems";
						rows=1;
						columns=4;
						strings[]=
						{
							"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_east_ca.paa",
							"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_west_ca.paa",
							"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_civ_ca.paa",
							"\a3\3DEN\Data\Displays\Display3DEN\PanelRight\side_empty_ca.paa"
						};
						tooltips[]=
						{
							"$STR_EAST",
							"$STR_WEST",
							"$STR_Civilian",
							"$STR_BCE_Generic"
						};
						colorBackground[]={0,0,0,0.3};
						colorText[]={1,1,1,0.4};
						colorTextSelect[]={1,1,1,1};
						colorSelectedBg[]=
						{
							"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
							"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
							0.5
						};
					};
				};
				#undef MARKER_WIDGET_W
				#undef MARKER_WIDGET_H
				#undef MAKRER_WIDGET_CONTENT_W
				#undef MARKER_WIDGET_BORDER
				#undef MAKRER_WIDGET_MULT
			};
			//- Color Select
			class MarkerColor: RscCombo
			{
				idc = idc_D(1090);
				
				PhoneMarkerColor;
				colorBackground[]={0.3,0.3,0.3,1};
				
				colorSelect[]={1,1,1,1};
				colorSelectBackground[]={0.2,0.2,0.2,1};
			};
			#undef PhoneMarkerColor
		// - Weather Condition (Widget)
			class cTab_android_on_Weather_condition_Box: cTab_Tablet_OSD_Weather_condition_Box
			{
				x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (0.35))) / 2048 * PhoneW + CustomPhoneX;
				y = (((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY) + (((60)) / 2048  * CustomPhoneH);
				w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
				
				size = 1.15 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
				class Attributes: Attributes
				{
					size = 0.9;
				};
			};
		//-App Menu
		class Desktop: cTab_RscControlsGroup
		{
			idc = 4610;
			x = phoneSizeX;
			y = phoneSizeY;
			w = phoneSizeW;
			h = phoneSizeH;
			class controls
			{
				class actBFTtxt: ctrlButton
				{
					idc = 1001;
					style = "0x02 + 0x30 + 0x800";
					text = APP_BFT;

					x = (((((257)) + (25)) - ((257))) / 2048 * (PhoneH * 3/4));
					y = (((((491) + (42)) + (25)) - ((491) + (42))) / 2048 * PhoneH);
					w = ((100)) / 2048 * (PhoneH * 3/4);
					h = ((100)) / 2048 * PhoneH;

					colorBackground[] = {0,0,0,0};

					action = "['cTab_Android_dlg',[['mode','BFT']]] call cTab_fnc_setSettings;";
					toolTip = "FBCB2 - Blue Force Tracker";
				};
			};
		};

		//-AV Feeds
		/*class Aircraft: Desktop
		{
			idc = 4630;
			class controls
			{
				class TurretTxt: cTab_RscText_Android
				{
					idc = idc_D(46320);
					text = "--";
					colorBackground[] = {0.25,0.25,0.25,0.5};

					x = (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
					y = (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
					h = ((30)) / 2048 * CustomPhoneH;
					sizeEx = TextSize;
				};
				class cTabAVlist: cTab_RscListbox_Tablet
				{
					idc = 1776;
					style = 64;
					sizeEx = TextSize;

					colorSelect[] = {0,1,0,1};
					colorSelect2[] = {0,1,0,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};

					x = ((((((452) + (20)) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * CustomPhoneH;

					onLBSelChanged = "if (_this # 1 != -1) then {['cTab_Android_dlg',[['uavCam',(_this # 0) lbData (_this # 1)]]] call cTab_fnc_setSettings;};";
				};
				class cTabAVInfolist: cTab_RscListbox_Tablet
				{
					idc = 1775;
					text = "";
					font = "RobotoCondensed";
					sizeEx = TextSize;

					style = 64;
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					soundSelect[] = {"",0,1};

					x = ((((((452) + (20)) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * CustomPhoneH;
				};

				class Info_Vic: cTab_RscButton
				{
					idc = idc_D(16120);
					text = "$STR_BCE_SwitchList";
					sizeEx = TextSize;

					offsetX = 0;
					offsetY = 0;
					offsetPressedX = "pixelW";
					offsetPressedY = "pixelH";

					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (0.75 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
					h = ((60)) / 2048 * CustomPhoneH;
					action = "['cTab_Android_dlg'] call cTab_fnc_AVInfoMenu_toggle;";
				};
				class SwitchTurret: Info_Vic
				{
					idc = idc_D(16121);

					colorBackground[] = {0.3,0.3,0.3,1};
					colorBackgroundActive[] = {0.3,0.3,0.3,1};
					colorFocused[] = {0.3,0.3,0.3,1};
					colorShadow[] = {0.15,0.15,0.15,1};
					colorBorder[] = {0,0,0,0};

					text = ">>";
					tooltip = "$STR_BCE_NextTurret";
					sizeEx = TextSize;

					action = "";
					onButtonClick = "[_this # 0,17000,true] call BCE_fnc_NextTurretButton;";

					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW) + (0.75 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
					w = (0.25 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
				};
				class Connect_Vic: cTab_RscButton
				{
					idc = idc_D(17);
					text = "$STR_BCE_Live_Feed";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW) * 0.49;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "call cTab_Tablet_btnACT;";
				};
				class Control_turret: Connect_Vic
				{
					idc = idc_D(18);
					text = "$STR_BCE_Control_Turret";
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW) + ((((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW) * 0.51);
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW) * 0.49;
					action = "0 call cTab_Tablet_btnACT;";
				};
			};
		};*/

		delete MESSAGE;
		delete COMPOSE;
		//-Message
		/*class MESSAGE: cTab_RscControlsGroup
		{
			idc = 4650;
			x = phoneSizeX;
			y = phoneSizeY;
			w = phoneSizeW;
			h = phoneSizeH;
			class VScrollbar{};
			class HScrollbar{};
			class Scrollbar{};
			class controls
			{
				class msgListbox: cTab_RscListBox
				{
					idc = 15000;
					style = 32;
					sizeEx = TextSize;
					x = ((((((452) + (20)) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * CustomPhoneH;
					onLBSelChanged = "_this call cTab_msg_get_mailTxt;";
				};
				class msgframe: cTab_RscFrame
				{
					idc = 16;
					text = "Read Message";
					x = (((((452) + (20))) - ((452))) / 2048 * PhoneW);
					y = (((((713) + (60) + (10))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((PHONE_MOD) - (20) * 2)) / 2048 * PhoneW;
					h = (((626) - (60) - (10) * 2)) / 2048 * CustomPhoneH;
				};
				class msgTxt: cTab_RscEdit
				{
					idc = 18510;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "No Message Selected";
					sizeEx = TextSize;
					x = (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048  * 	PhoneW);
					y = (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048  * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
					canModify = 0;
				};
				class deletebtn: cTab_RscButton
				{
					idc = 16120;
					text = "Delete";
					tooltip = "Delete Selected Message(s)";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "['cTab_Android_dlg'] call cTab_fnc_onMsgBtnDelete;";
				};
				class toCompose: cTab_RscButton
				{
					idc = 17;
					text = "Compose >>";
					tooltip = "Compose Messages";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "['cTab_Android_dlg',[['mode','COMPOSE']]] call cTab_fnc_setSettings;";
				};
			};
		};
		class COMPOSE: cTab_RscControlsGroup
		{
			idc = 4655;
			x = phoneSizeX;
			y = phoneSizeY;
			w = phoneSizeW;
			h = phoneSizeH;
			class VScrollbar{};
			class HScrollbar{};
			class Scrollbar{};
			class controls
			{
				class composeFrame: cTab_RscFrame
				{
					idc = 18;
					text = "Compose Message";
					x = ((((((452) + (20)))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((PHONE_MOD) - (20) * 2))) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2))) / 2048 * CustomPhoneH;
				};
				class playerlistbox: cTab_RscListBox
				{
					idc = 15010;
					style = 32;
					sizeEx = TextSize;
					x = (((((((452) + (20)) + (10)))) - ((452))) / 2048  * 	PhoneW);
					y = (((((((713) + (60) + (10))) + (20))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048  * 	PhoneW;
					h = (((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2))) / 2048  * 	(	PhoneW * 4/3);
				};
				class sendbtn: cTab_RscButton
				{
					idc = 16130;
					text = "Send";
					sizeEx = TextSize;
					x = (((((((452) + (20))) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "call cTab_msg_Send;";
				};
				class edittxtbox: cTab_RscEdit
				{
					idc = 14000;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "";
					sizeEx = TextSize;
					x = ((((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10)))) - ((452))) / 2048  * 	PhoneW);
					y = ((((((((713) + (60) + (10))) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2))) / 2048 * PhoneW;
					h = (((((626) - (60) - (10) * 2) - (20) -(10)))) / 2048 * CustomPhoneH;
				};
				class toRead: cTab_RscButton
				{
					idc = 19;
					text = "Read >>";
					tooltip = "Read Messages";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "['cTab_Android_dlg',[['mode','MESSAGE']]] call cTab_fnc_setSettings;";
				};
			};
		};*/
	};
};
#undef Android_BR_InfoY