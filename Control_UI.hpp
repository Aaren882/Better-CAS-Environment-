class RscControlsGroup;
class RscAttributeCAS;
class RscButtonMenu;
class RscDisplayAttributes
{
	class Controls
	{
		class Content: RscControlsGroup
		{
			class controls;
		};
	};
};
class RscDisplayAttributesModuleCAS: RscDisplayAttributes
{
	class Controls: Controls
	{
		class Background;
		class Title;
		class Content;
		class ButtonOK;
		class ButtonCancel;
	};
};

//Select Aircraft
class RscDisplay_TGP_Control: RscAttributeCAS
{
	onSetFocus = "[_this,""TGP_Select"",'BCE_Function'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};
class RscDisplay_TGP_Control_UI: RscDisplayAttributesModuleCAS
{
	scriptName = "RscDisplay_TGP_Control_UI";
	scriptPath = "BCE_Function";
	onLoad = "[""onLoad"",_this,""RscDisplay_TGP_Control_UI"",'BCE_Function'] call (uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplay_TGP_Control_UI"",'BCE_Function'] call (uinamespace getvariable 'BIS_fnc_initDisplay')";
	class Controls: Controls
	{
		class Background: Background{};
		class Title: Title
		{
			text = "Select TGP View";
		};
		class Content: Content
		{
			class Controls
			{
				class TGP_Select: RscDisplay_TGP_Control{};
			};
		};
		class ButtonOK: ButtonOK{};
		class ButtonCancel: ButtonCancel{};
	};
};
class RscDisplayAVTerminal
{
	scriptPath = "BCE_Function";
	onLoad = "[""onLoad"",_this,""RscDisplayAVTerminal"",'BCE_Function'] call (uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAVTerminal"",'BCE_Function'] call (uinamespace getvariable 'BIS_fnc_initDisplay')";
	class controls
	{
		class AVT_Info_Back;
		class TGP_Info_Back: AVT_Info_Back
		{
			idc = 1517;
			y = "0.558 * safezoneH + safezoneY";
			h = "0.325 * safezoneH";
		};
		class AVT_Text_SelectAV;
		class TGP_Select_Text: AVT_Text_SelectAV
		{
			idc = 1500;
			text = "Select Vehicle TGP:";
			y = "0.568 * safezoneH + safezoneY";
		};
		class AVT_Combo_SelectAV;
		class TGP_Select_Combo: AVT_Combo_SelectAV
		{
			idc = 1700;
			sizeEx = "0.023*SafezoneH";
			y = "0.6 * safezoneH + safezoneY";
			tooltip = "TGP View";
			
			class Items
			{
				class Empty
				{
					text = "--";
					default = 1;
				};
			};
			class ShortcutPos
			{
				left = 0;
				top = 0;
				w = 0;
				h = 0;
			};
			class TextPos
			{
				left = 0.01;
				top = 0;
				right = 0;
				bottom = 0;
			};
		};
		
		//Connect
		class Connect_Button: RscButtonMenu
		{
			idc = 1600;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "Connect To Vehicle";
			x = "0.3 * (safezoneW / 64) + (safezoneX)";
			y = "0.71 * safezoneH + safezoneY";
			//y = "0.695 * safezoneH + safezoneY";
			w = "13.2 * (safezoneW / 64)";
			h = "0.8 * (safezoneH / 40)";
			class Attributes
			{
				font = "RobotoCondensed";
				color = "#E5E5E5";
				align = "center";
				shadow = "true";
			};
		};
		class Connect_Gunner_Button: Connect_Button
		{
			idc = 1601;
			text = "Control Turret";
			y = "0.685 * safezoneH + safezoneY";
		};
		class Next_Turret_Button: Connect_Button
		{
			idc = 1602;
			text = ">";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			X = "0.195372 * safezoneW + safezoneX";
			y = "0.66 * safezoneH + safezoneY";
			W = "0.015 * safezoneW";
			h = "0.9 * (safezoneH / 40)";
			colorBackground[] = {0.36,0.36,0.36,0.5};
			class Attributes: Attributes
			{
				font = "TahomaB";
				align = "center";
			};
		};
		
		//-Hide UI
		class BCE_info_hide: Next_Turret_Button
		{
			idc = 1604;
			text = "X";
			X = "0.2036 * safezoneW + safezoneX";
			y = "0.558 * safezoneH + safezoneY";
			onButtonClick = "_display = ctrlParent (_this#0); (_display displayCtrl 1605) ctrlShow true; {(_display displayCtrl _x) ctrlShow false;} forEach [1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1600,1601,1602,1603,1604,1606,1607,1608,1609,1700];";
			colorBackground[] = {1,0,0,0.5};
			colorBackgroundFocused[] = {1,0,0,0.8};
			animTextureFocused = "#(argb,8,8,3)color(1,0,0,0.8)";
			animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
			periodFocus = 0;
		};
		class BCE_info_show: BCE_info_hide
		{
			idc = 1605;
			text = ">";
			show = 0;
			x = "safezoneX";
			onButtonClick = "_display = ctrlParent (_this#0); (_this#0) ctrlShow false; {(_display displayCtrl _x) ctrlShow true;} forEach [1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1600,1601,1602,1603,1604,1606,1607,1608,1609,1700];";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",0.8};
			animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
			colorBackgroundFocused[] = {1,1,1,1};
		};
		
