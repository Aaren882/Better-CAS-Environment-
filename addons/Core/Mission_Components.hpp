class BCE_Mission_Default
{
	class Air;
	class GND;
};
class BCE_Mission_Build_Controls
{
	class BCE_Holder: RscText
	{
		class BCE_Mission: BCE_Mission_Default{};
	};
  class taskDesc: RscStructuredText
	{
		class Attributes;
	};
	class TaskType;
	class New_Task_Ctrl_Title: BCE_RscButtonMenu
	{
		class ShortcutPos;
	};
	class New_Task_CFF_StructText: taskDesc {};
	class New_Task_AttackType_Combo;
	class New_Task_TG_DESC_Combo;
	class New_Task_CtrlType;
	class New_Task_AttackType;
	class New_Task_IPtype;
	class New_Task_TGT;
	class New_Task_MarkerCombo;
	class New_Task_IPExpression;
	class New_Task_TG_DESC;
	class New_Task_GRID_DESC;
	class New_Task_EGRS_Azimuth;
	class New_Task_EGRS_Bearing;
	class New_Task_EGRS;
	class New_Task_FRND_DESC;
	class New_Task_FADH;
	class New_Task_DangerClose_Text;
	class New_Task_DangerClose_Box;
	class New_Task_IE_Sheaf_Mode;
	class AI_Remark_WeaponCombo;
	class AI_Remark_ModeCombo;
	class Attack_Range_Combo;
	class Round_Count_Box;
	class Attack_Height_Box;
	class New_Task_AttackType_Title: New_Task_Ctrl_Title{};
	class New_Task_Ordnance_Title: New_Task_Ctrl_Title{};

	class New_Task_GRID_DESC_Air_5line;

	class CFF_IE_Radius_Box;
	class New_Task_IE_Sheaf_LINE_L;
	class New_Task_IE_Sheaf_LINE_W;
	class New_Task_IE_Sheaf_LINE_Mil;
	class New_Task_IE_Sheaf_LINE_L_T;
	class New_Task_IE_Sheaf_LINE_W_T;
	class New_Task_IE_Sheaf_LINE_Dir_T;
	class CFF_IE_WeaponCombo;
	class CFF_IE_FuzeCombo;
	class CFF_IE_FireUnit_Combo;
	class CFF_IE_Round_Box;
	class CFF_IE_FuzeValue_Box;
	class CFF_IE_FireAngle_Bnt;
	class New_Task_Adjust_Method_CFF;
	class New_Task_MissionType_ADJUST_CFF;
	class New_Task_MTO_Display
	{
		class Attributes;
	};
	class New_Task_OtherInfo_Display: New_Task_MTO_Display {};
	class New_Task_CFF_CtrlType;
	class New_Task_CFF_TOT;
	class New_Task_SUP_DESC_Checkboxes;
	class New_Task_SUP_DESC_Duration;
	class New_Task_SUP_RND_Interval;
	class New_Task_SUP_DESC_Interval;
	class New_Task_SUP_DESC_MinSec;
	class New_Task_SUP_DESC_SkipAdjust;
	class New_Task_CFF_SUP_StructText: New_Task_CFF_StructText {};
	class New_Task_CFF_SHEAF_StructText: New_Task_CFF_StructText {};
	class New_Task_Expression_CFF;

	class TaskType_GND;
	class Vehicle_Grp_Sel;

	class CFF_IA_WeaponCombo;
	class CFF_IA_FuzeCombo;
	class CFF_IA_FireUnit_Combo;
	class CFF_IA_Round_Box;
	class CFF_IA_FuzeValue_Box;
};