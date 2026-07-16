//- Custom Drop Menu
	class ATAK_Group_Manage_System: cTab_RscControlsGroup
	{
		class controls;
	};
	class ATAK_Group_Manage_Custom: ATAK_Group_Manage_System
	{
		class DropMenu_Props;
		class controls: controls
		{
			class menuBackground;
			class List_Info;

			class Tag_Bnt;
			class Msg_bnt;
			class Edit_bnt;
		};
	};
	class ATAK_TaskView_Tag: ATAK_Group_Manage_Custom
	{
		class DropMenu_Props: DropMenu_Props
		{
			onTagLoad = QFUNC(ATAK_Tag_Init);
			Expand_Height = 5;
			MaxOpened = 1;
		};
		class controls: controls
		{
			class Description_Group: RscControlsGroup
			{
				idc = 100;
				x = 0;
				y = QUOTE(0.7 * (((60)) / 2048 * CustomPhoneH));
				w = QUOTE(PhoneBFTContainerW(3));
				h = QUOTE((5 * 0.7) * (((60)) / 2048 * CustomPhoneH));

				class VScrollbar: VScrollbar
				{
					width = 0;
				};
				class controls
				{
					class menuBackground: RscBackground
					{
						idc = -1;
						x = 0;
						y = 0;
						w = QUOTE(PhoneBFTContainerW(3));
						h = QUOTE((5 * 0.8) * (((60)) / 2048 * CustomPhoneH));
						colorBackground[] = {0,0,0,0.2};
					};
					class Description: RscStructuredText
					{
						idc = 1;
						text = "";
						onLoad="(_this # 0) ctrlenable false;";

						x = 0;
						y = 0;
						w = QUOTE(PhoneBFTContainerW(3));
						h = 0;

						size = QUOTE((0.8 * 0.7) * (((60)) / 2048 * CustomPhoneH));
						colorBackground[] = {0,0,0,0};

						class Attributes
						{
							font = "RobotoCondensed_BCE";
							color = "#ffffff";
							align = "left";
							size = 0.75;
							shadow = 1;
						};
					};
				};
			};
			
			class Tag_Bnt: Tag_Bnt
			{
				w = QUOTE(PhoneBFTContainerW(CUSTOM_TAG_BNT_W(2)));
				
				colorBackground[] = {0.2,0.2,0.2,0.86};
				colorBackground2[] = {0.2,0.2,0.2,0.86};
				colorBackgroundFocused[] = {0.2,0.2,0.2,0.5};
			};
			class Msg_bnt: Msg_bnt
			{
				text = "<img image='a3\modules_f\data\icontasksetdestination_ca.paa' />";
			};
			class Edit_bnt: Msg_bnt
			{
				idc = 17;
				x = QUOTE(PhoneBFTContainerW(CUSTOM_TAG_BNT_W(2)));
				text = "<img image='\a3\modules_f\data\portraitstrategicmapimage_ca.paa' />";

				colorBackground[] = {0.23,0.23,0.23,0.86};
				colorBackground2[] = {0.23,0.23,0.23,0.86};
				colorBackgroundFocused[] = {0.23,0.23,0.23,0.5};
			};
		};
	};
