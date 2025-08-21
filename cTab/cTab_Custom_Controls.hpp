//- message Line
	class ATAK_Message_Line: RscStructuredText
	{
		x = 0;
		y = 0;
		w = PhoneBFTContainerW(3);
		h = 0.7 * (((60)) / 2048 * CustomPhoneH);
		size = 0.65 * (((60)) / 2048 * CustomPhoneH);
		class Attributes
		{
			color = "#dee0de";
		};
	};

//- Custom Drop Menu
	class ATAK_Group_Manage_System: cTab_RscControlsGroup
	{
		x = 0;
		y = 0;
		w = PhoneBFTContainerW(3);
		h = 0.7 * (((60)) / 2048 * CustomPhoneH);
		onLoad = "call BCE_fnc_ATAK_Custom_DropMenu_Init";
		//- Scrollbars
			REMOVE_SCROLL;
		class DropMenu_Props
		{
			Variable_Name = "group_Info"; //- Variable in cTab_fnc_getSettings
			Expand_Height = 0; //- Height of Drop Menu ("Tag_Bnt" Height * (1 + Expand_Height))
			MaxOpened = -1;
			//- Functions
			onTagLoad = "BCE_fnc_ATAK_GroupList_SYSTEM_Init";
			onTagClick = "";
		};
		class controls
		{
			#define BNT_W 0.4
			#define TAG_BNT_W(SIZE) (3 - (SIZE * BNT_W))
			class Tag_Bnt: BCE_RscButtonMenu
			{
				idc = 15;
				w = PhoneBFTContainerW(TAG_BNT_W(1));
				h = 0.7 * (((60)) / 2048 * CustomPhoneH);
				// size = 0.7 * (((60)) / 2048 * CustomPhoneH);
					size = TextSize;

				text = "";
				// onButtonClick = "call BCE_fnc_ATAK_onGroupClicked"

				colorBackground[] = {0.15,0.15,0.15,0.86};
				colorBackground2[] = {0.15,0.15,0.15,0.86};
				colorBackgroundFocused[] = {0.15,0.15,0.15,0.5};

				animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
				animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
				animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

				class Attributes: Attributes
				{
					size = 0.9;
					valign = "middle";
				};
			};
			//- Chat Bnt
				class Msg_bnt: Tag_Bnt
				{
					idc = 16;
					style = "0x02 + 0x0C + 0x0100";
					shadow = 1;
					text = "<img image='MG8\AVFEVFX\data\chat.paa'/>";
					
					x = PhoneBFTContainerW(TAG_BNT_W(1));
					w = PhoneBFTContainerW(BNT_W);
					// size = 0.65 * (((60)) / 2048 * CustomPhoneH);
					size = TextSize;
					
					colorBackground[] = {0.26,0.26,0.26,0.86};
					colorBackground2[] = {0.26,0.26,0.26,0.86};
					colorBackgroundFocused[] = {0.26,0.26,0.26,0.5};

					class Attributes: Attributes
					{
						size = 0.9;
						align = "center";
						valign = "Bottom";
					};
				};
		};
	};
	class ATAK_Group_Manage_Custom: ATAK_Group_Manage_System
	{
		class DropMenu_Props: DropMenu_Props
		{
			onTagLoad = "BCE_fnc_ATAK_GroupList_Init";
			Expand_Height = 2;
		};
		// h = (3 * 0.7) * (((60)) / 2048 * CustomPhoneH); // - Display with 3 lines
		class controls: controls
		{
			class menuBackground: RscBackground
			{
				idc = -1;
				x = 0;
				y = 0.7 * (((60)) / 2048 * CustomPhoneH);
				w = PhoneBFTContainerW(3);
				h = (2 * 0.7) * (((60)) / 2048 * CustomPhoneH);
				colorBackground[] = {0,0,0,0.2};
			};
			class List_Info: RscListNBox
			{
				idc = 50;
				
				onLoad="(_this # 0) ctrlenable false;";

				shadow = 1;
				shadowTextLeft = 1;
				shadowTextRight = 1;
				shadowPictureLeft = 1;
				shadowPictureRight = 1;

				x = 0;
				y = 0.7 * (((60)) / 2048 * CustomPhoneH);
				w = PhoneBFTContainerW(3);
				h = (2 * 0.7) * (((60)) / 2048 * CustomPhoneH);

				sizeEx = (0.8 * 0.7) * (((60)) / 2048 * CustomPhoneH);
				rowHeight = 0.7 * (((60)) / 2048 * CustomPhoneH);
				
				colorDisabled[]={1,1,1,1};
				colorShadow[] = {0,0,0,1};

				drawSideArrows = 0;
				tooltipPerColumn = 1;
				period=0;
				colorBackground[]={0,0,0,0.5};

				font = "RobotoCondensed_BCE";
				columns[] = {0.01,0.99};
				class ScrollBar
				{
					color[] = {1,1,1,0};
					colorActive[] = {1,1,1,0};
					colorDisabled[] = {1,1,1,0};
					thumb = "";
					arrowEmpty = "";
					arrowFull = "";
					border = "";
					shadow = 0;
					scrollSpeed = 0;
					width = 0;
					height = 0;
					autoScrollEnabled = 0;
					autoScrollSpeed = -1;
					autoScrollDelay = 5;
					autoScrollRewind = 0;
				};
				class ListScrollBar: ScrollBar{};
			};
			class Tag_Bnt: Tag_Bnt
			{
				w = PhoneBFTContainerW(TAG_BNT_W(2));
				
				colorBackground[] = {0.2,0.2,0.2,0.86};
				colorBackground2[] = {0.2,0.2,0.2,0.86};
				colorBackgroundFocused[] = {0.2,0.2,0.2,0.5};
			};
			class Msg_bnt: Msg_bnt {};
			class Edit_bnt: Msg_bnt
			{
				idc = 17;
				x = PhoneBFTContainerW(TAG_BNT_W(2));
				text = "<img image='MG8\AVFEVFX\data\edit.paa'/>";

				colorBackground[] = {0.23,0.23,0.23,0.86};
				colorBackground2[] = {0.23,0.23,0.23,0.86};
				colorBackgroundFocused[] = {0.23,0.23,0.23,0.5};
			};
		};
	};
	//- CFF Standard
		class ATAK_CFF_STD: ATAK_Group_Manage_Custom
		{
			class DropMenu_Props: DropMenu_Props
			{
				Variable_Name = "CFF_TaskList"; //- Variable in cTab_fnc_getSettings
				Expand_Height = 4;							//- height after expanded
				MaxOpened = 1;									//- Maximum number of opened tags
				onTagLoad = "BCE_fnc_ATAK_CFF_TaskList_Init";
				onTagClick = "";
			};
			class controls: controls
			{
				class menuBackground: menuBackground
				{
					h = (3 * 0.7) * (((60)) / 2048 * CustomPhoneH);
				};
				class List_Info: List_Info
				{
					h = (3 * 0.7) * (((60)) / 2048 * CustomPhoneH);
				};
				class Tag_Bnt: Tag_Bnt{};
				class Exec_bnt: Msg_bnt
				{
					text = "<img image='MG8\AVFEVFX\data\start.paa'/>";
					onButtonClick = "[_this # 0, 'START'] call BCE_fnc_CFF_Mission_XMIT";
				};
				class adjust_bnt: Edit_bnt
				{
					text = "<img image='MG8\AVFEVFX\data\ruler.paa'/>";
					onButtonClick = "[_this # 0, 'ADJUST_MENU'] call BCE_fnc_CFF_Mission_XMIT";
				};
				class RAT_bnt: Edit_bnt
				{
					idc = 18;
					x = 0;
					y = 4 * (0.7 * (((60)) / 2048 * CustomPhoneH));
					W = PhoneBFTContainerW(1.5);
					text = "<img image='MG8\AVFEVFX\data\archive.paa'/> RAT";
					tooltip = "$STR_BCE_RAT_Fire_MSN_Tip";
					onButtonClick = "call BCE_fnc_ATAK_CFF_Mission_RAT";
				};
				class EOM_bnt: RAT_bnt
				{
					idc = 20;
					x = PhoneBFTContainerW(1.5);
					text = "<img image='\MG8\AVFEVFX\data\gabage.paa'/> EOM";
					tooltip = "$STR_BCE_EOM_Fire_MSN_Tip";
					
					onButtonClick = "call BCE_fnc_ATAK_CFF_Mission_EOM";
					colorBackground[] = {0.45,0,0,0.8};
					colorBackground2[] = {0.45,0,0,0.8};
					colorBackgroundFocused[] = {0.45,0,0,0.5};
				};
			};
		};
	//- CFF Record as Target (RAT)
		class ATAK_CFF_RAT: ATAK_CFF_STD
		{
			class DropMenu_Props: DropMenu_Props
			{
				Variable_Name = "CFF_RAT_TaskList"; //- Variable in cTab_fnc_getSettings
			};
			class controls: controls
			{
				class menuBackground: menuBackground{};
				class List_Info: List_Info{};
				class Tag_Bnt: Tag_Bnt
				{
					w = PhoneBFTContainerW(TAG_BNT_W(1));
				};
				class Exec_bnt: Exec_bnt
				{
					tooltip = "$STR_BCE_Add_Fire_MSN_Tip";
					onButtonClick = "call BCE_fnc_ATAK_CFF_Mission_RAT_2_ADD";
				};
				// class adjust_bnt: adjust_bnt{};
				delete adjust_bnt;
				delete RAT_bnt;
				class EOM_bnt: EOM_bnt
				{
					idc = 20;
					x = 0;
					w = PhoneBFTContainerW(3);

					text = "<img image='\MG8\AVFEVFX\data\gabage.paa'/> Delete";
					tooltip = "$STR_BCE_DEL_RAT_Fire_MSN_Tip";
					onButtonClick = "[_this # 0, true] call BCE_fnc_ATAK_CFF_Mission_RAT; call BCE_fnc_ATAK_ShowTaskResult;";
				};
			};
		};
	#undef BNT_W
	#undef TAG_BNT_W

