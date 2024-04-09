#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"

class CfgPatches
{
	class AVFEVFX
	{
		units[]={};
		weapons[]={};
		requiredVersion="2.00";
		requiredAddons[]=
		{
			#if __has_include("\A3TI\config.bin")
				"A3TI",
			#endif
			#if __has_include("\z\ace\addons\map\config.bin")
				"ace_map",
			#endif
			#ifdef cTAB_Installed
				"cTab",
			#endif
			#if __has_include("\z\ctab\addons\core\config.bin")
				"ctab_core",
			#endif
			//-POLPOX map tools
			#define PLP_TOOL 0
			#if __has_include("\plp\plp_mapToolsRemastered\config.bin")
				#define PLP_TOOL 1
				"PLP_mapToolsRemastered",
			#endif
			"A3_Ui_F",
			"A3_Weapons_F",
			"A3_Air_F_Heli_Light_01",
			"A3_Air_F_Jets_Plane_Fighter_01",
			"A3_Armor_F_Tank_AFV_Wheeled_01",
			"A3_Armor_F_Tank_LT_01",
			"A3_Soft_F_Beta_MRAP_03"
		};
	};
};

//-RHS HMD
#if __has_include("\Kimi_HMDs_RHS\config.bin")
	#define RHS_HMD_Macro 1
#endif
#if __has_include("\CTG_HMD_RHSUSAF\config.cpp")
	#define RHS_HMD_Macro 1
#endif

//-CBA Compile
class Extended_PreInit_EventHandlers
{
	class AVFEVFX_EH
	{
		init = "call compile preprocessFileLineNumbers 'MG8\AVFEVFX\XEH_preInit.sqf'";
	};
};
class Extended_PostInit_EventHandlers
{
	class AVFEVFX_EH
	{
		init = "call compile preprocessFileLineNumbers 'MG8\AVFEVFX\XEH_postInit.sqf'";
	};
};
class CfgUIGrids
{
    class IGUI
	{
        class Presets
		{
            class Arma3
			{
                class Variables
				{
                    grid_BCE_TaskList[] =
					{
						{
							"safezoneX",
							"((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)",
							"(12 * (((safezoneW / safezoneH) min 1.2) / 40))",
							"(12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))"
						},
						"(((safezoneW / safezoneH) min 1.2) / 40)",
						"((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
					};
					#ifdef cTAB_Installed
						grid_cTab_ATAK_dsp[] = 
						{
							{
								"(safezoneX - 	(0.86) * 0.17)",
								"(safezoneY + safezoneH * 0.88 - 	(	(0.86) * 4/3) * 0.72)",
								"(safezoneW * 0.27)",
								"((safezoneW * 0.27) * 4/3)"
							},
							"(safezoneW * 0.27) / 4",
							"((safezoneW * 0.27) * 4/3) / 4"
						};
					#endif
                };
            };
        };
		
		#if __has_include("\z\ctab\addons\core\config.bin")
			#define PHONE_BG "\cTab\img\android_s7_ca.paa"
		#else
			#define PHONE_BG "\cTab\img\android_background_ca.paa"
		#endif

		class Variables
		{
            class grid_BCE_TaskList
			{
				displayName = "BCE Task Receiver";
				description = "TaskList from BCE";
				preview = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
				saveToProfile[] = {0,1,2,3};
				canResize = 1;
			};
			#ifdef cTAB_Installed
				class grid_cTab_ATAK_dsp
				{
					displayName = "cTab Android";
					description = "Android display from cTab";
					preview = PHONE_BG;
					saveToProfile[] = {0,1,2,3};
					canResize = 1;
				};
			#endif
        };
	};
};
class CfgHints
{
	class BCE
	{
		displayName = "BCE";
		logicalOrder = 22;
		class Task_Received
		{
			displayName = "$STR_BCE_ReceivedHint_Title";
			description = "$STR_BCE_ReceivedHint_DESC";
			tip = "";
			arguments[] = {};
			image = "";
			logicalOrder = 1;
			class ActionMenu_sub
			{
				displayName = "$STR_BCE_ReceivedHint_Title";
				description = "$STR_BCE_ReceivedHint_DESC";
				tip = "";
				image = "";
				arguments[] = {{{""}}};
				dlc = -1;
			};
		};
	};
};

