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
class RscCustomInfoMiniMap
{
	class controls
	{
		class MiniMap: RscControlsGroupNoScrollbars
		{
			class Controls
			{
				class CA_MiniMap: RscMapControl
				{
					onDraw="call BCE_fnc_drawGPS";
				};
			};
		};
	};
};
class RscDisplayMainMap
{
	class controlsBackground
	{
		class CA_Map: RscMapControl
		{
			onDraw="call BCE_fnc_drawGPS";
		};
	};
	class controls
	{
		//- 0.018
		class BCE_FOV_toggle: BCE_RscButtonMenu
		{
			idc = 1606;
			style="0x02";
			text = "FOV";
			tooltip = "$STR_BCE_Toggle_FOV";
			font = "RobotoCondensed_BCE";
			x = MAP_TOGGLE_X(1,1);
			y = MAP_TOGGLE_Y(0,0);
			w = "2.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onButtonClick = "[_this # 0,0] call BCE_fnc_Update_MapCtrls";
			sizeEx="0.75 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			
			colorBackground[] = {0,0,0,1};
			colorBackground2[] = {0,0,0,1};
			animTexturePressed = "#(argb,8,8,3)color(0.36,0.36,0.36,0.5)";
			class Attributes: Attributes
			{
				align = "center";
				valign = "middle";
				shadow = "true";
				size = "0.7";
			};
		};
		class BCE_Task_toggle: BCE_FOV_toggle
		{
			idc = 1607;
			text = "$STR_BCE_CAS_Task";
			tooltip = "$STR_BCE_Toggle_Task";
			x = MAP_TOGGLE_X(2,1.5);
			onButtonClick = "[_this # 0,1] call BCE_fnc_Update_MapCtrls";
		};
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
			text = "$STR_BCE_Select_AV_Camera";
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
	Brevity_Code[] =
	{
		"$STR_BCE_BVTITLE_Weapon",
		{"Guns x3","$STR_BCE_BVT_Guns"},
		{"Rifle","$STR_BCE_BVT_Rifle"},
		{"Pickle","$STR_BCE_BVT_Pickle"},
		{"Paveway","$STR_BCE_BVT_Paveway"},
		{"Ripple","$STR_BCE_BVT_Ripple"},
		{"Winchester","$STR_BCE_BVT_Winchester"},
		{"Splash(ed)","$STR_BCE_BVT_Splash"},
		{"Shack","$STR_BCE_BVT_Shack"},
		"$STR_BCE_BVTITLE_Task",
		{"Playtime","$STR_BCE_BVT_Playtime"},
		{"Contact","$STR_BCE_BVT_Contact"},
		{"Visual","$STR_BCE_BVT_Visual"},
		{"Tally","$STR_BCE_BVT_Tally"},
		{"Clear(ed) Hot","$STR_BCE_BVT_ClearHot"},
		"-", //Next Page
		{"Abort","$STR_BCE_BVT_Abort"},
		{"What Luck","$STR_BCE_BVT_What_Luck"},
		{"IP Inbound","$STR_BCE_BVT_IP_Inbound"},
		{"Bingo","$STR_BCE_BVT_Bingo"},
		{"Continue","$STR_BCE_BVT_Continue"},
		"$STR_BCE_BVTITLE_Laser",
		{"Laser On","$STR_BCE_BVT_Laser_On"},
		{"Sparkle","$STR_BCE_BVT_Sparkle"},
		{"Lasing","$STR_BCE_BVT_Lasing"},
		{"Snake/Pulse","$STR_BCE_BVT_SnakePulse"},
		{"Steady","$STR_BCE_BVT_Steady"},
		{"Spot","$STR_BCE_BVT_Spot"},
		{"Rope","$STR_BCE_BVT_Rope"},
		"",
		"<a href='https://wiki.hoggitworld.com/view/Brevity_List'>Hoggitworld</a>",
		"<a href='https://en.wikipedia.org/wiki/Multiservice_tactical_brevity_code'>Wikipedia</a>"
	};

