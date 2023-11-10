class cTab_android_btnHome;
class cTab_RscText_Android;

//-Clean up
#if MAP_MODE > 0
	class cTab_Tablet_RscMapControl: RscMapControl{showMarkers=0;};
	class cTab_android_RscMapControl: RscMapControl{showMarkers=0;};
	class cTab_microDAGR_RscMapControl: RscMapControl{showMarkers=0;};
	class cTab_TAD_RscMapControl: RscMapControl{showMarkers=0;};
#else
	class cTab_Tablet_RscMapControl: cTab_RscMapControl{showMarkers=0;};
	class cTab_android_RscMapControl: cTab_RscMapControl{showMarkers=0;};
	class cTab_microDAGR_RscMapControl: cTab_RscMapControl{showMarkers=0;};
	class cTab_TAD_RscMapControl: cTab_RscMapControl{showMarkers=0;};
#endif

//-Change TOPO -> Enhanced GPS