//- Detail https://community.bistudio.com/wiki/Arma_3:_Communication_Menu
class RscSubmenu;
class RscTeam: RscSubmenu
{
	//-Sort
	items[] = {"AssignRed","AssignGreen","AssignBlue","AssignYellow","AssignMain","AssignJTAC","UnAssignJTAC","Separator","SelectTeam","Back"};
	class AssignJTAC
	{
		title = "$STR_BCE_AsJTAC";
		enable = "NotEmpty";
		shortcuts[] = {7};
		shortcutsAction = "CommandingMenu6";
		command = -5;
		show = "IsLeader";
		class Params
		{
			expression = "_target setVariable ['BCE_is_JTAC',true,true]";
		};
	};
	class UnAssignJTAC
	{
		title = "$STR_BCE_UnAsJTAC";
		enable = "NotEmpty";
		shortcuts[] = {8};
		shortcutsAction = "CommandingMenu7";
		command = -5;
		show = "IsLeader";
		class Params
		{
			expression = "_target setVariable ['BCE_is_JTAC',false,true]";
		};
	};
};

class CfgVehicles
{
	//-ACE Actions
	class Man;
	class CAManBase: Man
	{
		class ACE_Actions
		{
			class ACE_MainActions
			{
				class ACE_TeamManagement
				{
					class ACE_BCE_Assign_JTAC
					{
						displayName="$STR_BCE_AsJTAC";
						condition="!(_target getVariable ['BCE_is_JTAC',false]) && (_player == leader _player)";
						icon="\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
						exceptions[]={};
						statement="_target setVariable ['BCE_is_JTAC',true,true]";
					};
					class ACE_BCE_Unassign_JTAC
					{
						displayName="$STR_BCE_UnAsJTAC";
						exceptions[]={};
						condition="(_target getVariable ['BCE_is_JTAC',false]) && (_player == leader _player)";
						statement="_target setVariable ['BCE_is_JTAC',false,true]";
					};
				};
			};
		};
		class ACE_SelfActions
		{
			class BCE_Task_Receiver
			{
				displayName = "$STR_BCE_CAS_Task";
				condition = "(((vehicle _player) getVariable ['BCE_Task_Receiver','']) != '') || !(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) || !(isNull (_player getVariable ['TGP_View_Selected_Vehicle',objNull]))";
				exceptions[] = {"isNotInside","isNotSitting"};
				icon = "\MG8\AVFEVFX\data\missions.paa";
			};
		};
	};

	//-Helis
	class Helicopter_Base_F;
	class Helicopter_Base_H: Helicopter_Base_F
	{
		class EventHandlers;
		class Turrets
		{
			class MainTurret;
		};
	};
	class Heli_Light_01_base_F;
	class Heli_Light_01_armed_base_F: Heli_Light_01_base_F
	{
		hiddenSelectionsTextures[] = {"A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_Blufor_CO.paa"};
		defaultUserMFDvalues[]={0.15,1,0.15,0.7};
		class MFD
		{
			#include "MFD\HUD.hpp"
		};
	};
	//MELB
	class MELB_base: Helicopter_Base_H
	{
		class EventHandlers: EventHandlers{};
	};
	class MELB_AH6M: MELB_base
	{
		#if __has_include("\Kimi_HMDs_MELB\config.bin")
		#else
			defaultUserMFDvalues[]={0.15,1,0.15,0.7};
			class MFD
			{
				#include "MFD\HUD.hpp"
			};
		#endif
		class EventHandlers: EventHandlers
		{
			class HUD
			{
				getin="if (((_this # 0) animationPhase 'Addcrosshair') != 0) then{(_this # 0) animate ['Addcrosshair', 0];};";
			};
		};
	};

	class Heli_Light_03_base_F: Helicopter_Base_F
	{
		class Turrets
		{
			class MainTurret;
		};
	};
	class Heli_Transport_01_base_F: Helicopter_Base_H{};