		//-Toggle Widgets
		class BCE_Waypoint_AV: Next_Turret_Button
		{
			idc = 1606;
			text = "WP";
			X = "0.17 * safezoneW + safezoneX";
			y = "0.755 * safezoneH + safezoneY";
			W = "0.0165 * safezoneW";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_WP',true]) then {(_this # 0) ctrlSetTextColor [1, 0, 0, 0.5]; uinamespace setVariable ['BCE_Terminal_WP',false];} else {uinamespace setVariable ['BCE_Terminal_WP',true]; (_this # 0) ctrlSetTextColor [1, 1, 1, 1];};";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			colorFocused[] = {1,1,1,0.5};
			animTexturePressed = "";
			periodFocus = 0;
			periodOver = 0;
			tooltip = "Waypoints of Selected Vehicle";
			class Attributes
			{
				font = "RobotoCondensedBold";
			};
		};
		class BCE_Vehicles_AV: BCE_Waypoint_AV
		{
			idc = 1607;
			X = "0.188 * safezoneW + safezoneX";
			text = "AV";
			tooltip = "Icon of Other Vehicles";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_Veh',true]) then {(_this # 0) ctrlSetTextColor [1, 0, 0, 0.5]; uinamespace setVariable ['BCE_Terminal_Veh',false];} else {uinamespace setVariable ['BCE_Terminal_Veh',true]; (_this # 0) ctrlSetTextColor [1, 1, 1, 1];};";
		};
		class BCE_Targeting_AV: BCE_Waypoint_AV
		{
			idc = 1608;
			y = "0.78 * safezoneH + safezoneY";
			text = "TG";
			tooltip = "POS of TGP Pointing";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_Targeting',true]) then {(_this # 0) ctrlSetTextColor [1, 0, 0, 0.5]; uinamespace setVariable ['BCE_Terminal_Targeting',false];} else {uinamespace setVariable ['BCE_Terminal_Targeting',true]; (_this # 0) ctrlSetTextColor [1, 1, 1, 1];};";
		};
		class BCE_SelColor_AV: BCE_Vehicles_AV
		{
			idc = 1609;
			y = "0.78 * safezoneH + safezoneY";
			text = "COR";
			color[] = {1, 1, 0.3, 0.8};
			tooltip = "Color of Selected Vehicle";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_SelColor',true]) then {(_this # 0) ctrlSetTextColor [0,1,0.3,0.8]; uinamespace setVariable ['BCE_Terminal_SelColor',false];} else {uinamespace setVariable ['BCE_Terminal_SelColor',true]; (_this # 0) ctrlSetTextColor [1,1,0.3,0.8];};";
		};
		
		//Details (interval 0.025)
		class AVT_Text_FUEL;
		class AVT_Value_Fuel;
		class TGP_Text_Driver: AVT_Text_FUEL
		{
			idc = 1516;
			y = "0.63 * safezoneH + safezoneY";
			text = "$STR_DRIVER";
		};
		class TGP_Value_Driver: AVT_Value_Fuel
		{
			idc = 1501;
			y = "0.63 * safezoneH + safezoneY";
			text = "-";
		};
		
		class TGP_Text_Gunner: AVT_Text_FUEL
		{
			idc = 1515;
			y = "0.66 * safezoneH + safezoneY";
			text = "$STR_GUNNER";
		};
		class TGP_Value_Gunner: AVT_Value_Fuel
		{
			idc = 1502;
			y = "0.66 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_WPN;
		class WeaponPrimary;
		class TGP_Text_WPN: AVT_Text_WPN
		{
			idc = 1514;
			y = "0.73 * safezoneH + safezoneY";
		};
		class TGP_Text_WeaponValue: WeaponPrimary
		{
			idc = 1503;
			text = "-";
			y = "0.73 * safezoneH + safezoneY";
		};
		
		class TGP_Text_FUEL: AVT_Text_FUEL
		{
			idc = 1513;
			y = "0.755 * safezoneH + safezoneY";
		};
		class TGP_Value_Fuel: AVT_Value_Fuel
		{
			idc = 1504;
			y = "0.755 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_POS;
		class AVT_Value_Position;
		class TGP_Text_POS: AVT_Text_POS
		{
			idc = 1512;
			y = "0.78 * safezoneH + safezoneY";
		};
		class TGP_Value_Position: AVT_Value_Position
		{
			idc = 1505;
			y = "0.78 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_AZT;
		class CA_Heading;
		class TGP_Text_AZT: AVT_Text_AZT
		{
			idc = 1511;
			y = "0.805 * safezoneH + safezoneY";
		};
		class TGP_Heading: CA_Heading
		{
			idc = 1506;
			y = "0.805 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_SPD;
		class CA_Speed;
		class TGP_Text_SPD: AVT_Text_SPD
		{
			idc = 1510;
			y = "0.83 * safezoneH + safezoneY";
		};
		class TGP_Speed: CA_Speed
		{
			idc = 1507;
			y = "0.83 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_ALT;
		class CA_Alt;
		class TGP_Text_ALT: AVT_Text_ALT
		{
			idc = 1509;
			y = "0.852 * safezoneH + safezoneY";
		};
		class TGP_Alt: CA_Alt
		{
			idc = 1508;
			y = "0.852 * safezoneH + safezoneY";
			text = "-";
		};
	};
};