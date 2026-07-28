class cTab_FBCB2_dlg
{
		class controlsBackground: BCE_Mission_Build_Controls
		{
			class screen: cTab_RscMapControl
			{
				onMouseButtonDblClick = "call cTab_fnc_onMapDoubleClick";
			};
			#if MAP_MODE > 2
				class screenTopo: screen
				{
					#include "..\Map_Type\TOPO_GRD.hpp"
				};
			#endif
		};
	class controls
	{
		cTab_Set_SubMenu(SubMenuH_FB);
		class cTab_FBCB2_on_Weather_condition_Box: cTab_Tablet_OSD_Weather_condition_Box
		{
			x = "((((15) + ((685))) + ((15) + ((((810)) - (15) * 6) / 5)) * (0.3))) / 2048 * (safezoneW) + (safezoneX + (safezoneW - 	(safezoneW)) / 2)";
			y = "((608) + ((44) - (24)) / 2) / 2048  * ((safezoneW) * 4/3) + (safezoneY + (safezoneH - ((safezoneW) * 4/3)) / 2) + ((((44) - (15))) / 2048 * ((safezoneW) * 4/3))";
			w = "1.05 * ((((((810)) - (15) * 6) / 5)) / 2048 * (safezoneW))";
			h = QUOTE(0);
			
			size = "(((safezoneW / safezoneH) min 1.2) / 1.2) / 25";
			
			class Attributes: Attributes
			{
				size = QUOTE(0.9);
			};
		};
	};
};