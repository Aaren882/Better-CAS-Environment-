class cTab_RscFrame;
class cTab_RscPicture;
class cTab_RscControlsGroup
{
	class VScrollbar;
	class HScrollbar;
};
class cTab_RscText;
class cTab_RscButtonInv;
class cTab_ActiveText;
class cTab_RscListBox;
class cTab_RscListbox_Tablet;
class cTab_RscEdit;
class cTab_RscEdit_Tablet;
class cTab_RscButton_Tablet;
class cTab_Tablet_btnF2;
class cTab_Tablet_btnF5;
class cTab_Tablet_window_back_BR;
class cTab_RscText_Tablet;
class cTab_IGUIBack;
class cTab_RscButton;
class cTab_RscText_WindowTitle;
class cTab_Tablet_btnMouse;

class cTab_Tablet_notification: cTab_RscText_Tablet
{
	x = "((257)) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	w = "(((1341))) / 2048 * ((safezoneH * 1.2) * 3/4)";
};
class cTab_MenuItem: RscButtonMenu
{
	color[] = {1,1,1,1};
	color2[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	colorBackground2[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.5};
	colorFocused[] = {1,1,1,1};
	colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.5};
	shadow = 2;
	style = 0;

	period = 0;
	periodFocus = 2;
	periodOver = 0.5;

	offsetPressedX = "pixelW";
	offsetPressedY = "pixelH";

	class Attributes
	{
		font = "PuristaLight";
		size = SubMenuText;
	};
};

class cTab_MenuExit: cTab_MenuItem
{
	color[] = {1,1,1,1};
	colorBackground[] = {1,0.25,0.25,0.1};
	colorBackground2[] = {1,0.25,0.25,0.3};
	colorBackgroundFocused[] = {1,0.25,0.25,0.3};
};
class cTab_Tablet_OSD_hookGrid: cTab_RscText_Tablet
{
	colorText[] = {0.95,0.95,0.95,1};
};
class cTab_Tablet_OSD_time;
class cTab_Tablet_OSD_dirDegree: cTab_Tablet_OSD_time
{
	style = 1;
};

//- Weather Widget Toggle
class cTab_Tablet_OSD_dirOctant: BCE_RscButtonMenu
{
	style = 2;
	
	//x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (2))) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (4 - 1))) / 2048  * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048)) + ((((((1341)) - (10) * 8) / 7)) / 2048  * ((safezoneH * 1.2) * 3/4))";
	y = "((491) + ((42) - (27)) / 2) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2)";
	w = "1.3 * ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4))";
	h = "(((42) - (10))) / 2048 * (safezoneH * 1.2)";
	
	text = "";
	action = "['cTab_Tablet_dlg'] call cTab_fnc_toggleWeather";
	
	size = "(((42) - (10))) / 2048 * (safezoneH * 1.2)";
	
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
	
	class Attributes: Attributes
	{
		align="left";
		valign="middle";
	};
};

//-Weather Condition
class cTab_Tablet_OSD_Weather_condition_Box: RscStructuredText
{
	idc = 26160;
	colorBackground[] = {0.2,0.2,0.2,0.5};
	
	y = "((491) + ((42) - (27)) / 2) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2) + ((((42) - (10))) / 2048 * (safezoneH * 1.2))";
	w = "1.3 * ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4))";
	h = 0;
	
	text = "";
	tooltip="";
	
	size = "(((42) - (10))) / 2048 * (safezoneH * 1.2)";
	
	class Attributes
	{
		align = "Left";
		font = "RobotoCondensedBold_BCE";
	};
};

#include "cTab_classes.hpp"

//-Main Frame Coordinate
#define MainFrameX ((((257))) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048)))
#define MainFrameY ((((491) + (42))) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2))
#define MainFrameW ((((1341))) / 2048 * ((safezoneH * 1.2) * 3/4))
#define MainFrameH ((((993) - (42) - (0))) / 2048 * (safezoneH * 1.2))

//- Spacing
#define smalSpc (1.25 * ((((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))-((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))))

//-FIF (Frame in Frame)
#define smalFmW (((((((1341)) - (20) * 2) - (10) * 3) / 3)) / 2048 * ((safezoneH * 1.2) * 3/4))
#define smalFmH (((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20))) / 2048 * (safezoneH * 1.2))

//-Coordination
#define FrameLX (((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))

#define FrameUY ((((((((491) + (42)) + (10)) + (20)))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))
//#define FrameDY (((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) - ((491) + (42))) / 2048 * (safezoneH * 1.2)))

#define ContC (0.03/1.2)
#define ContW (((((((1341)) - (20) * 2) - (10) * 3) / 3.1)) / 2048 * ((safezoneH * 1.2) * 3/4))
#define ContH (safezoneH / 60)

class cTab_Tablet_dlg
{
	//BCE_TASK_Offset = TASK_OFFSET;
	Brevity_Code[] =
	{
		"$STR_BCE_BVTITLE_Weapon",
		{"Guns x3","$STR_BCE_BVT_Guns"},
		{"Rifle","$STR_BCE_BVT_Rifle"},
		{"Pickle","$STR_BCE_BVT_Pickle"},
		{"Paveway","$STR_BCE_BVT_Paveway"},
		{"Ripple","$STR_BCE_BVT_Ripple"},
		{"Winchester","$STR_BCE_BVT_Winchester"},
		{"Splash(ed)","$STR_BCE_BVT_Splash"},
		{"Shack","$STR_BCE_BVT_Shack"},
		"$STR_BCE_BVTITLE_Task",
		{"Playtime","$STR_BCE_BVT_Playtime"},
		{"Contact","$STR_BCE_BVT_Contact"},
		{"Visual","$STR_BCE_BVT_Visual"},
		{"Tally","$STR_BCE_BVT_Tally"},
		{"Clear(ed) Hot","$STR_BCE_BVT_ClearHot"},
		"-", //Next Page
		{"Abort","$STR_BCE_BVT_Abort"},
		{"What Luck","$STR_BCE_BVT_What_Luck"},
		{"IP Inbound","$STR_BCE_BVT_IP_Inbound"},
		{"Bingo","$STR_BCE_BVT_Bingo"},
		{"Continue","$STR_BCE_BVT_Continue"},
		"$STR_BCE_BVTITLE_Laser",
		{"Laser On","$STR_BCE_BVT_Laser_On"},
		{"Sparkle","$STR_BCE_BVT_Sparkle"},
		{"Lasing","$STR_BCE_BVT_Lasing"},
		{"Snake/Pulse","$STR_BCE_BVT_SnakePulse"},
		{"Steady","$STR_BCE_BVT_Steady"},
		{"Spot","$STR_BCE_BVT_Spot"},
		{"Rope","$STR_BCE_BVT_Rope"},
		"",
		"<a href='https://wiki.hoggitworld.com/view/Brevity_List'>Hoggitworld</a>",
		"<a href='https://en.wikipedia.org/wiki/Multiservice_tactical_brevity_code'>Wikipedia</a>"
	};

