class BCE_Mission_Property
{
	class AIR //- Air Fire Support
	{
		class AIR_9_LINE
		{
			class Events;
		};
		class AIR_5_LINE
		{
			class Events;
		};
		class AIR_9_LINE_ATAK: AIR_9_LINE
		{
			Controls[] = 
			{
				{
					"","New_Task_CtrlType",
					"","New_Task_AttackType_Combo",
					"",
					"AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
				},
				{
					"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression"
				},
				{},
				{},
				{},
				{"New_Task_TG_DESC"},
				{"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
				{"New_Task_GRID_DESC"},
				{"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression","New_Task_FRND_DESC"},
				{"New_Task_EGRS","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_MarkerCombo"},
				{"New_Task_FADH","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_DangerClose_Text","New_Task_DangerClose_Box"}
			};
			class Events: Events
			{
				LBTaskTypeChanged = QEFUNC(cTab_ATAK_missions,ATAK_TaskTypeChanged); //- For the TaskType Selection
			};
		};
		class AIR_5_LINE_ATAK: AIR_5_LINE
		{
			Controls[] = {
				{
					"","New_Task_CtrlType",
					"","New_Task_AttackType_Combo",
					"",
					"AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
				},
				{"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression","New_Task_GRID_DESC_Air_5line"},
				{"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
				{"New_Task_TG_DESC","New_Task_GRID_DESC"},
				{"New_Task_FADH","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_DangerClose_Text","New_Task_DangerClose_Box"}
			};

			class Events: Events
			{
				TaskUnitChanged = QFUNC(ATAK_TaskUnitChanged_AIR); //- For the TaskUnit Selection
				LBTaskTypeChanged = QEFUNC(cTab_ATAK_missions,ATAK_TaskTypeChanged); //- For the TaskType Selection
			};
		};
	};
};