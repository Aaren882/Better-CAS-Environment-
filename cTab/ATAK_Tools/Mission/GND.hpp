class Call_For_Fire: AIR_5_LINE
{
    class controls: controls
    {
        #define MOVE_Y_OFFSET 1
        class Background: Background
        {
            ATAK_POS(0,0,0,(9.85 + 1.05 + 0.35 + MOVE_Y_OFFSET));
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
            /* class Submit_Mission_Type: New_Task_Submit_CFF_Mission_Type
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
            }; */
        #undef MOVE_Y_OFFSET
    };
};