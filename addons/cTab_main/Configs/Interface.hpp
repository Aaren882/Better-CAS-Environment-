//- Normal intractable UI
#include "..\UI\cTab_Layouts.hpp"

//- Apply Map for DAGR
#if MAP_MODE > 2
	class cTab_microDAGR_dlg
	{
		class controlsBackground: BCE_Mission_Build_Controls
		{
			class screen: cTab_microDAGR_RscMapControl{};
			class screenTopo: screen
			{
				#include "..\Map_Type\TOPO_GRD.hpp"
			};
		};
	};
#endif

//- Hovers on the Screen cannot be interacted with mouse
class RscTitles
{
	//- Additional UI
	#include "..\UI\Display\cTab_HCam.hpp"

	#undef IS_DIALOG
	#include "..\UI_Components.hpp"
	#include "..\UI\cTab_Layouts.hpp"

	//- Apply Map for DAGR
	#if MAP_MODE > 2
		class cTab_microDAGR_dsp
		{
			class controlsBackground
			{
				class screen: cTab_microDAGR_RscMapControl{}; 
				class screenTopo: screen
				{
					#include "..\Map_Type\TOPO_GRD.hpp"
				};
			};
		};
	#endif
};