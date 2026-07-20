//- sth like ts https://discord.com/channels/1307982923525390397/1308987363506126868/1337408155662942260

//- Slideshow
class ATAK_Slideshow: cTab_RscControlsGroup
{
	x = 0;
	y = 0;
	w = QUOTE(phoneSizeW);
	h = QUOTE(phoneSizeH - 0.11 * (((60)) / 2048 * CustomPhoneH));
	//- Scrollbars
		REMOVE_SCROLL;

	onLoad = QUOTE(call FUNC(onLoad));
	onKeyDown = QUOTE(call FUNC(onKeyDown));
	class controls
	{
		class menuBackground: RscBackground
		{
			idc = -1;
			x = 0;
			y = 0;
			w = QUOTE(phoneSizeW);
			h = QUOTE(phoneSizeH);
			colorBackground[] = {0,0,0,0.5};
		};
		class close: BCE_RscButtonMenu
		{
			idc = 5;

			x = QUOTE(PhoneBFTContainerW(0.25));
			y = QUOTE(phoneSizeH - (0.11 * (((60)) / 2048 * CustomPhoneH)) - (1.5 * 0.64 * ATAK_POS_H));
			w = QUOTE(PhoneBFTContainerW(0.75));
			h = QUOTE(0.64 * ATAK_POS_H);

			//- Color
				colorBackground[] = {1,0,0,0.5};
				colorBackground2[] = {1,0.25,0.25,0.4};
				colorBackgroundFocused[] = {1,0,0,0.2};

				animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
				animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
				animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";
			
			size = QUOTE(0.75 * TextSize);
			text = "$STR_disp_Back";

			onButtonClick = QUOTE(call FUNC(Close));
			class Attributes: Attributes
			{
				align="center";
				size = TextMenu(1);
			};
		};

		class ATAK_MediaPlayers: cTab_RscControlsGroup
		{
			idc = 10;
			x = QUOTE(PhoneBFTContainerW(0.5));
			y = QUOTE(0.25 * ATAK_POS_H);
			w = QUOTE(phoneSizeW - PhoneBFTContainerW(2 * 0.5));
			h = QUOTE(phoneSizeH - ((2 * 0.25) * ATAK_POS_H) - (0.11 * (((60)) / 2048 * CustomPhoneH)) - (1.5 * 0.64 * ATAK_POS_H));
			class controls
			{
				class IMAGE: RscText //RscPictureKeepAspect // RscText
				{
					show = 0;
					x = 0;
					y = 0;
					w = QUOTE(phoneSizeW - PhoneBFTContainerW(2 * 0.5));
					h = QUOTE(phoneSizeH - ((2 * 0.25) * ATAK_POS_H) - (0.11 * (((60)) / 2048 * CustomPhoneH)) - (1.5 * 0.64 * ATAK_POS_H));

					//- This works, but the image cannot be loaded when "onLoad"
					//  even "PageLoaded" is triggered
					type = 106; // CT_WEBBROWSER
					url = "file://z/BCE/addons/cTab_ATAK_Slideshow/UI/imagePlayer.html"; // Reference to a file inside our mission
				};
				/* class VIDEO: RscVideoKeepAspect
				{
					x = 0;
					y = 0;
					w = QUOTE(phoneSizeW - PhoneBFTContainerW(2 * 0.5));
					h = QUOTE(phoneSizeH - ((2 * 0.25) * ATAK_POS_H) - (0.11 * (((60)) / 2048 * CustomPhoneH)) - (1.5 * 0.64 * ATAK_POS_H));
					colorBackground[] = {0,0,0,0.5};
				}; */
				class WEB_LINK: RscText
				{
					show = 0;
					type = 106; // CT_WEBBROWSER
					allowExternalURL = 1; // This makes it require manual approval by user
					colorBackground[] = {0,0,0,0.5};

					x = 0;
					y = 0;
					w = QUOTE(phoneSizeW - PhoneBFTContainerW(2 * 0.5));
					h = QUOTE(phoneSizeH - ((2 * 0.25) * ATAK_POS_H) - (0.11 * (((60)) / 2048 * CustomPhoneH)) - (1.5 * 0.64 * ATAK_POS_H));
					
					//- Was working on embed-ed Youtube video (always Error 153)
					// url = "file://z/BCE/addons/cTab_ATAK_Slideshow/UI/webPlayer.html"; // Reference to a file inside our mission
				};
			};
		};
	};
};