//- ATAK APPs
	class ATAK_AppMenu_Base: cTab_RscControlsGroup
	{
		x = 0;
		y = 0;
		w = phoneSizeW * 2/5;
		h = phoneSizeH - 0.75 * ATAK_POS_H;
		
		class VScrollbar
		{
			scrollSpeed=0.08;
		};
		class HScrollbar{};
		class Scrollbar{};
	};

//- CFF ADJUST Interface (ATAK APPs)
	#define ADJUSTMENT_MENU 3
//- POLAR (ADJUST)
	class CFF_ADJUST_POLAR_Group: ATAK_AppMenu_Base
	{
		onLoad = "call BCE_fnc_ATAK_FireAdjust_Init_Polar";
		ATAK_POS(0,0,2.8,(ADJUSTMENT_MENU * 0.7));
		class controls
		{
			//- Background (for ControlGroup)
				class AdjustFrameBg: RscBackground
				{
					colorBackground[] = {0,0,0,0.2};
					ATAK_POS(0,0,2.8,(ADJUSTMENT_MENU * 0.7));
				};
			//- Clear Button
				class Clear_Adjust: BCE_RscButtonMenu
				{
					idc = 5000;
					ATAK_POS(0,0,0.35,(ADJUSTMENT_MENU * 0.7));

					//- Color
						colorBackground[] = {1,0,0,0.35};
						colorBackground2[] = {1,0.25,0.25,0.4};
						colorBackgroundFocused[] = {1,0,0,0.2};

						animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
						animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
						animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";
					
					size = 0.75 * TextSize;
					style = "0x02 + 0x30 + 0x800";
					shadow = 1;
					// text = "<img image='\MG8\AVFEVFX\data\gabage.paa' />";
					textureNoShortcut="\MG8\AVFEVFX\data\gabage.paa";
					onButtonClick = "call BCE_fnc_CleanFireAdjustValues";

					class ShortcutPos: ShortcutPos
					{
						left = (0.35 * ATAK_POS_W / 2) - (0.75 * TextSize / 2);
						top = ((ADJUSTMENT_MENU * 0.7 / 2) * ATAK_POS_H) - (0.75 * TextSize / 2);
						w = (0.75 * TextSize);
						h = (ADJUSTMENT_MENU * 0.7) * ATAK_POS_H / 4;
					};
					class TextPos: TextPos
					{
						top = ((ADJUSTMENT_MENU * 0.7 * 0.5) * ATAK_POS_H) - (0.75 * TextSize * 0.5);
					};
					class Attributes: Attributes
					{
						align="center";
						valign="top";
						size = TextMenu(1);
					};
				};
			
			//- Adjustment Controls (MACROS)
				#define ADJUST_BNT_OFFSET (1/20)
				#define ADJUST_BNT_X (2.5 - ADJUST_BNT_OFFSET) //- Center of third "ATAK_POS_W"
				#define ADJUST_BNT_W (0.32 + ADJUST_BNT_OFFSET)

				#define ADJUST_INTERVAL 6
				#define ADJUST_BNT_POS(XPOS,YPOS,WPOS,HPOS) \
					x = PhoneBFTContainerW(XPOS) + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW); \
					y = YPOS * ATAK_POS_H + (ADJUST_INTERVAL / 2 * pixelH); \
					w = PhoneBFTContainerW(WPOS) - (ADJUST_INTERVAL * pixelW); \
					h = HPOS * ATAK_POS_H - (ADJUST_INTERVAL * pixelH)
			
				#define BORDER (2 * ADJUST_BNT_OFFSET) //- Space for L,R borders
				//- Adjustment controls' Width (Higher the bigger Interval)
				#define ADJUST_CTRL_W(BORDER_W) (((1 + BORDER) * ATAK_POS_W) + BORDER_W * ((0.5 + 2) * ADJUST_INTERVAL * pixelW))
			
			//- Middle (Indicators, Adjust...)
				class Indicator: RscPictureKeepAspect
				{
					idc = 5001;

					x = 0.35 * ATAK_POS_W;
					y = 0;
					w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.4);
					h = 1.5 * 0.7 * ATAK_POS_H;

					sizeEx = TextSize;

					text = "\MG8\AVFEVFX\data\Arrows\thin_Arrow.paa";
				};
				class Indication: RscStructuredText
				{
					idc = 5002;
					x = 0.35 * ATAK_POS_W;
					y = 1.5 * 0.7 * ATAK_POS_H;
					w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525);
					h = 0.5 * 0.7 * ATAK_POS_H;
					
					colorBackground[] = {0,0,0,0.2};
					size = 0.5 * TextSize;

					text = "<img image='\MG8\AVFEVFX\data\Arrows\Point_Arrow.paa' /> 10 m | <img image='\MG8\AVFEVFX\data\Arrows\Point_Arrow_R.paa' /> 20 m";
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						align="center";
						valign="middle";
					};
				};
				class Adjust_Bnt: BCE_RscButtonMenu
				{
					idc = 5003;

					x = 0.35 * ATAK_POS_W;
					y = 2 * 0.7 * ATAK_POS_H;
					w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525);
					h = 0.7 * ATAK_POS_H;

					//- Style
						animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
						animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
						animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

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

					shadow=1;
					size = TextSize;
					text = "$STR_BCE_ADJUST_Title";
					onButtonClick = "['MSN_ADJUST_POLAR',nil,_this#0] call BCE_fnc_set_FireAdjust_MSN_State";

					class TextPos: TextPos
					{
						top = 0.1 * ATAK_POS_H;
					};
					class Attributes: Attributes
					{
						align="center";
						valign="middle";
						size = TextMenu(0.8);
					};
				};

			//- Adjust Buttons -//
				//- Background
					class AdjustBg: AdjustFrameBg
					{
						x = ((2.5 - BORDER) - 2 * ADJUST_BNT_W) * ATAK_POS_W + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW);
						y = 0;
						w = ADJUST_CTRL_W(1);
						h = 3 * 0.7 * ATAK_POS_H;
					};
				class Adjust_Meter: ctrlButton
				{
					idc = 5004;
					
					x = ((2.5 - BORDER) - 2 * ADJUST_BNT_W) * ATAK_POS_W + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW);
					y = 0;
					w = ADJUST_CTRL_W(1);
					h = 0.7 * ATAK_POS_H;

					//- Color
						colorBackground[] = {0,0,0,0.3};
					
					font = "RobotoCondensed_BCE";
					sizeEx = 0.8 * TextSize;
					text = "<-- 10 m -->";
					onButtonClick = "call BCE_fnc_ATAK_FireAdjustMeter";
				};
				
				class Adjust_Up: ctrlButtonPictureKeepAspect
				{
					idc = 5100;
					ADJUST_BNT_POS((ADJUST_BNT_X - ADJUST_BNT_W),(1 * 0.7),ADJUST_BNT_W,0.7);

					//- Color
						colorBackground[] = {0,0,0.2,0.3};
					
					sizeEx = 0.5 * TextSize;
					text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow.paa";
					onButtonClick = "[_this # 0, [0,1]] call BCE_fnc_UpdateFireAdjust";
				};
				class Adjust_Dn: Adjust_Up
				{
					idc = 5101;
					ADJUST_BNT_POS((ADJUST_BNT_X - ADJUST_BNT_W),(2 * 0.7),ADJUST_BNT_W,0.7);
					text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_D.paa";
					onButtonClick = "[_this # 0, [0,-1]] call BCE_fnc_UpdateFireAdjust";
				};
				class Adjust_L: Adjust_Up
				{
					idc = 5102;
					ADJUST_BNT_POS((ADJUST_BNT_X - 2 * ADJUST_BNT_W),(2 * 0.7),ADJUST_BNT_W,0.7);
					text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_L.paa";
					onButtonClick = "[_this # 0, [-1,0]] call BCE_fnc_UpdateFireAdjust";
				};
				class Adjust_R: Adjust_Up
				{
					idc = 5103;
					ADJUST_BNT_POS((ADJUST_BNT_X),(2 * 0.7),ADJUST_BNT_W,0.7);
					text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_R.paa";
					onButtonClick = "[_this # 0, [1,0]] call BCE_fnc_UpdateFireAdjust";
				};
		};
	};
