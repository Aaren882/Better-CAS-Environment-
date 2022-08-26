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
			y = "0.558 * safezoneH + safezoneY";
			h = "0.3 * safezoneH";
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
			y = "0.695 * safezoneH + safezoneY";
			w = "13.2 * (safezoneW / 64)";
			h = "1 * (safezoneH / 40)";
			class Attributes
			{
				font = "RobotoCondensed";
				color = "#E5E5E5";
				align = "center";
				shadow = "true";
			};
		};
		
		//Details (interval 0.025)
		class AVT_Text_FUEL;
		class AVT_Value_Fuel;
		class TGP_Text_Driver: AVT_Text_FUEL
		{
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
			y = "0.66 * safezoneH + safezoneY";
			text = "$STR_GUNNER";
		};
		class TGP_Value_Gunner: AVT_Value_Fuel
		{
			idc = 1502;
			y = "0.66 * safezoneH + safezoneY";
			text = "-";
		};
		
		
		class TGP_Text_FUEL: AVT_Text_FUEL
		{
			y = "0.73 * safezoneH + safezoneY";
		};
		class TGP_Value_Fuel: AVT_Value_Fuel
		{
			idc = 1503;
			y = "0.73 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_POS;
		class AVT_Value_Position;
		class TGP_Text_POS: AVT_Text_POS
		{
			y = "0.755 * safezoneH + safezoneY";
		};
		class TGP_Value_Position: AVT_Value_Position
		{
			idc = 1504;
			y = "0.755 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_AZT;
		class CA_Heading;
		class TGP_Text_AZT: AVT_Text_AZT
		{
			y = "0.78 * safezoneH + safezoneY";
		};
		class TGP_Heading: CA_Heading
		{
			idc = 1505;
			y = "0.78 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_SPD;
		class CA_Speed;
		class TGP_Text_SPD: AVT_Text_SPD
		{
			y = "0.805 * safezoneH + safezoneY";
		};
		class TGP_Speed: CA_Speed
		{
			idc = 1506;
			y = "0.805 * safezoneH + safezoneY";
			text = "-";
		};
		
		class AVT_Text_ALT;
		class CA_Alt;
		class TGP_Text_ALT: AVT_Text_ALT
		{
			y = "0.83 * safezoneH + safezoneY";
		};
		class TGP_Alt: CA_Alt
		{
			idc = 1507;
			y = "0.83 * safezoneH + safezoneY";
			text = "-";
		};
	};
};