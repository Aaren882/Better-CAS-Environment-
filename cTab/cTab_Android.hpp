#define Android_BR_InfoY(HEIGHT) ((-(0) + (713) + (626)) - (20) - ((60) - (20))) / 2048  * (PhoneW * 4/3) + (safezoneY + (safezoneH - (PhoneW * 4/3)) / 2) - (HEIGHT * (((32)) / 2048 * PhoneW))
#ifdef MOUSE_CLICK_EH
	class cTab_android_on_screen_hookGrid: cTab_RscText_Android
	{
		x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (1 - 1))) / 2048  * 	PhoneW + 	CustomPhoneX;
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
#endif
#undef Android_BR_InfoY

//-Edited Origins
class cTab_android_on_screen_dirOctant: cTab_Tablet_OSD_dirOctant
{
	x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (0.35))) / 2048 * PhoneW + CustomPhoneX;
	y = ((713) + ((60) - (38)) / 2) / 2048 * CustomPhoneH + CustomPhoneY;
	w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
	h = ((40)) / 2048 * CustomPhoneH;
	
	action = "['cTab_Android_dlg'] call cTab_fnc_toggleWeather";
	
	size = 0.8 * ((((60) - (20))) / 2048 * CustomPhoneH);
	
	class TextPos
	{
		left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
		top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
		right = 0;
		bottom = 0;
	};
	
	class Attributes: Attributes
	{
		size = TextMenu(0.9);
	};
};

//-ATAK Menu W
#define PhoneBFTContainerW(AxisX) AxisX*((phoneSizeW * 2/5)/3)

#define ATAK_POS(XPOS,YPOS,WPOS,HPOS) \
	x = PhoneBFTContainerW(XPOS); \
	y = YPOS * ((60)) / 2048 * CustomPhoneH; \
	w = PhoneBFTContainerW(WPOS); \
	h = HPOS * (((60)) / 2048 * CustomPhoneH)

