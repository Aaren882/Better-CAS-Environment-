class cTab_Tablet_dlg
{
	class controls: BCE_Mission_Build_Controls
	{
		#define InfoPOS(XPOS,HPOS) \
			x = QUOTE(XPOS * ContW + smalSpc); \
			y = QUOTE(1.65 * ContH); \
			w = QUOTE(ContW); \
			h = QUOTE(HPOS * (smalFmH - (2.75 * ContH)))
		
		class Task_Builder_TopLeft;
		class Task_Builder_TopRight: Task_Builder_TopLeft
		{
			class controls
			{
				class Vic_Crew_Info_List: cTab_RscListbox_Tablet
				{
					InfoPOS(0,0.5);
				};
				class Vic_ACRE_Info_List: Vic_Crew_Info_List
				{
					idc = idc_D(17850);

					colorBackground[] = {0,0,0,0};
					colorSelect[] = {1,1,1,1};
					colorSelect2[] = {1,1,1,1};
					colorSelectRight[] = {1,1,1,1};
					colorSelect2Right[] = {1,1,1,1};
					soundSelect[] = {"",0,1};
					onLBSelChanged = "";

					x = QUOTE(0);
					y = QUOTE((1.65 * ContH) + (0.5 * (smalFmH - (2.75 * ContH))));
					w = QUOTE(ContW);
					h = QUOTE(0.5 * (smalFmH - (2.75 * ContH)));
				};
			};
		};
	};
};