	class controlsBackground
	{
		delete MiniMapBG;
		class screen: cTab_Tablet_RscMapControl
		{
			onMouseButtonDblClick = "call cTab_fnc_onMapDoubleClick";
			onMouseButtonClick = "(_this + [17000]) call BCE_fnc_GetMapClickPOS";
		};
		class cTabUavMap: cTab_Tablet_RscMapControl
		{
			y = "(((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2)) - (safezoneH / 40)";
		};
		#if MAP_MODE > 2
			class screenTopo: screen
			{
				#include "..\Map_Type\TOPO_GRD.hpp"
			};
		#endif
		class Task_Builder_Background: RscBackground
		{
			idc = idc_D(4651);
			colorBackground[] = {0.2,0.2,0.2,0.4};
			x = MainFrameX;
			y = MainFrameY;
			w = MainFrameW;
			h = MainFrameH;
		};

		//-Separator
		class Task_Builder_Separator: cTab_RscFrame
		{
			idc = idc_D(4652);
			x = MainFrameX + ((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4));
			y = MainFrameY + MainFrameH / 2;
			w = "((((1341)) - (20) * 2)) / 2048 * ((safezoneH * 1.2) * 3/4)";
			h = "0.001";
		};

		class Extended_Frame: cTab_RscFrame
		{
			idc = idc_D(4653);
			x = MainFrameX + FrameLX + smalFmW + smalSpc;
			y = MainFrameY + FrameUY + (1.15 * ContH);
			w = 2 * smalFmW;
			h = smalFmH - (1.75 * ContH);
		};

	};
	class controls
	{
		class btnACT: cTab_Tablet_btnMouse
		{
			action = "";
		};
		//-Weather Widget
		class cTab_Tablet_OSD_Weather_condition_Box: cTab_Tablet_OSD_Weather_condition_Box{};
		
		#define sizeX ((((-(10) + ((257)) + ((1341))) - ((((1341)) - (10) * 8) / 7))) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048)))
		#define sizeY(SIZE) (((-(0) + (491) + (993)) - (10) - ((42) - (10)) * SIZE) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2))
		#define sizeW (64 / 2048)
		//- Map tools (Additional Tools)
			class Marker_Widget_Show: ctrlButton
			{
				idc = 1300;
				
				style = "0x02 + 0x30 + 0x800";
				colorBackground[]={0,0,0,0.2};
				text = "MG8\AVFEVFX\data\locating.paa";

