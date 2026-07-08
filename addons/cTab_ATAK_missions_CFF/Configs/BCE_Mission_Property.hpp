class BCE_Mission_Property
{
	class GND //- Ground Fire Support
	{
		class ADJ
		{
			class Events;
		};
		class SUP
		{
			class Events;
		};
		class IMM_SUP
		{
			class Events;
		};
		
		class ADJ_ATAK: ADJ
		{
			class Events: Events
			{
				LBTaskUnitChanged = QEFUNC(cTab_ATAK_missions,ATAK_LBTaskUnitChanged); //- For the TaskUnit Selection
				LBTaskTypeChanged = QFUNC(ATAK_TaskTypeChanged); //- For the TaskType Selection
			};
		};
		class SUP_ATAK: SUP
		{
			class Events: Events
			{
				LBTaskUnitChanged = QEFUNC(cTab_ATAK_missions,ATAK_LBTaskUnitChanged); //- For the TaskUnit Selection
				LBTaskTypeChanged = QFUNC(ATAK_TaskTypeChanged); //- For the TaskType Selection
			};
		};
		class IMM_SUP_ATAK: IMM_SUP
		{
			class Events: Events
			{
				LBTaskUnitChanged = QEFUNC(cTab_ATAK_missions,ATAK_LBTaskUnitChanged); //- For the TaskUnit Selection
				LBTaskTypeChanged = QFUNC(ATAK_TaskTypeChanged); //- For the TaskType Selection
			};
		};
	};
};