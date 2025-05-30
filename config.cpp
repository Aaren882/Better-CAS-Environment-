#include "\MG8\AVFEVFX\cTab\has_cTab.hpp"
#include "Additional_Fuze.hpp"

class CfgPatches
{
	class AVFEVFX
	{
		units[]={};
		weapons[]={};
		requiredVersion="2.00";
		requiredAddons[]=
		{
			#if __has_include("\A3TI\functions.hpp")
				"A3TI",
			#endif
			#if __has_include("\z\ace\addons\map\config.bin")
				"ace_map",
			#endif
			#ifdef cTAB_Installed
				"cTab",
			#endif
			#if __has_include("\z\ctab\addons\core\config.bin")
				#define cTab_1erGTD 1
				"ctab_core",
				"ctab_rangefinder",
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
	//- Remove 1erGTD's rangefinder Initiation
	#ifdef cTab_1erGTD
		class ctab_rangefinder
		{
			clientInit = "";
		};
	#endif
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
								"(safezoneX - (safezoneW * 0.443437) * 0.17)",
								"(safezoneY + safezoneH * 0.88 - ((safezoneW * 0.443437) * 4/3) * 0.72)",
								"(safezoneW * 0.443437)",
								"((safezoneW * 0.443437) * 4/3)"
							},
							"(safezoneW * 0.443437) / 4",
							"((safezoneW * 0.443437) * 4/3) / 4"
						};
					#endif
				};
			};
		};
		
		#ifdef cTab_1erGTD
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

#ifdef cTAB_Installed
	#include "cTab\cTab_MarkersClasses.hpp"
#endif
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
				condition = "(((vehicle _player) getVariable ['BCE_Task_Receiver','']) != '') || !(isnull (uiNamespace getVariable ['BCE_Task_Receiver', displayNull])) || !(isNull ([_player] call BCE_fnc_get_TaskCurUnit))";
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
	//- Phone Flash Light
	#ifdef cTAB_Installed
		class Reflector_Cone_Phone_FlashLight_BCE_F: Reflector_Cone_01_long_base_F
		{
			scope = 1;
			scopeCurator = 0;
			displayName = "Phone FlashLight (BCE)";
			class Reflectors: Reflectors
			{
				class Light_1: Light_1
				{
					intensity = 80;
					innerAngle = 45;
					outerAngle = 100;
					useFlare = 0;
					coneFadeCoef = 4;
					class Attenuation
					{
						start = 0;
						constant = 0;
						linear = 0;
						quadratic = 0.1;
						hardLimitStart = 8;
						hardLimitEnd = 22;
					};
				};
				class Light_1_Flare: Light_1_Flare
				{
					intensity = 0;
					useFlare = 0;
				};
			};
		};
	#endif

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

