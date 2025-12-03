class New_Task_Unit_Title: RscStructuredText
{
	REGISTER_FNC;
	idc = PROP_IDC(20114);

	shadow = 1;
	colorBackground[] = {0,0,0,0};
	size = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
	sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "center";
		valign="middle";
		shadow = 1;
		size = 1;
	};
	class TextPos
	{
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	text = "<t size='1' align='left'>%1 - %2</t>";
};
class New_Task_Unit_Pic: RscPictureKeepAspect
{
	REGISTER_FNC;
	idc = PROP_IDC(20115);

	text = "\A3\Ui_f\data\IGUI\RscIngameUI\RscOptics\square.paa";
};
class New_Task_Unit_List: RscListBox
{
	REGISTER_FNC;
	idc = PROP_IDC(20116);

	text = "";
	colorBackground[] = {0,0,0,0};
	colorSelect[] = {0,1,0,1};
	colorSelect2[] = {0,1,0,1};
	colorSelectRight[] = {0,1,0,1};
	colorSelect2Right[] = {0,1,0,1};
	colorSelectBackground[] = {0,0,0,0};
	colorSelectBackground2[] = {0,0,0,0};
	period = 0;

	onLBSelChanged = "call BCE_fnc_unitList_info";
};