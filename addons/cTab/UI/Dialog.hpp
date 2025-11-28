class RscTitles
{
	#undef MOUSE_CLICK_EH

	#define TAD_CLASS class cTab_TAD_dsp
	#define TAD_SizeH (0.86)
	#define TAD_SizeW (TAD_SizeH * 3/4)
	#define TAD_SizeX 2048 * (TAD_SizeH * 3/4) + (safeZoneX + (0.05) * 3/4)
	#define TAD_SizeY 2048 * TAD_SizeH + (safeZoneY + safeZoneH - TAD_SizeH - (0.2))
		#include "cTab_TAD.hpp"

	#define PHONE_CLASS class cTab_Android_dsp
	
	#define PhoneH (safezoneH * 0.8)
	#define PhoneW (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_W',(safezoneW * 0.443437)])
	
	//-Custom Layout
	#define CustomPhoneH (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_H',(PhoneW * 4/3)])
	#define CustomPhoneX (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_X',(safezoneX - PhoneW * 0.17)])
	#define CustomPhoneY (profilenamespace getvariable ['IGUI_GRID_cTab_ATAK_DSP_Y',(safezoneY + safezoneH * 0.88 - CustomPhoneH * 0.72)])

	#define TextSize (((38)) / 2048 * CustomPhoneH)
	#define TextTimes 2.537
	#define TextTimesH (((safezoneW * 0.8) * 4/3) / CustomPhoneH)
	
	#define phoneSizeX (((452)) / 2048 * PhoneW + CustomPhoneX)
	#define phoneSizeY ((((713) + (60))) / 2048 * CustomPhoneH + CustomPhoneY)
	#define phoneSizeW ((((PHONE_MOD))) / 2048 * PhoneW)
	#define phoneSizeH ((((626) - (60) - (0))) / 2048 * CustomPhoneH)
	
	
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
	
	//-Phone Layout
	#include "cTab_classes.hpp"
	
	//-Phone display
	#include "cTab_Android.hpp"
	#include "ScreenShot_UI.hpp"
	#include "cTab_HCam.hpp"
};