	class controlsBackground: BCE_Mission_Build_Controls
	{
		class BCE_Holder: BCE_Holder
		{
      class BCE_Mission: BCE_Mission
			{
				class AIR: AIR
				{
					9Line = "AIR_9_LINE_OLD";
					5Line = "AIR_5_LINE_OLD";
				};
			};
		};
		class CA_Map: RscMapControl
		{
			idcMarkerColor = 1090;
			idcMarkerIcon = 1091;
			onMouseButtonUp = "call BCE_fnc_GetMapClickPOS";
			onDraw = "call BCE_fnc_TAC_Map";
		};
	};
	class controls: BCE_Mission_Build_Controls
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
			text = "$STR_BCE_Live_Feed";
			x = "0.3 * (safezoneW / 64) + (safezoneX)";
			y = "0.71 * safezoneH + safezoneY";
			w = "13.2 * (safezoneW / 64)";
			h = "0.8 * (safezoneH / 40)";

			class TextPos
			{
				left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
				top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
				right = 0.005;
				bottom = 0.0;
			};
			class Attributes
			{
				font = "RobotoCondensed_BCE";
				color = "#E5E5E5";
				align = "center";
				shadow = "true";
			};
		};
		class Connect_Gunner_Button: Connect_Button
		{
			idc = 1601;
			text = "$STR_BCE_Control_Turret";
			y = "0.685 * safezoneH + safezoneY";
		};
		class Next_Turret_Button: Connect_Button
		{
			idc = 1602;
			text = ">";
			style = 2;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			X = "0.195372 * safezoneW + safezoneX";
			y = "0.66 * safezoneH + safezoneY";
			W = "0.015 * safezoneW";
			h = "0.9 * (safezoneH / 40)";
			tooltip = "$STR_BCE_NextTurret";
			onButtonClick = "call BCE_fnc_NextTurretButton";
			class Attributes: Attributes
			{
				font = "TahomaB";
			};
		};

		//-Hide UI
		class BCE_info_hide: BCE_RscButtonMenu
		{
			idc = 1604;
			text = "X";
			X = "0.2036 * safezoneW + safezoneX";
			y = "0.558 * safezoneH + safezoneY";
			W = "0.015 * safezoneW";
			h = "0.9 * (safezoneH / 40)";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onButtonClick = "_display = ctrlParent (_this#0); (_display displayCtrl 1605) ctrlShow true; {(_display displayCtrl _x) ctrlShow false;} forEach [1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1600,1601,1602,1603,1604,1606,1607,1608,1609,1610,1700];";

			colorBackground[] = {1,0,0,0.5};
			colorBackground2[] = {1,0,0,0.5};

			colorBackgroundFocused[] = {1,0,0,0.5};

			animTextureOver = "#(argb,8,8,3)color(1,0.25,0.25,0.5)";
			animTextureFocused = "#(argb,8,8,3)color(1,0,0,1)";
			animTexturePressed = "#(argb,8,8,3)color(1,0.25,0.25,0.3)";

			class Attributes: Attributes
			{
				font = "TahomaB";
				align = "center";
				valign = "middle";
			};
		};
		class BCE_info_show: BCE_info_hide
		{
			idc = 1605;
			text = ">";
			show = 0;
			x = "safezoneX";
			onButtonClick = "_display = ctrlParent (_this#0); (_this#0) ctrlShow false; {(_display displayCtrl _x) ctrlShow true;} forEach [1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1600,1601,1602,1603,1604,1606,1607,1608,1609,1610,1700];";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",0.8};
			animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
			colorBackgroundFocused[] = {0.5,0.5,0.5,0.8};
		};

