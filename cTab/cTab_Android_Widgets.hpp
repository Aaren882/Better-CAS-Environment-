class cTab_RscText_Android: cTab_RscText
{
	sizeEx = ((38)) / 2048 * CustomPhoneH;
	
	w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
	h = (((60) - (20))) / 2048 * CustomPhoneH;
};

/* 
  MAP_MODE is used to determine the map control type.
  - 0: Default
  - 1: Map DarkMode
  - 2: Enhanced Map
  - 3: Enhanced GPS
*/
#if MAP_MODE > 0
	class cTab_android_RscMapControl: cTab_RscMapControl
	{
		x = (((452))) / 2048  * 	PhoneW + 	CustomPhoneX;
		y = (((713) + (60))) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
		w = (((PHONE_MOD))) / 2048  * 	PhoneW;
		h = (((626) - (60) - (0))) / 2048  * 	CustomPhoneH;
	};
#else
	class cTab_android_RscMapControl: cTab_RscMapControl
	{
		x = (((452))) / 2048  * 	PhoneW + 	CustomPhoneX;
		y = (((713) + (60))) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
		w = (((PHONE_MOD))) / 2048  * 	PhoneW;
		h = (((626) - (60) - (0))) / 2048  * 	CustomPhoneH;
	};
#endif