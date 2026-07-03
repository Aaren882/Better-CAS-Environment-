//- SafeZone for cTab
#ifndef sizeX
	#define sizeX ((((-(10) + ((257)) + ((1341))) - ((((1341)) - (10) * 8) / 7))) / 2048 * ((safezoneH * 1.2) * 3/4) + (safezoneX + (safezoneW - ((safezoneH * 1.2) * 3/4)) / 2 + (((safezoneH * 1.2) * 3/4) * 96.5 / 2048)))
	#define sizeY(SIZE) (((-(0) + (491) + (993)) - (10) - ((42) - (10)) * SIZE) / 2048 * (safezoneH * 1.2) + (safezoneY + (safezoneH - (safezoneH * 1.2)) / 2))
	#define sizeW (64 / 2048)
#endif
//- Tablet
//-Tablet POS
	// #NOTE - Configuration for old cTabs
	// #define TabletLX ((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3)) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))
	// #define TabletRX (((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))

	// #define TabletTY ((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) - ((491) + (42))) / 2048 * (safezoneH * 1.2))
	// #define TabletDY (((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))

	// #define TabletW ((((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048 * ((safezoneH * 1.2) * 3/4))
	// #define TabletH ((((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048 * (safezoneH * 1.2))

	//- Internal Frame
#ifndef MainFrameX
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
#endif

//- TAD
#ifdef IS_DIALOG
	#define TAD_CLASS class cTab_TAD_dlg
	#define TAD_SizeH (safezoneH * 0.8)
	#define TAD_SizeW (TAD_SizeH * 3/4)
	#define TAD_SizeX 2048  * (TAD_SizeH * 3/4) + (safezoneX + (safezoneW - TAD_SizeH * 3/4) / 2)
	#define TAD_SizeY 2048  * TAD_SizeH + (safezoneY + safezoneH * 0.1)
#else
	#define TAD_CLASS class cTab_TAD_dsp
	#define TAD_SizeH (0.86)
	#define TAD_SizeW (TAD_SizeH * 3/4)
	#define TAD_SizeX 2048 * (TAD_SizeH * 3/4) + (safeZoneX + (0.05) * 3/4)
	#define TAD_SizeY 2048 * TAD_SizeH + (safeZoneY + safeZoneH - TAD_SizeH - (0.2))
#endif

//- Phone
#ifdef IS_DIALOG
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
#else
	//- Android Display
	#define PHONE_CLASS class cTab_Android_dsp
	
	#define PhoneH (safezoneH * 0.8)
	#define PhoneW (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_W',(safezoneW * 0.443437)])
	
	//-Custom Layout
	#define CustomPhoneH (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_H',(PhoneW * 4/3)])
	#define CustomPhoneX (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_X',(safezoneX - PhoneW * 0.17)])
	#define CustomPhoneY (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_Y',(safezoneY + safezoneH * 0.88 - CustomPhoneH * 0.72)])

	#define TextSize (((38)) / 2048 * CustomPhoneH)
	#define TextTimes 2.537
	#define TextTimesH (((safezoneW * 0.8) * 4/3) / CustomPhoneH)
	#define TextMenu(MULTI) __EVAL(1.1*MULTI)
	
	#define phoneSizeX (((452)) / 2048 * PhoneW + CustomPhoneX)
	#define phoneSizeY ((((713) + (60))) / 2048 * CustomPhoneH + CustomPhoneY)
	#define phoneSizeW ((((PHONE_MOD))) / 2048 * PhoneW)
	#define phoneSizeH ((((626) - (60) - (0))) / 2048 * CustomPhoneH)
#endif

#ifndef ATAK_POS
	#define ATAK_POS_H (((60)) / 2048 * CustomPhoneH)
	#define ATAK_POS_W ((phoneSizeW * 2/5)/3)
	#define PhoneBFTContainerW(AxisX) AxisX * ATAK_POS_W

	#define ATAK_POS(XPOS,YPOS,WPOS,HPOS) \
		x = QUOTE(PhoneBFTContainerW(XPOS)); \
		y = QUOTE(YPOS * ATAK_POS_H); \
		w = QUOTE(PhoneBFTContainerW(WPOS)); \
		h = QUOTE(HPOS * ATAK_POS_H)
#endif