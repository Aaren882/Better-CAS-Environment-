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
			Expand_Height = 2; //- Height of Drop Menu ("Tag_Bnt" Height * Expand_Height)
			MaxOpened = -1;
			//- Functions
			onTagLoad = "BCE_fnc_ATAK_GroupList_Init";
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
			Expand_Height = 3;
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
				Variable_Name = "CFF_TaskList";
				Expand_Height = 3;
				MaxOpened = 1;
				onTagLoad = "BCE_fnc_ATAK_CFF_TaskList_Init";
				onTagClick = "";
			};
			class controls: controls
			{
				class menuBackground: menuBackground{};
				class List_Info: List_Info{};
				class Tag_Bnt: Tag_Bnt{};
				class Exec_bnt: Msg_bnt
				{
					text = "<img image='MG8\AVFEVFX\data\locating.paa'/>";
					onButtonClick = "call BCE_fnc_CFF_Mission_XMIT";
				};
				class Edit_bnt: Edit_bnt
				{
					text = "<img image='MG8\AVFEVFX\data\edit.paa'/>";
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
