class cTab_RscControlsGroup;
class cTab_RscFrame;
class cTab_RscPicture;
class cTab_RscListbox_Tablet;
class cTab_RscEdit_Tablet;
class cTab_RscButton_Tablet;
class cTab_Tablet_btnF2;
class cTab_Tablet_btnF4;
class cTab_Tablet_window_back_BR;
class cTab_Tablet_RscMapControl;

#define TASK_OFFSET 17000
class cTab_Tablet_dlg
{
	//BCE_TASK_Offset = TASK_OFFSET;
	Brevity_Code[] =
	{
		"Weapon :",
		{"Guns x3","Firing cannon."},
		{"Rifle","Launch of A/G missile."},
		{"Pickle","Release of (Cluster/General-Purpose)bomb."},
		{"Paveway","Release of Laser-Guided bomb."},
		{"Ripple","Release multiple munitions in close succession."},
		{"Winchester","No ordnance remaining, can be used to against the specific target."},
		{"Splash(ed)","Ammunition impact/target destroyed."},
		{"Shack","Oradance impact on ground, (Unofficial)."},
		"Task :",
		{"Playtime","How long the aircraft can be on station."},
		{"Contact","Sighting of a specified reference point."},
		{"Visual","Sighting of the friendly.opposite “Blind”."},
		{"Tally","Sighting of the target.opposite “No Joy”."},
		{"Clear(ed) Hot","Give the plane clearance to attack."},
		"-", //Next Page
		{"Abort","Terminate the weapon release or mission."},
		{"What Luck","Request for task result. “BDA”"},
		{"IP Inbound","Aircraft has reached IP begin to attack."},
		{"Bingo","Aircraft has no fuel but return to base."},
		{"Continue","Continue present maneuver; does NOT imply clearance to engage."},
		"Laser :",
		{"Laser On","Call to begin Lasing at the target."},
		{"Sparkle","Marks target by Laser."},
		{"Lasing","You have begun Lasing the target."},
		{"Snake/Pulse","Jiggle/Pulse Laser on the target."},
		{"Steady","Steady the beam (Snake/Pulse)."},
		{"Spot","When you spot the Laser designation."},
		{"Rope","Circling Laser around an aircraft."},
		"",
		"<a href='https://wiki.hoggitworld.com/view/Brevity_List'>Hoggitworld</a>",
		"<a href='https://en.wikipedia.org/wiki/Multiservice_tactical_brevity_code'>Wikipedia</a>"
	};
	
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
			class VScrollbar;
			class HScrollbar;
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
					action = "['cTab_Tablet_dlg',[['mode','TASK_Builder']]] call cTab_fnc_setSettings;";
					toolTip = "Task Builder";
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
		
		
		#define smalSpc ((((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))-((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4)))
				
		#define smalFmW (((((((1341)) - (20) * 2) - (10) * 3) / 3)) / 2048 * ((safezoneH * 1.2) * 3/4))
		#define smalFmH (((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20))) / 2048 * (safezoneH * 1.2))
		
		//-Coordination
		#define FrameLX (((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))
		
		#define FrameDY (((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) - ((491) + (42))) / 2048 * (safezoneH * 1.2)))
		
		#define ContC (0.03/1.2)
		#define ContW (((((((1341)) - (20) * 2) - (10) * 3) / 3.1)) / 2048 * ((safezoneH * 1.2) * 3/4))
		#define ConH (safezoneH / 60)
		
		//-17000 + SET
		#define idc_D(SET) __EVAL(TASK_OFFSET+SET)
		
		class Task_Builder: Desktop
		{
			idc = 4651;
			class VScrollbar: VScrollbar
			{
				width = 0;
			};
			class HScrollbar: HScrollbar
			{
				height = 0;
			};
			class controls
			{
				//- Content (Task Type)
				class TaskType: RscCombo
				{
					idc = idc_D(2107);
					x = FrameLX + smalFmW + (smalSpc/2);
					y = FrameDY;
					w = ContW;
					h = ConH;
					//font = "RobotoCondensedLight";
					colorBackground[] = {0,0,0,1};
					colorSelectBackground[] = {0.5,0.5,0.5,1};
					wholeHeight = 0.8;
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					onLBSelChanged = "(_this + [17000]) call BCE_fnc_TaskTypeChanged";
					class Items
					{
						class 9line
						{
							text = "9 Line";
							textRight = "";
							value = 0;
							default = 1;
						};
						class 5line
						{
							text = "5 Line";
							textRight = "";
							value = 1;
						};
					};
				};
				