PHONE_CLASS
{
	#ifdef MOUSE_CLICK_EH
		TaskIDCs_List[] = {
			//- 9 Line
			{93,94,95,96,97,98,99,idc_D(2025),idc_D(2026),idc_D(20260),idc_D(2027),idc_D(20270),idc_D(2015),idc_D(2029),idc_D(2030),idc_D(2031),idc_D(2032)},
			//- 5 Line
			{51,52,53,54,idc_D(2040),idc_D(2041),idc_D(2042),idc_D(2043),idc_D(20430),idc_D(2015),idc_D(2016)}
		};
		onMouseZChanged = "call BCE_fnc_ATAK_getScrollValue";
	#endif
	class controlsBackground
	{
		
		class screen: cTab_android_RscMapControl
		{
			#ifdef MOUSE_CLICK_EH
				onMouseButtonClick = MOUSE_CLICK_EH;
				//onMouseButtonDblClick = "call cTab_fnc_Interaction_Menu";
			#endif
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
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
		};
		class Vic_PIP_Display: RscPicture
		{
			idc = idc_D(4632);
			text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";

			x = phoneSizeX + (((((((452) + (20)) + (10)) + ((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) + (10))) - ((452))) / 2048 * PhoneW);
			y = phoneSizeY + (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
			w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
			h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
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
				action = "['cTab_Android_dlg'] call cTab_fnc_toggleMapTools";
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
					h = 3.5 * (sizeW * PhoneW);
		
					rows = 7;
					columns = 1;
					strings[] =
					{
						"$STR_BCE_PLP_Title_Distance",
						"$STR_BCE_PLP_Title_Mark_House",
						"$STR_BCE_PLP_Title_Height",
						"$STR_BCE_PLP_Title_Compass",
						"$STR_BCE_PLP_Title_Edit_Grid",
						"$STR_BCE_PLP_Title_Find_Flat",
						"$STR_BCE_PLP_Title_Line_of_Sight"
					};
					tooltips[] =
					{
						"$STR_BCE_PLP_Tip_Distance",
						"$STR_BCE_PLP_Tip_Mark_House",
						"$STR_BCE_PLP_Tip_Height",
						"$STR_BCE_PLP_Tip_Compass",
						"$STR_BCE_PLP_Tip_Edit_Grid",
						"$STR_BCE_PLP_Tip_Find_Flat",
						"$STR_BCE_PLP_Tip_Line_of_Sight"
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
			h = phoneSizeH - 0.75 * (((60)) / 2048 * CustomPhoneH);
			class controls
			{
				class actMSGtxt: BCE_RscButtonMenu
				{
					idc = 4660 + 100;
					style = "0x02 + 0x0C + 0x0100";
					shadow = 1;
					text = ATAK_APP("MG8\AVFEVFX\data\mail.paa",Messages);
	
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
					
					size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
					action = "['cTab_Android_dlg',[['mode','MESSAGE']]] call cTab_fnc_setSettings;";
					
					textureNoShortcut=APP_MSG;
					class ShortcutPos
					{
						left = 0.75 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
						top = (phoneSizeW * 3/5)/3*0.18;
						w = (phoneSizeW * 2/5)/5*1.1;
						h = (phoneSizeW * 3/5)/5;
					};

					class TextPos
					{
						left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
						top = ((phoneSizeW * 3/5)/3*0.18) + ((phoneSizeW * 3/5)/5);
						right = 0;
						bottom = 0;
					};
					
					
					class Attributes
					{
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
					text = ATAK_APP("MG8\AVFEVFX\data\missions.paa",Missions);
					x = PhoneBFTContainerW(1);
					action = "['cTab_Android_dlg',[['showMenu',['mission',true,-1]]]] call cTab_fnc_setSettings;";
					
					textureNoShortcut="MG8\AVFEVFX\data\missions.paa";
				};
				class actUAVtxt: actMSGtxt
				{
					idc = 4660 + 102;
					x = PhoneBFTContainerW(2);
					text = ATAK_APP("MG8\AVFEVFX\data\AV_Cam.paa",AV Camera);
					action = "['cTab_Android_dlg',[['mode','UAV']]] call cTab_fnc_setSettings;";
					
					textureNoShortcut="MG8\AVFEVFX\data\AV_Cam.paa";
					/*class ShortcutPos: ShortcutPos
					{
						left = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
						//top = 2.5 * (phoneSizeW * 3/5)/3*0.18;
						w = (phoneSizeW * 2/5)/5*0.9;
						h = (phoneSizeW * 3/5)/5*0.8;
					};*/
				};
				//-Second Line
				class actPhototxt: actMSGtxt
				{
					idc = 4660 + 103;
					y = (phoneSizeW * 3/5)/3;
					text = ATAK_APP("MG8\AVFEVFX\data\photo.paa", Take Pictures);
					action = "call cTab_fnc_close; 557 cutRsc ['BCE_PhoneCAM_View','PLAIN',0.3,false];";
					
					textureNoShortcut="MG8\AVFEVFX\data\photo.paa";
				};
				class actGrouptxt: actPhototxt
				{
					idc = 4660 + 104;
					x = PhoneBFTContainerW(1);
					text = ATAK_APP("a3\3den\data\displays\display3den\panelright\modegroups_ca.paa",Groups);
					action = "";
					textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
				};
				class actHCamtxt: actPhototxt
				{
					idc = 4660 + 105;
					text = ATAK_APP("MG8\AVFEVFX\data\Hcam.paa",Helmet Cam);
					x = PhoneBFTContainerW(2);
					action = "";
					
					textureNoShortcut="MG8\AVFEVFX\data\Hcam.paa";
				};
				
				//-Thired Line
				class actWeathertxt: actMSGtxt
				{
					idc = 4660 + 106;
					y = 2*((phoneSizeW * 3/5)/3);
					text = ATAK_APP("a3\3den\data\displays\display3den\toolbar\intel_ca.paa",Weather);
					action = "";
					
					textureNoShortcut="a3\3den\data\displays\display3den\toolbar\intel_ca.paa";
				};
				class actBDAtxt: actWeathertxt
				{
					idc = 4660 + 107;
					x = PhoneBFTContainerW(1);
					text = ATAK_APP("a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",BDA Report);
					action = "";
					
					textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
				};
				
				class actSettingtxt: actUAVtxt
				{
					idc = 4660 + 108;
					y = 2*((phoneSizeW * 3/5)/3);
					x = PhoneBFTContainerW(2);
					text = ATAK_APP("MG8\AVFEVFX\data\settings.paa",Settings);
					action = "";
					
					textureNoShortcut="MG8\AVFEVFX\data\settings.paa";
				};
			};
		};
		
		//-Realistic ATAK
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
					onToolBoxSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
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
					
					onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
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
					ATAK_POS(0.7,(2 + (0.35/2)),1.5,0.65);
					sizeEx = 0.9 * TextSize;
					onLBSelChanged = "(_this + [17000]) call BCE_fnc_CAS_SelWPN; call BCE_fnc_ATAK_AutoSaveTask;";
					class Items{};
				};
				class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
				{
					idc = idc_D(2021);
					ATAK_POS(2.2,(2 + (0.35/2)),0.7,0.63);
					onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
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
					onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
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

					size = 0.7 * (((60) - (20))) / 2048 * CustomPhoneH;
					
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,1]]]] call cTab_fnc_setSettings;";
					
					class Attributes: Attributes
					{
						align = "center";
						font = "RobotoCondensedBold_BCE";
						size = TextMenu(1);
					};
					class TextPos
					{
						left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
						top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
						right = 0;
						bottom = 0;
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
					ATAK_POS(0.2,(4.6 + (0.35/2)),2.7,0.7);
					text = "535ft MSL";
					tooltip="$STR_BCE_TIP_ELEV";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,4]]]] call cTab_fnc_setSettings;";
				};
				/*class L94_PullBnt: ctrlButton
				{
					idc = idc_D(20260);
					ATAK_POS(2.55,(4.6 + (0.35/2)),0.35,0.7);
					
					style = "0x02 + 0x30 + 0x800";
					colorBackground[] = {0.1,0.1,0.1,0.75};
					sizeEx = 0.85 * TextSize;
					
					tooltip = "Show Info";
					text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
					action = "4 call BCE_fnc_ATAK_PullData";
				};*/

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
							text = "$STR_BCE_DESC_Custom";
							textRight = "";
							value = 0;
							default = 1;
						};
						class Open
						{
							text = "$STR_BCE_DESC_Open";
							textRight = "";
							value = 1;
							color[]={0.65,0.65,0.65,1};
						};
						class Cover: Open
						{
							text = "$STR_BCE_DESC_Cover";
							value = 2;
						};
						class treeline: Open
						{
							text = "$STR_BCE_DESC_treeline";
							value = 3;
						};
						class Hardstructure: Open
						{
							text = "$STR_BCE_DESC_Hardstructure";
							value = 4;
						};
					};
				};
				class L95_PullBnt: ctrlButton
				{
					idc = idc_D(20260);
					ATAK_POS(2.55,(5.6 + (0.35/2)),0.35,0.7);
					
					style = "0x02 + 0x30 + 0x800";
					colorBackground[] = {0.1,0.1,0.1,0.75};
					sizeEx = 0.85 * TextSize;
					
					tooltip = "$STR_BCE_ATAK_Show_Info";
					text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
					action = "6 call BCE_fnc_ATAK_PullData";
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
					
					size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
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
					idc = 53;
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
					idc = 54;
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
				class L54_PullBnt: L95_PullBnt
				{
					idc = idc_D(20430);
					ATAK_POS(2.55,(6.6 + (0.35/2)),0.35,0.7);
					action = "2 call BCE_fnc_ATAK_PullData";
				};
				
				//-Text EditBox
				class New_Task_TG_DESC: RscEdit
				{
					idc = idc_D(2015);
					sizeEx = 0.9 * TextSize;
					ATAK_POS(0.15,(6.5 + (0.35/2)),2.75,0.7);
					
					colorText[] = {0.75,0.75,0.75,1};
					colorBackground[]={0,0,0,0.5};
					tooltip="$STR_BCE_TIP_AddDESC";
					onEditChanged = "(_this + [0]) call BCE_fnc_ATAK_AutoSaveTask";
				};
				class New_Task_GRID_DESC: New_Task_TG_DESC
				{
					idc = idc_D(2016);
					ATAK_POS(0.15,(8.2 + (0.35/2)),2.75,0.7);
					
					text = "$STR_BCE_MarkWith";
					tooltip="";
					onEditChanged = "(_this + [1]) call BCE_fnc_ATAK_AutoSaveTask";
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
					ATAK_POS(0.1,(11.7 + (0.35/2)),2.9,1);
					sizeEx = 0.9 * TextSize;
					font = "RobotoCondensedBold_BCE";
					tooltip="$STR_BCE_TIP_Remarks";
				};
				
				class Remark_EditBnt: IP2TG_EditBnt
				{
					idc = 3002;
					ATAK_POS(0.1,(12.7 + (0.35/2)),2.8,0.7);
					text = "No Remarks";
					tooltip="$STR_BCE_TIP_Remarks";
					action = "['cTab_Android_dlg',[['showMenu',['mission_Build',true,10]]]] call cTab_fnc_setSettings;";
				};
				
				/*class AddRemark: ctrlButton
				{
					idc=3002;
					ATAK_POS((2.4+0.15/2),(11.8 + (0.35/2)),0.4,0.7);
					
					style = "0x02 + 0x30 + 0x800";
					colorBackground[] = {0,0,0,0.3};
					sizeEx = 0.85 * TextSize;
					
					tooltip = "$STR_BCE_TIP_AddRemark";
					text = "a3\3den\data\displays\display3den\panelleft\entitylist_layer_ca.paa";
					
					onButtonClick = "call BCE_fnc_ATAK_addRemark";
				};*/
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
					y = 0.1 * ((60)) / 2048 * CustomPhoneH;
					w = PhoneBFTContainerW(3);
					h = phoneSizeH - 0.75 * (((60)) / 2048 * CustomPhoneH);
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

				//-Mark
				class New_Task_GRID_DESC: New_Task_IPExpression
				{
					idc = idc_D(2016);
					ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
					canModify = 1;
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
				class New_Task_EGRS_Bearing: New_Task_GRID_DESC
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
				class New_Task_FADH: New_Task_IPtype
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
					ATAK_POS(0.26,(0.3/2 + 0.65*3),2.8,0.65);
					text = ": Danger Close";
					sizeEx = 0.9 * TextSize;
				};
				class New_Task_DangerClose_Box: RscCheckBox
				{
					idc = idc_D(2202);
					textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
					
					x = PhoneBFTContainerW(0.1);
					y = (0.35/2 + 0.65*3) * ((60)) / 2048 * CustomPhoneH;
					w = PhoneBFTContainerW(0.3) * (safezoneH/safezonew);
					h = PhoneBFTContainerW(0.3);
				};
			};
		};
		
		//-Task Result
		class Task_Result: Task_Building
		{
			idc = idc_D(4663);
			class controls
			{
				class taskDesc: RscListBox
				{
					idc = 11;
					shadow = 2;
					
					colorBackground[] = {0,0,0,0};
					period = 0;
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectRight[] = {1,1,1,1};
					colorSelect2Right[] = {1,1,1,1};
					colorSelectBackground[] = {0,0,0,0};
					colorSelectBackground2[] = {0,0,0,0};
					
					font = "RobotoCondensed_BCE";
					sizeEx = TextSize;
					soundSelect[]={"\A3\ui_f\data\sound\RscListbox\soundSelect",0,1};
					rowHeight = 0.1 * TextSize;
					
					x = 0;
					y = 0;
					w = PhoneBFTContainerW(3);
					h = "SafezoneH";
				};
			};
		};
		
		//-Bottons for ATAK Tools
		class InputButtons: ATAK_MenuBG
		{
			idc = 46600;
			y = phoneSizeY + phoneSizeH - (0.75 * (((60)) / 2048 * CustomPhoneH));
			h = 0.75 * (((60)) / 2048 * CustomPhoneH);
			class controls
			{
				class Back: BCE_RscButtonMenu
				{
					idc = 10;
					
					text = "$STR_disp_Back";
					
					colorBackground[] = {0,0,0,0.5};
					colorBackground2[] = {0,0,0,0.5};
					colorBackgroundFocused[] = {0,0,0,0.8};

					animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
					animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
					animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.35)";
					
					size = 0.64 * (((60) - (20))) / 2048 * CustomPhoneH;
					
					ATAK_POS(0,0,0.75,0.64);
					
					onButtonClick = "call BCE_fnc_ATAK_LastPage";
					
					class TextPos
					{
						left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
						top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
						right = 0;
						bottom = 0;
					};
	
					class Attributes: Attributes
					{
						align="center";
						size = TextMenu(1);
					};
				};
				class Send: Back
				{
					idc = 11;
					
					text = "$STR_BCE_Enter";
					
					ATAK_POS(0.75,0,0.75,0.64);
					onButtonClick = "call BCE_fnc_ATAK_DataReceiveButton";
				};
				
				class Live_Feed: Back
				{
					idc = 12;
					
					text = "$STR_BCE_Live_Feed";
					
					ATAK_POS(1.5,0,0.75,0.64);
					
					action = "call cTab_Tablet_btnACT";
					onButtonClick = "";
				};
				class Show_Result: Back
				{
					idc = 13;
					
					text = "<img image='a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa' />";
					
					colorBackground[] = 
					{
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
						0.5
					};
					colorBackground2[] = 
					{
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
						0.5
					};
					colorBackgroundFocused[] = 
					{
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
						"1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
						0.8
					};
					
					ATAK_POS(2.25,0,0.75,0.64);
					onButtonClick = "call BCE_fnc_ATAK_ShowTaskResult";
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
		//class CGrp: CGrp{};
		
		//-Weather Condition
		class cTab_android_on_Weather_condition_Box: cTab_Tablet_OSD_Weather_condition_Box
		{
			
			x = ((((20) + (452)) + ((20) + (((PHONE_MOD) - (20) * 6) / 5)) * (0.35))) / 2048 * PhoneW + CustomPhoneX;
			y = (((713)) / 2048  * 	CustomPhoneH + 	CustomPhoneY) + (((60)) / 2048  * CustomPhoneH);
			w = ((((PHONE_MOD) - (20) * 6) / 5)) / 2048 * PhoneW;
			
			size = 1.15 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
			class Attributes: Attributes
			{
				size = 0.9;
			};
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
					y = (((((((713) + (60) + (10)) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2)) / 2048 * PhoneW;
					h = ((30)) / 2048 * CustomPhoneH;
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
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * CustomPhoneH;

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
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * CustomPhoneH;
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
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (0.75 * (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW));
					h = ((60)) / 2048 * CustomPhoneH;
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
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW) * 0.49;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "call cTab_Tablet_btnACT;";
				};
				class Control_turret: Connect_Vic
				{
					idc = idc_D(18);
					text = "$STR_BCE_Control_Turret";
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW) + ((((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW) * 0.51);
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW) * 0.49;
					action = "0 call cTab_Tablet_btnACT;";
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
					y = ((((((713) + (60) + (10)) + (20))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3)) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) / 2048 * CustomPhoneH;
					onLBSelChanged = "_this call cTab_msg_get_mailTxt;";
				};
				class msgframe: cTab_RscFrame
				{
					idc = 16;
					text = "Read Message";
					x = (((((452) + (20))) - ((452))) / 2048 * PhoneW);
					y = (((((713) + (60) + (10))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((PHONE_MOD) - (20) * 2)) / 2048 * PhoneW;
					h = (((626) - (60) - (10) * 2)) / 2048 * CustomPhoneH;
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
					h = ((((626) - (60) - (10) * 2) - (20) -(10))) / 2048 * CustomPhoneH;
					canModify = 0;
				};
				class deletebtn: cTab_RscButton
				{
					idc = 16120;
					text = "Delete";
					tooltip = "Delete Selected Message(s)";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
					action = "['cTab_Android_dlg'] call cTab_fnc_onMsgBtnDelete;";
				};
				class toCompose: cTab_RscButton
				{
					idc = 17;
					text = "Compose >>";
					tooltip = "Compose Messages";
					sizeEx = TextSize;
					x = ((((((((452) + (20))) + (10)))) - ((452))) / 2048 * PhoneW);
					y = (((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10)) + (10) + (60))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
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
					y = ((((((713) + (60) + (10)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((PHONE_MOD) - (20) * 2))) / 2048 * PhoneW;
					h = ((((626) - (60) - (10) * 2))) / 2048 * CustomPhoneH;
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
					y = ((((((((713) + (60) + (10))) + (20)) + ((((626) - (60) - (10) * 2) - (10) * 3 - (20) - (60) * 2)) + (10))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = ((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3))) / 2048 * PhoneW;
					h = ((60)) / 2048 * CustomPhoneH;
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
					y = ((((((((713) + (60) + (10))) + (20)))) - ((713) + (60))) / 2048 * CustomPhoneH);
					w = (((((((PHONE_MOD) - (20) * 2) - (10) * 3) / 3) * 2))) / 2048 * PhoneW;
					h = (((((626) - (60) - (10) * 2) - (20) -(10)))) / 2048 * CustomPhoneH;
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
					h = ((60)) / 2048 * CustomPhoneH;
					action = "['cTab_Android_dlg',[['mode','MESSAGE']]] call cTab_fnc_setSettings;";
				};
			};
		};
	};
};
