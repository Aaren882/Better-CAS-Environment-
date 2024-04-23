class cTab_CfgMarkers
{
    class OPFOR
    {
        class unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_unknown";
            icon = "\A3\ui_f\data\map\markers\nato\o_unknown.paa";
            color[] = 
            {
                "(profilenamespace getvariable ['Map_OPFOR_R',0])",
                "(profilenamespace getvariable ['Map_OPFOR_G',1])",
                "(profilenamespace getvariable ['Map_OPFOR_B',1])",
                "(profilenamespace getvariable ['Map_OPFOR_A',0.8])"
            };
        };
        class inf: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_inf";
            icon = "\A3\ui_f\data\map\markers\nato\o_inf.paa";
        };
        class motor_inf: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_motor_inf";
            icon = "\A3\ui_f\data\map\markers\nato\o_motor_inf.paa";
        };
        class mech_inf: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_mech_inf";
            icon = "\A3\ui_f\data\map\markers\nato\o_mech_inf.paa";
        };
        class armor: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_armor";
            icon = "\A3\ui_f\data\map\markers\nato\o_armor.paa";
        };
        class recon: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_recon";
            icon = "\A3\ui_f\data\map\markers\nato\o_recon.paa";
        };
        class air: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_air";
            icon = "\A3\ui_f\data\map\markers\nato\o_air.paa";
        };
        class plane: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_plane";
            icon = "\A3\ui_f\data\map\markers\nato\o_plane.paa";
        };
        class uav: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_uav";
            icon = "\A3\ui_f\data\map\markers\nato\o_uav.paa";
        };
        class naval: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_naval";
            icon = "\A3\ui_f\data\map\markers\nato\o_naval.paa";
        };
        class med: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_med";
            icon = "\A3\ui_f\data\map\markers\nato\o_med.paa";
        };
        class art: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_art";
            icon = "\A3\ui_f\data\map\markers\nato\o_art.paa";
        };
        class mortar: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_mortar";
            icon = "\A3\ui_f\data\map\markers\nato\o_mortar.paa";
        };
        class hq: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_hq";
            icon = "\A3\ui_f\data\map\markers\nato\o_hq.paa";
        };
        class support: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_support";
            icon = "\A3\ui_f\data\map\markers\nato\o_support.paa";
        };
        class maint: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_maint";
            icon = "\A3\ui_f\data\map\markers\nato\o_maint.paa";
        };
        class service: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_service";
            icon = "\A3\ui_f\data\map\markers\nato\o_service.paa";
        };
        class installation: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_installation";
            icon = "\A3\ui_f\data\map\markers\nato\o_installation.paa";
        };
        class antiair: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_antiair";
            icon = "\A3\ui_f\data\map\markers\nato\o_antiair.paa";
        };
        class Ordnance: unknown
        {
            name="$STR_A3_CfgMarkers_NATO_Ordnance";
            icon="\a3\UI_F_Orange\Data\CfgMarkers\o_Ordnance_ca.paa";
        };
    };
    class BLUFOR
    {
        class unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_unknown";
            icon = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
            color[] = 
            {
                "(profilenamespace getvariable ['Map_BLUFOR_R',0])",
                "(profilenamespace getvariable ['Map_BLUFOR_G',1])",
                "(profilenamespace getvariable ['Map_BLUFOR_B',1])",
                "(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"
            };
        };
        class inf: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_inf";
            icon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
        };
        class motor_inf: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_motor_inf";
            icon = "\A3\ui_f\data\map\markers\nato\b_motor_inf.paa";
        };
        class mech_inf: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_mech_inf";
            icon = "\A3\ui_f\data\map\markers\nato\b_mech_inf.paa";
        };
        class armor: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_armor";
            icon = "\A3\ui_f\data\map\markers\nato\b_armor.paa";
        };
        class recon: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_recon";
            icon = "\A3\ui_f\data\map\markers\nato\b_recon.paa";
        };
        class air: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_air";
            icon = "\A3\ui_f\data\map\markers\nato\b_air.paa";
        };
        class plane: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_plane";
            icon = "\A3\ui_f\data\map\markers\nato\b_plane.paa";
        };
        class uav: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_uav";
            icon = "\A3\ui_f\data\map\markers\nato\b_uav.paa";
        };
        class naval: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_naval";
            icon = "\A3\ui_f\data\map\markers\nato\b_naval.paa";
        };
        class med: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_med";
            icon = "\A3\ui_f\data\map\markers\nato\b_med.paa";
        };
        class art: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_art";
            icon = "\A3\ui_f\data\map\markers\nato\b_art.paa";
        };
        class mortar: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_mortar";
            icon = "\A3\ui_f\data\map\markers\nato\b_mortar.paa";
        };
        class hq: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_hq";
            icon = "\A3\ui_f\data\map\markers\nato\b_hq.paa";
        };
        class support: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_support";
            icon = "\A3\ui_f\data\map\markers\nato\b_support.paa";
        };
        class maint: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_maint";
            icon = "\A3\ui_f\data\map\markers\nato\b_maint.paa";
        };
        class service: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_service";
            icon = "\A3\ui_f\data\map\markers\nato\b_service.paa";
        };
        class installation: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_installation";
            icon = "\A3\ui_f\data\map\markers\nato\b_installation.paa";
        };
        class antiair: unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_antiair";
            icon = "\A3\ui_f\data\map\markers\nato\b_antiair.paa";
        };
        class Ordnance: unknown
        {
            name="$STR_A3_CfgMarkers_NATO_Ordnance";
            icon="\a3\UI_F_Orange\Data\CfgMarkers\b_Ordnance_ca.paa";
        };
    };
    class CIV
    {
        class c_unknown
        {
            name = "$STR_A3_CfgMarkers_NATO_unknown";
            icon="\A3\ui_f\data\map\markers\nato\c_unknown.paa";
            color[]=
            {
                "(profilenamespace getvariable ['MAP_CIVILIAN_R',0.4])",
                "(profilenamespace getvariable ['Map_CIVILIAN_G',0])",
                "(profilenamespace getvariable ['Map_CIVILIAN_B',0.5])",
                "(profilenamespace getvariable ['Map_CIVILIAN_A',1])"
            };
        };
        class c_car: c_unknown
        {
            name="$STR_DN_CAR";
            icon="\A3\ui_f\data\map\markers\nato\c_car.paa";
        };
        class c_ship: c_unknown
        {
            name="$STR_DN_SHIP";
            icon="\A3\ui_f\data\map\markers\nato\c_ship.paa";
        };
        class c_air: c_unknown
        {
            name="$STR_DN_HELICOPTER";
            icon="\A3\ui_f\data\map\markers\nato\c_air.paa";
        };
        class c_plane: c_unknown
        {
            name="$STR_DN_PLANE";
            icon="\A3\ui_f\data\map\markers\nato\c_plane.paa";
        };
    };

    class Generic
    {
        class hd_dot
        {
            name="$STR_CFG_MARKERS_DOT";
            icon="\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
            color[]={0,0,0,0};
        };
        class hd_objective: hd_dot
        {
            name="$STR_CFG_MARKERS_objective";
            icon="\A3\ui_f\data\map\markers\handdrawn\objective_CA.paa";
        };
        class hd_flag: hd_dot
        {
            name="$STR_CFG_MARKERS_flag";
            icon="\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa";
        };
        class hd_arrow: hd_dot
        {
            name="$STR_CFG_MARKERS_arrow";
            icon="\A3\ui_f\data\map\markers\handdrawn\arrow_CA.paa";
        };
        class hd_ambush: hd_dot
        {
            name="$STR_CFG_MARKERS_ambush";
            icon="\A3\ui_f\data\map\markers\handdrawn\ambush_CA.paa";
        };
        class hd_destroy: hd_dot
        {
            name="$STR_CFG_MARKERS_destroy";
            icon="\A3\ui_f\data\map\markers\handdrawn\destroy_CA.paa";
        };
        class hd_start: hd_dot
        {
            name="$STR_CFG_MARKERS_start";
            icon="\A3\ui_f\data\map\markers\handdrawn\start_CA.paa";
        };
        class hd_end: hd_dot
        {
            name="$STR_CFG_MARKERS_end";
            icon="\A3\ui_f\data\map\markers\handdrawn\end_CA.paa";
        };
        class hd_pickup: hd_dot
        {
            name="$STR_CFG_MARKERS_pickup";
            icon="\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa";
        };
        class hd_join: hd_dot
        {
            name="$STR_CFG_MARKERS_join";
            icon="\A3\ui_f\data\map\markers\handdrawn\join_CA.paa";
        };
        class hd_warning: hd_dot
        {
            name="$STR_CFG_MARKERS_warning";
            icon="\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa";
        };
        class hd_unknown: hd_dot
        {
            name="$STR_CFG_MARKERS_unknown";
            icon="\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa";
        };
    };
};