class cTab_RscText_Android: cTab_RscText
{
  sizeEx = ((38)) / 2048 * CustomPhoneH;
  
  w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
  h = (((60) - (20))) / 2048 * CustomPhoneH;
};
class cTab_android_background: cTab_RscPicture
{
	x = CustomPhoneX;
	y = CustomPhoneY;
	w = PhoneW;
	h = CustomPhoneH;
};
class cTab_android_btnBack: cTab_RscButtonInv
{
	x = (1609) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (806) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = (102) / 2048  * 	PhoneW;
	h = (102) / 2048  * 	CustomPhoneH;
};
class cTab_android_btnHome: cTab_android_btnBack
{
	x = (1613) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (972) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
};
class cTab_android_btnPower: cTab_RscButtonInv
{
	x = (1583) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (1407) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = (107) / 2048  * 	PhoneW;
	h = (48) / 2048  * 	CustomPhoneH;
};
class cTab_android_notificationLight
{
	x = (1793) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (768) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = (61) / 2048  * 	PhoneW;
	h = (61) / 2048  * 	CustomPhoneH;
};
class cTab_android_header: cTab_RscPicture
{
	x = ((452)) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = ((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = ((PHONE_MOD)) / 2048  * 	PhoneW;
	h = ((60)) / 2048  * 	CustomPhoneH;
};
class cTab_android_on_screen_battery: cTab_RscPicture
{
	x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (1 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = ((713) + ((60) - (42)) / 2) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = ((42)) / 2048  * 	PhoneW;
	h = ((42)) / 2048  * 	CustomPhoneH;
};

class cTab_android_on_screen_time: cTab_RscText_Android
{
	x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (3 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = ((713) + ((60) - (38)) / 2) / 2048  * CustomPhoneH + CustomPhoneY;
};
class cTab_android_on_screen_signalStrength: cTab_android_on_screen_battery
{
	x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (5 - 1)) + (((PHONE_MOD) - (20) * 6) / 5) - (42) * 2) / 2048  * 	PhoneW + 	CustomPhoneX;
};
class cTab_android_on_screen_satellite: cTab_android_on_screen_battery
{
	x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (5 - 1)) + (((PHONE_MOD) - (20) * 6) / 5) - (42)) / 2048  * 	PhoneW + 	CustomPhoneX;
};

class cTab_android_on_screen_dirDegree: cTab_android_on_screen_time
{
	style = 0;
	x = (((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (0.35))) / 2048 * PhoneW + CustomPhoneX) + (((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW);
};
class cTab_android_on_screen_grid: cTab_android_on_screen_dirDegree
{
	style = 0;
	x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (4 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX;
};

class cTab_android_loadingtxt: cTab_RscText_Android
{
	x = (((452))) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (((713) + (60))) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = (((PHONE_MOD))) / 2048  * 	PhoneW;
	h = (((626) - (60) - (0))) / 2048  * 	CustomPhoneH;
};
class cTab_android_windowsBG: cTab_RscPicture
{
	x = ((452)) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = ((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = ((PHONE_MOD)) / 2048  * 	PhoneW;
	h = ((626)) / 2048  * 	CustomPhoneH;
};
class cTab_android_movingHandle_T: cTab_RscText_Android
{
	x = (0) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (0) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = (2048 ) / 2048  * 	PhoneW;
	h = ((713)) / 2048  * 	CustomPhoneH;
};

class cTab_android_movingHandle_L;
class cTab_android_movingHandle_R: cTab_android_movingHandle_L
{
	x = ((452) + (PHONE_MOD)) / 2048  * 	PhoneW + 	CustomPhoneX;
	w = (2048  - ((452) + (PHONE_MOD))) / 2048  * 	PhoneW;
};
class cTab_android_brightness: cTab_RscText_Android
{
	x = ((452)) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = ((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = ((PHONE_MOD)) / 2048  * 	PhoneW;
	h = ((626)) / 2048  * 	CustomPhoneH;
};
class cTab_android_notification: cTab_RscText_Android
{
	x = (((452)) + (((PHONE_MOD)) * 0.2) / 2) / 2048  * 	PhoneW + 	CustomPhoneX;
	y = (((713) + (60)) + ((626) - (60) - (0)) - 2 * (38)) / 2048  * 	CustomPhoneH + 	CustomPhoneY;
	w = (((PHONE_MOD)) * 0.8) / 2048  * 	PhoneW;
};