//- IMPACT (ADJUST)
	class CFF_ADJUST_IMPACT_Group: CFF_ADJUST_POLAR_Group
	{
		onLoad = "call BCE_fnc_ATAK_FireAdjust_Init_Impact";
		class controls: controls
		{
			class AdjustFrameBg: AdjustFrameBg {};
			class Clear_Adjust: Clear_Adjust {};
			
			class Adjust_Bnt: Adjust_Bnt
			{
				x = (2.8 * ATAK_POS_W) - (((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525));
				onButtonClick = "['MSN_ADJUST_IMPACT',nil,_this#0] call BCE_fnc_set_FireAdjust_MSN_State";
				//- Style
					colorBackground[] = {0.53,0.38,0,0.8};
					colorBackground2[] = {0.53,0.38,0,0.8};
					colorBackgroundFocused[] = {0.53,0.38,0,0.5};
			};
			//- OT Factor display
				class Indication: Indication
				{
					y = 2 * 0.7 * ATAK_POS_H;
					w = ADJUST_CTRL_W(0.525);
					h = 0.7 * ATAK_POS_H;
					text = "<img image='\MG8\AVFEVFX\data\binoculars.paa' /> OT : 0.8";
					size = TextSize;
					tooltip = "$STR_BCE_OT_Factor_Tip";
					class TextPos
					{
						left="0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
						top = 0.2 * ATAK_POS_H;
						right=0.005;
						bottom=0;
					};
					class Attributes: Attributes
					{
						align="center";
						valign="bottom";
						size = TextMenu(0.8);
					};
				};

			//- Titles
				class Adjust_Dir_Title: RscText
				{
					x = 0.35 * ATAK_POS_W;
					y = 0;
					w = 0.7 * ATAK_POS_W;
					h = 0.7 * ATAK_POS_H;
					text = "Mil/Deg :";
					colorText[]={1,0.737255,0.0196078,1};
					tooltip = "$STR_BCE_CFF_Adjust_Dir_Tip";

					style = 0;
					shadow=2;
					sizeEx = 0.9 * TextSize;
					font = "RobotoCondensed_BCE";
				};
				class Adjust_DIST_Title: Adjust_Dir_Title
				{
					y = 0.7 * ATAK_POS_H;
					text = "DIST(m) :";
					tooltip = "$STR_BCE_CFF_Adjust_DIST_Tip";
				};
			//- EditBox
				class Adjust_Dir_Edit: RscEdit
				{
					idc = 150;
					x = (0.35 + 0.7) * ATAK_POS_W;
					y = (4 * pixelH);
					w = ((2.8 - 0.35 - 0.7) * ATAK_POS_W) - (4 * pixelW);
					h = 0.7 * ATAK_POS_H - (4 * pixelH);

					Style = 2;
					colorBackground[] = {0,0,0,0.2};
					sizeEx = 0.8 * TextSize;
				};
				class Adjust_DIST_Edit: Adjust_Dir_Edit
				{
					idc = 160;
					y = 0.7 * ATAK_POS_H + (4 * pixelH);
				};
			delete Indicator;
			delete AdjustBg;
			delete Adjust_Meter;
			delete Adjust_Up;
			delete Adjust_Dn;
			delete Adjust_L;
			delete Adjust_R;
		};
	};
//- Gun-Line (ADJUST)
	class CFF_ADJUST_GL_Group: CFF_ADJUST_POLAR_Group
	{
		class controls: controls
		{
			class AdjustFrameBg: AdjustFrameBg {};
			class Clear_Adjust: Clear_Adjust {};
			class Indicator: Indicator{};
			class Indication: Indication{};
			class Adjust_Bnt: Adjust_Bnt
			{
				colorBackground[] = {0.13,0.35,0.18,0.8};
				colorBackground2[] = {0.13,0.35,0.18,0.8};
				colorBackgroundFocused[] = {0.13,0.35,0.18,0.5};
				onButtonClick = "['MSN_ADJUST_GUNLINE',nil,_this#0] call BCE_fnc_set_FireAdjust_MSN_State";
			};
			class AdjustBg: AdjustBg{};
			class Adjust_Meter: Adjust_Meter{};
			class Adjust_Up: Adjust_Up{};
			class Adjust_Dn: Adjust_Dn{};
			class Adjust_L: Adjust_L{};
			class Adjust_R: Adjust_R{};
		};
	};
//- Undef ADJUST MARCOs
	#undef ADJUSTMENT_MENU
	#undef BORDER
	#undef ADJUST_CTRL_W
	#undef ADJUST_BNT_OFFSET
	#undef ADJUST_BNT_X
	#undef ADJUST_BNT_W
	#undef ADJUST_INTERVAL
	#undef ADJUST_BNT_POS
		