				x = sizeX + ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4)) - (sizeW/1.2 * ((safezoneH * 1.2) * 3/4));
				y = smalSpc + ((491)) / 2048  * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2) + ((42)) / 2048  * (safezoneH * 1.2);
				w = sizeW/1.2 * ((safezoneH * 1.2) * 3/4);
				h = sizeW/1.2 * (safezoneH * 1.2);

				tooltip = "$STR_BCE_Toggle_Marker_Widget";
				action = "['cTab_Tablet_dlg', 17000 + 1300] call cTab_fnc_toggleMarkerWidget";
			};
			class Marker_Widgets: cTab_RscControlsGroup
			{
				class VScrollbar{};
				class HScrollbar{};
				class Scrollbar{};
				#define MARKER_WIDGET_SCALE 0.8 //- Addressing the Widget Scale
				#define MARKER_WIDGET_W (MARKER_WIDGET_SCALE * 8 * (sizeW * ((safezoneH * 1.2) * 3/4)))
				#define MARKER_WIDGET_H (MARKER_WIDGET_SCALE * 0.75 * sizeW * (safezoneH * 1.2))
				#define MAKRER_WIDGET_MULT 3.5
				#define MAKRER_WIDGET_CONTENT_W (MARKER_WIDGET_SCALE * sizeW * ((safezoneH * 1.2) * 3/4))
				#define MARKER_WIDGET_BORDER (0.9 * (MAKRER_WIDGET_MULT - 1) * MAKRER_WIDGET_CONTENT_W)

				#define MARKER_WIDGET_X \
					sizeX + (sizeW/1.2 * ((safezoneH * 1.2) * 3/4)) + ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4)) - (sizeW/1.2 * ((safezoneH * 1.2) * 3/4)) - MARKER_WIDGET_W
					
				idc = idc_D(1300);

				x = MARKER_WIDGET_X;
				y = (sizeW / 1.2 * (safezoneH * 1.2)) + 1.25 * smalSpc + ((491)) / 2048  * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2) + ((42)) / 2048  * (safezoneH * 1.2);
				w = MARKER_WIDGET_W;
				h = (MAKRER_WIDGET_MULT + 1.5) * MARKER_WIDGET_H
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
						action = "['cTab_Tablet_dlg', 17000 + 1300] call cTab_fnc_toggleMarkerWidget";
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
						
						action = "['cTab_Tablet_dlg'] call cTab_fnc_SwitchMarkerWidget";
						
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
				#undef MARKER_WIDGET_X
				#undef MARKER_WIDGET_W
				#undef MARKER_WIDGET_H
				#undef MAKRER_WIDGET_CONTENT_W
				#undef MARKER_WIDGET_BORDER
				#undef MAKRER_WIDGET_MULT
			};
			//- Color Select
			class MarkerColor: RscCombo
			{
				idc=idc_D(1090);
				x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (6 - 1))) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048)) + ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4))";
				y = "((491) + ((42) - (35)) / 2) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2)";
				w = "2.5 * (((35)) / 2048 * ((safezoneH * 1.2) * 3/4))";
				h = "35 / 2048 * (safezoneH * 1.2)";
				
				colorBackground[]={0.3,0.3,0.3,1};
				
				colorSelect[]={1,1,1,1};
				colorSelectBackground[]={0.2,0.2,0.2,1};
			};
		//- Marker Editor
			#define MARKER_HEIGHT 8
			#define MARKER_W (2 * (1.3 * ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4))))
			#define MARKER_H ((((42) - (10))) / 2048 * (safezoneH * 1.2))
			class Marker_Edit: cTab_RscControlsGroup
			{
				idc = idc_D(1301);
				x = MainFrameX + (MainFrameW / 2) - (MARKER_W /2);
				y = ((-(0) + (491) + (993)) - (10) - ((42) - (10)) * 2) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2) - (MARKER_HEIGHT * MARKER_H);
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
						// action = "[3] call cTab_fnc_userMenuSelect;";

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
		//-BFT
			class Map_Tool_Show: ctrlButton
			{
				idc = idc_D(1200);
				style = "0x02 + 0x30 + 0x800";
				text = "\a3\3den\data\displays\display3den\toolbar\map_off_ca.paa";
				colorBackground[] = {0,0,0,0.3};
				x = sizeX + ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4)) - (sizeW * ((safezoneH * 1.2) * 3/4));
				Y = sizeY(0) - (sizeW * (safezoneH * 1.2));
				w = sizeW * ((safezoneH * 1.2) * 3/4);
				h = sizeW * (safezoneH * 1.2);
				tooltip = "Toggle Map Tools";
				action = "['cTab_Tablet_dlg'] call cTab_fnc_toggleMapTools;";
			};
			
			//-BCE Widgets
			class Map_Tool_Show_BCE_widgets: Map_Tool_Show
			{
				idc = idc_D(1201);
				text = "\a3\3den\data\displays\display3den\toolbar\vision_normal_ca.paa";
				toolTip = "$STR_BCE_Tip_Click_Map";
				Y = sizeY(4.5) - (sizeW * (safezoneH * 1.2));
				action = "['cTab_Tablet_dlg','BCE_mapTools'] call cTab_fnc_toggleMapTools;";
			};
			class Map_Tool_BCE_widgets: RscToolbox
			{
				idc = idc_D(12010);

				Y = sizeY(5.25 + 2.25) - (sizeW * (safezoneH * 1.2));
				w = sizeW * ((safezoneH * 1.2) * 3/4);
				h = 1.5 * (sizeW * (safezoneH * 1.2));

				rows = 3;
				columns = 1;
				strings[] =
				{
					"IP/BP",
					"GRID",
					"FRND"
				};
				tooltips[] =
				{
					"$STR_BCE_TIP_IPBP",
					"$STR_BCE_TIP_GRID",
					"$STR_BCE_TIP_FRND"
				};
				colorBackground[] = {0,0,0,0.25};
				onToolBoxSelChanged = "call BCE_fnc_ctab_BFT_ToolBox";
			};
			class Map_Tool_BCE_widgets_Del: ctrlButton
			{
				idc = idc_D(12011);
				style = 2;
				x = sizeX + ((((((1341)) - (10) * 8) / 7)) / 2048 * ((safezoneH * 1.2) * 3/4)) - (sizeW * ((safezoneH * 1.2) * 3/4));
				Y = sizeY(6.25 + 2.25) - (sizeW * (safezoneH * 1.2));
				w = sizeW * ((safezoneH * 1.2) * 3/4);
				h = (sizeW * (safezoneH * 1.2)) / 2;

				colorBackground[] = {1,0,0,0.2};
				colorBackgroundActive[] = {1,0.25,0.25,0.3};

				text = "DEL MARK";
				tooltip = "Delete Task Marker";
				action = "[-4] call cTab_fnc_userMenuSelect;";
			};
			
			//-POLPOX Map Tools Widgets
			#if PLP_TOOL == 1
				class Map_Tool_Show_PLP_widgets: Map_Tool_Show
				{
					idc = idc_D(1202);
					//text = "\a3\3den\data\displays\display3den\panelright\customcomposition_editentities_ca.paa";
					text = "\a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa";
					toolTip = "MapTools Remastered";
					Y = sizeY(2.25) - (sizeW * (safezoneH * 1.2));
					action = "['cTab_Tablet_dlg','PLP_mapTools'] call cTab_fnc_toggleMapTools;";
				};
				class Map_Tool_PLP_widgets: RscToolbox
				{
					idc = idc_D(12012);
		
					Y = sizeY(5.25 + 2.25) - (sizeW * (safezoneH * 1.2));
					w = sizeW * ((safezoneH * 1.2) * 3/4);
					h = 3.5 * (sizeW * (safezoneH * 1.2));
		
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

		//---- Groups ----//
		class Desktop: cTab_RscControlsGroup
		{
			class VScrollbar;
			class HScrollbar;
			class controls
			{
				class actBFTtxt;
				class actUAVtxt: actBFTtxt
				{
					toolTip = "Air Vic Video Feeds";
				};
				class actTKBtxt: actBFTtxt
				{
					idc = 10041;
					text = "\MG8\AVFEVFX\data\missions.paa";
					y = "(((((491) + (42)) + (25) * 5 + (100) * 4) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','TASK_Builder']]] call cTab_fnc_setSettings;";
					toolTip = "Task Builder";
				};
			};
		};

		class UAV: cTab_RscControlsGroup
		{
			class controls
			{
				delete UAVListBG;
				delete UAVVidBG2;
				delete UAVVidTL2;
				//-Text
				#if PHONE_MOD == 1134
					AV_Members;
				#endif

				//-Camera Ctrls
				class cTab_CameraConnect: RscButtonMenu
				{
					idc = 2100;
					text = "$STR_BCE_Live_Feed";
					x = TabletRX;
					y = TabletDY + (TabletH - (safezoneH / 40));

					w = TabletW / 2;
					h = (safezoneH / 40);
					colorBackground[] = {0.5,0.5,0.5,0.55};
					periodFocus = 0;
					action = "call cTab_Tablet_btnACT;";
					class TextPos
					{
						left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
						top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
						right = 0.005;
						bottom = 0.0;
					};
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						color = "#E5E5E5";
						align = "center";
						shadow = "true";
					};
				};
				class cTab_CameraControl: cTab_CameraConnect
				{
					idc = 2101;
					text = "$STR_BCE_Control_Turret";
					x = TabletRX + (TabletW / 2);
					colorBackground[] = {0.5,0.5,0.5,0.5};
					action = "0 call cTab_Tablet_btnACT;";
				};

				//-UNIT info
				class New_Task_Unit_Title: RscStructuredText
				{
					idc = 20114;
					shadow = 1;
					colorBackground[] = {0,0,0,0};
					size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
					sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
					class Attributes
					{
						font = "PuristaMedium";
						color = "#E5E5E5";
						align = "center";
						valign="middle";
						shadow = 1;
						size = 1;
					};
					class TextPos
					{
						left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
						top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
						right = 0.005;
						bottom = 0.0;
					};
					text = "";
					x = TabletLX;
					y = TabletTY;
					w = TabletW;
					h = (safezoneH / 40);
				};

				//-PIP displays
				class cTabUAVdisplay: cTab_RscPicture
				{
					text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
				};

				//-List
				class cTabUAVlist: RscCombo
				{
					x = TabletRX;
					y = TabletDY - (safezoneH / 40);
					h = (safezoneH / 40);
				};
				class cTabUAV2nddisplay: cTab_RscListbox_Tablet
				{
					idc = 1775;
					text = "";
					sizeEx = "0.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					/*colorText[] = {0,0,0,1};
					colorTextRight[] = {0,0,0,1};*/
					colorBackground[] = {0.5,0.5,0.5,0.3};
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					soundSelect[] = {"",0,1};
					h = TabletH - (safezoneH / 40);
				};
				class cTabUnitList: cTabUAV2nddisplay
				{
					idc = 20116;
					text = "";
					colorBackground[] = {0.5,0.5,0.5,0.3};
					colorSelect[] = {0,1,0,1};
					colorSelect2[] = {0,1,0,1};
					colorSelectRight[] = {0,1,0,1};
					colorSelect2Right[] = {0,1,0,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					period = 0;

					onLBSelChanged = "call BCE_fnc_unitList_info";

					x = TabletLX;
					y = TabletTY + (safezoneH / 40);
					w = TabletW;
					h = TabletH;
				};
			};
		};

		//-Vic select (Task Builder)
		class Task_Builder_TopLeft: Desktop
		{
			idc = 4651;
			Y = MainFrameY;
			H = MainFrameH / 2;
			W = FrameLX + smalFmW;
			class controls
			{
				//---------------------------------//
				// - Top Info Displays
				#define RearangePOS(MULTIX,MULTIY,MULTIW,MULTIH,CONTU,CONTD) \
					x = FrameLX + MULTIX * (smalFmW + smalSpc);\
					y = FrameUY + (CONTU * ContH);\
					w = MULTIW * smalFmW;\
					h = (MULTIH * smalFmH) - (CONTD * ContH)

				//-Info List
				class TopLeft_Info_Combo: RscCombo
				{
					idc = idc_D(1776);
					x = FrameLX;
					y = FrameUY;
					w = smalFmW;
					h = 1.15 * ContH;
					sizeEx = "0.75 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					colorBackground[] = {0.3,0.3,0.3,0.8};
					onLBSelChanged = "if (!cTabIfOpenStart && (_this # 1 != -1)) then {['cTab_Tablet_dlg',[['uavCam',(_this # 0) lbData (_this # 1)]]] call cTab_fnc_setSettings;};";
				};
				class TopLeft_Info_List: cTab_RscListbox_Tablet
				{
					idc = idc_D(1775);
					text = "";
					font = "RobotoCondensed_BCE";
					sizeEx = "0.75 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					colorBackground[] = {0.5,0.5,0.5,0.3};
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					soundSelect[] = {"",0,1};

					RearangePOS(0,1,1,1,1.15,3.15);
				};

				//-Camera Ctrls
				class cTab_CameraConnect: RscButtonMenu
				{
					idc = idc_D(2100);
					text = "$STR_BCE_Live_Feed";
					x = FrameLX;
					y = FrameUY + (smalFmH - (2 * ContH));
					w = 0.5 * smalFmW;
					h = 1.5 * ContH;
					colorBackground[] = {0.5,0.5,0.5,0.55};
					periodFocus = 0;
					action = "call cTab_Tablet_btnACT;";
					class TextPos
					{
						left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
						top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
						right = 0.005;
						bottom = 0.0;
					};
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						color = "#E5E5E5";
						align = "center";
						valign = "middle";
						shadow = "true";
						size = 0.9;
					};
				};
				class cTab_CameraControl: cTab_CameraConnect
				{
					idc = idc_D(2101);
					text = "$STR_BCE_Control_Turret";
					x = FrameLX + (0.5 * smalFmW);
					colorBackground[] = {0.5,0.5,0.5,0.5};
					action = "0 call cTab_Tablet_btnACT;";
				};
			};
		};

		//-Switchable Frame (Task Builder)
		class Task_Builder_TopRight: Task_Builder_TopLeft
		{
			idc = 4652;
			x = MainFrameX + FrameLX + smalFmW + smalSpc;
			y = MainFrameY + FrameUY;
			w = 2 * smalFmW;
			h = smalFmH - (0.6 * ContH);
			class controls
			{
				class Extended_Toolbox: RscToolbox
				{
					idc = idc_D(3101);
					x = 0;
					y = 0;
					w = smalFmW;
					h = 1.15 * ContH;

					strings[] = {"$STR_BCE_Widgets_VIC","$STR_BCE_Widgets_WPN","$STR_BCE_Widgets_TASK"};
					tooltips[] =
					{
						"$STR_BCE_Widgets_TIP_VIC",
						"$STR_BCE_Widgets_TIP_WPN",
						"$STR_BCE_Widgets_TIP_TASK"
					};
					rows = 1;
					columns = 3;
					font = "PuristaMedium";
					colorBackground[] = {0.5,0.5,0.5,0.3};
					colorText[] = {0.95,0.95,0.95,0.5};
					onToolBoxSelChanged = "call BCE_fnc_ctab_Switch_ExtendedList";
				};

				#define InfoPOS(XPOS,HPOS) \
					x = XPOS * ContW + smalSpc; \
					y = 1.65 * ContH; \
					w = ContW; \
					h = HPOS * (smalFmH - (2.75 * ContH))

				//- Vic Info
				class Vic_Crew_Info_List: cTab_RscListbox_Tablet
				{
					idc = idc_D(1785);
					text = "";
					font = "RobotoCondensed_BCE";
					sizeEx = "0.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					colorBackground[] = {0,0,0,0};
					colorSelect[] = {0,1,0,1};
					colorSelect2[] = {0,1,0,1};
					colorSelectRight[] = {0,1,0,1};
					colorSelect2Right[] = {0,1,0,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					period = 0;
					fade = 1;

					onLBSelChanged = "call BCE_fnc_unitList_info";
					#if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
						InfoPOS(0,0.5);
					#else
						InfoPOS(0,1);
					#endif
				};
				#if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
					class Vic_ACRE_Info_List: Vic_Crew_Info_List
					{
						idc = idc_D(17850);

						colorBackground[] = {0,0,0,0};
						colorSelect[] = {1,1,1,1};
						colorSelect2[] = {1,1,1,1};
						colorSelectRight[] = {1,1,1,1};
						colorSelect2Right[] = {1,1,1,1};
						soundSelect[] = {"",0,1};
						onLBSelChanged = "";

						x = 0;
						y = (1.65 * ContH) + (0.5 * (smalFmH - (2.75 * ContH)));
						w = ContW;
						h = 0.5 * (smalFmH - (2.75 * ContH));
					};
				#endif
				class Vic_PIP_Display: RscPicture
				{
					idc = idc_D(1786);
					text = "#(argb,512,512,1)r2t(rendertarget8,1.1896551724)";
					fade = 1;

					InfoPOS(1,1);
				};

				//-WPN Info
				class Checklist_Info_List: cTab_RscListbox_Tablet
				{
					idc = idc_D(1787);
					sizeEx = "0.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					fade = 1;
					InfoPOS(0,1);

					onLBSelChanged = "call BCE_fnc_Extended_WeaponDESC";
				};
				class DESC_TextBox: RscStructuredText
				{
					idc = idc_D(1788);
					text = "Desc :";
					fade = 1;
					InfoPOS(1,1);
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						color = "#ffffff";
						align = "left";
						shadow = 1;
						size = 0.8;
					};
				};

				//-Mission List
				class Task_List: cTab_RscListbox_Tablet
				{
					idc = idc_D(1789);
					font = "RobotoCondensed_BCE";
					onLBSelChanged = "call BCE_fnc_Extended_TaskDESC";
					InfoPOS(0,1);
				}
				class Task_TextBox: RscStructuredText
				{
					idc = idc_D(1790);
					text = "Task Type: <t color='#e3c500'>-- line [N/A]</t><br/>Caller: <t color='#e3c500'> [N/A] </t><br/><br/>Detail:<br/><t color='#e3c500'>No description</t>";
					colorBackground[] = {0,0,0,0};
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectRight[] = {1,1,1,1};
					colorSelect2Right[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					period = 0;
					fade = 1;

					InfoPOS(1,1);
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						color = "#ffffff";
						align = "left";
						shadow = 1;
						size = 0.9;
					};
				};
			};
		};

		//- Task Builder
		class Task_Builder: Desktop
		{
			idc = 4653;
			Y = MainFrameY + MainFrameH / 2 + FrameUY / 2;
			W = MainFrameW;
			H = MainFrameH / 2;
			class controls
			{
				//- Content (Task Type)
				class TaskType: RscCombo
				{
					idc = idc_D(2107);
					x = FrameLX + smalFmW + smalSpc;
					y = 0;
					w = ContW;
					h = ContH;
					colorBackground[] = {0,0,0,1};
					colorSelectBackground[] = {0.5,0.5,0.5,1};
					wholeHeight = 0.8;
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					onLBSelChanged = "(_this + [17000]) call BCE_fnc_TaskTypeChanged";
					class Items
					{
						class 9line
						{
							text = "9 Line";
							textRight = "";
							value = 0;
							default = 1;
						};
						class 5line
						{
							text = "5 Line";
							textRight = "";
							value = 1;
						};
					};
				};

				//-Task List
				// -Description
				class Descframe: cTab_RscFrame
				{
					sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
					text = "$STR_BCE_Description";
					x = FrameLX;
					y = 0;
					w = smalFmW;
					h = smalFmH;
				};
				class taskDesc: RscStructuredText
				{
					idc = idc_D(2004);
					text = "Desc :";
					colorBackground[] = {0,0,0,0};
					x = FrameLX;
					y = (ContC * 1.1);
					w = smalFmW;
					h = smalFmH - ContC;
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						color = "#ffffff";
						align = "left";
						shadow = 1;
					};
				};
				// -List
				class taskframe: Descframe
				{
					sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
					text = "Task List : ";
					x = FrameLX + smalFmW + ContW + (2 * smalSpc);
				};

				//-9 line
				class CAS_TaskList_9: cTab_RscListbox_Tablet
				{
					idc = idc_D(2002);
					colorBackground[] = {0,0,0,0};
					show = 0;
					x = FrameLX + smalFmW + ContW + (2 * smalSpc);
					y = (ContC * 1.1);
					w = smalFmW;
					h = smalFmH - ContC;
					onLBSelChanged = (_this + [[TASK_OFFSET+2002,TASK_OFFSET+2005],TASK_OFFSET]) call BCE_fnc_TaskList_Changed;
					class Items
					{
						class Game_plan
						{
							text = "#: Game Plan :";
							data = "$STR_BCE_DECS_GAMEPLAN";
							textRight = "NA";
							Expression_idc[] = {20110,2011,20111,20112,20113,2020,2021,2022,2023,2024};
							multi_options = 1;
							default = 1;
							tooltip = "$STR_BCE_TIP_GAMEPLAN";

							//-dont write down on the right of the list
							Task_writeDown = "Y";
						};
						class Line1: Game_plan
						{
							text = "1: IP/BP :";
							data = "$STR_BCE_DECS_IPBP_NoKey";
							Expression_idc[] = {2012,2013,2014};
							multi_options = 0;
							tooltip = "$STR_BCE_TIP_IPBP";
							Task_writeDown = "";
						};
						class Line2: Line1
						{
							text = "2: HDG :";
							data = "$STR_BCE_DECS_HDG";
							textRight = "--";
							Expression_idc[] = {};
							tooltip = "$STR_BCE_TIP_HDG";
						};
						class Line3: Line1
						{
							text = "3: DIST :";
							data = "$STR_BCE_DECS_DIST";
							textRight = "--";
							Expression_idc[] = {};
							tooltip = "$STR_BCE_TIP_DIST";
						};
						class Line4: Line1
						{
							text = "4: ELEV :";
							data = "$STR_BCE_DECS_ELEV";
							textRight = "--";
							Expression_idc[] = {};
							tooltip = "$STR_BCE_TIP_ELEV";
						};
						class Line5: Line1
						{
							text = "5: DESC :";
							data = "$STR_BCE_DECS_DESC";
							tooltip = "$STR_BCE_TIP_DESC";
							Expression_idc[] = {2015};
						};
						class Line6: Line1
						{
							text = "6: GRID :";
							data = "$STR_BCE_DECS_GRID";
							tooltip = "$STR_BCE_TIP_GRID";
							Expression_idc[] = {20121,2013,2014};
						};
						class Line7: Line1
						{
							text = "7: MARK :";
							data = "$STR_BCE_DECS_MARK";
							tooltip = "$STR_BCE_TIP_MARK";
							Expression_idc[] = {2016};
						};
						class Line8: Line1
						{
							text = "8: FRND :";
							data = "$STR_BCE_DECS_FRND";
							tooltip = "$STR_BCE_TIP_FRND";
							Expression_idc[] = {2012,2013,2014,2016};
						};
						class Line9: Line1
						{
							text = "9: EGRS :";
							data = "$STR_BCE_DECS_EGRS";
							tooltip = "$STR_BCE_TIP_EGRS";
							Expression_idc[] = {2019,2018,2014,2017,2013};
						};
						class Remark: Line1
						{
							text = "Remarks :";
							data = "$STR_BCE_DECS_Remarks";
							tooltip = "$STR_BCE_TIP_Remarks";
							Expression_idc[] = {2200,2018,2014,2017,2201,2202};
						};
					};
				};
				//-5 line
				class CAS_TaskList_5: CAS_TaskList_9
				{
					idc = idc_D(2005);
					class Items: Items
					{
						class Line1: Game_plan
						{
							text = "1:  :";
							textRight = "--";
							Expression_idc[] = {20110,2011,20111,20112,20113,2020,2021,2022,2023,2024};
							multi_options = 1;
							default = 1;
							tooltip = "$STR_BCE_TIP_5Line";
						};
						class Line2: Line1
						{
							text = "2: FRND/Mark :";
							data = "$STR_BCE_DECS_FRNDMark";
							tooltip = "$STR_BCE_TIP_FRND";
							textRight = "NA";
							multi_options = 0;
							Task_writeDown = "";
							Expression_idc[] = {2012,2013,2014,2016};
						};
						class Line3: Line2
						{
							text = "3: TGT :";
							data = "$STR_BCE_DECS_TGT";
							tooltip = "$STR_BCE_TIP_GRID";
							Expression_idc[] = {20121,2013,2014};
						};
						class Line4: Line2
						{
							text = "4: DESC/Mark :";
							data = "$STR_BCE_DECS_DESCMark";
							tooltip = "$STR_BCE_TIP_DESC";
							Expression_idc[] = {2015,2016};
						};
						class Remark: Remark
						{
							text = "Remarks :";
							data = "$STR_BCE_DECS_Remarks";
							tooltip = "$STR_BCE_TIP_Remarks";
							Expression_idc[] = {2200,2018,2014,2017,2201,2202};
						};
					};
				};

				// ----------- Task Contents ----------- //

				#define ExpPOS(MULTIY,MULTIW,MULTIH) \
					x = FrameLX + smalFmW + smalSpc;\
					y = ((MULTIY + 1.2) * ContH) + (ContH / 3);\
					w = MULTIW * ContW;\
					h = MULTIH * ContH

				#define ExpBOX(MULTIY,MULTIH,MULTIW,OFFSETX) \
					x = (FrameLX + smalFmW + smalSpc) + (OFFSETX * (safezoneH/safezonew) * (safezoneH / 70));\
					y = ((MULTIY + 1.2) * ContH) + (ContH / 3);\
					w = MULTIW * (safezoneH/safezonew) * (safezoneH / 55);\
					h = MULTIH * (safezoneH / 55)

				//-Title
				class New_Task_Title: RscText
				{
					idc = idc_D(2003);
					text = "Task Title:";
					sizeEx = "0.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					x = FrameLX + smalFmW + (smalSpc / 2.5);
					y = ContH + (ContH / 3);
					w = ContW;
					h = ContH;
					show = 0;
					colorBackground[] = {0,0,0,0};
				};

				//-Control Buttons
				class Clear_TaskInfo: BCE_RscButtonMenu
				{
					idc = idc_D(2106);
					size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					x = FrameLX + smalFmW + smalSpc + (0.5 * ContW);
					y = ContH + (ContH / 3);
					w = 0.5 * ContW;
					h = "safezoneH / 53";
					text = "$STR_BCE_ClearTaskInfo";
					textureNoShortcut = "\a3\3den\data\cfg3den\history\deleteitems_ca.paa";
					//tooltip = "Clear Task Info";
					onButtonClick = "(_this + [false,'cTab_Tablet_dlg',17000]) call BCE_fnc_clearTaskInfo";

					colorBackground[] = {1,0,0,0.5};
					colorBackground2[] = {1,0,0,0.5};

					colorBackgroundFocused[] = {1,0,0,0.5};

					animTextureOver = "#(argb,8,8,3)color(1,0.25,0.25,0.5)";
					animTextureFocused = "#(argb,8,8,3)color(1,0,0,1)";
					animTexturePressed = "#(argb,8,8,3)color(1,0.25,0.25,0.3)";
					
					class ShortcutPos: ShortcutPos
					{
						left = 0.5 * ContW - (1.5 * 0.0175);
					};
				};

				class CAS_UI_SendData: ctrlButton
				{
					idc = idc_D(2105);
					x = FrameLX + smalFmW + smalSpc;
					y = smalFmH - (safezoneH / 40);
					w = ContW;
					h = "safezoneH / 40";
					text = "$STR_BCE_SendData";
					font = "RobotoCondensed_BCE";
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					colorBackground[] = {0.5,0.5,0.5,0.5};
					onButtonClick = "(_this + [17000,true]) call BCE_fnc_DataReceiveButton";
				};
				class CAS_UI_AbortData: CAS_UI_SendData
				{
					idc = idc_D(21050);
					x = FrameLX + smalFmW + smalSpc;
					y = smalFmH - ((safezoneH / 40) + (safezoneH / 52));
					w = 0.5 * ContW;
					h = "safezoneH / 53";
					text = "$STR_BCE_Abort_Task";
					font = "PuristaMedium";
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					colorBackground[] = {1,0.25,0.25,0.5};
					colorBackgroundDisabled[] = {0,0,0,0.5};
				};
				class CAS_UI_EnterData: CAS_UI_AbortData
				{
					idc = idc_D(21051);
					x = FrameLX + smalFmW + smalSpc + (0.5 * ContW);
					text = "$STR_BCE_Enter";
					colorBackground[] = {0.5,0.5,0.5,0.5};
				};

				//-Game Plan
				class New_Task_CtrlType: RscToolbox
				{
					idc = idc_D(2011);
					ExpPOS(2.15,1,1);
					rows = 1;
					columns = 3;
					strings[] =
					{
						"Type 1",
						"Type 2",
						"Type 3"
					};
					font = "RobotoCondensed_BCE";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class New_Task_Ctrl_Title: Clear_TaskInfo
				{
					idc = idc_D(20110);
					text = "$STR_BCE_ControlType_BNT";
					colorBackground[] = {0,0,0,0.4};
					tooltip = "$STR_BCE_more_Details";
					onButtonClick = (_this + [17000+2004,'"cTab_Tablet_dlg" >> "controls" >> "Task_Builder" >> "controls"']) call BCE_fnc_ctab_ChangeTask_Desc;
					BCE_Desc = "$STR_BCE_DECS_sm_CtrlType";
					ExpPOS(1,0.5,1);
					periodFocus = 0;
					periodOver = 0;
					textureNoShortcut="\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
				};
				class New_Task_AttackType_Title: New_Task_Ctrl_Title
				{
					idc = idc_D(20111);
					text = "$STR_BCE_AttackType_BNT";
					BCE_Desc = "$STR_BCE_DECS_sm_AttackType";
					ExpPOS(3.25,0.5,1);
				};
				class New_Task_AttackType: New_Task_CtrlType
				{
					idc = idc_D(20112);
					ExpPOS(4.4,1,1);
					columns = 2;
					strings[] =
					{
						"BoT",
						"BoC"
					};
				};
				class New_Task_Ordnance_Title: New_Task_Ctrl_Title
				{
					idc = idc_D(20113);
					text = "$STR_BCE_OrdnanceREQ_BNT";
					BCE_Desc = "$STR_BCE_DECS_sm_Ordnance";
					ExpPOS(5.5,0.575,1);
					
					class ShortcutPos: ShortcutPos
					{
						left = 0.575 * ContW - (1.5 * 0.0175);
					};
				};

				//-IP
				class New_Task_IPtype: New_Task_CtrlType
				{
					idc = idc_D(2012);
					ExpPOS(1,1,1);
					rows = 1;
					columns = 3;
					strings[] =
					{
						"$STR_BCE_Tit_Map_marker",
						"$STR_BCE_Tit_BFT_marker",
						"$STR_BCE_Tit_OverHead"
					};
					onToolBoxSelChanged = _this + [false,TASK_OFFSET] call BCE_fnc_ToolBoxChanged;
				};
				class New_Task_TGT: New_Task_IPtype
				{
					idc = idc_D(20121);
					columns = 2;
					strings[] =
					{
						"$STR_BCE_Tit_Map_marker",
						"$STR_BCE_Tit_BFT_marker"
					};
				};
				class New_Task_MarkerCombo: RscCombo
				{
					idc = idc_D(2013);
					ExpPOS(2,0.5,1);
					show = 0;
					colorBackground[] = {0.5,0.5,0.5,0.6};
					colorSelectBackground[] = {0.5,0.5,0.5,0.6};
					//colorPictureSelected[] = {1,1,1,0};
					wholeHeight = 0.8;
					font = "PuristaMedium";
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					onMouseButtonClick = "(_this # 0) call BCE_fnc_IPMarkers;";
					class Items
					{
						class NA
						{
							text = "$STR_BCE_SelectMarker";
							data = "[]";
							default = 1;
						};
					};
				};
				class New_Task_IPExpression: RscEdit
				{
					idc = idc_D(2014);
					ExpPOS(2,0.5,1);
					text = "";
					canModify = 0;
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					show = 0;
					colorBackground[] = {0,0,0,0};
					tooltip = "$STR_BCE_tip_ShowResult";
				};

				//-TG Description
				class New_Task_TG_DESC: RscEditMulti
				{
					idc = idc_D(2015);
					ExpPOS(1,1,8);
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					text = "";
					show = 0;
				};

				//-Mark
				class New_Task_GRID_DESC: RscEdit
				{
					idc = idc_D(2016);
					ExpPOS(1,1,1);
					text = "$STR_BCE_MarkWith";
					show = 0;
				};

				//-ERGS
				class New_Task_EGRS_Azimuth: New_Task_CtrlType
				{
					idc = idc_D(2017);
					ExpPOS(3,1,1);
					rows = 1;
					columns = 8;
					strings[] =
					{
						"N",
						"NE",
						"E",
						"SE",
						"S",
						"SW",
						"W",
						"NW"
					};
					values[] =
					{
						0,
						45,
						90,
						135,
						180,
						225,
						270,
						315
					};
					show = 0;
					sizeEx = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class New_Task_EGRS_Bearing: RscEdit
				{
					idc = idc_D(2018);
					ExpPOS(2,0.5,1);
					text = "$STR_BCE_Bearing_ENT";
					show = 0;
				};
				class New_Task_EGRS: New_Task_IPtype
				{
					idc = idc_D(2019);
					columns = 4;
					strings[] =
					{
						"$STR_BCE_Tit_Azimuth",
						"$STR_BCE_Tit_Bearing",
						"$STR_BCE_Tit_Map_marker",
						"$STR_BCE_Tit_OverHead"
					};
					sizeEx = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};

				//-Remarks
				class New_Task_FADH: New_Task_IPtype
				{
					idc = idc_D(2200);
					columns = 3;
					strings[] =
					{
						"FAD",
						"FAH",
						"$STR_BCE_Default"
					};
				};
				class New_Task_DangerClose_Text: RscText
				{
					idc = idc_D(2201);
					ExpBOX(4,1,17,1);
					text = ": Danger Close";
					show = 0;
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class New_Task_DangerClose_Box: RscCheckBox
				{
					idc = idc_D(2202);
					textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					ExpBOX(4,1,1,0);
					show = 0;
				};

				//-Ordnance
				class AI_Remark_WeaponCombo: New_Task_MarkerCombo
				{
					idc = idc_D(2020);
					ExpPOS(6.65,0.5,1);
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					onMouseButtonClick = "";
					onLBSelChanged = (_this + [TASK_OFFSET]) call BCE_fnc_CAS_SelWPN;
					class Items{};
				};
				class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
				{
					idc = idc_D(2021);
					onLBSelChanged = "";
				};
				class Attack_Range_Combo: AI_Remark_ModeCombo
				{
					idc = idc_D(2022);
					ExpPOS(7.65,1/3,1);
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					tooltip = "$STR_BCE_tip_Attack_Range";
					class Items
					{
						class 2000m
						{
							text = "2000m";
							value = 2000;
							default = 1;
						};
						class 1500m
						{
							text = "1500m";
							value = 1500;
						};
						class 1000m
						{
							text = "1000m";
							value = 1000;
						};
					};
				};
				class Round_Count_Box: RscEdit
				{
					idc = idc_D(2023);
					Style = 2;
					show = 0;
					text = "1";
					tooltip = "$STR_BCE_tip_Round_Count";
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class Attack_Height_Box: Round_Count_Box
				{
					idc = idc_D(2024);
					tooltip = "$STR_BCE_tip_Attack_Height";
					text = "2000";
				};
			};
		};

		//-SubMenu + lerGTD SubMenu + BCE Submenu
		class MainSubmenu: cTab_RscControlsGroup
		{
			h = MAINSUB * SubMenuH;
			REMOVE_SCROLL;
			class controls
			{
				class lockUavCam: cTab_MenuItem
				{
					colorBackground2[] = {0.5,1,0.5,0.3};
					colorBackgroundFocused[] = {0.5,1,0.5,0.3};
				};
			};
		};
		SetSubMenu(EnemySub1,E_SUB1,SubMenuH);
		SetSubMenu(EnemySub2,E_SUB2,SubMenuH);
		class EnemySub3: cTab_RscControlsGroup
		{
			h = E_SUB3 * SubMenuH;
			REMOVE_SCROLL;
			#ifdef SubMenuNEbnt
				SubMenuNEbnt;
			#endif
		};
		SetSubMenu(EnemySub4,E_SUB4,SubMenuH);
		SetSubMenu(CasulSub1,C_SUB1,SubMenuH);
		SubMenuID_FIX(SubMenuH);

		#if PHONE_MOD == 1134
			lerGTD_SUB(MenuCustomText,btn8,8,SubMenuH);
			lerGTD_SUB(MenuControlPoint,btn9,9,SubMenuH);
			lerGTD_SUB(MenuManoeuvre,btn5,5,SubMenuH);
			lerGTD_SUB(MenuSustainment,btn5,5,SubMenuH);
		#endif

		//-SubMenu
		class Connect_Veh_Submenu: MainSubmenu
		{
			idc = idc_D(3300);
			class controls
			{
				class mainbg: cTab_IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0;
					w = SubMenuW;
					h = 2 * SubMenuH;
				};
				class connect: cTab_MenuItem
				{
					idc = -1;
					text = "Connect Vehicle";
					style = 2;
					x = 0;
					y = 0;
					w = SubMenuW;
					h = SubMenuH;
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[3] call cTab_fnc_userMenuSelect;";
				};
				class exit: cTab_MenuExit
				{
					idc = -1;
					text = "Exit";
					x = 0;
					y = SubMenuH;
					w = SubMenuW;
					h = SubMenuH;
					sizeEx = "((27)) / 2048 * (safezoneH * 1.2)";
					action = "[0] call cTab_fnc_userMenuSelect;";
				};
			};
		};
		class DisConnect_Veh_Submenu: Connect_Veh_Submenu
		{
			idc = idc_D(33000);
			class controls: controls
			{
				class mainbg: mainbg{};
				class connect: connect
				{
					text = "Disconnect";
					action = "[-3] call cTab_fnc_userMenuSelect;";
				};
				class exit: exit{};
			};
		};

		//-Edit User Marker
		class Marker_Edit_Submenu: Connect_Veh_Submenu
		{
			idc = idc_D(3301);
			class controls: controls
			{
				class mainbg: mainbg
				{
					h = 4 * SubMenuH;
				};
				class IPBP: connect
				{
					text = "Mark as IP/BP";
					colorBackgroundActive[] = {1,1,0,0.3};
					action = "[41] call cTab_fnc_userMenuSelect;";
					tooltip = "$STR_BCE_TIP_IPBP";
				};
				class GRID: IPBP
				{
					text = "Mark as Target";
					colorBackgroundActive[] = {1,0,0,0.3};
					y = SubMenuH;
					action = "[42] call cTab_fnc_userMenuSelect;";
					tooltip = "$STR_BCE_TIP_GRID";
				};
				class FRND: IPBP
				{
					text = "Mark as FRND";
					colorBackgroundActive[] = {0,0.5,1,0.3};
					y = SubMenuH * 2;
					action = "[43] call cTab_fnc_userMenuSelect;";
					tooltip = "$STR_BCE_TIP_FRND";
				};
				class exit: exit
				{
					y = SubMenuH * 3;
				};
			};
		};

		class btnF2: cTab_Tablet_btnF2
		{
			tooltip = "AV Intel Live Feed - Quick Key";
		};
		class btnF5: cTab_Tablet_btnF5
		{
			tooltip = "Task Builder - Quick Key";
			action = "['cTab_Tablet_dlg',[['mode','TASK_Builder']]] call cTab_fnc_setSettings;";
		};
	};
};