		//-Toggle Widgets
		class BCE_Waypoint_AV: BCE_RscButtonMenu
		{
			idc = 1606;
			text = "WP";
			x = "0.17 * safezoneW + safezoneX";
			y = "0.755 * safezoneH + safezoneY";
			w = "0.0165 * safezoneW";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_WP',true]) then {(_this # 0) ctrlSetTextColor [1, 0, 0, 0.5]; uinamespace setVariable ['BCE_Terminal_WP',false];} else {uinamespace setVariable ['BCE_Terminal_WP',true]; (_this # 0) ctrlSetTextColor [1, 1, 1, 1];};";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) min 0.04";
			animTexturePressed = "#(argb,8,8,3)color(0.36,0.36,0.36,0.5)";
			tooltip = "$STR_BCE_Widget_WP";
			shadow = 0;
			class Attributes: Attributes
			{
				align = "center";
				valign = "middle";
				font = "RobotoCondensed_BCE";
			};
		};
		class BCE_Vehicles_AV: BCE_Waypoint_AV
		{
			idc = 1607;
			x = "0.188 * safezoneW + safezoneX";
			text = "AV";
			tooltip = "$STR_BCE_Widget_AV";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_Veh',true]) then {(_this # 0) ctrlSetTextColor [1, 0, 0, 0.5]; uinamespace setVariable ['BCE_Terminal_Veh',false];} else {uinamespace setVariable ['BCE_Terminal_Veh',true]; (_this # 0) ctrlSetTextColor [1, 1, 1, 1];};";
		};
		class BCE_Targeting_AV: BCE_Waypoint_AV
		{
			idc = 1608;
			y = "0.78 * safezoneH + safezoneY";
			text = "TG";
			tooltip = "$STR_BCE_Widget_TG";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_Targeting',true]) then {(_this # 0) ctrlSetTextColor [1, 0, 0, 0.5]; uinamespace setVariable ['BCE_Terminal_Targeting',false];} else {uinamespace setVariable ['BCE_Terminal_Targeting',true]; (_this # 0) ctrlSetTextColor [1, 1, 1, 1];};";
		};
		class BCE_SelColor_AV: BCE_Vehicles_AV
		{
			idc = 1609;
			y = "0.78 * safezoneH + safezoneY";
			text = "COR";
			color[] = {1, 1, 0.3, 0.8};
			tooltip = "$STR_BCE_Widget_COR";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
			onButtonClick = "if (uinamespace getVariable ['BCE_Terminal_SelColor',true]) then {(_this # 0) ctrlSetTextColor [0,1,0.3,0.8]; uinamespace setVariable ['BCE_Terminal_SelColor',false];} else {uinamespace setVariable ['BCE_Terminal_SelColor',true]; (_this # 0) ctrlSetTextColor [1,1,0.3,0.8];};";
		};
		class BCE_MapColor_AV: BCE_Vehicles_AV
		{
			idc = 1610;
			X = "0.17 * safezoneW + safezoneX";
			y = "0.805 * safezoneH + safezoneY";
			text = "BG";
			color[] = {0.969,0.957,0.949,0.8};
			tooltip = "$STR_BCE_Widget_BG";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			onButtonClick = "_map = ((ctrlparent (_this # 0)) displayctrl 51); _color = getArray (configfile >> 'RscMapControl' >> 'colorBackground'); if (uinamespace getVariable ['BCE_Map_BGColor',true]) then {(_this # 0) ctrlSetTextColor [0,1,0,0.8]; uinamespace setVariable ['BCE_Map_BGColor',false]; _map ctrlSetBackgroundColor [0.075,0.075,0.075,0.5];} else {(_this # 0) ctrlSetTextColor [0.969,0.957,0.949,0.8]; uinamespace setVariable ['BCE_Map_BGColor',true]; _map ctrlSetBackgroundColor _color;};";
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

		//-CAS UIs
		class AVT_MainListGroup: RscControlsGroupNoScrollbars
		{
			idc = 2000;
			text = "";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = "10 * (safezoneH / 40)";
			class controls
			{
				class AVT_CheckListBG: RscText
				{
					w = "safezoneW";
					h = "safezoneH";
					colorBackground[] = {0,0,0,0.5};
				};
			};
		};
		class TaskList_Title: RscText
		{
			idc = 2001;
			text = "$STR_BCE_TL_Check_List";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 15)";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "2 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = "safezoneH / 40";
			font = "RobotoCondensed_BCE";
			colorBackground[] = {0,0,0,0.5};
		};

