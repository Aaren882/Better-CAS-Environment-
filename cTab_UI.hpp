class cTab_RscControlsGroup;
class cTab_RscFrame;
class cTab_RscPicture;
class cTab_RscListbox_Tablet;
class cTab_RscEdit_Tablet;
class cTab_RscButton_Tablet;
class cTab_Tablet_btnF2;
class cTab_Tablet_window_back_BR;
class cTab_Tablet_RscMapControl;

class cTab_Tablet_dlg
{
	class controlsBackground
	{
		delete MiniMapBG;
		class cTabUavMap: cTab_Tablet_RscMapControl
		{
			y = "(((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2)) - (safezoneH / 40)";
		};
	};
	class controls
	{
		class Desktop: cTab_RscControlsGroup
		{
			class controls
			{
				class actBFTtxt;
				class actUAVtxt: actBFTtxt
				{
					toolTip = "Air Vic Video Feeds";
				};
				class actTKBtxt: actBFTtxt
				{
					idc = 10041;
					text = "\a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
					y = "(((((491) + (42)) + (25) * 5 + (100) * 4) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','AIRTASK']]] call cTab_fnc_setSettings;";
					toolTip = "Air Task Builder";
				};
			};
		};
		
		class UAV: cTab_RscControlsGroup
		{
			class controls
			{
				delete UAVListBG;
				//delete UAVVidBG1;
				delete UAVVidBG2;
				class NoSignal_Picture: cTab_RscPicture
				{
					idc = 20115;
					colorText[] = {"(profilenamespace getvariable ['IGUI_WARNING_RGB_R',0.8])","(profilenamespace getvariable ['IGUI_WARNING_RGB_G',0.5])","(profilenamespace getvariable ['IGUI_WARNING_RGB_B',0.0])","(profilenamespace getvariable ['IGUI_WARNING_RGB_A',0.8])"};
					text = "\A3\ui_f\data\map\diary\signal_ca.paa";
					x = "0";
					y = "0";
					w = "0";
					h = "0";
				};
				class cTabUAVlist: RscCombo
				{
					x = "(((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2)) - (safezoneH / 40)";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(safezoneH / 40)";
				};
				
				//-Camera Ctrls
				class cTab_CameraConnect: RscButtonMenu
				{
					idc = 2100;
					text = "View Camera";
					x = "(((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048 * (safezoneH * 1.2)) + (((((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048 * (safezoneH * 1.2)) - (safezoneH / 40))";
					w = "((((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048 * ((safezoneH * 1.2) * 3/4)) / 2";
					h = "(safezoneH / 40)";
					colorBackground[] = {0.5,0.5,0.5,0.5};
					periodFocus = 0;
					action = "call cTab_Tablet_btnACT;";
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
				class cTab_CameraControl: cTab_CameraConnect
				{
					idc = 2101;
					text = "Control Camera";
					x = "(((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)) + (((((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048 * ((safezoneH * 1.2) * 3/4)) / 2)";
					action = "0 call cTab_Tablet_btnACT;";
				};
				
				//-UNIT info
				class New_Task_Unit_Title: RscStructuredText
				{
					idc = 20114;
					shadow = 1;
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
					text = "";
					x = "(((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2)) - (safezoneH / 40)";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(safezoneH / 40)";
				};
				class cTabUnitList: cTab_RscListbox_Tablet
				{
					idc = 20116;
					text = "";
					colorBackground[] = {0.5,0.5,0.5,0.3};
					colorSelect[] = {0,1,0,1};
					colorSelect2[] = {0,1,0,1};
					colorSelectRight[] = {0,1,0,1};
					colorSelect2Right[] = {0,1,0,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
		
					onLBSelChanged = "call BCE_fnc_unitList_info";
					x = "(((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
				};
				
				//-PIP displays
				class cTabUAVdisplay: cTab_RscPicture
				{
					text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
				};
				class cTabUAV2nddisplay: cTab_RscListbox_Tablet
				{
					idc = 1775;
					text = "";
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					/*colorText[] = {0,0,0,1};
					colorTextRight[] = {0,0,0,1};*/
					colorBackground[] = {0.5,0.5,0.5,0.3};
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					soundSelect[] = {"",0,1};
					h = "((((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048 * (safezoneH * 1.2)) - (safezoneH / 40)";
				};
			};
		};
		class Task_Builder: Desktop
		{
			idc = 4651;
			class controls
			{
				class msgframe: cTab_RscFrame
				{
					idc = 14;
					text = "Read Message";
					x = "((((((257)) + (20))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((((1341)) - (20) * 2)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2)) / 2048  * 	(safezoneH * 1.2)";
				};
				class msgListbox: cTab_RscListbox_Tablet
				{
					idc = 15000;
					style = 32;
					x = "(((((((257)) + (20)) + (10))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (10)) + (20))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((((((1341)) - (20) * 2) - (10) * 3) / 3)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20))) / 2048  * 	(safezoneH * 1.2)";
					onLBSelChanged = "_this call cTab_msg_get_mailTxt;";
				};
				class msgTxt: cTab_RscEdit_Tablet
				{
					idc = 18510;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "No Message Selected";
					x = "((((((((257)) + (20)) + (10)) + (((((1341)) - (20) * 2) - (10) * 3) / 3) + (10))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((((491) + (42)) + (10)) + (20)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((((((1341)) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20)) - (10) - (50))) / 2048  * 	(safezoneH * 1.2)";
					canModify = 0;
				};
				class composeFrame: cTab_RscFrame
				{
					idc = 15;
					text = "Compose Message";
					x = "(((((((257)) + (20)))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((((1341)) - (20) * 2))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2))) / 2048  * 	(safezoneH * 1.2)";
				};
				class playerlistbox: cTab_RscListbox_Tablet
				{
					idc = 15010;
					style = 32;
					x = "((((((((257)) + (20)) + (10)))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((((((1341)) - (20) * 2) - (10) * 3) / 3))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20)))) / 2048  * 	(safezoneH * 1.2)";
				};
				class deletebtn: cTab_RscButton_Tablet
				{
					idc = 16120;
					text = "Delete";
					tooltip = "Delete Selected Message(s)";
					x = "(((((((((257)) + (20))) + ((((1341)) - (20) * 2)) - (10) - (150)))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((((491) + (42)) + (10)) + (20))) + ((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20)) - (10) - (50)) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((150)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "((50)) / 2048  * 	(safezoneH * 1.2)";
					action = "['cTab_Tablet_dlg'] call cTab_fnc_onMsgBtnDelete;";
				};
				class sendbtn: cTab_RscButton_Tablet
				{
					idc = 16130;
					text = "Send";
					x = "((((((((257)) + (20))) + ((((1341)) - (20) * 2)) - (10) - (150))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) + (((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20)) - (10) - (50))) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((150)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "((50)) / 2048  * 	(safezoneH * 1.2)";
					action = "call cTab_msg_Send;";
				};
				class edittxtbox: cTab_RscEdit_Tablet
				{
					idc = 14000;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "";
					x = "(((((((((257)) + (20)) + (10)) + (((((1341)) - (20) * 2) - (10) * 3) / 3) + (10)))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((((((((1341)) - (20) * 2) - (10) * 3) / 3) * 2))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "((((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20)) - (10) - (50)))) / 2048  * 	(safezoneH * 1.2)";
				};
			};
		};
		
		class btnF2: cTab_Tablet_btnF2
		{
			tooltip = "AV Intel Live Feed - Quick Key";
		};
	};
};