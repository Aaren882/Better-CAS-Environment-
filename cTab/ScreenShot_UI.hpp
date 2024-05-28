class BCE_PhoneCAM_View
{
    idd = -1;
    fadein = 0.5;
    fadeout = 0.5;
    duration = 1e+007;
    enableSimulation = 1;
    movingEnable = 0;
    name = "BCE_PhoneCAM_View";
    onLoad = "uiNamespace setVariable ['BCE_PhoneCAM_View', _this # 0]; call BCE_fnc_ATAK_CamInit;";
    class controlsBackground
    {
        //- Frame
        class frame_left_up_h: BCE_RscLine
        {
            idc = 1;
            x = safezoneXAbs + 0.05 * safezoneW;
            y = safezoneY + 0.05 * safezoneW;
            w = 0.06 * safezoneW;
            h = 0.0045;
        };
        class frame_left_up_v: BCE_RscLine
        {
            idc = 2;
            x = safezoneXAbs + 0.05 * safezoneW;
            y = safezoneY + 0.05 * safezoneW;
            w = 0.0045;
            h = 0.06 * safezoneW;
        };
        class frame_right_down_h: BCE_RscLine
        {
            idc = 3;
            x = safezoneXAbs + safezoneWAbs - ((0.05 * safezoneW) + (0.06 * safezoneW));
            y = safezoneY + safezoneH - ((0.05 * safezoneW) + 0.0045);
            w = 0.06 * safezoneW;
            h = 0.0045;
        };
        class frame_right_down_v: BCE_RscLine
        {
            idc = 4;
            x = safezoneXAbs + safezoneWAbs - (0.05 * safezoneW);
            y = safezoneY + safezoneH - ((0.05 * safezoneW) + (0.06 * safezoneW));
            w = 0.0045;
            h = 0.06 * safezoneW;
        };
        class frame_left_down_h: BCE_RscLine
        {
            idc = 5;
            x = safezoneXAbs + 0.05 * safezoneW;
            y = safezoneY + safezoneH - ((0.05 * safezoneW) + 0.0045);
            w = 0.06 * safezoneW;
            h = 0.0045;
        };
        class frame_left_down_v: BCE_RscLine
        {
            idc = 6;
            x = safezoneXAbs + 0.05 * safezoneW;
            y = safezoneY + safezoneH - ((0.05 * safezoneW) + (0.06 * safezoneW));
            w = 0.0045;
            h = 0.06 * safezoneW;
        };
        class frame_right_up_h: frame_left_down_h
        {
            idc = 7;
            x = safezoneXAbs + safezoneWAbs - ((0.05 * safezoneW) + (0.06 * safezoneW));
            y = safezoneY + 0.05 * safezoneW;
        };
        class frame_right_up_v: frame_left_down_v
        {
            idc = 8;
            x = safezoneXAbs + safezoneWAbs - (0.05 * safezoneW);
            y = safezoneY + 0.05 * safezoneW;
        };

        //- Middle
        class middle_left_v: BCE_RscLine
        {
            idc = 9;
            x = 0.45 * safezoneW + safezoneX;
            y = (0.5 * safezoneH + safezoneY) - (0.04 * safezoneW);
            w = 0.003;
            h = 0.08 * safezoneW;
        };
        class middle_left_up_h: middle_left_v
        {
            idc = 10;
            w = 0.02 * safezoneW;
            h = 0.003;
        };
        class middle_left_down_h: middle_left_up_h
        {
            idc = 11;
            y = (0.5 * safezoneH + safezoneY) + (0.04 * safezoneW);
        };
        
        class middle_right_v: middle_left_v
        {
            idc = 12;
            x = 0.55 * safezoneW + safezoneX;
        };
        class middle_right_up_h: middle_right_v
        {
            idc = 13;
            x = (0.55 * safezoneW + safezoneX) - (0.02 * safezoneW);
            w = 0.02 * safezoneW;
            h = 0.003;
        };
        class middle_right_down_h: middle_right_up_h
        {
            idc = 14;
            y = (0.5 * safezoneH + safezoneY) + (0.04 * safezoneW);
        };

        class Exit_hint: RscText
        {
            idc = 15;
            style = 2;
            x = safezoneX;
            y = (safezoneY + safezoneH - (0.09 * safezoneW)) - (0.8 * (0.1));
            w = safezoneW;
            h = 0.1;
            text = "Press “Space” to Exit Camera";
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
        };
        class Bnt_hint: Exit_hint
        {
            idc = 16;
            x = safezoneX + (safezoneW / 2) - (safezoneW * 0.15);
            y = (safezoneY + safezoneH - (0.09 * safezoneW)) - (0.8 * (0.1)) + (0.1 * 1.1);
            w = safezoneW * 0.3;
            colorBackground[] = {0,0,0,0.15};
        };
    };
    class controls
    {
        class Resolution_Info: RscText
        {
            idc = 50;
            style = "0x02";
            x = safezoneXAbs + 0.11 * safezoneW;
            y = safezoneY + safezoneH - ((0.05 * safezoneW) + 0.003) - (0.05/2);
            w = 0.3;
            h = 0.05;
            font = "LCD14";
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.8)";
        };
        
        //- Bottom Left
        class User_Info: RscText
        {
            idc = 51;
            x = safezoneXAbs + 0.08 * safezoneW;
            y = safezoneY + safezoneH - (0.09 * safezoneW);
            w = 0.3;
            h = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65) * 1.2;
            style = "0x02";
            font = "PuristaLight";
            colorBackground[] = {0,0,0,0.4};
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65)";
        };
        class Group_Info: User_Info
        {
            idc = 52;
            x = (safezoneXAbs + 0.08 * safezoneW);
            y = (safezoneY + safezoneH - (0.09 * safezoneW)) - ((((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65) * 1.2 / 2);
            w = 0.15;
            h = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65) * 1.2 / 2;
            colorBackground[] = {0,0,0,0.3};
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65) / 2";
        };

        //- Bottom Right
        class Time: User_Info
        {
            idc = 53;
            x =  safezoneXAbs + safezoneWAbs - (0.08 * safezoneW) - 0.3;
            w = 0.3;
            font = "PuristaMedium";
        };
        class Date: Group_Info
        {
            idc = 54;
            x =  safezoneXAbs + safezoneWAbs - (0.08 * safezoneW) - 0.2;
            w = 0.2;
            font = "PuristaMedium";
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65) / 1.75";
        };

        //- GRID info
        class GRID: Time
        {
            idc = 55;
            y = (safezoneY + safezoneH - (0.09 * safezoneW)) - (2 * (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.65) * 1.2);

            font = "RobotoCondensed";
            colorBackground[] = {0,0,0,0};
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5) / 1.75";
        };
    };
};