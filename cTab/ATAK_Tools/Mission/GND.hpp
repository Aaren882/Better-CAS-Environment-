class Call_For_Fire: AIR_5_LINE
{
    class controls: controls
    {
        #define ADJUSTMENT_MENU 3
        #define MOVE_Y_OFFSET 1
        class Background: Background
        {
            ATAK_POS(0,0,0,(8.85 + 1.05 + 2 + 0.35 + MOVE_Y_OFFSET));
        };
        //- ARTY Group DropBox
            class Vehicle_Grp_T: Game_Plan_T
            {
                text="Task Unit";
                sizeEx = 0.95 * TextSize;
            };
            class Vehicle_Grp_Sel: Vehicle_Grp_Sel
            {
                onLBSelChanged = "";
                ATAK_POS(1,((0.35/2)),1.9,0.65);

                sizeEx = 0.9 * TextSize;
                colorBackground[] = {0.3,0.3,0.3,1};
                colorSelect[]={1,1,1,1};
                colorSelectBackground[]={0.4,0.4,0.4,1};
                /* class Items
                {
                    class NA
                    {
                        text = "NA";
                        default = 1;
                    };   
                }; */
            };

        class Game_Plan_T: Game_Plan_T
        {
            text="Mission Type";
            sizeEx = 0.95 * TextSize;
            ATAK_POS(0,MOVE_Y_OFFSET,1,1);
        };
        //- FFE, Suppress ...
            class TaskType_GND: TaskType_GND
            {
                ATAK_POS(1,((0.35/2) + MOVE_Y_OFFSET),1.9,0.65);

                wholeHeight = 0.8;
                sizeEx = 0.9 * TextSize;
                font = "PuristaMedium";
                
                colorBackground[] = {0,0,0,1};
                colorSelect[]={1,1,1,1};
                colorSelectBackground[]={0.2,0.2,0.2,1};
            };

        //- Correction Method
        /*class Correction_Method: CtrlType
        {
            text="MOC";
            tooltip="Method of Control";
            
            sizeEx = 0.95 * TextSize;
        };*/

        //- In Effect (IE) Section
            class Weapon_T: Weapon_T
            {
                ATAK_POS(0,(1 + (0.35/2) + MOVE_Y_OFFSET),1,0.63);
            };
            class CFF_IE_WeaponCombo: CFF_IE_WeaponCombo
            {
                ATAK_POS(0.7,(1 + (0.35/2) + MOVE_Y_OFFSET),1.5,0.65);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask; call BCE_fnc_SelWPN_CFF";
                //- Style
                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                    sizeEx = 0.9 * TextSize;
            };
            class CFF_IE_FuzeCombo: CFF_IE_FuzeCombo
            {
                ATAK_POS(2.2,(1 + (0.35/2) + MOVE_Y_OFFSET),0.7,0.63);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask; (_this+[0]) call BCE_fnc_onTaskElementChange;";
                //- Style
                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                    sizeEx = 0.8 * TextSize;
            };
            class CFF_IE_FireUnit_Combo: CFF_IE_FireUnit_Combo
            {
                ATAK_POS(0.7,(1.65 + (0.35/2) + MOVE_Y_OFFSET),(1.1/2),0.63);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask;";
                //- Style
                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                    sizeEx = 0.9 * TextSize;
            };
            class CFF_IE_Round_Box: CFF_IE_Round_Box
            {
                ATAK_POS((0.7 + (1.1/2)),(1.65 + (0.35/2) + MOVE_Y_OFFSET),(1.1/3),0.63);
                sizeEx = 0.9 * TextSize;
                onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            };
            class CFF_IE_FuzeValue_Box: CFF_IE_FuzeValue_Box
            {
                ATAK_POS(2.2,(1.65 + (0.35/2) + MOVE_Y_OFFSET),0.7,0.63);
                sizeEx = 0.9 * TextSize;
                onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            };
            class CFF_IE_FireAngle_Bnt: CFF_IE_FireAngle_Bnt
            {
                ATAK_POS(0,(1.65 + (0.35/2) + MOVE_Y_OFFSET),0.7,0.63);
                size = 0.9 * TextSize;
                onButtonClick = "call BCE_fnc_ATAK_AutoSaveTask; private _m = (_this # 0) getVariable ['Mode',false]; (_this # 0) setVariable ['Mode', !_m];";
            };
        //- In Adjust (IA) (OPTIONAL)
            class Weapon_IA_T: Weapon_T
            {
                ATAK_POS(0,(2.6 + (0.35/2) + MOVE_Y_OFFSET),1,0.63);
                text = "(Adjust)";
                tooltip="Setting up ""In Adjust"" (OPTIONAL).";
            };
            class CFF_IA_WeaponCombo: CFF_IA_WeaponCombo
            {
                ATAK_POS(0.7,(2.6 + (0.35/2) + MOVE_Y_OFFSET),1.5,0.65);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
                //- Style
                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                    sizeEx = 0.9 * TextSize;
            };
            class CFF_IA_FuzeCombo: CFF_IA_FuzeCombo
            {
                ATAK_POS(2.2,(2.6 + (0.35/2) + MOVE_Y_OFFSET),0.7,0.63);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask; (_this+[0]) call BCE_fnc_onTaskElementChange;";
                //- Style
                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                    sizeEx = 0.8 * TextSize;
            };
            class CFF_IA_FireUnit_Combo: CFF_IA_FireUnit_Combo
            {
                ATAK_POS(0.7,(3.25 + (0.35/2) + MOVE_Y_OFFSET),(1.1/2),0.63);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask;";
                //- Style
                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                    sizeEx = 0.9 * TextSize;
            };
            class CFF_IA_Round_Box: CFF_IA_Round_Box
            {
                ATAK_POS((0.7 + (1.1/2)),(3.25 + (0.35/2) + MOVE_Y_OFFSET),(1.1/3),0.63);
                sizeEx = 0.9 * TextSize;
                onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            };
            class CFF_IA_FuzeValue_Box: CFF_IA_FuzeValue_Box
            {
                ATAK_POS(2.2,(3.25 + (0.35/2) + MOVE_Y_OFFSET),0.7,0.63);
                sizeEx = 0.9 * TextSize;
                onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            };

        //- Sheaf (OPTIONAL)
            class Line_Sheaf: Line1_T5
            {
                ATAK_POS(0,(4.25 + (0.35/2) + MOVE_Y_OFFSET),1,0.63);
                text = "(Sheaf)";
                tooltip="Sheaf Type (OPTIONAL)";
            };
            class Sheaf_EditBnt: L52_EditBnt
            {
                idc = idc_D(2039);
                text = "Standard Sheaf";
                ATAK_POS(0.7,(4.25 + (0.35/2) + MOVE_Y_OFFSET),2.2,0.7);
                tooltip="Sheaf Type (OPTIONAL)";
                onButtonClick = "[nil,'Task_Building',1] call BCE_fnc_ATAK_ChangeTool";
                
                //- Colors
                    colorBackground[] = 
                    {
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
                        0.65
                    };
                    colorBackground2[] = 
                    {
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
                        0
                    };
                    colorBackgroundFocused[] = 
                    {
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
                        "0.35 * (profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
                        0
                    };
            };

        //- Callouts
            class Line1_T5: Line1_T5
            {
                ATAK_POS(0,(5.25 + (0.35/2) + MOVE_Y_OFFSET),1,0.7);
            };
            class L51_EditBnt: L51_EditBnt //L52_EditBnt
            {
                idc = idc_D(2040);
                text = "“Alpha 1-1” / “Alpha 1-2”";
                ATAK_POS(0.2,(5.25 + (0.35/2) + MOVE_Y_OFFSET),2.7,0.7);
                // onButtonClick = "[nil,'Task_Building',1] call BCE_fnc_ATAK_ChangeTool";
            };

        //- Target
            class Line2_T5: Line2_T5
            {
                ATAK_POS(0,(6.25 + (0.35/2) + MOVE_Y_OFFSET),1,0.7);
                tooltip="$STR_BCE_TIP_GRID";
            };
            class L52_EditBnt: L52_EditBnt
            {
                ATAK_POS(0.2,(6.25 + (0.35/2) + MOVE_Y_OFFSET),2.7,0.7);
                text = "Target";
                tooltip="$STR_BCE_TIP_GRID";
                onButtonClick = "[nil,'Task_Building',2] call BCE_fnc_ATAK_ChangeTool";
            };


        //- Description
            class Line3_T5: Line3_T5
            {
                text="3";
                ATAK_POS(0,(7.25 + (0.35/2) + MOVE_Y_OFFSET),1,0.7);
                tooltip="$STR_BCE_TIP_DESC";
            };
            class L53_EditBnt: L54_EditBnt
            {
                ATAK_POS(0.2,(7.25 + (0.35/2) + MOVE_Y_OFFSET),2.3,0.7);
                tooltip="$STR_BCE_TIP_DESC";
            };
            class L53_PullBnt: L54_PullBnt
            {
                ATAK_POS(2.55,(7.25 + (0.35/2) + MOVE_Y_OFFSET),0.35,0.7);
                action = "2 call BCE_fnc_ATAK_PullData";
            };

            //-Text EditBox
            class New_Task_TG_DESC: New_Task_TG_DESC
            {
                ATAK_POS(0.15,(8.15 + (0.35/2) + MOVE_Y_OFFSET),2.75,0.7);
            };
            class New_Task_GRID_DESC: New_Task_GRID_DESC
            {
                ATAK_POS(0.15,(8.85 + (0.35/2) + MOVE_Y_OFFSET),2.75,0.7);
            };
        
        //- Control Method
            class Line4_T5: Line4_T5
            {
                ATAK_POS(0,(9.85 + (0.35/2) + MOVE_Y_OFFSET),1,0.7);
                tooltip="Method of Control";
            };
            class L54_EditBnt: Remark_EditBnt
            {
                ATAK_POS(0.2,(9.85 + (0.35/2) + MOVE_Y_OFFSET),2.7,0.7);
                toolTip="Method of Control";
                onButtonClick = "[nil,'Task_Building',4] call BCE_fnc_ATAK_ChangeTool";
            };

        //- Separator -//
            class Separator: Separator
            {
                ATAK_POS(0.1,(9.85 + 1.05 + (0.35/2) + MOVE_Y_OFFSET),2.8,0.001);
            };
        
        //- Submit
            class Submit_Mission_Type: New_Task_Submit_CFF_Mission_Type
            {
                // idc = 5000;                
                ATAK_POS(0.1,(9.85 + 1.05 + (3*0.35/2) + MOVE_Y_OFFSET),2.8,0.7);
                sizeEx = 0.8 * TextSize;
            };
            class Submit_Fire_Mission: New_Task_Submit_CFF_Mission
            {
                // idc = 5001;
                ATAK_POS(0.1,(9.85 + 1.05 + 0.7 + (3*0.35/2) + MOVE_Y_OFFSET),2.8,1.2 * 0.7);
                size = TextSize;

                class TextPos: TextPos
                {
                    top = 0.15 * ATAK_POS_H;
                };
                class Attributes: Attributes
                {
                    size = TextMenu(0.8);
                    align="center";
                    valign="middle";
                };
            };
        
        //- Adjustments
            /* class Adjust_Section: Remark
            {
                ATAK_POS(0,(8.3 + (0.35/2) + MOVE_Y_OFFSET),3,1);

                text = "Fire Adjustments :";
                tooltip="";
            };
            class Adjustments_Group: ATAK_AppMenu_Base
            {
                idc = 5400;
                ATAK_POS(0.1,(9.3 + (0.35/2) + MOVE_Y_OFFSET),2.8,(ADJUSTMENT_MENU * 0.7));
                class controls
                {
                    //- Background (for ControlGroup)
                        class AdjustFrameBg: Background
                        {
                            colorBackground[] = {0,0,0,0.2};
                            ATAK_POS(0,0,2.8,(ADJUSTMENT_MENU * 0.7));
                        };
                    //- Clear Button
                        class Clear_Adjust: BCE_RscButtonMenu
                        {
                            idc = 5000;
                            ATAK_POS(0,0,0.35,(ADJUSTMENT_MENU * 0.7));

                            //- Color
                                colorBackground[] = {1,0,0,0.35};
                                colorBackground2[] = {1,0.25,0.25,0.4};
                                colorBackgroundFocused[] = {1,0,0,0.2};

                                animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                                animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                                animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";
                            
                            size = 0.75 * TextSize;
                            style = "0x02 + 0x30 + 0x800";
                            shadow = 1;
                            text = "<img image='\MG8\AVFEVFX\data\gabage.paa' />";
                            onButtonClick = "_this call BCE_fnc_CleanFireAdjustValues";

                            class TextPos: TextPos
                            {
                                top = (ADJUSTMENT_MENU - 1) * 0.6 * TextSize;
                            };
                            class Attributes: Attributes
                            {
                                align="center";
                                valign="middle";
                                size = TextMenu(1);
                            };
                        };
                    
                    //- Adjustment Controls
                        #define ADJUST_BNT_OFFSET (1/20)
                        #define ADJUST_BNT_X (2.5 - ADJUST_BNT_OFFSET) //- Center of third "ATAK_POS_W"
                        #define ADJUST_BNT_W (0.32 + ADJUST_BNT_OFFSET)

                        #define ADJUST_INTERVAL 6
                        #define ADJUST_BNT_POS(XPOS,YPOS,WPOS,HPOS) \
                            x = PhoneBFTContainerW(XPOS) + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW); \
                            y = YPOS * ATAK_POS_H + (ADJUST_INTERVAL / 2 * pixelH); \
                            w = PhoneBFTContainerW(WPOS) - (ADJUST_INTERVAL * pixelW); \
                            h = HPOS * ATAK_POS_H - (ADJUST_INTERVAL * pixelH)
                    
                        #define BORDER (2 * ADJUST_BNT_OFFSET) //- Space for L,R borders
                        //- Adjustment controls' Width (Higher the bigger Interval)
                        #define ADJUST_CTRL_W(BORDER_W) (((1 + BORDER) * ATAK_POS_W) + BORDER_W * ((0.5 + 2) * ADJUST_INTERVAL * pixelW))
                    
                    //- Middle (Indicators, Adjust...)
                        class Indicator: RscPictureKeepAspect
                        {
                            idc = 5001;

                            x = 0.35 * ATAK_POS_W;
                            y = 0;
                            w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.4);
                            h = 1.5 * 0.7 * ATAK_POS_H;

                            sizeEx = TextSize;

                            text = "\MG8\AVFEVFX\data\Arrows\thin_Arrow.paa";
                        };
                        class Indication: RscStructuredText
                        {
                            idc = 5002;
                            x = 0.35 * ATAK_POS_W;
                            y = 1.5 * 0.7 * ATAK_POS_H;
                            w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525);
                            h = 0.5 * 0.7 * ATAK_POS_H;
                            
                            colorBackground[] = {0,0,0,0.2};
                            size = 0.5 * TextSize;

                            text = "<img image='\MG8\AVFEVFX\data\Arrows\Point_Arrow.paa' /> 10 m | <img image='\MG8\AVFEVFX\data\Arrows\Point_Arrow_R.paa' /> 20 m";
                            class Attributes
                            {
                                font = "RobotoCondensed_BCE";
                                align="center";
                                valign="middle";
                            };
                        };
                        class Adjust_Bnt: BCE_RscButtonMenu
                        {
                            idc = 5003;

                            x = 0.35 * ATAK_POS_W;
                            y = 2 * 0.7 * ATAK_POS_H;
                            w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525);
                            h = 0.7 * ATAK_POS_H;

                            //- Style
                                animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                                animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                                animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

                                colorBackground[] = 
                                {
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                                    0.8
                                };
                                colorBackground2[] = 
                                {
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                                    0.8
                                };
                                colorBackgroundFocused[] = 
                                {
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                                    0.5
                                };

                            shadow=1;
                            size = TextSize;
                            text = "<img image='\MG8\AVFEVFX\data\ruler.paa' /> ADJUST";

                            class TextPos: TextPos
                            {
                                top = 0.1 * ATAK_POS_H;
                            };
                            class Attributes: Attributes
                            {
                                align="center";
                                valign="middle";
                                size = TextMenu(0.8);
                            };
                        };

                    //- Adjust Buttons -//
                        //- Background
                            class AdjustBg: AdjustFrameBg
                            {
                                x = ((2.5 - BORDER) - 2 * ADJUST_BNT_W) * ATAK_POS_W + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW);
                                y = 0;
                                w = ADJUST_CTRL_W(1);
                                h = 3 * 0.7 * ATAK_POS_H;
                            };
                        class Adjust_Meter: ctrlButton
                        {
                            idc = 5004;
                            
                            x = ((2.5 - BORDER) - 2 * ADJUST_BNT_W) * ATAK_POS_W + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW);
                            y = 0;
                            w = ADJUST_CTRL_W(1);
                            h = 0.7 * ATAK_POS_H;

                            //- Color
                                colorBackground[] = {0,0,0,0.3};
                            
                            font = "RobotoCondensed_BCE";
                            sizeEx = 0.8 * TextSize;
                            text = "<-- 10 m -->";
                            onButtonClick = "call BCE_fnc_ATAK_FireAdjustMeter";
                        };
                        //- Undef "BORDER", "ADJUST_CTRL_W"
                            #undef BORDER
                            #undef ADJUST_CTRL_W
                        class Adjust_Up: ctrlButtonPictureKeepAspect
                        {
                            idc = 5100;
                            ADJUST_BNT_POS((ADJUST_BNT_X - ADJUST_BNT_W),(1 * 0.7),ADJUST_BNT_W,0.7);

                            //- Color
                                colorBackground[] = {0,0,0.2,0.3};
                            
                            sizeEx = 0.5 * TextSize;
                            text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow.paa";
                            onButtonClick = "[_this # 0, [0,1]] call BCE_fnc_UpdateFireAdjust";
                        };
                        class Adjust_Dn: Adjust_Up
                        {
                            idc = 5101;
                            ADJUST_BNT_POS((ADJUST_BNT_X - ADJUST_BNT_W),(2 * 0.7),ADJUST_BNT_W,0.7);
                            text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_D.paa";
                            onButtonClick = "[_this # 0, [0,-1]] call BCE_fnc_UpdateFireAdjust";
                        };
                        class Adjust_L: Adjust_Up
                        {
                            idc = 5102;
                            ADJUST_BNT_POS((ADJUST_BNT_X - 2 * ADJUST_BNT_W),(2 * 0.7),ADJUST_BNT_W,0.7);
                            text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_L.paa";
                            onButtonClick = "[_this # 0, [-1,0]] call BCE_fnc_UpdateFireAdjust";
                        };
                        class Adjust_R: Adjust_Up
                        {
                            idc = 5103;
                            ADJUST_BNT_POS((ADJUST_BNT_X),(2 * 0.7),ADJUST_BNT_W,0.7);
                            text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_R.paa";
                            onButtonClick = "[_this # 0, [1,0]] call BCE_fnc_UpdateFireAdjust";
                        };
                        #undef ADJUST_BNT_OFFSET
                        #undef ADJUST_BNT_X
                        #undef ADJUST_BNT_W
                        #undef ADJUST_INTERVAL
                        #undef ADJUST_BNT_POS
                };
            };
            
        //- Execute Fire Mission
            class Execute_Mission_Type: RscToolbox
            {
                idc = 5401;
                ATAK_POS(0.1,(9.3 + (0.7 * ADJUSTMENT_MENU) + 0.35 + MOVE_Y_OFFSET),2.8,0.7);
                shadow = 2;
                rows = 1;
                columns = 2;
                strings[] =
                {
                    "SHIFT",
                    "Fire for Effect"
                };
                tooltips[] =
                {
                    "One gun fires one round at a time, to adjust the point of impact.",
                    "When the FO has an accurate target location and is confident that the first volley will be effective."
                };
                colorBackground[] = {0,0,0,0.3};
                sizeEx = 0.8 * TextSize;
            };
            class Execute_Fire_Mission: BCE_RscButtonMenu
            {
                idc = 5402;
                ATAK_POS(0.1,(9.3 + (0.7 * (ADJUSTMENT_MENU + 1)) + 0.35 + MOVE_Y_OFFSET),2.8,1.2 * 0.7);
                text = "<img image='\MG8\AVFEVFX\data\explosion.paa' /> Execute Mission";

                //- Style
                    animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                    animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                    animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

                    colorBackground[] = 
                    {
                        0.45,0,0,0.8
                    };
                    colorBackground2[] = 
                    {
                        0.45,0,0,0.8
                    };
                    colorBackgroundFocused[] = 
                    {
                        0.45,0,0,0.5
                    };

                size = TextSize;

                class TextPos: TextPos
                {
                    top = 0.15 * ATAK_POS_H;
                };
                class Attributes: Attributes
                {
                    align="center";
                    valign="middle";
                    size = TextMenu(0.8);
                };
            }; */
        #undef ADJUSTMENT_MENU
        #undef MOVE_Y_OFFSET
    };
};