class CfgFunctions
{
	class BCE
	{
		class Initiation
		{
			// file="MG8\AVFEVFX\Functions";
			file=QPATHTOF(functions);
			class Init;
		};
		
		class Components
		{
			// file="MG8\AVFEVFX\Functions\Components";
			file=QPATHTOF(functions\Components);
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

			class getMarkerColor;

			class getAzimuth;
			class getAzimuthMil;
			class getTurretDir;
			class getUnitParams;
			class getMagazineAmmo;
			class getAmmoType;
			class getGroupVehicles;
			class CFF_getAmmoType;

			class Add_CountDown;
			
			class getCompatibleAVs;
			class getCompatibleARTYs;
		};
		
		
		class Fuze_Framework
		{
			// file="MG8\AVFEVFX\Functions\Fuze_Framework";
			file=QPATHTOF(functions\Fuze_Framework);
			class FuzeInit;
			class FuzeTrigger;
			class FuzeVT;
			class FuzeDelay;
		};
		class Gunner_Action
		{
			// file="MG8\AVFEVFX\Functions\Gunner_Action";
			file=QPATHTOF(functions\Gunner_Action);
			class gunnerLoop;
			class CreateLaser;
			class CreateSpotLight;
			class CreateLightSources;
			class deleteGunnerLaserSources;
			class deleteGunnerLightSources;
		};
		class LaserDesignator
		{
			// file="MG8\AVFEVFX\Functions\LaserDesignator";
			file=QPATHTOF(functions\LaserDesignator);
			class LaserDesignator;
			class deleteLaserDesignator;
			class isLaserOn;
		};
		class Camera
		{
			// file="MG8\AVFEVFX\Functions\Camera";
			file=QPATHTOF(functions\Camera);
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
			// file="MG8\AVFEVFX\Functions\Unit_Lists";
			file=QPATHTOF(functions\Unit_Lists);
			class IR_UnitList;
			class TGP_UnitList;
		};
		class DrawMap
		{
			// file="MG8\AVFEVFX\functions\DrawMap";
			file=QPATHTOF(functions\DrawMap);
			class DrawGPS;
			class DrawFOV;
			class TAC_Map;
		};
		class CFF_Actions
		{
			// file="MG8\AVFEVFX\functions\CAS_Event\Call_for_Fire";
			file=QPATHTOF(functions\CAS_Event\Call_for_Fire);
			class FindBestCharge;
			class doFireMission;
			class doAim_CFF;
			class getAllCharges;
			class getCharge;
			class UnstuckUnit;
			class get_CFF_Value;
			class set_CFF_Value;

			class getCurUnit_CFF;
			class getPos_Sheaf;

			//- Send Missions
				class Send_MSN_CFF;
		};
		class CFF_Method_of_Controls
		{
			// file="MG8\AVFEVFX\functions\CAS_Event\Call_for_Fire\MOC";
			file=QPATHTOF(functions\CAS_Event\Call_for_Fire\MOC);
			class CFF_AT_READY;
			class CFF_AMC;
			class CFF_ToT;
		};
		class CAS_Event
		{
			// file="MG8\AVFEVFX\functions\CAS_Event";
			file=QPATHTOF(functions\CAS_Event);
			class CAS_Action;
			class CFF_Action;
			class GunShip_Loiter;
			class Plane_CASEvent;
			class Send_Task_RadioMsg;
		};
		class CAS_Events
		{
			// file="MG8\AVFEVFX\functions\CAS_Event\Events";
			file=QPATHTOF(functions\CAS_Event\Events);
			class Send_Task_Event;
			class Delete_Task_Event;
			class Record_Task_Event;
			class RequestTasks_Task_Event;
			class RespondTasks_Task_Event;
		};
		class WPN_CheckList
		{
			// file="MG8\AVFEVFX\functions\CAS_Menu\WPN_CheckList";
			file=QPATHTOF(functions\CAS_Menu\WPN_CheckList);
			class checkList;
			class WPN_List_AIR;
			class WPN_List_CFF;

