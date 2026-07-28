class cTab_RscText_Android: cTab_RscText
{
  sizeEx = QUOTE(((38)) / 2048 * CustomPhoneH);
  
  w = QUOTE(((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW);
  h = QUOTE((((60) - (20))) / 2048 * CustomPhoneH);
};
class cTab_android_background: cTab_RscPicture
{
	x = QUOTE(CustomPhoneX);
	y = QUOTE(CustomPhoneY);
	w = QUOTE(PhoneW);
	h = QUOTE(CustomPhoneH);
};
class cTab_android_btnBack: cTab_RscButtonInv
{
	x = QUOTE((1609) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((806) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE((102) / 2048  * 	PhoneW);
	h = QUOTE((102) / 2048  * 	CustomPhoneH);
};
class cTab_android_btnHome: cTab_android_btnBack
{
	x = QUOTE((1613) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((972) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
};
class cTab_android_btnPower: cTab_RscButtonInv
{
	x = QUOTE((1583) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((1407) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE((107) / 2048  * 	PhoneW);
	h = QUOTE((48) / 2048  * 	CustomPhoneH);
};
class cTab_android_notificationLight
{
	x = QUOTE((1793) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((768) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE((61) / 2048  * 	PhoneW);
	h = QUOTE((61) / 2048  * 	CustomPhoneH);
};
class cTab_android_header: cTab_RscPicture
{
	x = QUOTE(((452)) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE(((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE(((PHONE_MOD)) / 2048  * 	PhoneW);
	h = QUOTE(((60)) / 2048  * 	CustomPhoneH);
};
class cTab_android_on_screen_battery: cTab_RscPicture
{
	x = QUOTE(((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (1 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE(((713) + ((60) - (42)) / 2) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE(((42)) / 2048  * 	PhoneW);
	h = QUOTE(((42)) / 2048  * 	CustomPhoneH);
};

class cTab_android_on_screen_time: cTab_RscText_Android
{
	x = QUOTE(((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (3 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE(((713) + ((60) - (38)) / 2) / 2048  * CustomPhoneH + CustomPhoneY);
};
class cTab_android_on_screen_signalStrength: cTab_android_on_screen_battery
{
	x = QUOTE(((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (5 - 1)) + (((PHONE_MOD) - (20) * 6) / 5) - (42) * 2) / 2048  * 	PhoneW + 	CustomPhoneX);
};
class cTab_android_on_screen_satellite: cTab_android_on_screen_battery
{
	x = QUOTE(((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (5 - 1)) + (((PHONE_MOD) - (20) * 6) / 5) - (42)) / 2048  * 	PhoneW + 	CustomPhoneX);
};

class cTab_android_on_screen_dirDegree: cTab_android_on_screen_time
{
	style = 0;
	x = QUOTE((((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (0.35))) / 2048 * PhoneW + CustomPhoneX) + (((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW));
};
class cTab_android_on_screen_grid: cTab_android_on_screen_dirDegree
{
	style = 0;
	x = QUOTE(((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (4 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX);
};

class cTab_android_loadingtxt: cTab_RscText_Android
{
	x = QUOTE((((452))) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((((713) + (60))) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE((((PHONE_MOD))) / 2048  * 	PhoneW);
	h = QUOTE((((626) - (60) - (0))) / 2048  * 	CustomPhoneH);
};
class cTab_android_windowsBG: cTab_RscPicture
{
	x = QUOTE(((452)) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE(((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE(((PHONE_MOD)) / 2048  * 	PhoneW);
	h = QUOTE(((626)) / 2048  * 	CustomPhoneH);
};
class cTab_android_movingHandle_T: cTab_RscText_Android
{
	x = QUOTE((0) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((0) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE((2048 ) / 2048  * 	PhoneW);
	h = QUOTE(((713)) / 2048  * 	CustomPhoneH);
};

class cTab_android_movingHandle_L;
class cTab_android_movingHandle_R: cTab_android_movingHandle_L
{
	x = QUOTE(((452) + (PHONE_MOD)) / 2048  * 	PhoneW + 	CustomPhoneX);
	w = QUOTE((2048  - ((452) + (PHONE_MOD))) / 2048  * 	PhoneW);
};
class cTab_android_brightness: cTab_RscText_Android
{
	x = QUOTE(((452)) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE(((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE(((PHONE_MOD)) / 2048  * 	PhoneW);
	h = QUOTE(((626)) / 2048  * 	CustomPhoneH);
};
class cTab_android_notification: cTab_RscText_Android
{
	x = QUOTE((((452)) + (((PHONE_MOD)) * 0.2) / 2) / 2048  * 	PhoneW + 	CustomPhoneX);
	y = QUOTE((((713) + (60)) + ((626) - (60) - (0)) - 2 * (38)) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
	w = QUOTE((((PHONE_MOD)) * 0.8) / 2048  * 	PhoneW);
};