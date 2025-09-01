//- Tablet
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

//- TAD
	#define TAD_SizeH (safezoneH * 0.8)
	#define TAD_SizeW (TAD_SizeH * 3/4)
	#define TAD_SizeX 2048  * (TAD_SizeH * 3/4) + (safezoneX + (safezoneW - TAD_SizeH * 3/4) / 2)
	#define TAD_SizeY 2048  * TAD_SizeH + (safezoneY + safezoneH * 0.1)

	#define TAD_CLASS class cTab_TAD_dlg

//- Phone
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