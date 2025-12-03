class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};
//- #TODO : CBA style preprocessing script compile
class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};