				class mainframe: cTab_RscFrame
				{
					idc = -1;
					text = "";
					x = "((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((((1341)) - (20) * 2)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "2 * ((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2)) / 2048 * (safezoneH * 1.2)) + ((((((((491) + (42)) + (10)) + (20))) - ((491) + (42))) / 2048  *  (safezoneH * 1.2)) - ((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  *  (safezoneH * 1.2)))";
				};
				
				class Background: RscBackground
				{
					colorBackground[] = {0.2,0.2,0.2,0.4};
					x = "((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((((1341)) - (20) * 2)) / 2048 * ((safezoneH * 1.2) * 3/4)";
					h = "2 * ((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2)) / 2048 * (safezoneH * 1.2)) + ((((((((491) + (42)) + (10)) + (20))) - ((491) + (42))) / 2048  *  (safezoneH * 1.2)) - ((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  *  (safezoneH * 1.2)))";
				};
				
				//-Separator
				class Separator: cTab_RscFrame
				{
					idc = -1;
					x = "((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2)) + ((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2)) / 2048 * (safezoneH * 1.2)) + ((((((((491) + (42)) + (10)) + (20))) - ((491) + (42))) / 2048  *  (safezoneH * 1.2)) - ((((((491) + (42)) + (10))) - ((491) + (42))) / 2048  *  (safezoneH * 1.2))))";
					w = "((((1341)) - (20) * 2)) / 2048 * ((safezoneH * 1.2) * 3/4)";
					h = "0.001";
				};

				//-Task List
				// -Description
				class Descframe: cTab_RscFrame
				{
					idc = -1;
					sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
					text = "Description : ";
					x = FrameLX;
					y = FrameDY;
					w = smalFmW;
					h = smalFmH;
				};
				class taskDesc: RscStructuredText
				{
					idc = idc_D(2004);
					text = "Desc :";
					colorBackground[] = {0,0,0,0};
					x = FrameLX;
					y = FrameDY + ContC;
					w = smalFmW;
					h = smalFmH - ContC;
					class Attributes
					{
						font = "RobotoCondensed";
						color = "#ffffff";
						align = "left";
						shadow = 1;
						size = 0.68;
					};
				};
				// -List
				class taskframe: cTab_RscFrame
				{
					idc = -1;
					sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
					text = "Task List : ";
					x = "((((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4)) + ((((((((1341)) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * ((safezoneH * 1.2) * 3/4)))";
					y = "((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))";
					w = "((((((1341)) - (20) * 2) - (10) * 3) / 3)) / 2048 * ((safezoneH * 1.2) * 3/4)";
					h = smalFmH;
				};
				
