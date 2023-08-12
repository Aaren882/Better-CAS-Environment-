PHONE_CLASS
{
	class controlsBackground
	{
		class screen: cTab_android_RscMapControl
		{
			onMouseButtonClick = MOUSE_CLICK_EH;
		};
		#if MAP_MODE > 2
			class screenTopo: screen
			{
				#include "..\Map_Type\TOPO_GRD.hpp"
			};
		#endif
		class AVmainFrame: cTab_RscFrame
		{
			idc = idc_D(4630);
			text = "AV Live Feed";
			x = phoneSizeX + (((((452) + (20))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((713) + (60) + (10))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
			w = (((PHONE_MOD) - (20) * 2)) / 2048 * PhoneW;
			h = (((626) - (60) - (10) * 2)) / 2048 * (PhoneW * 4/3);
		};
		class AVCamFrame: cTab_RscFrame
		{
			idc = idc_D(4631);
			x = phoneSizeX + (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * (PhoneW * 4/3);
		};
		class Vic_PIP_Display: RscPicture
		{
			idc = idc_D(4632);
			text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
			
			x = phoneSizeX + (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * (PhoneW * 4/3);
		};
	};
	class controls
	{
		//-App Menu
		class Desktop: cTab_RscControlsGroup
		{
			idc = 4610;
			x = phoneSizeX;
			y = phoneSizeY;
			w = phoneSizeW;
			h = phoneSizeH;
			class controls
			{
				class actBFTtxt: ctrlButton
				{
					idc = 1001;
					style = "0x02 + 0x30 + 0x800";
					text = APP_BFT;
					
					x = (((((257)) + (25)) - ((257))) / 2048 * (PhoneH * 3/4));
					y = (((((491) + (42)) + (25)) - ((491) + (42))) / 2048 * PhoneH);
					w = ((100)) / 2048 * (PhoneH * 3/4);
					h = ((100)) / 2048 * PhoneH;
					
					colorBackground[] = {0,0,0,0};
					
					action = "['cTab_Android_dlg',[['mode','BFT']]] call cTab_fnc_setSettings;";
					toolTip = "FBCB2 - Blue Force Tracker";
				};
				class actUAVtxt: actBFTtxt
				{
					idc = 1002;
					y = (((((491) + (42)) + (25) * 2 + (100)) - ((491) + (42))) / 2048 * PhoneH);
					text = APP_UAV;
					action = "['cTab_Android_dlg',[['mode','UAV']]] call cTab_fnc_setSettings;";
					toolTip = "Air Vic Video Feeds";
				};
				class actMSGtxt: actBFTtxt
				{
					idc = 1004;
					text = APP_MSG;
					y = (((((491) + (42)) + (25) * 3 + (100) * 2) - ((491) + (42))) / 2048 * PhoneH);
					action = "['cTab_Android_dlg',[['mode','MESSAGE']]] call cTab_fnc_setSettings;";
					toolTip = "Text Messaging System";
				};
			};
		};
		
		//-AV Feeds
		class Aircraft: Desktop
		{
			idc = 4630;
			class controls
			{
				class TurretTxt: cTab_RscText_Android
				{
					idc = idc_D(46320);
					text = "--";
					colorBackground[] = {0.25,0.25,0.25,0.5};
					
					x = (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
					y = (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
					h = ((30)) / 2048 * (PhoneW * 4/3);
					sizeEx = TextSize;
				};
				class cTabAVlist: cTab_RscListbox_Tablet
				{
					idc = 1776;
					style = 64;
					sizeEx = TextSize;
					
					colorSelect[] = {0,1,0,1};
					colorSelect2[] = {0,1,0,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					
					x = ((((((452) + (20)) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * (PhoneW * 4/3);
					
					onLBSelChanged = "if (_this # 1 != -1) then {['cTab_Android_dlg',[['uavCam',(_this # 0) lbData (_this # 1)]]] call cTab_fnc_setSettings;};";
				};
				class cTabAVInfolist: cTab_RscListbox_Tablet
				{
					idc = 1775;
					text = "";
					font = "RobotoCondensed";
					sizeEx = TextSize;
					
					style = 64;
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					soundSelect[] = {"",0,1};
					
					x = ((((((452) + (20)) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * (PhoneW * 4/3);
				};
				
				class Info_Vic: cTab_RscButton
				{
					idc = idc_D(16120);
					text = "Switch List";
					sizeEx = TextSize;
					
					offsetX = 0;
					offsetY = 0;
					offsetPressedX = "pixelW";
					offsetPressedY = "pixelH";
					
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (0.75 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "['cTab_Android_dlg'] call cTab_fnc_AVInfoMenu_toggle;";
				};
				class SwitchTurret: Info_Vic
				{
					idc = idc_D(16121);
					
					colorBackground[] = {0.3,0.3,0.3,1};
					colorBackgroundActive[] = {0.3,0.3,0.3,1};
					colorFocused[] = {0.3,0.3,0.3,1};
					colorShadow[] = {0.15,0.15,0.15,1};
					colorBorder[] = {0,0,0,0};
					
					text = ">>";
					tooltip = "Next Turret";
					sizeEx = TextSize;
					
					action = "";
					onButtonClick = "(_this + [17000,true]) call BCE_fnc_NextTurretButton;";
					
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW) + (0.75 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
					w = (0.25 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
				};
				class Connect_Vic: cTab_RscButton
				{
					idc = idc_D(17);
					text = "Live Feed";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "call cTab_Tablet_btnACT;";
				};
			};
		};
		
		//-SubMenu + lerGTD SubMenu + BCE Submenu
		cTab_Set_SubMenu(SubMenuH_P);
		
		class btnHome: cTab_android_btnHome
		{
			action = "['cTab_Android_dlg',[['mode','DESKTOP']]] call cTab_fnc_setSettings;";
			tooltip = "Desktop";
		};
		
		//-Message
		class MESSAGE: cTab_RscControlsGroup
		{
			idc = 4650;
			x = phoneSizeX;
			y = phoneSizeY;
			w = phoneSizeW;
			h = phoneSizeH;
			class VScrollbar{};
			class HScrollbar{};
			class Scrollbar{};
			class controls
			{
				class msgListbox: cTab_RscListBox
				{
					idc = 15000;
					style = 32;
					sizeEx = TextSize;
					x = ((((((452) + (20)) + (10))) - ((452))) / 2048  * 	PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048  * 	PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * (PhoneW * 4/3);
					onLBSelChanged = "_this call cTab_msg_get_mailTxt;";
				};
				class msgframe: cTab_RscFrame
				{
					idc = 16;
					text = "Read Message";
					x = (((((452) + (20))) - ((452))) / 2048  * 	PhoneW);
					y = (((((713) + (60) + (10))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = (((PHONE_MOD) - (20) * 2)) / 2048  * 	PhoneW;
					h = (((626) - (60) - (10) * 2)) / 2048  * 	(	PhoneW * 4/3);
				};
				class msgTxt: cTab_RscEdit
				{
					idc = 18510;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "No Message Selected";
					sizeEx = TextSize;
					x = (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048  * 	PhoneW);
					y = (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048  * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * (PhoneW * 4/3);
					canModify = 0;
				};
				class deletebtn: cTab_RscButton
				{
					idc = 16120;
					text = "Delete";
					tooltip = "Delete Selected Message(s)";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "['cTab_Android_dlg'] call cTab_fnc_onMsgBtnDelete;";
				};
				class toCompose: cTab_RscButton
				{
					idc = 17;
					text = "Compose >>";
					tooltip = "Compose Messages";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048  * 	PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048  * 	PhoneW;
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "['cTab_Android_dlg',[['mode','COMPOSE']]] call cTab_fnc_setSettings;";
				};
			};
		};
		class COMPOSE: cTab_RscControlsGroup
		{
			idc = 4655;
			x = phoneSizeX;
			y = phoneSizeY;
			w = phoneSizeW;
			h = phoneSizeH;
			class VScrollbar{};
			class HScrollbar{};
			class Scrollbar{};
			class controls
			{
				class composeFrame: cTab_RscFrame
				{
					idc = 18;
					text = "Compose Message";
					x = ((((((452) + (20)))) - ((452))) / 2048  * 	PhoneW);
					y = ((((((713) + (60) + (10)))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((PHONE_MOD) - (20) * 2))) / 2048  * 	PhoneW;
					h = ((((626) - (60) - (10) * 2))) / 2048  * 	(	PhoneW * 4/3);
				};
				class playerlistbox: cTab_RscListBox
				{
					idc = 15010;
					style = 32;
					sizeEx = TextSize;
					x = (((((((452) + (20)) + (10)))) - ((452))) / 2048  * 	PhoneW);
					y = (((((((713) + (60) + (10))) + (20))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048  * 	PhoneW;
					h = (((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2))) / 2048  * 	(	PhoneW * 4/3);
				};
				class sendbtn: cTab_RscButton
				{
					idc = 16130;
					text = "Send";
					sizeEx = TextSize;
					x = (((((((452) + (20))) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "call cTab_msg_Send;";
				};
				class edittxtbox: cTab_RscEdit
				{
					idc = 14000;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "";
					sizeEx = TextSize;
					x = ((((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10)))) - ((452))) / 2048  * 	PhoneW);
					y = ((((((((713) + (60) + (10))) + (20)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2))) / 2048 * PhoneW;
					h = (((((626) - (60) - (10) * 2) - (20) -(10)))) / 2048 * (PhoneW * 4/3);
				};
				class toRead: cTab_RscButton
				{
					idc = 19;
					text = "Read >>";
					tooltip = "Read Messages";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048  * 	(	PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "['cTab_Android_dlg',[['mode','MESSAGE']]] call cTab_fnc_setSettings;";
				};
			};
		};
	};
};