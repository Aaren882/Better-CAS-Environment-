PHONE_CLASS // #LINK - addons/cTab/UI/cTab_Macros_Interface.hpp
{
	class controls
	{
		//-POLPOX Map Tools Widgets
		class Map_Tool_Show;
		class Map_Tool_Show_PLP_widgets: Map_Tool_Show
		{
			idc = idc_D(1202);
			text = "a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa";
			toolTip = "MapTools Remastered";
			Y = QUOTE(sizeY(2.25) - (sizeW * PhoneW));
			action = "['cTab_Android_dlg','PLP_mapTools'] call cTab_fnc_toggleMapTools;";
		};
		class Map_Tool_PLP_widgets: RscToolbox
		{
			idc = idc_D(12012);

			Y = QUOTE(sizeY(5.25 + 2.25) - (sizeW * PhoneW));
			w = QUOTE(sizeW * (PhoneW * 3/4));
			h = QUOTE(3.5 * (sizeW * PhoneW));

			rows = 7;
			columns = 1;
			strings[] =
			{
				"$STR_BCE_PLP_Title_Distance",
				"$STR_BCE_PLP_Title_Mark_House",
				"$STR_BCE_PLP_Title_Height",
				"$STR_BCE_PLP_Title_Compass",
				"$STR_BCE_PLP_Title_Edit_Grid",
				"$STR_BCE_PLP_Title_Find_Flat",
				"$STR_BCE_PLP_Title_Line_of_Sight"
			};
			tooltips[] =
			{
				"$STR_BCE_PLP_Tip_Distance",
				"$STR_BCE_PLP_Tip_Mark_House",
				"$STR_BCE_PLP_Tip_Height",
				"$STR_BCE_PLP_Tip_Compass",
				"$STR_BCE_PLP_Tip_Edit_Grid",
				"$STR_BCE_PLP_Tip_Find_Flat",
				"$STR_BCE_PLP_Tip_Line_of_Sight"
			};
			colorBackground[] = {0,0,0,0.25};
			onToolBoxSelChanged = "call BCE_fnc_ctab_BFT_ToolBox";
		};
		
		//-Tool Description
		class BCE_MapTools_Tooltip: PLP_SMT_Description{};
	};
};

class cTab_Tablet_dlg
{
	class controls
	{
		//-POLPOX Map Tools Widgets
		class Map_Tool_Show;
		class Map_Tool_Show_PLP_widgets: Map_Tool_Show
		{
			idc = idc_D(1202);
			//text = "\a3\3den\data\displays\display3den\panelright\customcomposition_editentities_ca.paa";
			text = "\a3\3den\data\displays\display3den\toolbar\grid_rotation_off_ca.paa";
			toolTip = "MapTools Remastered";
			Y = QUOTE(sizeY(2.25) - (sizeW * (safezoneH * 1.2)));
			action = "['cTab_Tablet_dlg','PLP_mapTools'] call cTab_fnc_toggleMapTools;";
		};
		class Map_Tool_PLP_widgets: RscToolbox
		{
			idc = idc_D(12012);

			Y = QUOTE(sizeY(5.25 + 2.25) - (sizeW * (safezoneH * 1.2)));
			w = QUOTE(sizeW * ((safezoneH * 1.2) * 3/4));
			h = QUOTE(3.5 * (sizeW * (safezoneH * 1.2)));

			rows = 7;
			columns = 1;
			strings[] =
			{
				"$STR_BCE_PLP_Title_Distance",
				"$STR_BCE_PLP_Title_Mark_House",
				"$STR_BCE_PLP_Title_Height",
				"$STR_BCE_PLP_Title_Compass",
				"$STR_BCE_PLP_Title_Edit_Grid",
				"$STR_BCE_PLP_Title_Find_Flat",
				"$STR_BCE_PLP_Title_Line_of_Sight"
			};
			tooltips[] =
			{
				"$STR_BCE_PLP_Tip_Distance",
				"$STR_BCE_PLP_Tip_Mark_House",
				"$STR_BCE_PLP_Tip_Height",
				"$STR_BCE_PLP_Tip_Compass",
				"$STR_BCE_PLP_Tip_Edit_Grid",
				"$STR_BCE_PLP_Tip_Find_Flat",
				"$STR_BCE_PLP_Tip_Line_of_Sight"
			};
			colorBackground[] = {0,0,0,0.25};
			onToolBoxSelChanged = "call BCE_fnc_ctab_BFT_ToolBox";
		};
		
		//-Tool Description
		class BCE_MapTools_Tooltip: PLP_SMT_Description{};
	};
};