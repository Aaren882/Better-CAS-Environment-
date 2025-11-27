#define SubMenuText 0.8

//-17000 + SET
#define TASK_OFFSET 17000
#define idc_D(SET) __EVAL(TASK_OFFSET+SET)

//-desktop icons
#define APP_BFT "\cTab\img\cTab_BFT_ico.paa"
#define APP_UAV QPATHTOF(data\AV_Cam.paa)
#define APP_MSG QPATHTOF(data\mail.paa)

//-SubMenus
#define MAINSUB 5
#define E_SUB1 9
#define E_SUB2 6
#define E_SUB3 10
#define E_SUB4 8
#define C_SUB1 5
#define G_SUB1 11

#define MAINSUB_P 4
#define E_SUB1_P 9
#define E_SUB2_P 6
#define E_SUB3_P 10
#define E_SUB4_P 8
#define C_SUB1_P 5
#define G_SUB1_P 11

//-SubMenu W H
#define SubMenuW ((12 + 1.5) * ((27)) / 2048 * (safezoneH * 1.2) * 3/4 * 0.5)

#define SubMenuH (27 / 2048 * (safezoneH * 1.2) / 0.8)
#define SubMenuH_P (27 / 2048 * ((safezoneW * 0.8) * 4/3) / 0.8)
#define SubMenuH_FB (24 / 2048 * ((safezoneW) * 4/3) / 0.8)
#define SubMenuH_TAD ((42 / 2048 * (safezoneH * 0.8)) / 0.8)

#define REMOVE_SCROLL \
	class VScrollbar: VScrollbar \
	{ \
		width = 0; \
		scrollSpeed = 0; \
	}; \
	class HScrollbar: HScrollbar \
	{ \
		height = 0; \
		scrollSpeed = 0; \
	}

//-Set Submenu 
#define SetSubMenu(CLASS,LINE,SIZE_H) \
	class CLASS: cTab_RscControlsGroup \
	{ \
		h = QUOTE(LINE * SIZE_H); \
		REMOVE_SCROLL; \
	}

//-Tablet POS
#define TabletLX ((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3)) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))
#define TabletRX (((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048 * ((safezoneH * 1.2) * 3/4))

#define TabletTY ((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) - ((491) + (42))) / 2048 * (safezoneH * 1.2))
#define TabletDY (((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048 * (safezoneH * 1.2))

#define TabletW ((((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048 * ((safezoneH * 1.2) * 3/4))
#define TabletH ((((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048 * (safezoneH * 1.2))

//-Default
#define PHONE_MOD 1167

//-Check if the cTab is "NSWDG Edition"
/* #if __has_include("\cTab\bis_addoninfo.hpp")
	#define PHONE_MOD 1098
	
	//-SubMenus
	#define E_SUB1 8
	#define E_SUB1_P 8
	
	#define G_SUB1 3
	#define G_SUB1_P 3
	
	#define SubMenuH (27 / 2048 * (safezoneH * 1.2) / 0.8)
	#define SubMenuH_P (27 / 2048 * ((safezoneW * 0.8) * 4/3) / 0.8)
	#define SubMenuH_FB (24 / 2048 * ( (safezoneW) * 4/3) / 0.8)
	#define SubMenuH_TAD ((42 / 2048  *  (safezoneH * 0.8)) / 0.8)
#endif */

#define SubMenuID_FIX(SIZE_H) \
	SetSubMenu(GenSub1,G_SUB1,SIZE_H)


//-Check if the cTab is "Devastator Edition"
/* #if __has_include("\cTab\img\rp_ca.paa")
	#define SubMenuID_FIX(SIZE_H) \
		class GenSub1: cTab_RscControlsGroup \
		{ \
			h = G_SUB1 * SIZE_H; \
			REMOVE_SCROLL; \
			class Controls \
			{ \
				class aopbtn: cTab_MenuItem \
				{ \
					action = "cTabUserSelIcon set [1,40];[1] call cTab_fnc_userMenuSelect;"; \
				}; \
			}; \
		}
#endif */

//-Submenu btn
#define SubMenuNEbnt \
	class controls \
	{ \
		class nthbtn; \
		class nebtn: nthbtn{}; \
	}

