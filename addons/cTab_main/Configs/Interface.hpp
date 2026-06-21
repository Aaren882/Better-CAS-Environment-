//- Normal intractable UI
#include "..\..\cTab\UI\cTab_UI_Base.hpp" // <== IS_DIALOG
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
	#undef IS_DIALOG
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

	//- Additional UI
	#include "..\UI\ScreenShot_UI.hpp"
	#include "..\UI\cTab_HCam.hpp"
};