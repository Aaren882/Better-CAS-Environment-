class cTab_android_btnHome;
class cTab_RscText_Android;

//-Clean up
#if MAP_MODE > 0
	class cTab_Tablet_RscMapControl: RscMapControl{};
	class cTab_android_RscMapControl: RscMapControl{};
	class cTab_microDAGR_RscMapControl: RscMapControl{};
	class cTab_TAD_RscMapControl: RscMapControl{};
#else
	class cTab_Tablet_RscMapControl: cTab_RscMapControl{};
	class cTab_android_RscMapControl: cTab_RscMapControl{};
	class cTab_microDAGR_RscMapControl: cTab_RscMapControl{};
	class cTab_TAD_RscMapControl: cTab_RscMapControl{};
#endif

//-Change TOPO -> Enhanced GPS