class cTab_FBCB2_on_screen_time;
class cTab_FBCB2_on_screen_dirDegree: cTab_FBCB2_on_screen_time
{
	style = 1;
};
//-Weather Condition
class cTab_FBCB2_on_screen_dirOctant: cTab_Tablet_OSD_dirOctant
{
	x = "((((15) + ((685))) + ((15) + ((((810)) - (15) * 6) / 5)) * (0.3))) / 2048 * (safezoneW) + (safezoneX + (safezoneW - 	(safezoneW)) / 2)";
	y = "((608) + ((44) - (24)) / 2) / 2048  * ((safezoneW) * 4/3) + (safezoneY + (safezoneH - ((safezoneW) * 4/3)) / 2)";
	w = "1.05 * ((((((810)) - (15) * 6) / 5)) / 2048 * (safezoneW))";
	h = "(((44) - (15))) / 2048 * ((safezoneW) * 4/3)";
	
	size = "(((44) - (15))) / 2048 * ((safezoneW) * 4/3)";
	action = "['cTab_FBCB2_dlg'] call cTab_fnc_toggleWeather";
	
	class TextPos
	{
		left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40);
		top = (((((1341))) / 2048 * (safezoneH * 0.8)) * 3/5)/4/20;
		right = 0.0049999999;
		bottom = 0;
	};
	class Attributes: Attributes
	{
		size = 0.8;
	};
};