//-SubMenu + BCE Submenu
#define cTab_Set_SubMenu(SIZE_H) \
	SetSubMenu(MainSubmenu,MAINSUB_P,SIZE_H); \
	SetSubMenu(EnemySub1,E_SUB1_P,SIZE_H); \
	SetSubMenu(EnemySub2,E_SUB2_P,SIZE_H); \
	class EnemySub3: cTab_RscControlsGroup \
	{ \
		h = QUOTE(E_SUB3_P * SIZE_H); \
		REMOVE_SCROLL; \
		SubMenuNEbnt; \
	}; \
	SetSubMenu(EnemySub4,E_SUB4_P,SIZE_H); \
	SetSubMenu(CasulSub1,C_SUB1_P,SIZE_H); \
	SubMenuID_FIX(SIZE_H); \
	class Connect_Veh_Submenu: MainSubmenu \
	{ \
		idc = idc_D(3300); \
		h = QUOTE(2 * SIZE_H); \
		class controls \
		{ \
			class mainbg: cTab_IGUIBack \
			{ \
				idc = -1; \
				x = 0; \
				y = 0; \
				w = QUOTE(SubMenuW); \
				h = QUOTE(2 * SIZE_H); \
			}; \
			class connect: cTab_MenuItem \
			{ \
				idc = -1; \
				text = "Connect Vehicle"; \
				style = 2; \
				x = 0; \
				y = 0; \
				w = QUOTE(SubMenuW); \
				h = QUOTE(SIZE_H); \
				sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)"; \
				action = "[3] call cTab_fnc_userMenuSelect;"; \
			}; \
			class exit: cTab_MenuExit \
			{ \
				idc = -1; \
				text = "Exit"; \
				x = 0; \
				y = QUOTE(SIZE_H); \
				w = QUOTE(SubMenuW); \
				h = QUOTE(SIZE_H); \
				sizeEx = "((27)) / 2048 * (safezoneH * 1.2)"; \
				action = "[0] call cTab_fnc_userMenuSelect;"; \
			}; \
		}; \
	}; \
	class DisConnect_Veh_Submenu: Connect_Veh_Submenu \
	{ \
		idc = idc_D(33000); \
		class controls: controls \
		{ \
			class mainbg: mainbg{}; \
			class connect: connect \
			{ \
				text = "Disconnect"; \
				action = "[-3] call cTab_fnc_userMenuSelect;"; \
			}; \
			class exit: exit{}; \
		}; \
	}
	
//-Check if it's "1erGTD"
// #if __has_include("\z\ctab\addons\core\config.bin")
	#define PHONE_MOD 1134
	
	#define APP_BFT "\cTab\img\icon_bft_ca.paa"
	
	//-Tablet POS
	#define TabletLX ((((((257)) + (((1341)) - 2 * ((560) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49))) / 3)) - ((257))) / 2048  * ((safezoneH * 1.2) * 3/4))
	#define TabletRX (((((((257)) + ((560) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49)) + (((1341)) - 2 * ((560) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49))) / 3 * 2) + ((1) / (560) * ((560) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49))))) - ((257))) / 2048  * ((safezoneH * 1.2) * 3/4))
	
	#define TabletTY ((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1335) * (50)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49)) / 3)) - ((491) + (42))) / 2048  * (safezoneH * 1.2))
	#define TabletDY (((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1335) * (50)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49)) / 3 * 2) + ((38) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49)))) - ((491) + (42))) / 2048  * (safezoneH * 1.2))
	
	#define TabletW ((((558) / (560) * ((560) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49)))) / 2048  * ((safezoneH * 1.2) * 3/4))
	#define TabletH ((((369) / (408) * ((((993) - (42) - (0)) - (((1341)) / (1335) * (50))) * 0.49))) / 2048  * (safezoneH * 1.2))
	
	//-SubMenu
	#define MAINSUB 8
	#define E_SUB1 10
	#define E_SUB2 6
	#define E_SUB3 6
	#define E_SUB4 8
	#define C_SUB1 5
	#define G_SUB1 5
	
	#define MAINSUB_P 7
	#define E_SUB1_P 10
	#define E_SUB2_P 6
	#define E_SUB3_P 6
	#define E_SUB4_P 8
	#define C_SUB1_P 5
	#define G_SUB1_P 5
	
	//-SubMenu W H
	#define SubMenuW ((20 + 1.5) * ((27)) / 2048 * (safezoneH * 1.2) * 3/4 * 0.5)
	
	#define SubMenuH (((27)) / 2048  * (safezoneH * 1.2) / 0.8)
	#define SubMenuH_P ((27) / 2048  * ((safezoneW * 0.8) * 4/3) / 0.8)
	#define SubMenuH_FB (((24)) / 2048 * ((safezoneW) * 4/3) / 0.8)
	#define SubMenuH_TAD ((((42)) / 2048 * (safezoneH * 0.8)) / 0.8)
	
	//-Set SubMenu
	#define lerGTD_SUB(CLASS1,CLASS2,LINE,SIZE_H) \
		class CLASS1: cTab_RscControlsGroup \
		{ \
			REMOVE_SCROLL; \
			h = QUOTE(LINE * SIZE_H); \
			class controls \
			{ \
				class CLASS2: cTab_MenuExit{}; \
			}; \
		}
	
	//-Text 
	#define AV_Members \
		class HUAVListTL: cTab_RscText_WindowTitle \
		{ \
			colorText[] = {1,1,1,1}; \
			text = "Crew Members"; \
			Shadow = 2; \
		}
	
	#undef SubMenuNEbnt
	
	// - lerGTD SubMenu
	// - SubMenu + lerGTD SubMenu + BCE Submenu
	#define cTab_Set_SubMenu(SIZE_H) \
		SetSubMenu(MainSubmenu,MAINSUB_P,SIZE_H); \
		SetSubMenu(EnemySub1,E_SUB1_P,SIZE_H); \
		SetSubMenu(EnemySub2,E_SUB2_P,SIZE_H); \
		class EnemySub3: cTab_RscControlsGroup \
		{ \
			h = QUOTE(E_SUB3_P * SIZE_H); \
			REMOVE_SCROLL; \
		}; \
		SetSubMenu(EnemySub4,E_SUB4_P,SIZE_H); \
		SetSubMenu(CasulSub1,C_SUB1_P,SIZE_H); \
		SetSubMenu(GenSub1,G_SUB1_P,SIZE_H); \
		lerGTD_SUB(MenuCustomText,btn8,8,SIZE_H); \
		lerGTD_SUB(MenuControlPoint,btn9,9,SIZE_H); \
		lerGTD_SUB(MenuManoeuvre,btn5,5,SIZE_H); \
		lerGTD_SUB(MenuSustainment,btn5,5,SIZE_H); \
		class Connect_Veh_Submenu: MainSubmenu \
		{ \
			idc = idc_D(3300); \
			h = QUOTE(2 * SIZE_H); \
			class controls \
			{ \
				class mainbg: cTab_IGUIBack \
				{ \
					idc = -1; \
					x = 0; \
					y = 0; \
					w = QUOTE(SubMenuW); \
					h = QUOTE(2 * SIZE_H); \
				}; \
				class connect: cTab_MenuItem \
				{ \
					idc = -1; \
					text = "Connect Vehicle"; \
					style = 2; \
					x = 0; \
					y = 0; \
					w = QUOTE(SubMenuW); \
					h = QUOTE(SIZE_H); \
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)"; \
					action = "[3] call cTab_fnc_userMenuSelect;"; \
				}; \
				class exit: cTab_MenuExit \
				{ \
					idc = -1; \
					text = "Exit"; \
					x = 0; \
					y = QUOTE(SIZE_H); \
					w = QUOTE(SubMenuW); \
					h = QUOTE(SIZE_H); \
					sizeEx = "((27)) / 2048 * (safezoneH * 1.2)"; \
					action = "[0] call cTab_fnc_userMenuSelect;"; \
				}; \
			}; \
		}; \
		class DisConnect_Veh_Submenu: Connect_Veh_Submenu \
		{ \
			idc = idc_D(33000); \
			class controls: controls \
			{ \
				class mainbg: mainbg{}; \
				class connect: connect \
				{ \
					text = "Disconnect"; \
					action = "[-3] call cTab_fnc_userMenuSelect;"; \
				}; \
				class exit: exit{}; \
			}; \
		}

// #endif

#define MAP_MODE 0

//-Map DarkMode
/* #if __has_include("\z\darkmap\addons\main\config.bin")
	#define MAP_MODE 1
#endif 
#if __has_include("\z\darkmap_ace\addons\main\config.bin")
	#define MAP_MODE 1
#endif

//-Enhanced Map
#if __has_include("\DIS_enhanced_map\config.cpp")
	#define MAP_MODE 2
#endif
#if __has_include("\DIS_enhanced_map_ace\config.cpp")
	#define MAP_MODE 2
#endif

//-Enhanced GPS
#if __has_include("\DIS_enhanced_GPS\config.cpp")
	#define MAP_MODE 3
#endif */