	//-RHS HMD
	#ifndef RHS_HMD_Macro
		class RHS_MELB_base: Helicopter_Base_H
		{
			class EventHandlers: EventHandlers{};
		};
		class RHS_MELB_AH6M: RHS_MELB_base
		{
			defaultUserMFDvalues[]={0.15,1,0.15,0.7};
			class MFD
			{
				#include "MFD\HUD.hpp"
			};
			class EventHandlers: EventHandlers
			{
				class HUD
				{
					getin="if (((_this # 0) animationPhase 'Addcrosshair') != 0) then{(_this # 0) animate ['Addcrosshair', 0];};";
				};
			};
		};
		class RHS_UH60_Base: Heli_Transport_01_base_F{};
		class RHS_UH60M_base: RHS_UH60_Base{};
		class RHS_UH60M_US_base: RHS_UH60M_base{};
		class RHS_UH60M: RHS_UH60M_US_base{};
		class RHS_UH60M2: RHS_UH60M{};
		class RHS_UH60M_ESSS: RHS_UH60M2
		{
			defaultUserMFDvalues[]={0.15,1,0.15,0.7};
			class MFD
			{
				#include "MFD\HUD.hpp"
			};
		};
	#else
		class RHS_MELB_base: Helicopter_Base_H
		{
			class EventHandlers: EventHandlers{};
		};
		class RHS_MELB_AH6M: RHS_MELB_base
		{
			class EventHandlers: EventHandlers
			{
				class HUD
				{
					getin="if (((_this # 0) animationPhase 'Addcrosshair') != 0) then{(_this # 0) animate ['Addcrosshair', 0];};";
				};
			};
		};
	#endif

	//RHS
	#if __has_include("\rhsusf\addons\rhsusf_main\config.bin")
		class Heli_Transport_02_base_F;
		class RHS_CH_47F_base: Heli_Transport_02_base_F
		{
			//BCE_DoorGunners = 1;
		};
		class RHS_UH1_Base: Heli_Light_03_base_F{};
		class RHS_UH1Y_base: RHS_UH1_Base{};
		class RHS_UH1Y_US_base: RHS_UH1Y_base{};
		class RHS_UH1Y: RHS_UH1Y_US_base
		{
			class Turrets: Turrets
			{
				class MainTurret: MainTurret
				{
					Laser_Offset[] = {0,0,-0.1};
				};
				class CopilotTurret: MainTurret
				{
					LightFromLOD=1;
				};
				class RightDoorGun: MainTurret
				{
					Laser_Offset[] = {0,0,-0.1};
				};
			};
		};
	#endif