//-SubMenu + lerGTD SubMenu + BCE Submenu
class cTab_FBCB2_dlg
{
		class controlsBackground
		{
			class screen: RscMapControl
			{
				onMouseButtonDblClick = "call cTab_fnc_onMapDoubleClick";
			};
			#if MAP_MODE > 2
				class screenTopo: screen
				{
					#include "..\Map_Type\TOPO_GRD.hpp"
				};
			#endif
		};
	class controls
	{
		cTab_Set_SubMenu(SubMenuH_FB);
		class cTab_FBCB2_on_Weather_condition_Box: cTab_Tablet_OSD_Weather_condition_Box
		{
			x = "((((15) + ((685))) + ((15) + ((((810)) - (15) * 6) / 5)) * (0.3))) / 2048 * (safezoneW) + (safezoneX + (safezoneW - 	(safezoneW)) / 2)";
			y = "((608) + ((44) - (24)) / 2) / 2048  * ((safezoneW) * 4/3) + (safezoneY + (safezoneH - ((safezoneW) * 4/3)) / 2) + ((((44) - (15))) / 2048 * ((safezoneW) * 4/3))";
			w = "1.05 * ((((((810)) - (15) * 6) / 5)) / 2048 * (safezoneW))";
			h = 0;
			
			size = "(((safezoneW / safezoneH) min 1.2) / 1.2) / 25";
			
