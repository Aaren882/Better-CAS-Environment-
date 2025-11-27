class BCE_Mission_Default {
	class AIR;
	class GND;
};

class BCE_Mission_Build_Controls
{
	class BCE_Holder: RscText {
		class BCE_Mission: BCE_Mission_Default{};
	};
	class Rsc_BCE_MapControl: RscMapControl {
		class BCE_Map_Events;
	};
  class TaskType: RscCombo {};
  class Vehicle_Grp_Sel: RscCombo {};
  class taskDesc: RscStructuredText {
    class Attributes;
	};
  class New_Task_Desc_Extended: taskDesc {};
  class New_Task_Ctrl_Title: BCE_RscButtonMenu {
    class Attributes;
	};
	class New_Task_CtrlType: RscToolbox {};
	class New_Task_AttackType_Title: New_Task_Ctrl_Title {};
	class New_Task_AttackType: New_Task_CtrlType {};
	class New_Task_AttackType_Combo: TaskType {};
	class New_Task_Ordnance_Title: New_Task_Ctrl_Title {};
	class AI_Remark_WeaponCombo: RscCombo {};
	class AI_Remark_ModeCombo: AI_Remark_WeaponCombo {};
	class Attack_Range_Combo: AI_Remark_ModeCombo {};
	class Round_Count_Box: RscEdit {};
	class Attack_Height_Box: Round_Count_Box {};
	class New_Task_IPtype: RscToolbox {};
	class New_Task_MarkerCombo: AI_Remark_WeaponCombo {};
	class New_Task_IPExpression: RscEdit {};
	class New_Task_TGT: New_Task_IPtype {};
	class New_Task_TG_DESC: RscEdit {};
	class New_Task_TG_DESC_Combo: RscCombo {};
	class New_Task_GRID_DESC: New_Task_IPExpression {};
	class New_Task_GRID_DESC_Air_5line: New_Task_GRID_DESC {};
	class New_Task_FRND_DESC: New_Task_GRID_DESC {};
	class New_Task_EGRS_Azimuth: RscToolbox {};
	class New_Task_EGRS_Bearing: New_Task_GRID_DESC {};
	class New_Task_EGRS: New_Task_IPtype {};
	class New_Task_FADH: New_Task_IPtype {};
	class New_Task_DangerClose_Text: RscText {};
	class New_Task_DangerClose_Box: RscCheckBox {};
	class TaskType_GND: TaskType {};
	class CFF_IE_WeaponCombo: AI_Remark_WeaponCombo {};
	class CFF_IE_FuzeCombo: AI_Remark_ModeCombo {};
	class CFF_IE_FireUnit_Combo: AI_Remark_ModeCombo {};
	class CFF_IE_Round_Box: Round_Count_Box {};
	class CFF_IE_Radius_Box: Attack_Height_Box {};
	class CFF_IE_FuzeValue_Box: CFF_IE_Round_Box {};
	class CFF_IE_FireAngle_Bnt: BCE_RscButtonMenu {
		class Attributes;
	};
	class CFF_IA_WeaponCombo: CFF_IE_WeaponCombo {};
	class CFF_IA_FuzeCombo: CFF_IE_FuzeCombo {};
	class CFF_IA_FireUnit_Combo: CFF_IE_FireUnit_Combo {};
	class CFF_IA_Round_Box: CFF_IE_Round_Box {};
	class CFF_IA_FuzeValue_Box: CFF_IE_FuzeValue_Box {};
	class New_Task_CFF_OT_Info: New_Task_IPtype {};
	class New_Task_CFF_CtrlType: New_Task_IPtype {
		class BCE_Data;
	};
	class New_Task_CFF_TOT: New_Task_EGRS_Bearing {};
	class New_Task_CFF_StructText: taskDesc {};
	class New_Task_Adjust_Method_CFF: RscToolbox {
		class BCE_Data;
	};
	class New_Task_MissionType_ADJUST_CFF: New_Task_Adjust_Method_CFF {};
	class New_Task_MTO_Display: RscStructuredText {
		class Attributes;
	};
	class New_Task_OtherInfo_Display: New_Task_MTO_Display {};
	class New_Task_IE_Sheaf_Mode: New_Task_IPtype {
		class BCE_Data;
	};
	class New_Task_IE_Sheaf_LINE_L: CFF_IE_Radius_Box {};
	class New_Task_IE_Sheaf_LINE_W: New_Task_IE_Sheaf_LINE_L {};
	class New_Task_IE_Sheaf_LINE_Mil: New_Task_IE_Sheaf_LINE_L {};
	class New_Task_IE_Sheaf_LINE_L_T: RscText {};
	class New_Task_IE_Sheaf_LINE_W_T: New_Task_IE_Sheaf_LINE_L_T {};
	class New_Task_IE_Sheaf_LINE_Dir_T: New_Task_IE_Sheaf_LINE_L_T {};
	class New_Task_SUP_DESC_Checkboxes: ctrlCheckboxes {};
	class New_Task_SUP_DESC_Duration: New_Task_GRID_DESC {};
	class New_Task_SUP_RND_Interval: New_Task_SUP_DESC_Duration {};
	class New_Task_SUP_DESC_Interval: New_Task_SUP_DESC_Duration {};
	class New_Task_SUP_DESC_SkipAdjust: New_Task_SUP_DESC_Checkboxes {};
	class New_Task_SUP_DESC_MinSec: New_Task_SUP_DESC_Checkboxes {};
	class New_Task_CFF_SHEAF_StructText: New_Task_CFF_StructText {};
	class New_Task_CFF_SUP_StructText: New_Task_CFF_StructText {};
	class New_Task_Expression_CFF: New_Task_IPExpression {};
};