	//Lights
	class Reflector_Cone_01_base_F;
	class Reflector_Cone_01_long_base_F: Reflector_Cone_01_base_F
	{
		class Reflectors
		{
			class Light_1;
			class Light_1_Flare;
		};
	};
	class Reflector_Cone_IR_Laser_F: Reflector_Cone_01_long_base_F
	{
		scope = 1;
		scopeCurator = 0;
		displayName = "IR Laser Sim (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				irLight=1;
				intensity = 5;
				innerAngle = 1;
				outerAngle = 3;
				coneFadeCoef = 8;
				class Attenuation
				{
					start = 4000;
					constant = 0;
					linear = 0;
					quadratic = 0.1;
					hardLimitStart = 4800;
					hardLimitEnd = 6000;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				irLight=1;
				innerAngle = 3;
				outerAngle = 10;
				coneFadeCoef = 8;
				useFlare = 1;
				flareMaxDistance = 3000;
				flareSize = 15;
			};
		};
	};
	class Reflector_Cone_IR_Laser_Light_F: Reflector_Cone_IR_Laser_F
	{
		displayName = "IR Laser Light Source (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1_Flare: Light_1_Flare
			{
				color[]={1,0.58,0.16};
				ambient[]={1,0.58,0.16};
				diffuse[]={1,0.58,0.16};
				intensity = 70;
				innerAngle = 20;
				outerAngle = 60;
				coneFadeCoef = 6;

				useFlare = 1;
				flareSize = 0.3;
				flareMaxDistance = 2000;
				drawLight=1;
				dayLight=1;
				brightness=2;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 1;
					quadratic = 1;
					hardLimitStart = 0.01;
					hardLimitEnd = 0.01;
				};
			};
		};
	};
	class Reflector_Cone_IR_LaserDesignator_Light_F: Reflector_Cone_IR_Laser_Light_F
	{
		displayName = "IR Laser Designator Light Source (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1_Flare: Light_1_Flare
			{
				innerAngle = 10;
				outerAngle = 30;
				coneFadeCoef = 4;

				flareSize = 10;
				flareMaxDistance = 4000;
			};
		};
	};

	//Heli
	class Reflector_Cone_01_spotlight_F: Reflector_Cone_01_long_base_F
	{
		scope = 1;
		scopeCurator = 0;
		displayName = "Heli SpotLight (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				intensity = 10000;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 0;
					quadratic = 0.01;
					hardLimitStart = 2800;
					hardLimitEnd = 3000;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				innerAngle = 10;
				outerAngle = 60;
				useFlare = 1;
				flareMaxDistance = 1000;
				flareSize = 5;
			};
		};
	};
	class Reflector_Cone_01_spotlight_IR_F: Reflector_Cone_01_spotlight_F
	{
		displayName = "Heli SpotLight IR (BCE)";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				irLight=1;
				innerAngle = 4;
				coneFadeCoef = 15;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 0;
					quadratic = 0.01;
					hardLimitStart = 2800;
					hardLimitEnd = 3000;
				};
			};
			class Light_1_Flare: Light_1_Flare
			{
				irLight=1;
				innerAngle = 4;
				useFlare = 1;
			};
		};
	};

	class Tank;
	class Tank_F: Tank
	{
		class Turrets;
	};
	class LT_01_base_F: Tank_F
	{
		class Turrets: Turrets
		{
			class MainTurret;
		};
	};
	class LT_01_scout_base_F: LT_01_base_F
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				LaserDesignator_Offset[] = {0,0.03,0}; //{X,Y,Z}
			};
		};
	};
	
	class Plane;
	class Plane_Base_F: Plane
	{
		class Eventhandlers;
	};

	#include "Compat.hpp"
};
class CfgFunctions
{
	class BCE
	{
		class Initiation
		{
			file="MG8\AVFEVFX\Functions";
			class Init;
		};
		class Componets
		{
			file="MG8\AVFEVFX\Functions\Componets";
			class ServerClientSide;
			class ClientSide;

			class ACE_actions;
			class canUseTurret;

			class trueZoom;
			class Check_Optics;
			class Set_EnvironmentList;
			class Turret_interSurface;

			class POS2Grid;
			class Grid2POS;

			class VecRot;