			class Attributes: Attributes
			{
				size = 0.9;
			};
		};
	};
};
#if MAP_MODE > 2
	class cTab_microDAGR_dlg
	{
		class controlsBackground
		{
			class screen: cTab_microDAGR_RscMapControl{};
			class screenTopo: screen
			{
				#include "..\Map_Type\TOPO_GRD.hpp"
			};
		};
	};
#endif

#define MOUSE_CLICK_EH "(_this + [17000]) call BCE_fnc_GetMapClickPOS"

//- TAD
	#define TAD_SizeH (safezoneH * 0.8)
	#define TAD_SizeW (TAD_SizeH * 3/4)
	#define TAD_SizeX 2048  * (TAD_SizeH * 3/4) + (safezoneX + (safezoneW - TAD_SizeH * 3/4) / 2)
	#define TAD_SizeY 2048  * TAD_SizeH + (safezoneY + safezoneH * 0.1)

	#define TAD_CLASS class cTab_TAD_dlg
	#include "cTab_TAD.hpp"

//-Phone
#define PHONE_CLASS class cTab_Android_dlg

#define PhoneH (safezoneH * 1.2)
#define PhoneW (safezoneW * 0.8)

//-Default Layout
#define CustomPhoneH (PhoneW * 4/3)
#define CustomPhoneX (safezoneX + (safezoneW - 	PhoneW) / 2)
#define CustomPhoneY (safezoneY + (safezoneH - 	CustomPhoneH) / 2)

#define phoneSizeX ((((452))) / 2048 * PhoneW + CustomPhoneX)
#define phoneSizeY ((((713) + (60))) / 2048 * CustomPhoneH + CustomPhoneY)
#define phoneSizeW ((((PHONE_MOD))) / 2048 * PhoneW)
#define phoneSizeH ((((626) - (60) - (0))) / 2048 * CustomPhoneH)

#define TextSize (((38)) / 2048 * CustomPhoneH)
#define TextTimes 1
#define TextTimesH 1
#define TextMenu(MULTI) __EVAL(1.1*MULTI)

//-ATAK Map
#include "cTab_Android_Widgets.hpp"
#include "cTab_Android_Layout.hpp"

//-Phone display
#include "cTab_Android.hpp"
