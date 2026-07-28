class ATAK_AppMenu_Base;

//- Message Interface
class ATAK_Message: ATAK_AppMenu_Base
{
	class controls
	{
		class Title: BCE_RscButtonMenu
		{
			idc = 5;
			x = 0;
			y = 0;
			w = QUOTE(PhoneBFTContainerW(3));
			h = QUOTE(0.8 * ATAK_POS_H);

			size = QUOTE(0.7 * ATAK_POS_H);
			text = "";

			colorBackground[] = {0,0,0,0.5};
			colorBackground2[] = {0,0,0,0.5};
			colorBackgroundFocused[] = {0,0,0,0.8};

			animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
			animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
			animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";

			onButtonClick = "call BCE_fnc_ATAK_toggleSubListMenu";
			class Attributes: Attributes
			{
				align = "center";
				valign = "Bottom";
			};
		};
		class Group_Box: cTab_RscControlsGroup
		{
			idc = 10;

			class VScrollbar: VScrollbar
			{
				width = 0;
			};
			class HScrollbar: HScrollbar
			{
				height = 0;
			};
			
			x = 0;
			y = QUOTE(0.8 * ATAK_POS_H);
			w = QUOTE(PhoneBFTContainerW(3));
			h = QUOTE(phoneSizeH - 2.3 * ATAK_POS_H);
		};
		class Contacts_list: RscListBox
		{
			idc = 6;
			colorBackground[] = {0,0,0,0.3};
			colorSelectBackground[] = {0.95,0.95,0.95,0.4};
			sizeEx = QUOTE(0.8 * (((60) - (20))) / 2048 * CustomPhoneH);

			x = 0;
			y = QUOTE(0.8 * ATAK_POS_H);
			w = QUOTE(PhoneBFTContainerW(3));
			h = 0;
		};
		class typing: RscEdit
		{
			idc = 11;
			
			x = 0;
			y = QUOTE(phoneSizeH - 1.5 * ATAK_POS_H);
			w = QUOTE(PhoneBFTContainerW(3));
			h = QUOTE(0.75 * ATAK_POS_H);

			sizeEx = QUOTE(0.64 * (((60) - (20))) / 2048 * CustomPhoneH);

			colorBackground[]={0,0,0,0.5};
		};
	};
};