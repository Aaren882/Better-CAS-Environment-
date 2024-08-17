class cTab_TAD_OSD_navModeOrScale;
class cTab_TAD_OSD_txtToggleIconBg;
class cTab_TAD_OSD_txtToggleIcon;
class cTab_TAD_RscMapControl_BLACK;
TAD_CLASS
{
	class controlsBackground
	{
		class screen: cTab_TAD_RscMapControl
		{
			#ifdef MOUSE_CLICK_EH
				showMarkers = 0;
			#else
				showMarkers = 1;
			#endif
			onMouseButtonDblClick = "call cTab_fnc_onMapDoubleClick";
		};
        class screenBlack: cTab_TAD_RscMapControl_BLACK
        {
			onMouseButtonDblClick = "call cTab_fnc_onMapDoubleClick";
        };
		#if MAP_MODE > 2
			class screenTopo: screen
			{
				#include "..\Map_Type\TOPO_AIR.hpp"
			};
		#endif
	};
	class controls
	{
        #ifdef MOUSE_CLICK_EH
            cTab_Set_SubMenu(SubMenuH_TAD);
        #endif
		class txtToggleMarker: cTab_TAD_OSD_navModeOrScale
		{
			idc = idc_D(1600);
			y = (647 - (32) / 2) / TAD_SizeY;
			w = (134) / 2048  * TAD_SizeW;
			h = 53 / 2048  * TAD_SizeH;
			sizeEx = ((42)) / 2048  * TAD_SizeH;
			text = "MARK";
		};
		//- Marker Color Text
		class txtCycleMarkerColor1: txtToggleMarker
		{
			idc = idc_D(1601);
			text = "TYPE";
			x = ((-(24) + (359) + (1330)) - (36) - (26) * 4) / TAD_SizeX;
			y = (836 - 53) / TAD_SizeY;
			w = ((26) * 4) / 2048  * TAD_SizeW;
		};
		class txtCycleMarkerColor2: txtCycleMarkerColor1
		{
			idc = idc_D(1602);
			text = "BLK";
			y = (836) / TAD_SizeY;
		};
		class CycleMarkerColorIconBg: cTab_TAD_OSD_txtToggleIconBg
		{
			idc = idc_D(1603);
			y = (836 - (53) / 2) / TAD_SizeY;
		};
		class CycleMarkerColorIcon: cTab_TAD_OSD_txtToggleIcon
		{
			idc = idc_D(16030);
			y = (836 - (32) / 2) / TAD_SizeY;
		};

		//- Bottons
			class btnfunction;
			class btnMarker: btnfunction
			{
				idc = idc_D(16010);
				tooltip = "$STR_BCE_Toggle_Marker_Dropper";
				y = (563) / TAD_SizeY;
				action = "['cTab_TAD_dlg',0] call cTab_fnc_toggleTADMarkerDropper";
			};
			class btnMarker_color: btnfunction //- Maybe will be Multi-Purpose
			{
				idc = idc_D(16011);
				tooltip = "$STR_BCE_Cycle_Marker";
				y = (760) / TAD_SizeY;
				action = "['cTab_TAD_dlg',1] call cTab_fnc_toggleTADMarkerDropper";
			};
	};
};