				//-9 line
				class CAS_TaskList_9: cTab_RscListbox_Tablet
				{
					idc = idc_D(2002);
					colorBackground[] = {0,0,0,0};
					show = 0;
					x = "((((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4)) + ((((((((1341)) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * ((safezoneH * 1.2) * 3/4)))";
					y = FrameDY + ContC;
					w = smalFmW;
					h = smalFmH - ContC;
					onLBSelChanged = (_this + [[17000+2002,17000+2005]]) call BCE_fnc_TaskList_Changed;
					class Items
					{
						class Game_plan
						{
							text = "#: Game Plan :";
							data = "Provide a short summary of how the attack is going to be performed.<br/><br/>1. Type of control (1,2 or3)<br/>2. Method (BOT/BOC)<br/>3. Ordnance requested on target";
							textRight = "NA";
							Expression_idc[] = {20110,2011,20111,20112,20113,2020,2021,2022,2023};
							multi_options = 1;
							default = 1;
							tooltip = "Game Plan";
						};
						class Line1: Game_plan
						{
							text = "1: IP/BP :";
							data = "“Alt + LMB” on the map to set marker<br/><br/>“Initial Point” or “Battle Position”.<br/><br/>IP for FW aircraft (Planes), the IP is the starting point for the run-in to the target. <br/><br/>BP for RW aircraft (Helis), the BP is where attacks on the target are commenced.";
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
							data = "Supplies additional important information.<br/><br/>1.<t underline='true'>Troops in Contact</t> or <t underline='true'>Danger Close</t><br/>2.Final Attack Heading (FAH) or altitude restrictions <br/>3.Threat <br/>5.Active gun target lines <br/>etc";
							tooltip = "Remarks/Restrictions";
							Expression_idc[] = {2200,2018,2014,2017,2201,2202};
						};
					};
				};
				//-5 line
				class CAS_TaskList_5: CAS_TaskList_9
				{
					idc = idc_D(2005);
					class Items: Items
					{
						class Line1: Game_plan
						{
							text = "1:  :";
							textRight = "NA";
							Expression_idc[] = {20110,2011,20111,20112,20113,2020,2021,2022,2023};
							multi_options = 1;
							default = 1;
							tooltip = "“Aircraft call sign” / “Yours”";
						};
						class Line2: Line1
						{
							text = "2: FRND/Mark :";
							data = "Friendly position (The closest one to the Target).<br/>GRID/TRP/bearing and range etc<br/><br/>Marked by (smoke/VS-17 panel/beacon/GLINT/IR strobe etc.)";
							tooltip = "Friendly";
							multi_options = 0;
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
							text = "4: DESC/Mark :";
							data = "Description of target<br/>Method used to mark ENY position. (IR, tracer etc)";
							tooltip = "Target Description/Mark method";
							Expression_idc[] = {2015,2016};
						};
						class Remark: Line2
						{
							text = "Remarks :";
							data = "Supplies additional important information.<br/><br/>1.<t underline='true'>Troops in Contact</t> or <t underline='true'>Danger Close</t><br/>2.Final Attack Heading (FAH) or altitude restrictions <br/>3.Threat <br/>5.Active gun target lines <br/>etc";
							tooltip = "Remarks/Restrictions";
							Expression_idc[] = {2200,2018,2014,2017,2201,2202};
						};
					};
				};
				
				class msgTxt: cTab_RscEdit_Tablet
				{
					idc = 18510;
					htmlControl = "true";
					style = 16;
					lineSpacing = 0.2;
					text = "No Message Selected";
					x = "(((( ((((257)) + (20)) + (10)) + (((((1341)) - (20) * 2) - (10) * 3) / 3) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))";
					y = "((((((((491) + (42)) + (10)) + (20)))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))";
					w = "(((((((1341)) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * ((safezoneH * 1.2) * 3/4)";
					h = "(((((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) - (10) - (20)) - (10) - (50))) / 2048  * 	(safezoneH * 1.2)";
					canModify = 0;
				};
				
				
				// ----------- Task Contents ----------- //
				
				#define ExpPOS(MULTIY,MULTIW,MULTIH) \
					x = FrameLX + smalFmW + (smalSpc / 2);\
					y = ((MULTIY + 1.2) * ConH) + FrameDY + (ConH / 3);\
					w = MULTIW * ContW;\
					h = MULTIH * ConH
					
				#define ExpBOX(MULTIY,MULTIH,MULTIW,OFFSETX) \
					x = (FrameLX + smalFmW + smalSpc) + (OFFSETX * (safezoneH/safezonew) * (safezoneH / 70));\
					y = ((MULTIY + 1.2) * ConH) + FrameDY + (ConH / 3);\
					w = MULTIW * (safezoneH/safezonew) * (safezoneH / 55);\
					h = MULTIH * (safezoneH / 55)
				
