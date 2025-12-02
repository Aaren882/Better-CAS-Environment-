class RscDisplayMainMap
{
	class controlsBackground
	{
		class CA_Map: RscMapControl
		{
			onDraw="call BCE_fnc_drawGPS; [ctrlParent (_this # 0)] call ace_map_fnc_onDrawMap;";
		};
	};
	class controls
	{
		class BCE_Task_toggle;
		class BCE_MapLight_toggle: BCE_Task_toggle
		{
			idc = 1608;
			text = "$STR_BCE_Map_Tit_illumination";
			tooltip = "$STR_BCE_Map_illumination";
			onButtonClick = "[_this # 0,2] call BCE_fnc_Update_MapCtrls";
			y = MAP_TOGGLE_Y(1,1);
			w = "5 * (((safezoneW / safezoneH) min 1.2) / 40) + (0.5 * 0.015)";
		};
	};
};