#define ATAK_APP(TITLE) #<t size='1'>TITLE</t>

//- Base ICON CONTROL
    class BCE_ATAK_Tool_ICON: BCE_RscButtonMenu
    {
        style = "0x02 + 0x0C + 0x0100";
        shadow = 1;
        text = "";

        x = 0;
        y = 0;
        w = PhoneBFTContainerW(1);
        h = (phoneSizeW * 3/5)/3;
        
        //-Style
        colorBackground[] = {0,0,0,0.5};
        colorBackground2[] = {0,0,0,0};
        colorBackgroundFocused[] = {0,0,0,0};

        animTextureDefault="#(argb,8,8,3)color(0,0,0,0)";
        animTextureNormal="#(argb,8,8,3)color(0,0,0,0)";
        animTextureOver = "#(argb,8,8,3)color(0,0,0,0.5)";
        animTextureFocused = "#(argb,8,8,3)color(0,0,0,0)";
        animTexturePressed = "#(argb,8,8,3)color(0,0,0,0.3)";
        
        size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
        
        textureNoShortcut="";
        class ShortcutPos
        {
            left = 0.75 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
            top = (phoneSizeW * 3/5)/3*0.18;
            w = (phoneSizeW * 2/5)/5*1.1;
            h = (phoneSizeW * 3/5)/5;
        };

        class TextPos
        {
            left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
            top = ((phoneSizeW * 3/5)/3*0.18) + ((phoneSizeW * 3/5)/5);
            right = 0;
            bottom = 0;
        };
        
        class Attributes
        {
            font = "RobotoCondensed_BCE";
            color = "#E5E5E5";
            align = "center";
            shadow = 1;
            size = __EVAL(3/TextTimes);
        };
    };

/*#define CREATE_APP(CLASS,ID,ICON,DISPLAY_NAME) \
    class BCE_ATAK_##NAME##_ICON: BCE_ATAK_Tool_ICON \
    { \
        idc = 4760 + ID; \
        text = ATAK_APP(DISPLAY_NAME); \
        onButtonClick = #[_this select 0, #NAME] call BCE_fnc_ATAK_ChangeTool ; \
        textureNoShortcut= #ICON ; \
    }*/