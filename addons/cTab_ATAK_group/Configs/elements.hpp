//- Custom Drop Menu
	class ATAK_Group_Manage_System: cTab_RscControlsGroup
	{
		x = 0;
		y = 0;
		w = QUOTE(PhoneBFTContainerW(3));
		h = QUOTE(0.7 * (((60)) / 2048 * CustomPhoneH));
		onLoad = "call BCE_fnc_ATAK_Custom_DropMenu_Init";
		//- Scrollbars
			REMOVE_SCROLL;
		class DropMenu_Props
		{
			Variable_Name = "group_Info"; //- Variable in cTab_fnc_getSettings
			Expand_Height = 0; //- Height of Drop Menu ("Tag_Bnt" Height * (1 + Expand_Height))
			MaxOpened = -1;
			//- Functions
			onTagLoad = QFUNC(ATAK_GroupList_SYSTEM_Init);
			onTagClick = "";
		};
		class controls
		{
			#define BNT_W 0.4
			#define TAG_BNT_W(SIZE) (3 - (SIZE * BNT_W))
			class Tag_Bnt: BCE_RscButtonMenu
			{
				idc = 15;
				w = QUOTE(PhoneBFTContainerW(TAG_BNT_W(1)));
				h = QUOTE(0.7 * (((60)) / 2048 * CustomPhoneH));
				size = QUOTE(TextSize);

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
					text = QSTRUCTURE_IMAGE(Core,data\chat.paa);
					
					x = QUOTE(PhoneBFTContainerW(TAG_BNT_W(1)));
					w = QUOTE(PhoneBFTContainerW(BNT_W));
					// size = 0.65 * (((60)) / 2048 * CustomPhoneH);
					size = QUOTE(TextSize);
					
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
			onTagLoad = QFUNC(ATAK_GroupList_Init);
			Expand_Height = 2;
		};
		// h = (3 * 0.7) * (((60)) / 2048 * CustomPhoneH); // - Display with 3 lines
		class controls: controls
		{
			class menuBackground: RscBackground
			{
				idc = -1;
				x = 0;
				y = QUOTE(0.7 * (((60)) / 2048 * CustomPhoneH));
				w = QUOTE(PhoneBFTContainerW(3));
				h = QUOTE((2 * 0.7) * (((60)) / 2048 * CustomPhoneH));
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
				y = QUOTE(0.7 * (((60)) / 2048 * CustomPhoneH));
				w = QUOTE(PhoneBFTContainerW(3));
				h = QUOTE((2 * 0.7) * (((60)) / 2048 * CustomPhoneH));

				sizeEx = QUOTE((0.8 * 0.7) * (((60)) / 2048 * CustomPhoneH));
				rowHeight = QUOTE(0.7 * (((60)) / 2048 * CustomPhoneH));
				
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
				w = QUOTE(PhoneBFTContainerW(TAG_BNT_W(2)));
				
				colorBackground[] = {0.2,0.2,0.2,0.86};
				colorBackground2[] = {0.2,0.2,0.2,0.86};
				colorBackgroundFocused[] = {0.2,0.2,0.2,0.5};
			};
			class Msg_bnt: Msg_bnt {};
			class Edit_bnt: Msg_bnt
			{
				idc = 17;
				x = QUOTE(PhoneBFTContainerW(TAG_BNT_W(2)));
				text = QSTRUCTURE_IMAGE(Core,data\edit.paa);

				colorBackground[] = {0.23,0.23,0.23,0.86};
				colorBackground2[] = {0.23,0.23,0.23,0.86};
				colorBackgroundFocused[] = {0.23,0.23,0.23,0.5};
			};
		};
	};
