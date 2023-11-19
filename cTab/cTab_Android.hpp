#define Android_BR_InfoY(HEIGHT) ((-(0) + (713) + (626)) - (20) - ((60) - (20))) / 2048  * (PhoneW * 4/3) + (safezoneY + (safezoneH - (PhoneW * 4/3)) / 2) - (HEIGHT * (((32)) / 2048 * PhoneW))
class cTab_android_on_screen_hookGrid: cTab_RscText_Android
{
	y = Android_BR_InfoY(3);
	h = (((42) - (10))) / 2048 * PhoneW;
	colorText[] = {0.95,0.95,0.95,1};
	sizeEx = ((27)) / 2048 * PhoneW;
};
class cTab_android_on_screen_hookElevation: cTab_android_on_screen_hookGrid
{
	y = Android_BR_InfoY(2);
};
class cTab_android_on_screen_hookDst: cTab_android_on_screen_hookGrid
{
	y = Android_BR_InfoY(1);
};
#undef Android_BR_InfoY
PHONE_CLASS
{
	#ifdef MOUSE_CLICK_EH
		TaskIDCs_List[] = {
			//- 9 Line
			{93,94,95,96,97,98,99,idc_D(2025),idc_D(2026),idc_D(20260),idc_D(2027),idc_D(20270),idc_D(2028),idc_D(2029),idc_D(2030),idc_D(2031),idc_D(2032)},
			//- 5 Line
			{51,52,53,idc_D(2040),idc_D(2041),idc_D(2042),idc_D(2043),idc_D(20430),idc_D(2044)}
		};
	#endif
	class controlsBackground
	{
		#ifdef MOUSE_CLICK_EH
			class screen: cTab_android_RscMapControl
			{
				onMouseButtonClick = MOUSE_CLICK_EH;
			};
		#endif
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
		#ifdef MOUSE_CLICK_EH
		
			//-SubMenu + lerGTD SubMenu + BCE Submenu
			cTab_Set_SubMenu(SubMenuH_P);
		
			delete menuContainer;
			//-BFT
			class Map_Tool_Show: ctrlButton
			{
				idc = idc_D(1200);
				style = "0x02 + 0x30 + 0x800";
				text = "a3\3den\data\displays\display3den\toolbar\map_off_ca.paa";
				colorBackground[] = {0,0,0,0.3};
				x = sizeX + ((((((1341)) - (10) * 8) / 7)) / 2048 * (PhoneW * 3/4)) - (sizeW * (PhoneW * 3/4));
				Y = sizeY(0) - (sizeW * PhoneW);
				w = sizeW * (PhoneW * 3/4);
				h = sizeW * PhoneW;
				tooltip = "Toggle Map Tools";
				action = "['cTab_Android_dlg'] call cTab_fnc_toggleMapTools;";
			};
			
			//-POLPOX Map Tools Widgets
			#if PLP_TOOL == 1
				class Map_Tool_Show_PLP_widgets: Map_Tool_Show
				{
					idc = idc_D(1202);
					//text = "a3\3den\data\displays\display3den\panelright\customcomposition_editentities_ca.paa";
					text = "a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa";
					toolTip = "MapTools Remastered";
					Y = sizeY(2.25) - (sizeW * PhoneW);
					action = "['cTab_Android_dlg','PLP_mapTools'] call cTab_fnc_toggleMapTools;";
				};
				class Map_Tool_PLP_widgets: RscToolbox
				{
					idc = idc_D(12012);
		
					Y = sizeY(5.25 + 2.25) - (sizeW * PhoneW);
					w = sizeW * (PhoneW * 3/4);
					h = 3 * (sizeW * PhoneW);
		
					rows = 6;
					columns = 1;
					strings[] =
					{
						"$STR_BCE_PLP_Title_Distance",
						"$STR_BCE_PLP_Title_Mark_House",
						"$STR_BCE_PLP_Title_Height",
						"$STR_BCE_PLP_Title_Compass",
						"$STR_BCE_PLP_Title_Edit_Grid",
						"$STR_BCE_PLP_Title_Find_Flat"
					};
					tooltips[] =
					{
						"$STR_BCE_PLP_Tip_Distance",
						"$STR_BCE_PLP_Tip_Mark_House",
						"$STR_BCE_PLP_Tip_Height",
						"$STR_BCE_PLP_Tip_Compass",
						"$STR_BCE_PLP_Tip_Edit_Grid",
						"$STR_BCE_PLP_Tip_Find_Flat"
					};
					colorBackground[] = {0,0,0,0.25};
					onToolBoxSelChanged = "call BCE_fnc_ctab_BFT_ToolBox";
				};
				
				//-Tool Description
				class BCE_MapTools_Tooltip: PLP_SMT_Description{};
			#endif
			
			//-Home Button
			class btnHome: cTab_android_btnHome
			{
				action = "['cTab_Android_dlg',[['mode','DESKTOP']]] call cTab_fnc_setSettings;";
				tooltip = "Desktop";
			};
		#endif
		
		//-Option Menu
		class ATAK_MenuBG: cTab_RscControlsGroup
		{
			idc = 4660;
			x = phoneSizeX + (phoneSizeW * 3/5);
			y = phoneSizeY;
			w = phoneSizeW * 2/5;
			h = phoneSizeH;
			class VScrollbar{};
			class HScrollbar{};
			class Scrollbar{};
			class controls
			{	
				class menuBackground: cTab_IGUIBack
				{
					idc = 9;
					x = 0;
					y = 0;
					w = "safezoneW";
					h = phoneSizeH;
					colorBackground[] = {0.2,0.2,0.2,0.5};
				};
			};
		};
		class ATAK_Tools: ATAK_MenuBG
		{
			idc = idc_D(4660);
			h = phoneSizeH - 0.75 * (((60)) / 2048 * (PhoneW * 4/3));
			class controls
			{
				#define PhoneBFTContainerW(AxisX) AxisX*((phoneSizeW * 2/5)/3)
				
				class actMSGtxt: BCE_RscButtonMenu
				{
					idc = 4660 + 100;
					style = "0x02 + 0x0C + 0x0100";
					shadow = 1;
					text = ATAK_APP(APP_MSG,Messages);
	
					x = 0;
					y = 0;
					w = PhoneBFTContainerW(1);
					h = (phoneSizeW * 3/5)/3;
					
					//-Style
					colorBackground[] = {0,0,0,0.5};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					animTextureDefault="#(argb,8,8,3)color(0,0,0,0)";
					animTextureNormal="#(argb,8,8,3)color(0,0,0,0)";
					animTextureOver = "#(argb,8,8,3)color(0,0,0,0.5)";
					animTextureFocused = "#(argb,8,8,3)color(0,0,0,0)";
					animTexturePressed = "#(argb,8,8,3)color(0,0,0,0.3)";
	
					action = "['cTab_Android_dlg',[['mode','MESSAGE']]] call cTab_fnc_setSettings;";
					
					#if TextTimes == 1
						textureNoShortcut=APP_MSG;
						class ShortcutPos
						{
							left = 0.85 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimes;
							top = (phoneSizeW * 3/5)/3/20;
							w = (phoneSizeW * 2/5)/5*1.1;
							h = (phoneSizeW * 3/5)/5;
						};
					#endif
					
					class TextPos
					{
						left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
						top = (phoneSizeW * 3/5)/3/20;
						right = 0.0049999999;
						bottom = 0;
					};
					
					class Attributes
					{
						valign = "bottom";
						font = "RobotoCondensed_BCE";
						color = "#E5E5E5";
						align = "center";
						shadow = 1;
						size = __EVAL(3/TextTimes);
					};
				};
				class actTKBtxt: actMSGtxt
				{
					idc = 4660 + 101;
					text = ATAK_APP("\a3\characters_f\data\ui\icon_expl_specialist_ca.paa",Missions);
					x = PhoneBFTContainerW(1);
					action = "['cTab_Android_dlg',[['showMenu',['mission',true,-1]]]] call cTab_fnc_setSettings;";
					
					#if TextTimes == 1
						textureNoShortcut="\a3\characters_f\data\ui\icon_expl_specialist_ca.paa";
					#endif
				};
				class actUAVtxt: actMSGtxt
				{
					idc = 4660 + 102;
					x = PhoneBFTContainerW(2);
					text = ATAK_APP("a3\weapons_f_orange\reticle\data\camera_ca.paa",AV Camera);
					action = "['cTab_Android_dlg',[['mode','UAV']]] call cTab_fnc_setSettings;";
					
					#if TextTimes == 1
						textureNoShortcut="a3\weapons_f_orange\reticle\data\camera_ca.paa";
						class ShortcutPos: ShortcutPos
						{
							left = 1.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimes;
							top = 2.5 * (phoneSizeW * 3/5)/3/20;
							w = (phoneSizeW * 2/5)/5*0.9;
							h = (phoneSizeW * 3/5)/5*0.8;
						};
					#endif
				};
				//-Second Line
				class actHCamtxt: actMSGtxt
				{
					idc = 4660 + 103;
					text = ATAK_APP("a3\3den\data\displays\display3den\entitymenu\movecamera_ca.paa",Helmet Cam);
					y = (phoneSizeW * 3/5)/3;
					action = "";
					
					#if TextTimes == 1
						textureNoShortcut="a3\3den\data\displays\display3den\entitymenu\movecamera_ca.paa";
					#endif
				};
				class actGrouptxt: actHCamtxt
				{
					idc = 4660 + 104;
					x = PhoneBFTContainerW(1);
					text = ATAK_APP("a3\3den\data\displays\display3den\panelright\modegroups_ca.paa",Groups);
					action = "";
					#if TextTimes == 1
						textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
					#endif
				};
				class actDashBoardtxt: actHCamtxt
				{
					idc = 4660 + 105;
					x = PhoneBFTContainerW(2);
					text = ATAK_APP("a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa",CheckList);
					action = "";
					
					#if TextTimes == 1
					textureNoShortcut="a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa";
					#endif
				};
				
				//-Thired Line
				class actWeathertxt: actMSGtxt
				{
					idc = 4660 + 106;
					y = 2*((phoneSizeW * 3/5)/3);
					text = ATAK_APP("a3\3den\data\displays\display3den\toolbar\intel_ca.paa",Weather);
					action = "";
					
					#if TextTimes == 1
						textureNoShortcut="a3\3den\data\displays\display3den\toolbar\intel_ca.paa";
					#endif
				};
				class actBDAtxt: actWeathertxt
				{
					idc = 4660 + 107;
					x = PhoneBFTContainerW(1);
					text = ATAK_APP("a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",Damage Assessment);
					action = "";
					
					#if TextTimes == 1
						textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
					#endif
				};
				
				class actSettingtxt: actUAVtxt
				{
					idc = 4660 + 108;
					y = 2*((phoneSizeW * 3/5)/3);
					x = PhoneBFTContainerW(2);
					text = ATAK_APP("a3\weapons_f_orange\reticle\data\settings_ca.paa",Settings);
					action = "";
					
					#if TextTimes == 1
						textureNoShortcut="a3\weapons_f_orange\reticle\data\settings_ca.paa";
					#endif
				};
			};
		};
		
		//-Realistic ATAK
		#define ATAK_POS(XPOS,YPOS,WPOS,HPOS) \
			x = PhoneBFTContainerW(XPOS); \
			y = YPOS * ((60)) / 2048 * (PhoneW * 4/3); \
			w = PhoneBFTContainerW(WPOS); \
			h = HPOS * (((60)) / 2048 * (PhoneW * 4/3))
		class Task_Builder: ATAK_Tools
		{
			idc = idc_D(4661);
			class VScrollbar
			{
				scrollSpeed=0.08;
			};
			class controls
			{
				
				class Game_Plan_T: RscText
				{
					idc = -1;
					shadow=2;
					text="Game Plan";
					sizeEx = TextSize;
					ATAK_POS(0,0,1,1);
					font = "RobotoCondensed_BCE";
					colorBackground[] = {0,0,0,0};
					colorText[]={1,0.737255,0.0196078,1};
					tooltip="$STR_BCE_TIP_GAMEPLAN";
				};
				
				//-Task Type
				class TaskType: RscCombo
				{
					idc = idc_D(2107);
					ATAK_POS(1,0.35/2,1.9,0.65);
					
					wholeHeight = 0.8;
					sizeEx = 0.9 * TextSize;
					font = "PuristaMedium";
					
					colorBackground[] = {0,0,0,1};
					colorSelect[]={1,1,1,1};
					colorSelectBackground[]={0.2,0.2,0.2,1};
					
					onLBSelChanged = "call BCE_fnc_ATAK_TaskTypeChanged";
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
				
				class CtrlType: Game_Plan_T
				{
					text="Type";
					ATAK_POS(0,1.1,1,0.8);
					sizeEx = TextSize;
					tooltip="$STR_BCE_TIP_CtrlType";
				};
				
				//-MOA
				class New_Task_CtrlType: RscToolbox
				{
					idc = idc_D(2011);
					ATAK_POS(0.5,(1 + (0.35/2)),1.2,0.65);
					rows = 1;
					columns = 3;
					strings[] =
					{
						"T1",
						"T2",
						"T3"
					};
					font = "RobotoCondensed_BCE";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = 0.9 * TextSize;
				};
				class MOA_T: Game_Plan_T
				{
					text="MOA";
					sizeEx = 0.85 * TextSize;
					ATAK_POS(1.8,(1 + (0.35/2)),0.4,0.65);
					tooltip="$STR_BCE_TIP_MOA";
				};
				class MOA_Combo: TaskType
				{
					idc = idc_D(20112);
					ATAK_POS(2.2,(1 + (0.35/2)),0.7,0.65);
					
					colorBackground[] = {0.3,0.3,0.3,1};
					colorSelect[]={1,1,1,1};
					colorSelectBackground[]={0.4,0.4,0.4,1};
					
					class Items
					{
						class BoT
						{
							text = "BoT";
							textRight = "";
							value = 0;
							default = 1;
						};
						class BoC
						{
							text = "BoC";
							textRight = "";
							value = 1;
						};
					};
				};

				//-Weapons Selections
				class Weapon_T: CtrlType
				{
					text="Weapon";
					ATAK_POS(0,(2 + (0.35/2)),1,0.63);
					tooltip="$STR_BCE_TIP_Weapon";
				};
				class AI_Remark_WeaponCombo: MOA_Combo
				{
					idc = idc_D(2020);
					ATAK_POS(0.7,(2 + (0.35/2)),1.1,0.65);
					sizeEx = 0.9 * TextSize;
					onMouseButtonClick = "";
					onLBSelChanged = "call BCE_fnc_CAS_SelWPN";
					class Items{};
				};
				class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
				{
					idc = idc_D(2021);
					ATAK_POS(1.8,(2 + (0.35/2)),1.1,0.63);
					onLBSelChanged = "";
				};
				class Attack_Range_Combo: AI_Remark_ModeCombo
				{
					idc = idc_D(2022);
					ATAK_POS(0.7,(2.65 + (0.35/2)),1.1,0.63);
					tooltip = "$STR_BCE_tip_Attack_Range";
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
					ATAK_POS(1.8,(2.65 + (0.35/2)),(1.1/3),0.63);
					Style = 2;
					text = "1";
					sizeEx = 0.9 * TextSize;
					tooltip = "$STR_BCE_tip_Round_Count";
				};
				class Attack_Height_Box: Round_Count_Box
				{
					idc = idc_D(2024);
					ATAK_POS((1.8 + (1.1/3)),(2.65 + (0.35/2)),(2.2/3),0.63);
					tooltip = "$STR_BCE_tip_Attack_Height";
					text = "2000";
				};
				
				//-1~3 lines
				class IP2TG_T9: CtrlType
				{
					idc = 93;
					text="1-3";
					ATAK_POS(0,(3.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_IPBP_Info";
				};
				class IP2TG_EditBnt: BCE_RscButtonMenu
				{
					idc = idc_D(2025);
					ATAK_POS(0.4,(3.6 + (0.35/2)),2.5,0.7);
					sizeEx = TextSize;
					text = "T1 , 360° , 1200m";
					tooltip="$STR_BCE_TIP_IPBP_Info";
					
					//-Style
					colorBackground[] = {0,0,0,0.5};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					animTextureDefault="#(argb,8,8,3)color(0,0,0,0.8)";
					animTextureNormal="#(argb,8,8,3)color(0,0,0,0.8)";
					animTextureOver = "#(argb,8,8,3)color(0,0,0,0.5)";
					animTextureFocused = "#(argb,8,8,3)color(0,0,0,0.8)";
					animTexturePressed = "#(argb,8,8,3)color(0,0,0,0.3)";
					
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,1]]]] call cTab_fnc_setSettings;";
					
					class Attributes: Attributes
					{
						align = "center";
						font = "RobotoCondensedBold_BCE";
						size = TextMenu(1);
					};
				};

				//-Line 4
				class Line4_T9: CtrlType
				{
					idc = 94;
					text="4";
					ATAK_POS(0,(4.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_ELEV";
				};
				class L94_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2026);
					ATAK_POS(0.2,(4.6 + (0.35/2)),2.3,0.7);
					text = "535ft MSL";
					tooltip="$STR_BCE_TIP_ELEV";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,4]]]] call cTab_fnc_setSettings;";
				};
				class L94_PullBnt: ctrlButton
				{
					idc = idc_D(20260);
					ATAK_POS(2.55,(4.6 + (0.35/2)),0.35,0.7);
					
					style = "0x02 + 0x30 + 0x800";
					colorBackground[] = {0.1,0.1,0.1,0.75};
					sizeEx = 0.85 * TextSize;
					
					tooltip = "Show Info";
					text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
				};

				//-Line 5
				class Line5_T9: CtrlType
				{
					idc = 95;
					text="5";
					ATAK_POS(0,(5.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_DESC";
				};
				//-Task Type
				class L95_EditBnt: RscCombo
				{
					idc = idc_D(2027);
					ATAK_POS(0.2,(5.6 + (0.35/2)),2.3,0.7);
					
					wholeHeight = 0.8;
					sizeEx = 0.9 * TextSize;
					font = "PuristaMedium";
					tooltip="$STR_BCE_TIP_DESC";
					
					style="0x10 + 0x200 + 0x02";
					colorText[] = {1,1,1,1};
					colorBackground[]={0,0,0,0.75};
					colorSelect[]={1,1,1,1};
					colorSelectBackground[]={0.2,0.2,0.2,1};
					
					onLBSelChanged = "call BCE_fnc_ATAK_DescType_Changed";
					class Items
					{
						class Custom
						{
							text = "Custom Description";
							textRight = "";
							value = 0;
							default = 1;
						};
						class Open
						{
							text = "In the open";
							textRight = "";
							value = 1;
							color[]={0.65,0.65,0.65,1};
						};
						class Cover: Open
						{
							text = "Under Cover";
							value = 2;
						};
						class treeline: Open
						{
							text = "In treeline";
							value = 3;
						};
						class Hardstructure: Open
						{
							text = "Hardstructure";
							value = 4;
						};
					};
				};
				class L95_PullBnt: L94_PullBnt
				{
					idc = idc_D(20270);
					ATAK_POS(2.55,(5.6 + (0.35/2)),0.35,0.7);
				};
				class L95_EditText: RscEdit
				{
					idc = idc_D(2028);
					sizeEx = 0.9 * TextSize;
					ATAK_POS(0.15,(6.5 + (0.35/2)),2.75,0.9);
					colorText[] = {0.75,0.75,0.75,1};
					colorBackground[]={0,0,0,0.5};
					tooltip="$STR_BCE_TIP_AddDESC";
				};
				
				//-Line 6
				class Line6_T9: CtrlType
				{
					idc = 96;
					text="6";
					ATAK_POS(0,(7.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_GRID";
				};
				class L96_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2029);
					ATAK_POS(0.2,(7.6 + (0.35/2)),2.7,0.7);
					text = "XT 123456";
					tooltip="$STR_BCE_TIP_GRID";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,6]]]] call cTab_fnc_setSettings;";
				};
				
				//-Line 7
				class Line7_T9: CtrlType
				{
					idc = 97;
					text="7";
					ATAK_POS(0,(8.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_MARK";
				};
				class L97_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2030);
					ATAK_POS(0.2,(8.6 + (0.35/2)),2.7,0.7);
					text = "NO MARKS";
					tooltip="$STR_BCE_TIP_MARK";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,7]]]] call cTab_fnc_setSettings;";
				};
				
				//-Line 8
				class Line8_T9: CtrlType
				{
					idc = 98;
					text="8";
					ATAK_POS(0,(9.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_FRND";
				};
				class L98_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2031);
					ATAK_POS(0.2,(9.6 + (0.35/2)),2.7,0.7);
					text = "None";
					tooltip="$STR_BCE_TIP_FRND";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,8]]]] call cTab_fnc_setSettings;";
				};
				//-Line 9
				class Line9_T9: CtrlType
				{
					idc = 99;
					text="9";
					ATAK_POS(0,(10.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_EGRS";
				};
				class L99_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2032);
					ATAK_POS(0.2,(10.6 + (0.35/2)),2.7,0.7);
					text = "Back To IP";
					tooltip="$STR_BCE_TIP_EGRS";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,9]]]] call cTab_fnc_setSettings;";
				};

				////////// -5 Line //////////
				class Line1_T5: CtrlType
				{
					idc = 51;
					text="1";
					ATAK_POS(0,(3.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_5Line";
				};
				class L51_EditBnt: RscStructuredText
				{
					idc = idc_D(2040);
					ATAK_POS(0.2,(3.6 + (0.35/2)),2.7,0.7);
					colorBackground[] = {0.2,0.2,0.2,0.5};
					
					text = "“Alpha 1-1” / “Alpha 1-2”";
					tooltip="$STR_BCE_TIP_5Line";
					
					class Attributes
					{
						align = "center";
						font = "RobotoCondensedBold_BCE";
						size = TextMenu(1);
					};
				};
				
				class Line2_T5: CtrlType
				{
					idc = 52;
					text="2";
					ATAK_POS(0,(4.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_FRND";
				};
				class L52_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2041);
					ATAK_POS(0.2,(4.6 + (0.35/2)),2.7,0.7);
					text = "None";
					tooltip="$STR_BCE_TIP_FRND";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,1]]]] call cTab_fnc_setSettings;";
				};
				
				class Line3_T5: CtrlType
				{
					idc = 52;
					text="3";
					ATAK_POS(0,(5.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_GRID";
				};
				class L53_EditBnt: IP2TG_EditBnt
				{
					idc = idc_D(2042);
					ATAK_POS(0.2,(5.6 + (0.35/2)),2.7,0.7);
					text = "None";
					tooltip="$STR_BCE_TIP_GRID";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,2]]]] call cTab_fnc_setSettings;";
				};
				
				class Line4_T5: CtrlType
				{
					idc = 53;
					text="4";
					ATAK_POS(0,(6.6 + (0.35/2)),1,0.7);
					tooltip="$STR_BCE_TIP_DESC";
				};
				class L54_EditBnt: L95_EditBnt
				{
					idc = idc_D(2043);
					ATAK_POS(0.2,(6.6 + (0.35/2)),2.3,0.7);
					tooltip="$STR_BCE_TIP_DESC";
				};
				class L54_PullBnt: L94_PullBnt
				{
					idc = idc_D(20430);
					ATAK_POS(2.55,(6.6 + (0.35/2)),0.35,0.7);
				};
				class L54_EditText: RscEdit
				{
					idc = idc_D(2044);
					sizeEx = 0.9 * TextSize;
					ATAK_POS(0.15,(7.5 + (0.35/2)),2.75,0.9);
					colorText[] = {0.75,0.75,0.75,1};
					colorBackground[]={0,0,0,0.5};
					tooltip="$STR_BCE_TIP_AddDESC";
				};
				
				////// -Separator for Remarks //////
				class Separator: cTab_RscFrame
				{
					idc=3000;
					ATAK_POS(0.1,(11.65 + (0.35/2)),2.8,0.001);
				};
				
				class Remark: Game_Plan_T
				{
					idc=3001;
					text="Remarks/Restrictions";
					ATAK_POS(0,(11.7 + (0.35/2)),3,1);
					sizeEx = 0.9 * TextSize;
					font = "RobotoCondensedBold_BCE";
					tooltip="$STR_BCE_TIP_Remarks";
				};
				class AddRemark: ctrlButton
				{
					idc=3002;
					ATAK_POS((2.4+0.15/2),(11.8 + (0.35/2)),0.4,0.7);
					
					style = "0x02 + 0x30 + 0x800";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = 0.85 * TextSize;
					
					tooltip = "$STR_BCE_TIP_AddRemark";
					text = "a3\3den\data\displays\display3den\panelleft\entitylist_layer_ca.paa";
				};
			};
		};
		
		//- Task building Components
		class Task_Building: Task_Builder
		{
			idc = idc_D(4662);
			class VScrollbar
			{
				scrollSpeed=0;
			};
			class controls
			{
				//-Description
				class taskDesc: RscStructuredText
				{
					idc = idc_D(2004);
					text = "Desc :";
					colorBackground[] = {0,0,0,0};
					ATAK_POS(0,0,3,1);
					size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
					class Attributes
					{
						font = "RobotoCondensed_BCE";
						color = "#ffffff";
						align = "left";
						shadow = 1;
						size = TextMenu(0.95);
					};
				};
				
				class Indicator: RscText
				{
					idc = idc_D(2011);
					
					x = PhoneBFTContainerW(0.1);
					y = 0.1 * ((60)) / 2048 * (PhoneW * 4/3);
					w = PhoneBFTContainerW(3);
					h = phoneSizeH - 0.75 * (((60)) / 2048 * (PhoneW * 4/3));
				};
				
				//-IP
				class New_Task_IPtype: RscToolbox
				{
					idc = idc_D(2012);
					ATAK_POS(0.1,0.35/2,2.8,0.65);
					
					rows = 1;
					columns = 3;
					strings[] =
					{
						"$STR_BCE_Tit_Map_marker",
						"$STR_BCE_Tit_Click_Map",
						"$STR_BCE_Tit_OverHead"
					};
					
					font = "RobotoCondensed_BCE";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = 0.9 * TextSize;
					
					onToolBoxSelChanged = _this + [false,TASK_OFFSET,'cTab_Android_dlg'] call BCE_fnc_ToolBoxChanged;
				};
				class New_Task_MarkerCombo: RscCombo
				{
					idc = idc_D(2013);
					ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
					colorBackground[] = {0.5,0.5,0.5,0.6};
					colorSelectBackground[] = {0.5,0.5,0.5,0.6};
					//colorPictureSelected[] = {1,1,1,0};
					wholeHeight = 0.8;
					font = "PuristaMedium";
					sizeEx = 0.85 * TextSize;
					onMouseButtonClick = "(_this # 0) call BCE_fnc_IPMarkers;";
					class Items
					{
						class NA
						{
							text = "$STR_BCE_SelectMarker";
							data = "[]";
							default = 1;
						};
					};
				};
				class New_Task_IPExpression: RscEdit
				{
					idc = idc_D(2014);
					ATAK_POS(1.5,(0.65 + 0.35/2),1.3,0.65);
					text = "";
					canModify = 0;
					sizeEx = 0.85 * TextSize;
					colorBackground[] = {0,0,0,0};
					tooltip = "$STR_BCE_tip_ShowResult";
				};
				
				//-TG Description
				class New_Task_TGT: New_Task_IPtype
				{
					idc = idc_D(20121);
					columns = 2;
					strings[] =
					{
						"$STR_BCE_Tit_Map_marker",
						"$STR_BCE_Tit_Click_Map"
					};
				};
				class New_Task_TG_DESC: RscEditMulti
				{
					idc = idc_D(2015);
					ATAK_POS(0.1,0.35/2,2.8,0.65*3);
					text = "";
				};

				//-Mark
				class New_Task_GRID_DESC: RscEdit
				{
					idc = idc_D(2016);
					ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
					text = "$STR_BCE_MarkWith";
				};

				//-ERGS
				class New_Task_EGRS_Azimuth: RscToolbox
				{
					idc = idc_D(2017);
					ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
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
					font = "RobotoCondensed_BCE";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = 0.85 * TextSize;
				};
				class New_Task_EGRS_Bearing: RscEdit
				{
					idc = idc_D(2018);
					ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
					text = "$STR_BCE_Bearing_ENT";
				};
				class New_Task_EGRS: New_Task_IPtype
				{
					idc = idc_D(2019);
					columns = 4;
					strings[] =
					{
						"$STR_BCE_Tit_Azimuth",
						"$STR_BCE_Tit_Bearing",
						"$STR_BCE_Tit_Map_marker",
						"$STR_BCE_Tit_OverHead"
					};
					sizeEx = 0.85 * TextSize;
				};

				//-Remarks
				/*class New_Task_FADH: New_Task_IPtype
				{
					idc = idc_D(2200);
					columns = 3;
					strings[] =
					{
						"FAD",
						"FAH",
						"$STR_BCE_Default"
					};
				};
				class New_Task_DangerClose_Text: RscText
				{
					idc = idc_D(2201);
					ATAK_POS(0.12,(0.35/2 + 0.65*3),2.8,0.65);
					text = ": Danger Close";
					sizeEx = 0.7 * TextSize;
				};
				class New_Task_DangerClose_Box: RscCheckBox
				{
					idc = idc_D(2202);
					textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					ATAK_POS(0,(0.35/2 + 0.65*3),0.1,0.1);
				};*/
			};
		};
			
		//-Bottons for ATAK Tools
		class InputButtons: ATAK_MenuBG
		{
			idc = 46600;
			y = phoneSizeY + phoneSizeH - (0.75 * (((60)) / 2048 * (PhoneW * 4/3)));
			h = 0.75 * (((60)) / 2048 * (PhoneW * 4/3));
			class controls
			{
				class Back: ctrlButton
				{
					idc = 10;
					text = "Back";
					sizeEx = TextSize;
					x = 0;
					y = 0;
					w = PhoneBFTContainerW(2);
					h = 0.64 * (((60)) / 2048 * (PhoneW * 4/3));
					action = "call BCE_fnc_ATAK_LastPage";
				};
			};
		};
		
		//-Color Select
		class MarkerColor: RscCombo
		{
			idc = idc_D(1090);
			
			PhoneMarkerColor;
			colorBackground[]={0.3,0.3,0.3,1};
			
			colorSelect[]={1,1,1,1};
			colorSelectBackground[]={0.2,0.2,0.2,1};
			
			onLBSelChanged = "['cTab_Android_dlg',[['markerColor',_this # 1]]] call cTab_fnc_setSettings;";
		};
		
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
					text = "$STR_BCE_SwitchList";
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
					tooltip = "$STR_BCE_NextTurret";
					sizeEx = TextSize;

					action = "";
					onButtonClick = "(_this + [17000,true]) call BCE_fnc_NextTurretButton;";

					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW) + (0.75 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
					w = (0.25 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
				};
				class Connect_Vic: cTab_RscButton
				{
					idc = idc_D(17);
					text = "$STR_BCE_Live_Feed";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * (PhoneW * 4/3);
					action = "call cTab_Tablet_btnACT;";
				};
			};
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
					x = ((((((452) + (20)) + (10))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * (PhoneW * 4/3);
					onLBSelChanged = "_this call cTab_msg_get_mailTxt;";
				};
				class msgframe: cTab_RscFrame
				{
					idc = 16;
					text = "Read Message";
					x = (((((452) + (20))) - ((452))) / 2048 * PhoneW);
					y = (((((713) + (60) + (10))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = (((PHONE_MOD) - (20) * 2)) / 2048 * PhoneW;
					h = (((626) - (60) - (10) * 2)) / 2048 * (PhoneW * 4/3);
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
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
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
					x = ((((((452) + (20)))) - ((452))) / 2048 * PhoneW);
					y = ((((((713) + (60) + (10)))) - ((713) + (60))) / 2048 * (PhoneW * 4/3));
					w = ((((PHONE_MOD) - (20) * 2))) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2))) / 2048 * (PhoneW * 4/3);
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
