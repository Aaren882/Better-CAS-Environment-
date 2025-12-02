class ButtonACRE_Racks: RscButtonMenu
{
	REGISTER_FNC;
	idc = PROP_IDC(201141);

	text = "<img image='\idi\acre\addons\ace_interact\data\icons\rack3.paa' align='center' size='0.7' />";
	tooltip = "$STR_ACRE_sys_rack_Racks";
	style = 2;
	onButtonClick = "call BCE_fnc_ButtonRacks";
	class TextPos
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	colorBackground[] = {0,0,0,0.2};
	periodFocus = 0;
};
class ListACRE_Racks: New_Task_Unit_List
{
	REGISTER_FNC;
	idc = PROP_IDC(201142);
	
	onLBSelChanged = "";
	colorBorder[] = {1,1,1,1};
	colorSelect[] = {1,1,1,1};
	colorSelect2[] = {1,1,1,1};
	colorSelectRight[] = {1,1,1,1};
	colorSelect2Right[] = {1,1,1,1};
};