//- Animation Config
#include "Extended_Anim_props.hpp"
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
			class GetMapClickPOS;

			class POS2Grid;
			class Grid2POS;

			class VecRot;

			class getAzimuth;
			class getAzimuthMil;
			class getTurretDir;
			class getUnitParams;
			
			class getCompatibleAVs;
			class getCompatibleARTYs;

			#if __has_include("\MG8\DiscordMessageAPI\config.bin")
				class Discord_GetWebhooks;
			#endif
		};
		class Anim_Componets
		{
			file="MG8\AVFEVFX\Functions\Componets\Animation_Transform";
			class Anim_Type;
			class Anim_Init;
			class Anim_CustomOffset;
			class Anim_getConfigSteps;
			class Anim_SmoothDamp;
		};
		class HUD
		{
			file="MG8\AVFEVFX\Functions\HUD";
			class setMFDValue;
			class filtered_compass;
			class call_Compass;
		};
		class Fuze_Framework
		{
			file="MG8\AVFEVFX\Functions\Fuze_Framework";
			class FuzeInit;
			class FuzeTrigger;
			class FuzeVT;
			class FuzeDelay;
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
			class Switch_Zoom;
			class OpticMode;
			class Cam_Layout;
			class getTurret;
			class Cam_Delete;
			class onButtonClick_Gunner;
			class addKeyInEH;
			class touchMark;
			class UpdateCameraInfo;
			class LandMarks_icon;
			class Next_VisionMode;
		};
		class Lists
		{
			file="MG8\AVFEVFX\Functions\Unit_Lists";
			class IR_UnitList;
			class TGP_UnitList;
		};
		class DrawMap
		{
			file="MG8\AVFEVFX\functions\DrawMap";
			class DrawGPS;
			class DrawFOV;
			class TAC_Map;
		};
		class CFF_Actions
		{
			file="MG8\AVFEVFX\functions\CAS_Event\Call_for_Fire";
			class FindBestCharge;
			class doFireMission;
			class findCharge;
			class getAllCharges;
			class UnstuckUnit;
			class get_CFF_Value;
			class set_CFF_Value;
		};
		class CFF_Method_of_Controls
		{
			file="MG8\AVFEVFX\functions\CAS_Event\Call_for_Fire\MOC";
			class CFF_AT_READY;
			class CFF_AMC;
			class CFF_ToT;
		};
		class CAS_Event
		{
			file="MG8\AVFEVFX\functions\CAS_Event";
			class CAS_Action;
			class CFF_Action;
			class GunShip_Loiter;
			class Plane_CASEvent;
		};
		class WPN_CheckList
		{
			file="MG8\AVFEVFX\functions\CAS_Menu\WPN_CheckList";
			class checkList;
			class WPN_List_AIR;
			class WPN_List_CFF;

			class SelWPN_AIR;
			class SelWPN_CFF;
		};
		class CAS_Menu
		{
			file="MG8\AVFEVFX\functions\CAS_Menu";
			class DataReceiveButton;
			class ListSwitch;
			class TaskListDblCLick;
			class ToolBoxChanged;
			class IPMarkers;
			class clearTaskInfo;
			class SendTaskData;
			class Extended_Desc;
			class unitList_info;
			class Show_CurTaskCtrls;
			class TaskList_Changed;
			class Reset_TaskList;
			class NextTurretButton;

			//- Registries
				class RegisterMissionControls;
				class onLoad_BCE_Holder;
				class get_Control_Data; //- "BCE_Data"
				class set_Control_Data; //- "BCE_Data"

			//- Menu Events (ToolBox, LB DropBox)
				class onTaskElementChange;
				class onLBTaskTypeChanged;
				class onLBTaskUnitChanged;
		};
		//- Fire Mission
		class Fire_Mission_Map_Infos
		{
			file="MG8\AVFEVFX\functions\CAS_Menu\Fire_Mission\Map_Infos";
			class get_TaskMapInfo;
			class get_TaskMapInfoEntry;

			//- Draw Infos
				class draw_TaskMapInfo;
				class drawEach_TaskMapInfo;
		};
		class Fire_Mission
		{
			file="MG8\AVFEVFX\functions\CAS_Menu\Fire_Mission";
			class getTaskProps;
			class getDisplayTaskProps;
			class get_TaskIndex;

			//- BCE handling Functions
				class get_BCE_TaskClass;
				class get_BCE_TaskCateClass;
				class get_BCE_TaskCateClasses;
			
			//- Task Setup
				class get_TaskCurSetup;
				class set_TaskCurSetup;
			
			//- Task Variables
				class getTaskVar;
				class setTaskVar;

			//- Task Building Components
				class getTaskComponents;
				class getTaskSingleComponent;

			//- Task Line
				class get_TaskCurLine;
				class set_TaskCurLine;
				
			//- Task Type
				class get_TaskCurType;
				class set_TaskCurType;
			
			//- Task Unit
				class get_TaskCurUnit;
				class set_TaskCurUnit;
		};
		class Fire_Mission_Events
		{
			file="MG8\AVFEVFX\functions\CAS_Menu\Fire_Mission\Events";
			class TaskEvent_Opened;
			class TaskEvent_Enter;
			class TaskEvent_Element_SelChanged;
			class TaskEvent_Clear;
			class TaskEvent_SendData;
			class TaskEvent_DataSent;
			class TaskEvent_TaskUnitChanged;
			class TaskEvent_LBTaskTypeChanged;
			class TaskEvent_LBTaskUnitChanged;
		};
		class Call_for_Fire_Menu
		{
			file="MG8\AVFEVFX\functions\CAS_Menu\Call_for_fire";
			class CFF_Mission_XMIT;
			class CFF_Mission_EOM;
			class CFF_Mission_AutoSaveTask;
			class CFF_Mission_Get_Values;
			class CFF_Mission_Set_Value;
			class UpdateFireAdjust;
			class set_FireAdjust_MSN_State;
			class CleanFireAdjustValues;
			class get_FireAdjustValues;
			class set_FireAdjustValues;
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
			class SelChanged_AIR;
			class SelChanged_CFF;

			class clearTask5line;
			class clearTask9line;
			class clearTaskCFF;

			class DataReceive5line;
			class DataReceive9line;
			class DataReceive_CFF;

			class DataSent_AIR;
			class DataSent_CFF;
			
			class SendData5line;
			class SendData9line;
			class SendDataCFF;

			class DblClick5line;
			class DblClick9line;
			class DblClickCFF;

			class LBTaskTypeChanged;
			class LBTaskUnitChanged;

			class TaskUnitChanged_CFF;
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
				class cTab_Marker_update;
				class cTab_ChangeTask_Desc;
				class cTab_List_AV_Info;
				class cTab_Switch_ExtendedList;
				class cTab_BFT_ToolBox;
				class cTab_getWeather_Infos;
				class cTab_UpdateInterface;
				class cTab_CreateCameraList;
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
				class ATAK_LastPage;
				class ATAK_bnt_clickEvent;
				class ATAK_getScrollValue;
				class ATAK_Check_Layout;
				class ATAK_Camera_Controls;
			};
			//- ATAK Menus
				class ATAK_Fire_Mission
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Fire_Mission";
					class ATAK_DescType_Changed;
					class ATAK_set_TaskType;
					class ATAK_TaskTypeChanged;
					class ATAK_LBTaskUnitChanged;
					class ATAK_AutoSaveTask;
					class ATAK_Refresh_TaskInfos;
					class ATAK_Refresh_Weapons;
					class ATAK_PullData;
					class ATAK_ShowTaskResult;
					class ATAK_onVehicleChanged;
					class ATAK_updateTaskControl;
					class ATAK_getTaskCategoryInfo;
					class ATAK_TaskUnitChanged_AIR;
				};
				class ATAK_Call_for_Fire_Menu
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Fire_Mission\Call_for_Fire";
					class ATAK_CFF_TaskList_Init;

					class ATAK_onFireAdjusted;
					class ATAK_FireAdjustMeter;
				};
				class ATAK_Menu_Init
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Menu\Init";
					class ATAK_setAPPs_props;
					class ATAK_getAPPs_props;
				};
				class ATAK_Menu_Custom_Controls
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Menu\Custom_Controls";
					class ATAK_Custom_DropMenu_Init;
					class ATAK_Custom_DropMenu_Click;

					class Create_ATAK_Custom_DropMenu; //- Create Custom DropMenu
					class Init_ATAK_Custom_DropMenu; //- Initiate Custom DropMenu
				};
				class ATAK_Menu
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Menu";
					class ATAK_getAPPs;
					class ATAK_openPage;
					class ATAK_openMenu;
					class ATAK_ChangeTool;
					class ATAK_createSubPage;
					class ATAK_getAPP_Config;
					class ATAK_toggleSubListMenu;
					class ATAK_getCurrentAPP;
					class ATAK_getLastAPP;
					class ATAK_ignoreFade_Transform;
				};
				class ATAK_Menu_Buttons
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Menu\Button_Events";
					class ATAK_DataReceiveButton;
					class ATAK_bnt_MessageSend_Click;
					class ATAK_bnt_VideoFeeds_Click;
					class ATAK_bnt_CFF_Action_Click;
				};
				class ATAK_Menu_Buttons_Init
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Menu\Init_Buttons";
					class ATAK_bnt_SendMission;
					class ATAK_bnt_Group;
					class ATAK_bnt_Message;
					class ATAK_bnt_TaskBuilding;
					class ATAK_bnt_VideoFeeds;
				};
				class ATAK_Menu_onOpened
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\APP_Menu_onOpened";
					class ATAK_message_Init;
					class ATAK_mission_Init;
					class ATAK_Group_Init;
					class ATAK_VideoFeeds_Init;
					class ATAK_mission_SUB_TaskBuilding;
					class ATAK_mission_SUB_TaskResult;
					class ATAK_mission_SUB_TaskCFFList;
					class ATAK_mission_SUB_TaskCFF_Action;
				};
				class ATAK_CAM
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Camera";
					class ATAK_CamInit;
					class ATAK_TakePicture;
					class ATAK_FullScreenCamera;
				};
				class ATAK_MSG
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Message";
					class ATAK_msg_Line_Create;
				};
				class ATAK_Group_Menu
				{
					file="MG8\AVFEVFX\functions\cTab\functions\ATAK\Group";
					class ATAK_GroupList_Init;
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
				
				class onMapDoubleClick
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_onMapDoubleClick.sqf";
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
				class OnDrawHCam
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawHCam.sqf";
				};
				class onIfMainPressed
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_onIfMainPressed.sqf";
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
				class updateUserMarkerList
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateUserMarkerList.sqf";
				};
				class createUavCam
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_createUavCam.sqf";
				};
				class createHelmetCam
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_createHelmetCam.sqf";
				};
				class deleteHelmetCam
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_deleteHelmetCam.sqf";
				};
				class userMenuSelect
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_userMenuSelect.sqf";
				};
				class setInterfacePosition
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_setInterfacePosition.sqf";
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
				class msg_gui_Load
				{
					file="MG8\AVFEVFX\functions\cTab\Origin\fn_msg_gui_Load.sqf";
				};
			};

			//- Add
			class BCE_Marker
			{
				file="MG8\AVFEVFX\functions\cTab\functions\Marker";
				class Marker_Edittor;
				class NextMarkerID;
				class DrawMarkerDir;
				#if __has_include("\z\ace\addons\map_gestures\config.bin")
					class MapPointer;
					class onDrawMapPointer;
				#endif
				#if __has_include("\z\ctab\addons\rangefinder\config.bin")
					class DrawRangefinder_ACE;
				#endif
				class FinishEDIT_Marker;
				class PlaceMarker;
				class Add_to_MarkerList;
				class DrawArea;
			};
			class BCE_Widget
			{
				file="MG8\AVFEVFX\functions\cTab\functions\Menu_Widget";
				class onMarkerSelChanged;
				class onMarkerTextEditted;
				class onMarkerOpacityChanged;
				class Update_MarkerItems;
				class toggleWeather;
				class toggleMarkerWidget;
				class toggleTADMarkerDropper;
				class SwitchMarkerWidget;
			};
		};
	#endif

	//- especially for "1erGTD"
	#ifdef cTab_1erGTD
		class cTab_core
		{
			class function
			{
				file="MG8\AVFEVFX\functions\cTab\Origin\Extra";
				class toggleInterface;
			};
		};
	#endif

	//- Hatchet H-60
	#if __has_include("\z\vtx\addons\uh60_jvmf\config.bin")
		class vtx_uh60_jvmf
		{
			class Marker
			{
				file = "MG8\AVFEVFX\functions\cTab\functions\Marker";
				class cTabToJVMF;
			};
		};
	#endif

	#if __has_include("\A3TI\functions.hpp")
		class A3TI
		{
			class core
			{
				class specialCase
				{
					file="MG8\AVFEVFX\functions\A3TI\fn_specialCase.sqf";
				};
				class toggleLTM
				{
					file="MG8\AVFEVFX\functions\A3TI\fn_toggleLTM.sqf";
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

class CfgMarkerColors
{
	class Default;
	class cTab_Highlight: Default
	{
		name = "cTab Highlight";
		color[] = {0.952941,0.952941,0.0823529,1};
		scope = 1;
	};
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

class RscText;
class RscPicture;
class ScrollBar;
//class RscLine;
class BCE_RscLine: RscPicture
{
	text="\MG8\AVFEVFX\data\Element\line.paa";
	ColorText[]={1,1,1,0.8};
	background=1;
	shadow=2;
};
class RscInfoBack;
class RscToolbox;
class RscListBox
{
	class ListScrollBar;
};
class RscListNBox;
class RscIGUIText;
class RscPictureKeepAspect;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscAttributeCAS;
class RscShortcutButton;
class RscButtonMenu: RscShortcutButton
{
	class TextPos;
	class AttributesImage;
};
class ctrlButton;
class ctrlButtonPictureKeepAspect;
class RscEdit;
class RscCombo;
class RscXSliderH;
class RscEditMulti;
class RscStructuredText;
class ctrlToolboxPictureKeepAspect;
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
		valign = "middle";
		shadow = "false";
	};
};

//- Mission Property + Controls + Map Infos
	#include "Mission_Property.hpp"
	#include "Mission_Controls.hpp"
	#include "Mission_Map_Infos.hpp"

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