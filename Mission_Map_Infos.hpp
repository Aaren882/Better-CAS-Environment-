/* 
    Map Drawing Infos

    //- Entry Function
        #LINK - functions/CAS_Menu/Fire_Mission/Map_Infos/fn_get_TaskMapInfo.sqf

    #NOTE - drawIcon - https://community.bistudio.com/wiki/drawIcon
    [
        texture,
        color,
        position,
        width,
        height,
        angle,
        text,
        shadow,
        textSize,
        font,
        align
    ]
*/

class Mission_Map_Infos
{
    //- IP Point
    class IP_BP_Point
    {
        display = "%1"; //- Format Text
        Icon = "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overfriendly_gs.paa"; //- ICON
        color[] = {1,1,0,1}; //- Color
        font = "RobotoCondensed_BCE"; //- Font
        shadow = 1; //- Shadow
        textSize = 0.075; //- Text Size
        align = "right"; //- Text Align
        angle = 0; //- Angle

        sizeW = 40; //- Width
        sizeH = 40; //- Height
    };
    
    //- Target Point
    class Air_TGT_Point: IP_BP_Point
    {
        display = "%1"; //- Format Text
        Icon = "\a3\ui_f\data\GUI\Cfg\Cursors\hc_overenemy_gs.paa"; //- ICON
        color[] = {1,0,0,1}; //- Color

        sizeW = 30; //- Width
        sizeH = 30; //- Height
    };

    //- Friendly Point
    class FRD_Point: Air_TGT_Point
    {
        display = "FRND: %1"; //- Format Text
        Icon = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa"; //- ICON
        color[] = {0,0.5,1,1}; //- Color
    };
    //- Air Egrees Point
    class EGRS_Point: Air_TGT_Point
    {
        display = "EGRS: %1"; //- Format Text
        Icon = "\a3\ui_f\data\IGUI\Cfg\Targeting\Empty_ca.paa"; //- ICON
        color[] = {1,1,1,1}; //- Color
    };
};