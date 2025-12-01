class RscDisplayMainMap
{
	class controlsBackground
	{
		class CA_Map: RscMapControl
		{
			onDraw="call BCE_fnc_drawGPS; [ctrlParent (_this # 0)] call ace_map_fnc_onDrawMap;";
		};
	};
};