//-Clean up
#if MAP_MODE > 0
	//-Change TOPO -> Enhanced GPS
	class cTab_Tablet_RscMapControl: RscMapControl{};
	class cTab_microDAGR_RscMapControl: RscMapControl{};
	class cTab_TAD_RscMapControl: RscMapControl{};
#else
	class cTab_Tablet_RscMapControl: cTab_RscMapControl{};
	class cTab_microDAGR_RscMapControl: cTab_RscMapControl{};
	class cTab_TAD_RscMapControl: cTab_RscMapControl{};
#endif