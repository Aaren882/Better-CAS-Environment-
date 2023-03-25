//-IGUI_GRID_BCE_TASKLIST
class BCE_Task_Receiver
{
	idd = -1;
	fadein = 0;
	fadeout = 0;
	duration = 1e+007;
	enableSimulation = 1;
	movingEnable = 1;
	name = "BCE_Task_Receiver";
	onLoad = "uiNamespace setVariable ['BCE_Task_Receiver', _this # 0]";
	class controlsBackground
	{
		class Background: RscPicture
		{
			IDC = 15110;
			text = "A3\Ui_f\data\IGUI\RscCustomInfo\background_ca.paa";
			x = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_X"", safezoneX])";
			y = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_Y"", ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)])";
			w = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_W"", (10 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			h = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_H"", (10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - (1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			colorText[] = {0.2,0.2,0.2,0.8};
		};
		class BackgroundGroup: RscControlsGroupNoScrollbars
		{
			IDC = 15111;
			x = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_X"", safezoneX])";
			y = "1.125 * (profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_Y"", ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)])";
			w = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_W"", (10 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			h = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_H"", (10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 1.25 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls{};
		};
	};
	class controls
	{
		class Title: RscIGUIText
		{
			colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
			idc = 15112;
			text = "Task Receiver";
			x = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_X"", safezoneX])";
			y = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_Y"", ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)]) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_W"", (10 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class JTAC_Unit: RscIGUIText
		{
			IDC = 101;
			text = "From";
			style = 1;
			x = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_X"", safezoneX]) + (0.25 * (profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_W"", (10 * (((safezoneW / safezoneH) min 1.2) / 40))]))";
			y = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_Y"", ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)]) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "0.75 * (profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_W"", (10 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class TaskList: RscListBox
		{
			IDC = 102;
			x = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_X"", safezoneX])";
			y = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_Y"", ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)])";
			w = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_W"", (10 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			h = "(profilenamespace getvariable [""IGUI_GRID_BCE_TASKLIST_H"", (10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - (1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			text = "";
			colorBackground[] = {0,0,0,0};
			shadow = 2;
			font = "RobotoCondensedBold";
			sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class CfgItems
			{
				class 9Line
				{
					class Type_Control
					{
						text = "#: Game Plan :";
					};
					class Line1: Type_Control
					{
						text = "1: IP/BP :";
					};
					class Line2: Type_Control
					{
						text = "2: HDG :";
					};
					class Line3: Type_Control
					{
						text = "3: DIST :";
					};
					class Line4: Type_Control
					{
						text = "4: ELEV :";
					};
					class Line5: Type_Control
					{
						text = "5: DESC :";
					};
					class Line6: Type_Control
					{
						text = "6: GRID :";
					};
					class Line7: Type_Control
					{
						text = "7: MARK :";
					};
					class Line8: Type_Control
					{
						text = "8: FRND :";
					};
					class Line9: Type_Control
					{
						text = "9: EGRS :";
					};
					class Remark: Type_Control
					{
						text = "Remarks :";
					};
				};
				class 5Line
				{
					class Line1
					{
						text = "1:  :";
					};
					class Line2: Line1
					{
						text = "2: FRND/Mark :";
					};
					class Line3: Line2
					{
						text = "3: TGT :";
					};
					class Line4: Line2
					{
						text = "4: Description/Mark :";
					};
					class Remark: Line2
					{
						text = "Remarks :";
					};
				};
			};
		};
	};
};
