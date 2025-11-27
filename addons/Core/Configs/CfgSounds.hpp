#define set_Switch_Sound(NUM) \
	class switch_mod_0##NUM \
	{ \
		sound[] = {QUOTE(\a3\sounds_f_epb\Weapons\noise\switch_mod_0##NUM) ,1,1}; \
		titles[] = {}; \
	}
class CfgSounds
{
	set_Switch_Sound(1);
	set_Switch_Sound(2);
	set_Switch_Sound(3);
	set_Switch_Sound(4);
	set_Switch_Sound(5);
};