			class getAzimuth;
			class getTurretDir;
			class getUnitParams;
			class getCompatibleAVs;
		};
		class HUD
		{
			file="MG8\AVFEVFX\Functions\HUD";
			class setMFDValue;
			class filtered_compass;
			class call_Compass;
		};
		class Gunner_Action
		{
			file="MG8\AVFEVFX\Functions\Gunner_Action";
			class gunnerLoop;
			class CreateLaser;
			class CreateSpotLight;
			class CreateLightSources;
			class deleteGunnerLaserSources;
			class deleteGunnerLightSources;
		};
		class LaserDesignator
		{
			file="MG8\AVFEVFX\Functions\LaserDesignator";
			class LaserDesignator;
			class deleteLaserDesignator;
			class isLaserOn;
		};
		class Camera
		{
			file="MG8\AVFEVFX\Functions\Camera";
			class 3DCompass;
			class Unit_Icon;
			class map_Icon;
			class UpdateTime;
			class OpticMode;
			class Cam_Layout;
			class getTurret;
			class Cam_Delete;
			class onButtonClick_Gunner;
			class addKeyInEH;
			class touchMark;
			class UpdateCameraInfo;
			class LandMarks_icon;
		};
		class Lists
		{
			file="MG8\AVFEVFX\Functions\Unit_Lists";
			class IR_UnitList;
			class TGP_UnitList;
		};
		class CAS_Event
		{
			file="MG8\AVFEVFX\functions\CAS_Event";
			class CAS_Action;
			class drawGPS;
			class GunShip_Loiter;
			class Plane_CASEvent;
		};
		class CAS_Menu
		{
			file="MG8\AVFEVFX\functions\CAS_Menu";
			class checkList;
			class DataReceiveButton;
			class ListSwitch;
			class TaskListDblCLick;
			class ToolBoxChanged;
			class IPMarkers;
			class GetMapClickPOS;
			class clearTaskInfo;
			class TAC_Map;
			class SendTaskData;
			class CAS_SelWPN;
			class Extended_Desc;
			class unitList_info;
			class Show_CurTaskCtrls;
			class TaskList_Changed;
			class Reset_TaskList;
			class DrawFOV;
			class NextTurretButton;
		};
		class Task_Receiver
		{
			file="MG8\AVFEVFX\functions\Task_Receiver";
			class UpdateTaskInfo;
			class SetTaskReceiver;
		};
		class UI
		{
			file="MG8\AVFEVFX\functions\UI";
			class TGP_Select_Confirm;
			class Update_MapCtrls;
		};
		class Task_Type
		{
			file="MG8\AVFEVFX\functions\Task_Type";
			class clearTask5line;
			class clearTask9line;
			class DataReceive5line;
			class DataReceive9line;
			class DblClick5line;
			class DblClick9line;
			class TaskTypeChanged;
		};
		class Radio_Compat
		{
			file="MG8\AVFEVFX\functions\Radio_Compat";
			#if __has_include("\idi\acre\addons\sys_core\script_component.hpp")
				class getFreq_ACRE;
				class setRacks_ACRE;
				class ButtonRacks;
			#else
				class getFreq_TFAR;
			#endif
		};
		#ifdef cTAB_Installed
			class cTab
			{
				file="MG8\AVFEVFX\functions\cTab";
				class cTab_postInit;
			};
			class cTab_BCE
			{
				file="MG8\AVFEVFX\functions\cTab\functions";
				class cTabMap;
				class ctab_ChangeTask_Desc;
				class ctab_List_AV_Info;
				class ctab_Switch_ExtendedList;
				class ctab_BFT_ToolBox;
				class cTab_getWeather_Infos;
				class Extended_WeaponDESC;
				class Extended_TaskDESC;
			};
			class cTab_Task
			{
				file="MG8\AVFEVFX\functions\cTab\Task_Type";
				class cTab_9_TaskChanged;
				class cTab_5_TaskChanged;
			};
			class ATAK
			{
				file="MG8\AVFEVFX\functions\cTab\functions\ATAK";
				class ATAK_openPage;
				class ATAK_TaskCreate;
				class ATAK_LastPage;
				class ATAK_DescType_Changed;
				class ATAK_TaskTypeChanged;
				class ATAK_DataReceiveButton;
				class ATAK_AutoSaveTask;
				class ATAK_Refresh_TaskInfos;
				class ATAK_Refresh_Weapons;
				class ATAK_getScrollValue;
				class ATAK_PullData;
				class ATAK_ShowTaskResult;
				class ATAK_onVehicleChanged;
			};
		#endif
	};
	#ifdef cTAB_Installed
		class cTab
		{
			class Functions
			{
				class AVInfoMenu_toggle
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_AVInfoMenu_toggle.sqf";
				};
				class Tablet_btnACT
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_Tablet_btnACT.sqf";
				};
				class showMenu_toggle
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_showMenu_toggle.sqf";
				};
				
				class OnDrawbft
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbft.sqf";
				};
				class OnDrawbftAndroid
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftAndroid.sqf";
				};
				class OnDrawbftAndroidDsp
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftAndroidDsp.sqf";
				};
				class OnDrawbftTAD
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftTAD.sqf";
				};
				class OnDrawbftTADdialog
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftTADdialog.sqf";
				};
				class OnDrawbftVeh
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftVeh.sqf";
				};
				class OnDrawUAV
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawUAV.sqf";
				};
				
				//-Original Ones
				class onIfKeyDown
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_onIfKeyDown.sqf";
				};
				class open
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_open.sqf";
				};
				class drawBftMarkers
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_drawBftMarkers.sqf";
				};
				class drawUserMarkers
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_drawUserMarkers.sqf";
				};
				class findUserMarker
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_findUserMarker.sqf";
				};
				class updateInterface
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateInterface.sqf";
				};
				class updateLists
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateLists.sqf";
				};
				class createUavCam
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_createUavCam.sqf";
				};
				class userMenuSelect
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_userMenuSelect.sqf";
				};
				class deleteUAVcam
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_deleteUAVcam.sqf";
				};
				class toggleMapTools
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_toggleMapTools.sqf";
				};
				class onIfClose
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_onIfClose.sqf";
				};
				
				//- Add
				class toggleWeather
				{
					file="MG8\AVFEVFX\functions\cTab\functions\fn_toggleWeather.sqf";
				};
				//- Action Menu
				class Interaction_Menu
				{
					file="MG8\AVFEVFX\functions\cTab\functions\menu\fn_Interaction_Menu.sqf";
				};
				class Menu_Correction
				{
					file="MG8\AVFEVFX\functions\cTab\functions\menu\fn_Menu_Correction.sqf";
				};
			};
		};
	#endif
	#if __has_include("\A3TI\config.bin")
		class A3TI
		{
			class core
			{
				class specialCase
				{
					file="MG8\AVFEVFX\functions\A3TI\fn_specialCase.sqf";
				};
			};
		};
	#endif
	
	#if cTAB_Installed == PLP_TOOL
		class PLP
		{
			class PLP_SMT
			{
				class SMT_distance
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_distance.sqf";
				};
				class SMT_markHouses
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_markHouses.sqf";
				};
				class SMT_height
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_height.sqf";
				};
				class SMT_compass
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_compass.sqf";
				};
				class SMT_placeGrid
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_placeGrid.sqf";
				};
				class SMT_findFlat
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_findFlat.sqf";
				};
				class SMT_Description
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_Description.sqf";
				};
				class SMT_LineOfSight
				{
					file="MG8\AVFEVFX\functions\PLP_Tools\fn_SMT_LineOfSight.sqf";
				};
			};
		};
	#endif
};