			class SelWPN_AIR;
			class SelWPN_CFF;
		};
		class Map_Click
		{
			// file="MG8\AVFEVFX\functions\CAS_Menu\Map_Click";
			file=QPATHTOF(functions\CAS_Menu\Map_Click);
			class GetMapClickPOS;
		};
		class CAS_Menu
		{
			// file="MG8\AVFEVFX\functions\CAS_Menu";
			file=QPATHTOF(functions\CAS_Menu);
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
        //- BCE Interface control Holder
          class onLoad_BCE_Holder;
          class onLoad_BCE_Map_Holder;
          class get_BCE_Holder;
          class get_BCE_Holder_Name;

				class get_BCE_curDisplay;
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
			// file="MG8\AVFEVFX\functions\CAS_Menu\Fire_Mission\Map_Infos";
			file=QPATHTOF(functions\CAS_Menu\Fire_Mission\Map_Infos);
			class Update_TaskMapInfo;
			class Update_TaskMapInfo_Icons;
			class Update_TaskMapInfo_Lines;

			class get_TaskMapInfo;
			class get_TaskMapInfoEntry;

			//- Draw Infos
				class draw_TaskMapInfo;
				class drawEach_TaskMapInfo;
		};
		class Fire_Mission
		{
			// file="MG8\AVFEVFX\functions\CAS_Menu\Fire_Mission";
			file=QPATHTOF(functions\CAS_Menu\Fire_Mission);
			class getTaskProps;
			class getDisplayTaskProps;
			class get_TaskIndex;
			class get_TaskCateIndex;

			//- BCE handling Functions
				class get_BCE_TaskClass;
				class get_BCE_TaskCateClass;
				class get_BCE_TaskCateClasses;
				class get_BCE_Task_Interface;
			
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
			// file="MG8\AVFEVFX\functions\CAS_Menu\Fire_Mission\Events";
			file=QPATHTOF(functions\CAS_Menu\Fire_Mission\Events);
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
			// file="MG8\AVFEVFX\functions\CAS_Menu\Call_for_fire";
			file=QPATHTOF(functions\CAS_Menu\Call_for_fire);
			class CFF_Mission_XMIT;

			class CFF_Mission_EOM; 				//- End of Mission
			class CFF_Mission_STOP; 			//- Stop/Remove CFF mission
			class CFF_Mission_RAT; 				//- Record as Target
			class CFF_Mission_RAT_2_ADD;	//- Add the Mission

			class CFF_Mission_AutoSaveTask;

			class CFF_Mission_Get_Group;
			class CFF_Mission_Get_Group_Units;
			class CFF_Mission_CheckActive;
			class CFF_Mission_CheckActive_Units;

			class CFF_Mission_Get_Values;
			class CFF_Mission_Set_Values;
			class CFF_Mission_Get_RAT_Values;
			class CFF_Mission_Set_RAT_Values;

			class UpdateFireAdjust;
			class set_FireAdjust_MSN_State;
			class CleanFireAdjustValues;
			class get_FireAdjustValues;
			class set_FireAdjustValues;
		};
		class Task_Receiver
		{
			// file="MG8\AVFEVFX\functions\Task_Receiver";
			file=QPATHTOF(functions\Task_Receiver);
			class UpdateTaskInfo;
			class SetTaskReceiver;
		};
		class UI
		{
			// file="MG8\AVFEVFX\functions\UI";
			file=QPATHTOF(functions\UI);
			class TGP_Select_Confirm;
			class Update_MapCtrls;
		};
		class Task_Type
		{
			// file="MG8\AVFEVFX\functions\Task_Type";
			file=QPATHTOF(functions\Task_Type);
			class SelChanged_AIR;
			class SelChanged_ADJ;
			class SelChanged_SUP;

			class clearTask5line;
			class clearTask9line;
			class clearTaskCFF;

			class DataReceive5line;
			class DataReceive9line;
			class DataReceive_ADJ;
			class DataReceive_SUP;
			class DataReceive_IMM_SUP;

			class DataSent_AIR;
			class DataSent_CFF;
			
			class SendData5line;
			class SendData9line;
			class SendDataCFF;

			//- OLD ones
				class DblClick5line_OLD;
				class DblClick9line_OLD;

			class DblClick5line;
			class DblClick9line;
			class DblClickADJ;
			class DblClickSUP;

			class LBTaskTypeChanged;
			class LBTaskUnitChanged;

			class TaskUnitChanged_CFF;
		};
	};
};
