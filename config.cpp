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
			"A3_Ui_F",
			"A3_Weapons_F",
			"A3_Air_F_Heli_Light_01",
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

//- Detail https://community.bistudio.com/wiki/Arma_3:_Communication_Menu
class RscSubmenu;
class RscTeam: RscSubmenu
{
	//-Sort
	items[] = {"AssignRed","AssignGreen","AssignBlue","AssignYellow","AssignMain","Separator","SelectTeam","AssignJTAC","UnAssignJTAC","Back"};
	class AssignJTAC
	{
		title = "Assign JTAC";
		enable = "NotEmpty";
		shortcuts[] = {7};
		shortcutsAction = "CommandingMenu6";
		command = -5;
		show = "IsLeader";
		cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\call_ca.paa";
		class Params
		{
			expression = "_target setVariable ['BCE_is_JTAC',true,true]";
		};
	};
	class UnAssignJTAC
	{
		title = "UnAssign JTAC";
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
	//-ACE action
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
						displayName="Assign as JTAC";
						condition="!(_target getVariable ['BCE_is_JTAC',false]) && (isFormationLeader _player)";
						icon="\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
						exceptions[]={};
						statement="_target setVariable ['BCE_is_JTAC',true,true]";
					};
					class ACE_BCE_Unassign_JTAC
					{
						displayName="Unssign as JTAC";
						exceptions[]={};
						condition="(_target getVariable ['BCE_is_JTAC',false]) && (isFormationLeader _player)";
						statement="_target setVariable ['BCE_is_JTAC',false,true]";
					};
				};
			};
		};
	};
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
				engine="if (((_this select 0) animationPhase 'Addcrosshair') != 0) then{(_this select 0) animate ['Addcrosshair', 0];};";
			};
		};
	};

	class Heli_Transport_01_base_F: Helicopter_Base_H
	{
		//BCE_DoorGunners = 1;
		/*class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				Laser_Offset[] = {0,0,0};
			};
		};*/
	};
	class Heli_Transport_03_base_F: Helicopter_Base_H
	{
		//BCE_DoorGunners = 1;
	};

	//RHS
	#if __has_include("\rhsusf\addons\rhsusf_main\config.bin")
		class RHS_MELB_base: Helicopter_Base_H
		{
			class EventHandlers: EventHandlers{};
		};
		class RHS_MELB_AH6M: RHS_MELB_base
		{

			#ifndef RHS_HMD_Macro
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
					engine="if (((_this select 0) animationPhase 'Addcrosshair') != 0) then{(_this select 0) animate ['Addcrosshair', 0];};";
				};
			};
		};
		class RHS_UH60M2;
		class RHS_UH60M_ESSS: RHS_UH60M2
		{
			#ifndef RHS_HMD_Macro
				defaultUserMFDvalues[]={0.15,1,0.15,0.7};
				class MFD
				{
					#include "MFD\HUD.hpp"
				};
			#endif
		};

		class Heli_Transport_02_base_F;
		class RHS_CH_47F_base: Heli_Transport_02_base_F
		{
			//BCE_DoorGunners = 1;
		};
		class RHS_UH1_Base;
		class RHS_UH1Y_base: RHS_UH1_Base
		{
			class Turrets;
		};
		class RHS_UH1Y_US_base: RHS_UH1Y_base
		{
			class Turrets: Turrets
			{
				class MainTurret;
			};
		};
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

	class Car;
	class Car_F: Car
	{
		class NewTurret;
		class Turrets
		{
			class MainTurret;
		};
	};
	class Wheeled_APC_F: Car_F
	{
		class Turrets
		{
			class MainTurret: NewTurret
			{
				class Turrets
				{
					class CommanderOptics;
				};
			};
		};
	};
	class AFV_Wheeled_01_base_F: Wheeled_APC_F
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				class Turrets: Turrets
				{
					class CommanderOptics: CommanderOptics
					{
						primaryGunner = 1;
					};
				};
				primaryGunner = 0;
			};
		};
	};
	class MRAP_03_base_F: Car_F
	{
		class Turrets: Turrets
		{
			class CommanderTurret: MainTurret
			{
				primaryGunner = 1;
			};
		};
	};
	class MRAP_03_hmg_base_F: MRAP_03_base_F
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				primaryGunner = 0;
			};
		};
	};
	class MRAP_03_gmg_base_F: MRAP_03_hmg_base_F
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				primaryGunner = 0;
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
				primaryGunner = 1;
				LaserDesignator_Offset[] = {0,0.03,0}; //{X,Y,Z}
			};
		};
	};

	class Plane;
	class Plane_Base_F: Plane
	{
		class Eventhandlers;
		class Turrets;
	};
	class VTOL_Base_F: Plane_Base_F
	{
		class NewTurret;
		class Turrets: Turrets
		{
			class CopilotTurret;
		};
	};
	#include "Compat.hpp"
	//Black Fish
	class VTOL_01_base_F: VTOL_Base_F
	{
		class Turrets: Turrets
		{
			class CopilotTurret: CopilotTurret
			{
				primaryGunner = 1;
			};
		};
	};
	class VTOL_01_armed_base_F: VTOL_01_base_F
	{
		class Turrets: Turrets
		{
			class GunnerTurret_01: NewTurret
			{
				primaryGunner = 0;
			};
		};
	};
};
class CfgFunctions
{
	class BCE
	{
		class Componets
		{
			file="MG8\AVFEVFX\Functions";
			class Init;
			class perf_EH;
			class ACE_actions;
		};
		class HUD
		{
			file="MG8\AVFEVFX\Functions\HUD";
			class setMFDValue;
			class filtered_compass;
			class call_Compass;
			class trueZoom;
		};
		class Heli_Gunner
		{
			file="MG8\AVFEVFX\Functions\Heli_Gunner";
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
			class delete;
			class VecRot;
		};
		class Camera
		{
			file="MG8\AVFEVFX\Functions\Camera";
			class 3DCompass;
			class Check_Optics;
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
			class canUseTurret;
		};
		class Lists
		{
			file="MG8\AVFEVFX\Functions\Unit_Lists";
			class IR_UnitList;
			class TGP_UnitList;
		};
		class UI
		{
			file="MG8\AVFEVFX\functions\UI";
			class TGP_Select_Confirm;
		};
	};
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
};

class CfgScriptPaths
{
	BCE_Function = "MG8\AVFEVFX\Functions\UI\";
};

class RscLine;
class RscInfoBack;
class RscText;
class RscPictureKeepAspect;

//Dialog
#include "Dialog.hpp"
#include "Control_UI.hpp"