#define set_Switch_Sound(NUM) \
	class switch_mod_0##NUM \
	{ \
		sound[] = {#\a3\sounds_f_epb\Weapons\noise\switch_mod_0##NUM ,1,1}; \
		titles[] = {}; \
	}
class CfgSounds
{
	set_Switch_Sound(1);
	set_Switch_Sound(2);
	set_Switch_Sound(3);
	set_Switch_Sound(4);
	set_Switch_Sound(5);
};

class ScrollBar;
class RscLine;
class RscInfoBack;
class RscText;
class RscToolbox;
class RscListBox
{
	class ListScrollBar;
};
class RscPicture;
class RscIGUIText;
class RscPictureKeepAspect;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscAttributeCAS;
class RscShortcutButton;
class RscButtonMenu: RscShortcutButton
{
	class TextPos;
};
class ctrlButton;
class RscEdit;
class RscCombo;
class RscEditMulti;
class RscStructuredText;
class RscMapControl
{
	class Bunker;
	class busstop;
	class Chapel;
	class church;
	class Cross;
	class Fountain;
	class Fortress;
	class fuelstation;
	class hospital;
	class Legend;
	class lighthouse;
	class power;
	class powersolar;
	class powerwave;
	class powerwind;
	class quay;
	class ruin;
	class shipwreck;
	class Stack;
	class Tourism;
	class transmitter;
	class viewtower;
	class watertower;
	showCountourInterval = 2;
};
class RscCheckBox;
class RscBackground;
class BCE_RscButtonMenu: RscButtonMenu
{
	style = 2;
	shadow = 1;
	colorBackground[] = {0.36,0.36,0.36,0.5};
	colorBackground2[] = {0.36,0.36,0.36,0.5};
	
	colorBackgroundFocused[] = {0.36,0.36,0.36,0.5};
	
	//-Text
	color[] = {1,1,1,1};
	color2[] = {1,1,1,1};
	colorFocused[] = {0.3,0.3,0.3,1};
	colorFocusedSecondary[] = {0.3,0.3,0.3,1};
	
	period = 0;
	periodFocus = 0;
	periodOver = 0;
	
	class ShortcutPos
	{
		left = 0;
		top = 0.005;
		w = 0.0175;
		h = 0.025;
	};
	class Attributes
	{
		font = "RobotoCondensed_BCE";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
};

//-POLPOX Map Tools Control
#if cTAB_Installed == PLP_TOOL
	class PLP_SMT_Description;
	class PLP_SMT_Data
	{
		class RadialMenu
		{
			class Distance
			{
				displayName = "$STR_BCE_PLP_Title_Distance";
				function = "PLP_fnc_SMT_distance";
				controls = "$STR_BCE_PLP_Ctrl_Distance";
				description = "$STR_BCE_PLP_Tip_Distance";
			};
			class MarkHouses
			{
				displayName = "$STR_BCE_PLP_Title_Mark_House";
				function = "PLP_fnc_SMT_markHouses";
				controls = "$STR_BCE_PLP_Ctrl_Mark_House";
				description = "$STR_BCE_PLP_Tip_Mark_House";
			};
			class Height
			{
				displayName = "$STR_BCE_PLP_Title_Height";
				function = "PLP_fnc_SMT_height";
				controls = "$STR_BCE_PLP_Ctrl_Height";
				description = "$STR_BCE_PLP_Tip_Height";
			};
			class Compass
			{
				displayName = "$STR_BCE_PLP_Title_Compass";
				function = "PLP_fnc_SMT_compass";
				controls = "$STR_BCE_PLP_Ctrl_Compass";
				description = "$STR_BCE_PLP_Tip_Compass";
			};
			class EditGrid
			{
				displayName = "$STR_BCE_PLP_Title_Edit_Grid";
				function = "PLP_fnc_SMT_placeGrid";
				controls = "$STR_BCE_PLP_Ctrl_Edit_Grid";
				description = "$STR_BCE_PLP_Tip_Edit_Grid";
			};
			class FindFlat
			{
				displayName = "$STR_BCE_PLP_Title_Find_Flat";
				function = "PLP_fnc_SMT_findFlat";
				controls = "$STR_BCE_PLP_Ctrl_Find_Flat";
				description = "$STR_BCE_PLP_Tip_Find_Flat";
			};
			class LineOfSight
			{
				displayName = "$STR_BCE_PLP_Title_Line_of_Sight";
				function = "PLP_fnc_SMT_lineOfSight";
				controls = "$STR_BCE_PLP_Ctrl_Line_of_Sight";
				description = "$STR_BCE_PLP_Tip_Line_of_Sight";
			};
		};
	};
#endif

#include "cTab\cTab_Macros.hpp"

//-cTab UI
#ifdef cTAB_Installed
	#include "cTab\cTab_UI.hpp"
#endif

class CfgFontFamilies
{
	//-Default Font for BCE
	class RobotoCondensed_BCE
	{
		fonts[] = {{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed8","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light6"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed9","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light7"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed10","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light8"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed11","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light9"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed12","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light10"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed13","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light11"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed14","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light12"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed15","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light13"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed16","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light14"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed17","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light15"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed18","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light16"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed19","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light17"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed20","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light18"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed21","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light19"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed22","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light20"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed23","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light21"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed24","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light22"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed25","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light23"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed26","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light24"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed27","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light25"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed28","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light26"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed29","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light27"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed30","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light28"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed31","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light29"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed34","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light30"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed35","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light31"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed37","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light34"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light35"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light37"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed\Roboto-Condensed46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light46"}};
	};
	class RobotoCondensedBold_BCE
	{
		fonts[] = {{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold9","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light6"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold10","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light7"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold11","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light8"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold12","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light9"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold13","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light10"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold14","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light11"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold15","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light12"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold16","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light13"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold17","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light14"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold18","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light15"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold19","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light16"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold20","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light17"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold21","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light18"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold22","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light19"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold23","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light20"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold24","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light21"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold25","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light22"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold26","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light23"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold27","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light24"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold28","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light25"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold29","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light26"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold30","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light27"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold31","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light28"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold34","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light29"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold35","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light30"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold37","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light31"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light34"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light35"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light37"},{"A3\Uifonts_f\Data\Fonts\Roboto-Condensed-Bold\Roboto-Condensed-Bold46","A3\Uifonts_f\Data\Fonts\NotoSansCJK-Light\NotoSansCJK-Light46"}};
	};
};

//UI
#include "Control_UI.hpp"
#include "Dialog.hpp"

class CfgScriptPaths
{
	BCE_Function = "MG8\AVFEVFX\Functions\UI\";
};