				//-Title
				class New_Task_Title: RscText
				{
					idc = idc_D(2003);
					text = "Task Title:";
					sizeEx = "0.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					x = "(((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4)) + (((((((1341)) - (20) * 2) - (10) * 3) / 3)) / 2048 * ((safezoneH * 1.2) * 3/4)) + (((((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))-((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))) / 2)";
					y = "(safezoneH / 60) + (((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))) + ((safezoneH / 60) / 3)";
					w = "(((((((1341)) - (20) * 2) - (10) * 3) / 3.1)) / 2048 * ((safezoneH * 1.2) * 3/4))";
					h = "safezoneH / 60";
					show = 0;
					colorBackground[] = {0,0,0,0};
				};
				
				//-Control Buttons
				class Clear_TaskInfo: RscButtonMenu
				{
					idc = idc_D(2106);
					style = 2;
					size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8";
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					x = FrameLX + smalFmW + (smalSpc / 2) + (0.5 * ContW);
					y = "(safezoneH / 60) + (((((((((491) + (42)) + (10)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - (10) * 3) / 2) + (10)) + (20))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))) + ((safezoneH / 60) / 3)";
					w = 0.5 * ContW;
					h = "safezoneH / 53";
					text = "Clear Task Info <img image='\a3\3den\data\cfg3den\history\deleteitems_ca.paa' align='Right' size='0.8' />";
					tooltip = "Clear Task Info";
					onButtonClick = "(_this + [false,'cTab_Tablet_dlg',17000]) call BCE_fnc_clearTaskInfo";
					
					shadow = 1;
					periodFocus = 0;
					class Attributes
					{
						font = "RobotoCondensed";
						color = "#E5E5E5";
						align = "left";
						shadow = "false";
					};
				};
				class CAS_UI_SendData: ctrlButton
				{
					idc = idc_D(2105);
					x = "(((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4)) + (((((((1341)) - (20) * 2) - (10) * 3) / 3)) / 2048 * ((safezoneH * 1.2) * 3/4)) + (((((((((257)) + (20)) + (10))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))-((((((257)) + (20))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))) / 2)";
					y = FrameDY + smalFmH - (safezoneH / 40);
					w = "1 * (((((((1341)) - (20) * 2) - (10) * 3) / 3.1)) / 2048 * ((safezoneH * 1.2) * 3/4))";
					h = "safezoneH / 40";
					text = "Send Data";
					font = "RobotoCondensed";
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					colorBackground[] = {0.5,0.5,0.5,0.5};
					onButtonClick = "call BCE_fnc_DataReceiveButton";
				};
				
				//-Game Plan
				class New_Task_CtrlType: RscToolbox
				{
					idc = idc_D(2011);
					ExpPOS(2.15,1,1);
					rows = 1;
					columns = 3;
					strings[] =
					{
						"Type 1",
						"Type 2",
						"Type 3"
					};
					colorBackground[] = {0,0,0,0.3};
					sizeEx = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class New_Task_Ctrl_Title: Clear_TaskInfo
				{
					idc = idc_D(20110);
					text = "Control Type: <img image='\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa' align='Right' size='0.8' />";
					colorBackground[] = {0,0,0,0.4};
					tooltip = "more details";
					onButtonClick = (_this + [17000+2004,'"cTab_Tablet_dlg" >> "controls" >> "Task_Builder" >> "controls"']) call BCE_fnc_ChangeTask_Desc;
					BCE_Desc = "Type 1 : <br/>JTAC can see target and Aircraft, and is for individual attacks.<br/><br/>Type 2 : <br/>JTAC can see either the target or the aircraft (one or the other, not both) and is for individual attacks he must have real time data for the target from FO (Forward Observer)/Scout.<br/><br/>Type 3 : <br/>Multiple attacks within a single engagement, JTAC can't see the aircraft but <t font='RobotoCondensedBold'>must have real time data</t> from FO/Scout.";
					ExpPOS(1,0.5,1);
					periodFocus = 0;
					periodOver = 0;
				};
				class New_Task_AttackType_Title: New_Task_Ctrl_Title
				{
					idc = idc_D(20111);
					text = "Attack Type: <img image='\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa' align='Right' size='0.8' />";
					BCE_Desc = "“Bomb on Target” / “Bomb on Coordinate” <br/><br/>BOC : <br/>GPS guided ammunitions. <br/>Ex. GBU-31 GBU-32 GBU-35 <br/><br/>BOT : <br/>Guns ,rockets and Laser guided ammunitions. <br/>Ex. Hydra70 GBU-12";
					ExpPOS(3.25,0.5,1);
				};
				class New_Task_AttackType: New_Task_CtrlType
				{
					idc = idc_D(20112);
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
					idc = idc_D(20113);
					text = "Request Ordnance: <img image='\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa' align='Right' size='0.8' />";
					BCE_Desc = "What ammunition will be droped. <br/>How many. <br/>How far. <br/>etc";
					ExpPOS(5.5,0.575,1);
				};
			
				//-IP
				class New_Task_IPtype: New_Task_CtrlType
				{
					idc = idc_D(2012);
					ExpPOS(1,1,1);
					rows = 1;
					columns = 3;
					strings[] =
					{
						"Map Marker",
						"Click Map “Alt + LMB”",
						"OverHead"
					};
					onToolBoxSelChanged = _this + [false,TASK_OFFSET] call BCE_fnc_ToolBoxChanged;
				};
				class New_Task_TGT: New_Task_IPtype
				{
					idc = idc_D(20121);
					columns = 2;
					strings[] =
					{
						"Map Marker",
						"Click Map “Alt + LMB”"
					};
				};
				class New_Task_MarkerCombo: RscCombo
				{
					idc = idc_D(2013);
					ExpPOS(2,0.5,1);
					show = 0;
					colorBackground[] = {0.5,0.5,0.5,0.6};
					colorSelectBackground[] = {0.5,0.5,0.5,0.6};
					//colorPictureSelected[] = {1,1,1,0};
					wholeHeight = 0.8;
					font = "PuristaMedium";
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
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
				class New_Task_IPExpression: RscEdit
				{
					idc = idc_D(2014);
					ExpPOS(2,0.5,1);
					text = "";
					canModify = 0;
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					show = 0;
					colorBackground[] = {0,0,0,0};
					tooltip = "This shows the input result";
				};
			
				//-TG Description
				class New_Task_TG_DESC: RscEditMulti
				{
					idc = idc_D(2015);
					ExpPOS(1,1,8);
					text = "";
					show = 0;
				};
			
				//-GRID
				class New_Task_GRID_DESC: RscEdit
				{
					idc = idc_D(2016);
					ExpPOS(1,1,1);
					text = "Mark with...";
					show = 0;
				};
			
				//-ERGS
				class New_Task_EGRS_Azimuth: New_Task_CtrlType
				{
					idc = idc_D(2017);
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
					sizeEx = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class New_Task_EGRS_Bearing: RscEdit
				{
					idc = idc_D(2018);
					ExpPOS(2,0.5,1);
					text = "Bearing...";
					show = 0;
				};
				class New_Task_EGRS: New_Task_IPtype
				{
					idc = idc_D(2019);
					columns = 4;
					strings[] =
					{
						"Azimuth",
						"Bearing",
						"Map Marker",
						"OverHead"
					};
					sizeEx = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
			
				//-Remarks
				class New_Task_FADH: New_Task_IPtype
				{
					idc = idc_D(2200);
					columns = 3;
					strings[] =
					{
						"FAD",
						"FAH",
						"Default"
					};
				};
				class New_Task_DangerClose_Text: RscText
				{
					idc = idc_D(2201);
					ExpBOX(4,1,17,1);
					text = ": Danger Close";
					show = 0;
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
				class New_Task_DangerClose_Box: RscCheckBox
				{
					idc = idc_D(2202);
					ExpBOX(4,1,1,0);
					show = 0;
				};
			
				//-Ordnance
				class AI_Remark_WeaponCombo: New_Task_MarkerCombo
				{
					idc = idc_D(2020);
					ExpPOS(6.65,0.5,1);
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
					onMouseButtonClick = "";
					onLBSelChanged = (_this + [TASK_OFFSET]) call BCE_fnc_CAS_SelWPN;
					class Items{};
				};
				class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
				{
					idc = idc_D(2021);
					onLBSelChanged = "";
				};
				class Attack_Range_Combo: AI_Remark_ModeCombo
				{
					idc = idc_D(2022);
					ExpPOS(7.65,0.5,1);
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
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
					idc = idc_D(2023);
					show = 0;
					text = "1";
					tooltip = "Round Count";
					sizeEx = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 18)";
				};
			};
		};
		
		class btnF2: cTab_Tablet_btnF2
		{
			tooltip = "AV Intel Live Feed - Quick Key";
		};
		class btnF4: cTab_Tablet_btnF4
		{
			tooltip = "Task Builder - Quick Key";
			action = "['cTab_Tablet_dlg',[['mode','TASK_Builder']]] call cTab_fnc_setSettings;";
		};
	};
};