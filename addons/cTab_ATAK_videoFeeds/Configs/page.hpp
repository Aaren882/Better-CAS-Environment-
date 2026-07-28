class ATAK_AppMenu_Base;

//- Video Feeds Interface
class ATAK_Video: ATAK_AppMenu_Base
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
			colorBackgroundFocused[] = {0,0,0,0.5};

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
		//- Sel Other Camera (Helmet, TGP etc)
		class CamSelBox: cTab_RscControlsGroup
		{
			idc = 10;
			//- Scroll
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
			h = 0;

			class controls
			{
				class Type: RscToolbox
				{
					idc = 6;
					
					x = QUOTE(PhoneBFTContainerW(0.05));
					y = QUOTE(EMPT_SPAC);
					w = QUOTE(PhoneBFTContainerW(2.9));
					h = QUOTE(((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC);

					rows = 1;
					columns = 2;
					strings[] =
					{
						"$STR_BCE_AC_CAM",
						"$STR_BCE_Helmet_CAM"
					};
					font = "RobotoCondensed_BCE";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = QUOTE(0.8 * TextSize);
				};
				class List: RscListBox
				{
					idc = 7;
					colorBackground[]={0,0,0,0.8};
					sizeEx = QUOTE(TextSize);

					x = 0;
					y = QUOTE(((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 + EMPT_SPAC);
					w = QUOTE(PhoneBFTContainerW(3));
					h = QUOTE(phoneSizeH - (0.75 + 0.8) * ATAK_POS_H - ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2);
				};
			};
		};
		class ViewBox: CamSelBox
		{
			idc = 20;
			h = QUOTE(phoneSizeH - (0.75 + 0.8) * ATAK_POS_H);
			class controls
			{
				// - Turret Infos + Optional Controls
					class Track_TG: Title
					{
						idc = 11;
						text = "$STR_BCE_TRACK_TG";
						
						colorBackground[] = {0,0,0.5,0.3};
						colorBackground2[] = {0,0,0.5,0.3};
						colorBackgroundFocused[] = {0,0,0,0.3};

						size = QUOTE(0.8 * TextSize);

						x = QUOTE(PhoneBFTContainerW(0.05));
						y = QUOTE(EMPT_SPAC);
						w = QUOTE(PhoneBFTContainerW(1.45));
						h = QUOTE(((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC);

						onButtonClick = "[_this#0,0] call BCE_fnc_ATAK_Camera_Controls";
					};
					class TG_INFO: RscText
					{
						idc = 12;

						style = 2;
						text = "";
						sizeEx = QUOTE(0.8 * TextSize);
						colorBackground[]={0,0,0,0.2};

						x = QUOTE(PhoneBFTContainerW(0.05));
						y = QUOTE(EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2);
						w = QUOTE(PhoneBFTContainerW(1.45));
						h = QUOTE(((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC);
					};
					class Vision: Track_TG
					{
						idc = 13;
						text = "";
						
						x = QUOTE(PhoneBFTContainerW(1.55));
						onButtonClick = "[_this#0,1] call BCE_fnc_ATAK_Camera_Controls";
					};
					class Sync_Camera: Vision
					{
						idc = 14;
						text = "$STR_BCE_Sync_Zoom";
						
						y = QUOTE(EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2);
						onButtonClick = "[_this#0,2] call BCE_fnc_ATAK_Camera_Controls";
					};
				// - Next Turret
					class TurretTxt: ctrlButton
					{
						idc = 46320;
						text = "";
						colorBackground[] = {0.25,0.25,0.25,0.8};
						colorBackgroundActive[] = {0.25,0.25,0.25,0.4};
						colorBackgroundDisabled[] = {0.25,0.25,0.25,0.8};
						colorDisabled[] = {1,1,1,1};

						x = 0;
						y = QUOTE(EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * ATAK_POS_H) - (0.85 * TextSize));
						w = QUOTE(PhoneBFTContainerW(3));
						h = QUOTE(0.85 * TextSize);
						sizeEx = QUOTE(0.75 * TextSize);

						font = "RobotoCondensed_BCE";
						colorShadow[] = {0,0,0,0.2};

						offsetPressedX = 0;
						offsetPressedY = 0;
						
						onButtonClick = "[_this # 0,17000] call BCE_fnc_NextTurretButton;";
					};
				// - Video Layer
					class Vic_PIP_Display: RscPicture
					{
						idc = 4632;
						text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
						x = 0;
						y = QUOTE(EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH)));
						w = QUOTE(PhoneBFTContainerW(3));
						h = QUOTE(phoneSizeH - EMPT_SPAC - 0.75 * ATAK_POS_H - (phoneSizeW * 3/5)/3);
					};
					class Vic_PIP_No_Signal: TurretTxt
					{
						idc = 46310;

						x = 0;
						y = QUOTE(EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH)));
						w = QUOTE(PhoneBFTContainerW(3));
						h = QUOTE(phoneSizeH - EMPT_SPAC - 0.75 * ATAK_POS_H - (phoneSizeW * 3/5)/3);
						
						style = 2;
						text = "$STR_BCE_No_Signal";
						colorBackground[]={0,0,0,0.4};
						colorBackgroundActive[] = {0,0,0,0.2};
						colorBackgroundDisabled[] = {0,0,0,0.4};
						colorDisabled[] = {1,1,1,0.25};

						onButtonClick = "";
						action = "call cTab_Tablet_btnACT";
					};
			};
		};
	};
};
