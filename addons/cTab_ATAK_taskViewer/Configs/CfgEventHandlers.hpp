class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_PreInit));
	};
};
class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_PostInit));
		serverInit = QUOTE(call COMPILE_FILE(XEH_serverPostInit));
		clientInit = QUOTE(call COMPILE_FILE(XEH_clientPostInit));
	};
};