		#define TextH (safezoneH / 30)
		//-Text
		class New_Task_Title: RscText
		{
			idc = 2003;
			text = "Task Title:";
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "2 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (safezoneH / 40)";
			w = "14 * (safezoneW / 64)";
			h = "0.035 * safezoneH";
			show = 0;
			colorBackground[] = {0,0,0,0};
		};
		class New_Task_Desc: taskDesc
		{
			idc = 2004;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2) min 0.048";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = QUOTE(11 * TextH);
			show = 0;
			class Attributes: Attributes
			{
				font = "RobotoCondensed_BCE";
				colorLink = "#D09B43";
			};
		};
		class New_Task_Desc_Extended: New_Task_Desc_Extended
		{
			idc = 20041;
			colorBackground[] = {0,0,0,0.5};
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "((safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + ((11/2)*(safezoneH / 30)))";
			w = "14 * (safezoneW / 64)";
			h = QUOTE(8 * TextH);
			fade = 1;
			Enabled = 0;
		};
		class New_Task_Desc_Extended_show: ctrlButton
		{
			idc = 20042;
			x = "50 * (safezoneW / 64) + (safezoneX) - (0.0135 * safezoneW)";
			y = "((safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + ((11/2)*(safezoneH / 30))) - (1.8 * (safezoneH / 40))";
			w = "0.0135 * safezoneW";
			h = "1.8 * (safezoneH / 40)";
			text = "<";
			font = "RobotoCondensed_BCE";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 15)";
			show = 0;
			tooltip = "$STR_BCE_more_Details";
			colorBackground[] = {0,0,0,0.8};
			onButtonClick = "[_this # 0,false] call BCE_fnc_Extended_Desc";
			class TextPos
			{
				left = 0;
				top = "safezoneH / 2";
				right = 0.005;
				bottom = 0;
			};
		};

		class CAS_TaskList_9: RscListBox
		{
			idc = 2002;
			text = "";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = QUOTE(11.1 * TextH);
			colorBackground[] = {0,0,0,0};
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			rowHeight = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5";
			shadow = 0;
			show = 0;
			fade = 1;
			colorPictureRightSelected[] = {0,1,0,1};
			colorSelectBackground[] = {0.95,0.95,0.95,0.2};
			colorSelectBackground2[] = {1,1,1,0.4};
			onLBDblClick = "call BCE_fnc_TaskListDblClick";
			class Items
			{
				class Game_plan
				{
					text = "#: Game Plan :";
					data = "$STR_BCE_DECS_GAMEPLAN";
					textRight = "$STR_BCE_clickx2";
					Expression_idc[] = {20110,2011,20111,20112,20113,2020,2021,2022,2023,2024};
					multi_options = 1;
					default = 1;
					tooltip = "$STR_BCE_TIP_GAMEPLAN";
				};
				class Line1: Game_plan
				{
					text = "1: IP/BP :";
					data = "$STR_BCE_DECS_IPBP";
					Expression_idc[] = {2012,2013,2014};
					multi_options = 0;
					tooltip = "$STR_BCE_TIP_IPBP";
				};
				class Line2: Line1
				{
					text = "2: HDG :";
					data = "$STR_BCE_DECS_HDG";
					textRight = "--";
					Expression_idc[] = {};
					tooltip = "$STR_BCE_TIP_HDG";
				};
				class Line3: Line1
				{
					text = "3: DIST :";
					data = "$STR_BCE_DECS_DIST";
					textRight = "--";
					Expression_idc[] = {};
					tooltip = "$STR_BCE_TIP_DIST";
				};
				class Line4: Line1
				{
					text = "4: ELEV :";
					data = "$STR_BCE_DECS_ELEV";
					textRight = "--";
					Expression_idc[] = {};
					tooltip = "$STR_BCE_TIP_ELEV";
				};
				class Line5: Line1
				{
					text = "5: DESC :";
					data = "$STR_BCE_DECS_DESC";
					tooltip = "$STR_BCE_TIP_DESC";
					Expression_idc[] = {2015};
				};
				class Line6: Line1
				{
					text = "6: GRID :";
					data = "$STR_BCE_DECS_GRID";
					tooltip = "$STR_BCE_TIP_GRID";
					Expression_idc[] = {20121,2013,2014};
				};
				class Line7: Line1
				{
					text = "7: MARK :";
					data = "$STR_BCE_DECS_MARK";
					tooltip = "$STR_BCE_TIP_MARK";
					Expression_idc[] = {2016};
				};
				class Line8: Line1
				{
					text = "8: FRND :";
					data = "$STR_BCE_DECS_FRND";
					tooltip = "$STR_BCE_TIP_FRND";
					Expression_idc[] = {2012,2013,2014,2026};
				};
				class Line9: Line1
				{
					text = "9: EGRS :";
					data = "$STR_BCE_DECS_EGRS";
					tooltip = "$STR_BCE_TIP_EGRS";
					Expression_idc[] = {2019,2018,2014,2017,2013};
				};
				class Remark: Line1
				{
					text = "Remarks :";
					data = "$STR_BCE_DECS_Remarks";
					tooltip = "$STR_BCE_TIP_Remarks";
					Expression_idc[] = {2200,2018,2014,2017,2201,2202};
				};
			};
		};
		class CAS_TaskList_5: CAS_TaskList_9
		{
			idc = 2005;
			class Items: Items
			{
				class Line1: Game_plan
				{
					text = "1:  :";
					textRight = "$STR_BCE_clickx2";
					Expression_idc[] = {
						20110,2011,
						20111,20112,
						20113,
						2020,2021,2022,2023,2024
					};
					multi_options = 1;
					default = 1;
					tooltip = "$STR_BCE_TIP_5Line";
				};
				class Line2: Line1
				{
					text = "2: FRND/Mark :";
					data = "$STR_BCE_DECS_FRNDMark";
					tooltip = "$STR_BCE_TIP_FRND";
					multi_options = 0;
					Expression_idc[] = {2012,2013,2014,2026};
				};
				class Line3: Line2
				{
					text = "3: TGT :";
					data = "$STR_BCE_DECS_TGT";
					tooltip = "$STR_BCE_TIP_GRID";
					Expression_idc[] = {20121,2013,2014};
				};
				class Line4: Line2
				{
					text = "4: DESC/Mark :";
					data = "$STR_BCE_DECS_DESCMark";
					tooltip = "$STR_BCE_TIP_DESC";
					Expression_idc[] = {2015,2016};
				};
				class Remark: Line2
				{
					text = "Remarks :";
					data = "$STR_BCE_DECS_Remarks";
					tooltip = "$STR_BCE_TIP_Remarks";
					Expression_idc[] = {2200,2018,2014,2017,2201,2202};
				};
			};
		};
		//-Expressions
		#define ExpPOS(MULTIY,MULTIW,MULTIH) \
			x = "50 * (safezoneW / 64) + (safezoneX)";\
			y = QUOTE((MULTIY + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH));\
			w = QUOTE((MULTIW * 14) * (safezoneW / 64));\
			h = QUOTE(MULTIH * (safezoneH / 40))

		#define ExpBOX(MULTIY,MULTIH,MULTIW,OFFSETX) \
			x = QUOTE(50 * (safezoneW / 64) + (safezoneX) + (OFFSETX * (safezoneH/safezonew) * (safezoneW / 55)));\
			y = QUOTE((MULTIY + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH));\
			w = QUOTE(MULTIW * (safezoneH/safezonew) * (safezoneW / 55));\
			h = QUOTE(MULTIH * (safezoneW / 55))

		class New_Task_Expression: RscEdit
		{
			idc = 2010;
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			ExpPOS(1,1,1);
			show = 0;
			colorBackground[] = {0,0,0,0};
		};

		//-Game Plan
		class New_Task_Ctrl_Title: New_Task_Ctrl_Title
		{
			idc = 20110;
			size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			ExpPOS(1,0.5,1);
			show = 0;
		};
		class New_Task_CtrlType: New_Task_CtrlType
		{
			idc = 2011;
			ExpPOS(2.15,1,1);
			font = "RobotoCondensed_BCE";
			show = 0;
		};
		class New_Task_AttackType_Title: New_Task_AttackType_Title
		{
			idc = 20111;
			ExpPOS(3.25,0.5,1);
			show = 0;
		};
		class New_Task_AttackType: New_Task_AttackType
		{
			idc = 20112;
			ExpPOS(4.4,1,1);
			show = 0;
		};
		class New_Task_Ordnance_Title: New_Task_Ordnance_Title
		{
			idc = 20113;
			ExpPOS(5.5,0.5,1);
			show = 0;
		};

		//-UNIT info
		class New_Task_Unit_Title: New_Task_Unit_Title
		{
			idc = 20114;
			ExpPOS(8.75,0.5,1);
			show = 0;
		};
		class New_Task_Unit_Pic: New_Task_Unit_Pic
		{
			idc = 20115;
			x = "58 * (safezoneW / 64) + (safezoneX)";
			y = "(8.75 + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH)";
			w = "5 * (safezoneW / 64)";
			h = "(safezonew/safezoneH) * (5 * (safezoneW / 64))";
			show = 0;
		};
		class New_Task_Unit_List: New_Task_Unit_List
		{
			idc = 20116;
			ExpPOS(9.75,0.5,5);
			show = 0;
		};

		//-IP
		class New_Task_IPtype: New_Task_IPtype
		{
			idc = 2012;
			ExpPOS(1,1,1);
			show = 0;
			onToolBoxSelChanged = "call BCE_fnc_ToolBoxChanged";
		};
		class New_Task_TGT: New_Task_TGT
		{
			idc = 20121;
			ExpPOS(1,1,1);
			show = 0;
		};
		class New_Task_MarkerCombo: New_Task_MarkerCombo
		{
			idc = 2013;
			ExpPOS(2,0.5,1);
			show = 0;
			colorBackground[] = {0.5,0.5,0.5,0.6};
			colorSelectBackground[] = {0.5,0.5,0.5,0.6};
			//colorPictureSelected[] = {1,1,1,0};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			onMouseButton = "(_this # 0) call BCE_fnc_IPMarkers";
		};
		class New_Task_IPExpression: New_Task_IPExpression
		{
			idc = 2014;
			ExpPOS(2,0.5,1);
			show = 0;
		};

		//-TG Description
		class New_Task_TG_DESC: New_Task_TG_DESC
		{
			idc = 2015;
			ExpPOS(1,1,5);
			show = 0;
		};

		//-Mark
		class New_Task_GRID_DESC: New_Task_GRID_DESC
		{
			idc = 2016;
			ExpPOS(1,1,1);
			show = 0;
		};

		//-ERGS
		class New_Task_EGRS_Azimuth: New_Task_EGRS_Azimuth
		{
			idc = 2017;
			ExpPOS(3,1,1);
			show = 0;
		};
		class New_Task_EGRS_Bearing: New_Task_EGRS_Bearing
		{
			idc = 2018;
			ExpPOS(2,0.5,1);
			show = 0;
		};
		class New_Task_EGRS: New_Task_EGRS
		{
			idc = 2019;
			ExpPOS(1,1,1);
			show = 0;
		};
		class New_Task_FRND_DESC: New_Task_FRND_DESC
		{
			idc = 2026;
			ExpPOS(3,1,1);
			show = 0;
		};

		//-Remarks
		class New_Task_FADH: New_Task_FADH
		{
			idc = 2200;
			ExpPOS(1,1,1);
			show = 0;
		};
		class New_Task_DangerClose_Text: New_Task_DangerClose_Text
		{
			idc = 2201;
			ExpBOX(4,1,17,1);
			show = 0;
		};
		class New_Task_DangerClose_Box: New_Task_DangerClose_Box
		{
			idc = 2202;
			ExpBOX(4,1,1,0);
			show = 0;
		};

		//-Ordnance
		class AI_Remark_WeaponCombo: AI_Remark_WeaponCombo
		{
			idc = 2020;
			ExpPOS(6.65,0.5,1);
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			show = 0;
			onMouseButtonClick = "";
			onLBSelChanged = "call BCE_fnc_SelWPN_AIR";
		};
		class AI_Remark_ModeCombo: AI_Remark_ModeCombo
		{
			idc = 2021;
			ExpPOS(6.65,0.5,1);
			show = 0;
		};
		class Attack_Range_Combo: Attack_Range_Combo
		{
			idc = 2022;
			ExpPOS(7.65,1/3,1);
			show = 0;
		};
		class Round_Count_Box: Round_Count_Box
		{
			idc = 2023;
			show = 0;
		};
		class Attack_Height_Box: Attack_Height_Box
		{
			idc = 2024;
			show = 0;
		};

		//-List Controls
		class CAS_List_Main: RscListBox
		{
			idc = 2100;
			text = "";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = "10 * (safezoneH / 40)";
			colorBackground[] = {0,0,0,0};
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
			shadow = 0;
			onLBSelChanged = "uiNameSpace setVariable ['BCE_CAS_MainList_selected', _this # 1]";
		};

		//-Category
		class ListCategory: RscToolbox
		{
			idc = 2102;
			x = "50 * (safezoneW / 64) + (safezoneX) - 0.075";
			y = "2 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = 0.075;
			h = 0.15;
			style = "0x02 + 0x30 + 0x800";
			rows = 2;
			columns = 1;
			strings[] =
			{
				"\a3\modules_f\data\iconTaskCreate_ca.paa",
				QPATHTOEF(Core,data\terms.paa)
			};
			tooltips[] =
			{
				"$STR_BCE_AddTask",
				"$STR_BCE_Brevity_Codes"
			};
			onToolBoxSelChanged = "(_this + [true]) call BCE_fnc_ToolBoxChanged";
		};

		//-Buttons
		class Create_Task: ctrlButton
		{
			idc = 2103;
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (10 * (safezoneH / 40))";
			w = "14 * (safezoneW / 64)";
			h = "safezoneH / 30";
			text = "$STR_BCE_New_Task";
			font = "RobotoCondensed_BCE";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
			Enable = 0;
			onButtonClick = "[ctrlParent(_this#0), 1, false, [nil,'AIR' call BCE_fnc_get_TaskCateIndex] call BCE_fnc_get_TaskCurUnit] call BCE_fnc_ListSwitch;";
		};
		class CAS_UI_LastPage: Create_Task
		{
			idc = 2104;
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (10 * (safezoneH / 40)) - (safezoneH / 30)";
			w = "7 * (safezoneW / 64)";
			text = "<";
			fade = 1;
			enable = 0;
		};
		class CAS_UI_SendData: CAS_UI_LastPage
		{
			idc = 2105;
			x = "50 * (safezoneW / 64) + (safezoneX) + (7 * (safezoneW / 64))";
			text = "$STR_BCE_SendData";
			fade = 1;
			enable = 0;
			onButtonClick = "call BCE_fnc_DataReceiveButton";
		};
		class Clear_TaskInfo: ctrlButton
		{
			idc = 2106;
			x = "(safezoneX + safezoneW) - (5 * (safezoneW / 64))";
			y = "2 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "5 * (safezoneW / 64)";
			h = "safezoneH / 40";
			text = "$STR_BCE_ClearAll";
			font = "RobotoCondensed_BCE";
			show = 0;
			onButtonClick = "call BCE_fnc_clearTaskInfo";
		};

		//-Switch 5 or 9 line
		class TaskType: TaskType
		{
			idc = 2107;
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (10 * (safezoneH / 40)) + (safezoneH / 30)";
			w = "14 * (safezoneW / 64)";
			h = "safezoneH / 45";
			font = "RobotoCondensed_BCE";
			sizeEx = "0.028*SafezoneH";
			onLBSelChanged = "call BCE_fnc_onLBTaskTypeChanged";
		};
	};
};
