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
					onDraw="call BCE_fnc_drawGPS;";
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
			#if __has_include("\z\ace\addons\map\config.bin")
				onDraw="call BCE_fnc_drawGPS; [ctrlParent (_this # 0)] call ace_map_fnc_onDrawMap;";
			#else
				onDraw="call BCE_fnc_drawGPS;";
			#endif
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
	class controlsBackground
	{
		class CA_Map: RscMapControl
		{
			idcMarkerColor = 1090;
			idcMarkerIcon = 1091;
			onMouseButtonUp = "call BCE_fnc_GetMapClickPOS;";
			onDraw = "call BCE_fnc_TAC_Map;";
		};
	};
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
			onButtonClick = "_display = ctrlParent (_this#0); (_display displayCtrl 1605) ctrlShow true; {(_display displayCtrl _x) ctrlShow false;} forEach [1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1600,1601,1602,1603,1604,1606,1607,1608,1609,1610,1700];";
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
			onButtonClick = "_display = ctrlParent (_this#0); (_this#0) ctrlShow false; {(_display displayCtrl _x) ctrlShow true;} forEach [1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1600,1601,1602,1603,1604,1606,1607,1608,1609,1610,1700];";
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
			class Attributes: Attributes
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
			colorFocused[] = {1,1,1,0.8};
			tooltip = "Map Brightness";
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
			text = "Check List:";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 15)";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "2 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = "safezoneH / 40";
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
		class New_Task_Desc: RscStructuredText
		{
			idc = 2004;
			text = "Description :";
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = 11 * TextH;
			show = 0;
			colorBackground[] = {0,0,0,0};
		};
		class New_Task_Desc_Extended: New_Task_Desc
		{
			idc = 20041;
			colorBackground[] = {0,0,0,0.5};
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			y = "((safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + ((11/2)*(safezoneH / 30)))";
			h = 9*TextH;
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
			font = "RobotoCondensedLight";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 15)";
			show = 0;
			tooltip = "Show Description";
			colorBackground[] = {0,0,0,0.8};
			onButtonClick = "[_this # 0,false] call BCE_fnc_Extended_Desc;";
			class TextPos
			{
				left = 0;
				top = "safezoneH / 2";
				right = 0.005;
				bottom = 0;
			};
			class Attributes
			{
				font = "RobotoCondensedLight";
				color = "#E5E5E5";
				align = "center";
				shadow = "false";
			};
		};
		
		class CAS_TaskList_9: RscListBox
		{
			idc = 2002;
			text = "";
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "14 * (safezoneW / 64)";
			h = 11 * TextH;
			colorBackground[] = {0,0,0,0};
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			rowHeight = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5";
			shadow = 0;
			show = 0;
			fade = 1;
			colorPictureRightSelected[] = {0,1,0,1};
			colorSelectBackground[] = {0.95,0.95,0.95,0.2};
			colorSelectBackground2[] = {1,1,1,0.4};
			onLBDblClick = "call BCE_fnc_TaskListDblCLick;";
			class Items
			{
				class Game_plan
				{
					text = "#: Game Plan :";
					data = "Type 1 : <br/>JTAC can see target and Aircraft, and is for individual attacks.<br/><br/>Type 2 : <br/>JTAC can see either the target or the aircraft (one or the other, not both) and is for individual attacks he must have real time data for the target from FO/Scout.<br/><br/>Type 3 : <br/>Multiple attacks within a single engagement, JTAC can't see the aircraft but must have real time data from Scout or FO.";
					textRight = "click x2";
					Expression_idc[] = {20110,2011,20111,20112,20113,2020,2021,2022,2023};
					multi_options = 1;
					default = 1;
					tooltip = "Task Type";
				};
				class Line1: Game_plan
				{
					text = "1: IP/BP :";
					data = "“Shift + LMB” on the map to set marker<br/><br/>“Initial Point” or “Battle Position”.<br/><br/>For FW aircraft (Planes), the IP is the starting point for the run-in to the target. <br/><br/>For RW aircraft (Helis), the BP is where attacks on the target are commenced.";
					Expression_idc[] = {2012,2013,2014};
					multi_options = 0;
					tooltip = "Initial Point\Battle Position";
				};
				class Line2: Line1
				{
					text = "2: HDG :";
					data = "Heading and Offset.<br/><br/>The heading is given in degrees magnetic from the “IP to target” or from the center of the BP to the target. <br/><br/>The offset is the side of the “IP to target” line on which aircrews can maneuver for the attack.";
					textRight = "--";
					Expression_idc[] = {};
					tooltip = "Heading between IP/BP and Target";
				};
				class Line3: Line1
				{
					text = "3: DIST :";
					data = "Distance.<br/><br/>The distance “IP/BP to target”.";
					textRight = "--";
					Expression_idc[] = {};
					tooltip = "Distance between IP/BP and Target";
				};
				class Line4: Line1
				{
					text = "4: ELEV :";
					data = "Target Elevation.<br/><br/>The target elevation is given in <t underline='true'>Feet</t> Mean Sea Level (MSL) unless otherwise specified.";
					textRight = "--";
					Expression_idc[] = {};
					tooltip = "Target elevation (in Feet)";
				};
				class Line5: Line1
				{
					text = "5: DESC :";
					data = "Target Description.<br/><br/>The description should be specific enough for the aircrew to recognize the target.";
					tooltip = "Target description";
					Expression_idc[] = {2015};
				};
				class Line6: Line1
				{
					text = "6: GRID :";
					data = "The target location.";
					tooltip = "Target Position (GRID)";
					Expression_idc[] = {20121,2013,2014};
				};
				class Line7: Line1
				{
					text = "7: MARK :";
					data = "Mark Type/Terminal Guidance.<br/><br/>The type of mark the JTAC/FAC(A) will use (for example, smoke(WP), laser, or IR). <br/><br/>If using a laser, the JTAC/FAC(A) will also pass the call sign of the platform/ individual that will provide terminal guidance for the weapon and laser code.";
					tooltip = "Mark method";
					Expression_idc[] = {2016};
				};
				class Line8: Line1
				{
					text = "8: FRND :";
					data = "Friendlies bearing from the target.<br/><br/>Cardinal/sub-cardinal bearing from the target (N, NE, E, SE, S, SW, W, or NW) and distance of <t underline='true'>closest friendlies</t> from the target in meters (e.g., “South 300”). ";
					tooltip = "Friendlies";
					Expression_idc[] = {2012,2013,2014,2016};
				};
				class Line9: Line1
				{
					text = "9: EGRS :";
					data = "Egress.<br/><br/>These are the instructions the aircrews use to exit the target area.";
					tooltip = "Egress";
					Expression_idc[] = {2019,2018,2014,2017,2013};
				};
				class Remark: Line1
				{
					text = "Remarks :";
					data = "Supplies additional important information.<br/><br/>1.<t underline='true'>Troops in Contact</t> or <t underline='true'>Danger Close</t><br/>2.Airspace coordination: final attack heading (FAH) or altitude restrictions <br/>3.Threat <br/>4.SEAD support in effect <br/>5.Active gun target lines <br/>6.Ordnance requested <br/>etc";
					tooltip = "Remarks/Restrictions";
					Expression_idc[] = {};
				};
			};
		};
		class CAS_TaskList_5: CAS_TaskList_9
		{
			idc = 2005;
			class Items
			{
				class Game_plan
				{
					text = "1:  :";
					data = "State the “Aircraft call sign” / “Yours”.<br/><br/>Control Type (Type 1, 2 or 3).<br/>Method Of Attack (MOA) - Bombs On Coordinate or On Target (BOC or BOT).<br/>Ordnance requested by the user.";
					textRight = "--";
					Expression_idc[] = {2011,20111,20112};
					multi_options = 1;
					default = 1;
					tooltip = "“Aircraft call sign” / “Yours”";
				};
				class Line2: Game_plan
				{
					text = "2: FRND/Mark :";
					data = "Friendly position (The closest one to the Target).<br/>GRID/TRP/bearing and range etc<br/><br/>Marked by (smoke/VS-17 panel/beacon/GLINT/IR strobe etc.)";
					textRight = "click x2";
					tooltip = "Friendly";
					Expression_idc[] = {2012,2013,2014,2016};
				};
				class Line3: Line2
				{
					text = "3: TGT :";
					data = "Target location. (GRID/TRP/bearing and range etc)";
					tooltip = "The target location";
					Expression_idc[] = {20121,2013,2014};
				};
				class Line4: Line2
				{
					text = "4: Description/Mark :";
					data = "Description of target<br/>Method used to mark ENY position. (IR, tracer etc)";
					tooltip = "Target Description";
					Expression_idc[] = {2015,2016};
				};
				class Remark: Line2
				{
					text = "Remarks :";
					data = "Supplies additional important information.<br/><br/>1.<t underline='true'>Troops in Contact</t> or <t underline='true'>Danger Close</t><br/>2.Airspace coordination: final attack heading (FAH) or altitude restrictions <br/>3.Threat <br/>4.SEAD support in effect <br/>5.Active gun target lines <br/>6.Ordnance requested <br/>etc";
					tooltip = "Remarks/Restrictions";
					Expression_idc[] = {2020,2021,2022,2023};
				};
			};
		};
		//-Expressions
		#define ExpPOS(MULTIY,MULTIW,MULTIH) \
			x = "50 * (safezoneW / 64) + (safezoneX)";\
			y = (MULTIY + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH);\
			w = (MULTIW * 14) * (safezoneW / 64);\
			h = MULTIH * (safezoneH / 40)
		class New_Task_Expression: RscEdit
		{
			idc = 2010;
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			ExpPOS(1,1,1);
			show = 0;
			colorBackground[] = {0,0,0,0};
		};
		
		//-Game Plan
		class New_Task_Ctrl_Title: RscButtonMenu
		{
			idc = 20110;
			style = 2;
			text = "Control Type: <img image='\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa' align='Right' size='0.8' />";
			size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2";
			colorBackground[] = {0,0,0,0.4};
			show = 0;
			shadow = 1;
			periodFocus = 0;
			periodOver = 0;
			tooltip = "more details";
			onButtonClick = "call BCE_fnc_Extended_Desc;";
			BCE_Desc = "Type 1 : <br/>JTAC can see target and Aircraft, and is for individual attacks.<br/><br/>Type 2 : <br/>JTAC can see either the target or the aircraft (one or the other, not both) and is for individual attacks he must have real time data for the target from FO (Forward Observer)/Scout.<br/><br/>Type 3 : <br/>Multiple attacks within a single engagement, JTAC can't see the aircraft but <t font='RobotoCondensedBold'>must have real time data</t> from FO/Scout.";
			class Attributes
			{
				font = "RobotoCondensed";
				color = "#E5E5E5";
				align = "left";
				shadow = "true";
			};
			ExpPOS(1,0.5,1);
		};
		class New_Task_CtrlType: RscToolbox
		{
			idc = 2011;
			ExpPOS(2.15,1,1);
			rows = 1;
			columns = 3;
			strings[] =
			{
				"Type 1",
				"Type 2",
				"Type 3"
			};
			show = 0;
			colorBackground[] = {0,0,0,0.3};
		};
		class New_Task_AttackType_Title: New_Task_Ctrl_Title
		{
			idc = 20111;
			text = "Attack Type: <img image='\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa' align='Right' size='0.8' />";
			BCE_Desc = "“Bomb on Target” / “Bomb on Coordinate” <br/><br/>BOC : <br/>GPS guided ammunitions. <br/>Ex. GBU-31 GBU-32 GBU-35 <br/><br/>BOT : <br/>Guns ,rockets and Laser guided ammunitions. <br/>Ex. Hydra70 GBU-12";
			ExpPOS(3.25,0.5,1);
		};
		class New_Task_AttackType: New_Task_CtrlType
		{
			idc = 20112;
			ExpPOS(4.4,1,1);
			columns = 2;
			strings[] =
			{
				"BoT",
				"BoC"
			};
		};
		class New_Task_Ordnance_Title: New_Task_Ctrl_Title
		{
			idc = 20113;
			text = "Request Ordnance: <img image='\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa' align='Right' size='0.8' />";
			BCE_Desc = "What ammunition will be droped. <br/>How many. <br/>How far. <br/>etc";
			ExpPOS(5.5,0.5,1);
		};
		
		//-UNIT info
		class New_Task_Unit_Title: RscStructuredText
		{
			idc = 20114;
			shadow = 1;
			show = 0;
			colorBackground[] = {0,0,0,0};
			size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
			class Attributes
			{
				font = "PuristaMedium";
				color = "#E5E5E5";
				align = "center";
				valign="middle";
				shadow = 1;
				size = 1;
			};
			class TextPos
			{
				left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
				top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
				right = 0.005;
				bottom = 0.0;
			};
			text = "<t size='1' align='left'>%1 - %2</t>";
			ExpPOS(8.75,0.5,1);
		};
		class New_Task_Unit_Pic: RscPicture
		{
			idc = 20115;
			text = "\A3\Ui_f\data\IGUI\RscIngameUI\RscOptics\square.paa";
			x = "58 * (safezoneW / 64) + (safezoneX)";
			y = "(8.75 + 2) * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (0.035 * safezoneH)";
			w = "5 * (safezoneW / 64)";
			h = "(safezonew/safezoneH) * (5 * (safezoneW / 64))";
			show = 0;
		};
		class New_Task_Unit_List: RscListBox
		{
			idc = 20116;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {0,1,0,1};
			colorSelect2[] = {0,1,0,1};
			colorSelectRight[] = {0,1,0,1};
			colorSelect2Right[] = {0,1,0,1};
			colorSelectBackground[] = {0,0,0,0};
			colorSelectBackground2[] = {0,0,0,0};
			
			onLBSelChanged = "call BCE_fnc_unitList_info";
			ExpPOS(9.75,0.5,5);
		};
		
		//-IP
		class New_Task_IPtype: New_Task_CtrlType
		{
			idc = 2012;
			ExpPOS(1,1,1);
			rows = 1;
			columns = 3;
			strings[] =
			{
				"Map Marker",
				"Click Map “Shift + LMB”",
				"OverHead"
			};
			onToolBoxSelChanged = "call BCE_fnc_IPToolBoxChanged;";
		};
		class New_Task_TGT: New_Task_IPtype
		{
			idc = 20121;
			columns = 2;
			strings[] =
			{
				"Map Marker",
				"Click Map “Shift + LMB”"
			};
		};
		class New_Task_MarkerCombo: RscCombo
		{
			idc = 2013;
			ExpPOS(2,0.5,1);
			show = 0;
			colorBackground[] = {0.5,0.5,0.5,0.6};
			colorSelectBackground[] = {0.5,0.5,0.5,0.6};
			//colorPictureSelected[] = {1,1,1,0};
			wholeHeight = 0.8;
			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
			onMouseButtonClick = "(_this # 0) call BCE_fnc_IPMarkers;";
			class Items
			{
				class NA
				{
					text = "Select Marker";
					data = "[]";
					default = 1;
				};
			};
		};
		class New_Task_IPExpression: New_Task_Expression
		{
			idc = 2014;
			ExpPOS(2,0.5,1);
			text = "";
			canModify = 0;
		};

		//-TG Description
		class New_Task_TG_DESC: RscEditMulti
		{
			idc = 2015;
			ExpPOS(1,1,5);
			text = "";
			show = 0;
		};

		//-GRID
		class New_Task_GRID_DESC: RscEdit
		{
			idc = 2016;
			ExpPOS(3,1,1);
			text = "Mark with...";
			show = 0;
		};

		//-ERGS
		class New_Task_EGRS_Azimuth: New_Task_CtrlType
		{
			idc = 2017;
			ExpPOS(3,1,1);
			rows = 1;
			columns = 8;
			strings[] =
			{
				"N",
				"NE",
				"E",
				"SE",
				"S",
				"SW",
				"W",
				"NW"
			};
			values[] =
			{
				0,
				45,
				90,
				135,
				180,
				225,
				270,
				315
			};
			show = 0;
		};
		class New_Task_EGRS_Bearing: RscEdit
		{
			idc = 2018;
			ExpPOS(2,0.5,1);
			text = "Bearing...";
			show = 0;
		};
		class New_Task_EGRS: New_Task_IPtype
		{
			idc = 2019;
			columns = 4;
			strings[] =
			{
				"Azimuth",
				"Bearing",
				"Map Marker",
				"OverHead"
			};
		};
		
		//-Ordnance
		class AI_Remark_WeaponCombo: New_Task_MarkerCombo
		{
			idc = 2020;
			ExpPOS(6.65,0.5,1);
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onMouseButtonClick = "";
			onLBSelChanged = "call BCE_fnc_CAS_SelWPN;";
			class Items{};
		};
		class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
		{
			idc = 2021;
			onLBSelChanged = "";
		};
		class Attack_Range_Combo: AI_Remark_ModeCombo
		{
			idc = 2022;
			ExpPOS(7.65,0.5,1);
			class Items
			{
				class 2000m
				{
					text = "2000m";
					value = 2000;
					default = 1;
				};
				class 1500m
				{
					text = "1500m";
					value = 1500;
				};
				class 1000m
				{
					text = "1000m";
					value = 1000;
				};
			};
		};
		class Round_Count_Box: RscEdit
		{
			idc = 2023;
			show = 0;
			text = "1";
			tooltip = "Round Count";
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
			onLBSelChanged = "uiNameSpace setVariable ['BCE_CAS_MainList_selected', _this # 1];";
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
				"\a3\modules_f\data\iconTaskSetDescription_ca.paa"
			};
			tooltips[] =
			{
				"Add Task",
				"Task History (Not Working yet)"
			};
		};

		//-Buttons
		class Create_Task: ctrlButton
		{
			idc = 2103;
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (10 * (safezoneH / 40))";
			w = "14 * (safezoneW / 64)";
			h = "safezoneH / 30";
			text = "New Task";
			font = "RobotoCondensedLight";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
			Enable = 0;
			onButtonClick = "[ctrlParent(_this#0), 1, false, player getVariable ['TGP_View_Selected_Vehicle',objNull]] call BCE_fnc_ListSwitch;";
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
			text = "Send Data";
			fade = 1;
			enable = 0;
			onButtonClick = "call BCE_fnc_DataReceiveButton;";
		};
		class Clear_TaskInfo: ctrlButton
		{
			idc = 2106;
			x = "(safezoneX + safezoneW) - (5 * (safezoneW / 64))";
			y = "2 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01)";
			w = "5 * (safezoneW / 64)";
			h = "safezoneH / 40";
			text = "Clear All";
			font = "RobotoCondensedLight";
			show = 0;
			onButtonClick = "call BCE_fnc_clearTaskInfo;";
		};

		//-Switch 5 or 9 line
		class Task_Type: RscCombo
		{
			idc = 2107;
			x = "50 * (safezoneW / 64) + (safezoneX)";
			y = "3 * (safezoneH / 40) + (safezoneY) + (19.9 * (safezoneH / 40) + 0.01) + (10 * (safezoneH / 40)) + (safezoneH / 30)";
			w = "14 * (safezoneW / 64)";
			h = "safezoneH / 45";
			font = "RobotoCondensedLight";
			colorBackground[] = {0,0,0,0.3};
			colorSelectBackground[] = {0.5,0.5,0.5,0.6};
			wholeHeight = 0.8;
			sizeEx = "0.028*SafezoneH";
			onLBSelChanged = "call BCE_fnc_TaskTypeChanged;";
			class Items
			{
				class 9line
				{
					text = "9 Line";
					textRight = "(Compat with jets)";
					value = 0;
					default = 1;
				};
				class 5line
				{
					text = "5 Line";
					textRight = "(Compat with V-44X)";
					value = 1;
				};
			};
		};
	};
};
