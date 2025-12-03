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