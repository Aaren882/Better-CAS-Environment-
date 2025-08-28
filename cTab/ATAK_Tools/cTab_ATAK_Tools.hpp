//- Message Interface
    class ATAK_Message: ATAK_AppMenu_Base
    {
        /*x = phoneSizeX + (phoneSizeW * 3/5);
        y = phoneSizeY;*/
        w = phoneSizeW * 2/5;
        h = phoneSizeH - 0.75 * (((60)) / 2048 * CustomPhoneH);

        class controls
        {
            class Title: BCE_RscButtonMenu
            {
                idc = 5;
                x = 0;
                y = 0;
                w = PhoneBFTContainerW(3);
                h = 0.8 * (((60)) / 2048 * CustomPhoneH);

                size = 0.7 * (((60)) / 2048 * CustomPhoneH);
                text = "";

                colorBackground[] = {0,0,0,0.5};
                colorBackground2[] = {0,0,0,0.5};
                colorBackgroundFocused[] = {0,0,0,0.8};

                animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";

                onButtonClick = "call BCE_fnc_ATAK_toggleSubListMenu";
                class Attributes: Attributes
                {
                    align = "center";
                    valign = "Bottom";
                };
            };
            class Group_Box: cTab_RscControlsGroup
            {
                idc = 10;

                class VScrollbar: VScrollbar
                {
                    width = 0;
                };
                class HScrollbar: HScrollbar
                {
                    height = 0;
                };
                
                x = 0;
                y = 0.8 * (((60)) / 2048 * CustomPhoneH);
                w = PhoneBFTContainerW(3);
                h = phoneSizeH - 2.3 * (((60)) / 2048 * CustomPhoneH);
            };
            class Contacts_list: RscListbox
            {
                idc = 6;
                colorBackground[] = {0,0,0,0.3};
                colorSelectBackground[] = {0.95,0.95,0.95,0.4};
                sizeEx = 0.8 * (((60) - (20))) / 2048 * CustomPhoneH;

                x = 0;
                y = 0.8 * (((60)) / 2048 * CustomPhoneH);
                w = PhoneBFTContainerW(3);
                h = 0;
            };
            class typing: RscEdit
            {
                idc = 11;
                
                x = 0;
                y = phoneSizeH - 1.5 * (((60)) / 2048 * CustomPhoneH);
                w = PhoneBFTContainerW(3);
                h = 0.75 * (((60)) / 2048 * CustomPhoneH);

                sizeEx = 0.64 * (((60) - (20))) / 2048 * CustomPhoneH;

                colorBackground[]={0,0,0,0.5};
            };
        };
    };
//- Task Building Page
    class Task_Builder: ATAK_Message
    {
        class controls
        {
            class Game_Plan_T: RscText
            {
                idc = -1;
                shadow=2;
                text="Game Plan";
                sizeEx = TextSize;
                ATAK_POS(0,0,1,1);
                font = "RobotoCondensed_BCE";
                colorBackground[] = {0,0,0,0};
                colorText[]={1,0.737255,0.0196078,1};
                tooltip="$STR_BCE_TIP_GAMEPLAN";
            };
            
            //-Task Type
            class TaskType: RscCombo
            {
                idc = idc_D(2107);
                ATAK_POS(1,0.35/2,1.9,0.65);
                
                wholeHeight = 0.8;
                sizeEx = 0.9 * TextSize;
                font = "PuristaMedium";
                
                colorBackground[] = {0,0,0,1};
                colorSelect[]={1,1,1,1};
                colorSelectBackground[]={0.2,0.2,0.2,1};
                
                onLBSelChanged = "call BCE_fnc_ATAK_TaskTypeChanged";
                class Items
                {
                    class 9line
                    {
                        text = "9 Line";
                        textRight = "";
                        value = 0;
                        default = 1;
                    };
                    class 5line
                    {
                        text = "5 Line";
                        textRight = "";
                        value = 1;
                    };
                };
            };
            
            class CtrlType: Game_Plan_T
            {
                text="Type";
                ATAK_POS(0,1.1,1,0.8);
                sizeEx = TextSize;
                tooltip="$STR_BCE_TIP_CtrlType";
            };
            
            //-MOA
            class New_Task_CtrlType: RscToolbox
            {
                idc = idc_D(2011);
                ATAK_POS(0.5,(1 + (0.35/2)),1.2,0.65);
                rows = 1;
                columns = 3;
                strings[] =
                {
                    "T1",
                    "T2",
                    "T3"
                };
                onToolBoxSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
                font = "RobotoCondensed_BCE";
                colorBackground[] = {0,0,0,0.3};
                sizeEx = 0.9 * TextSize;
            };
            class MOA_T: Game_Plan_T
            {
                text="MOA";
                sizeEx = 0.85 * TextSize;
                ATAK_POS(1.8,(1 + (0.35/2)),0.4,0.65);
                tooltip="$STR_BCE_TIP_MOA";
            };
            class MOA_Combo: TaskType
            {
                idc = idc_D(20112);
                ATAK_POS(2.2,(1 + (0.35/2)),0.7,0.65);
                
                colorBackground[] = {0.3,0.3,0.3,1};
                colorSelect[]={1,1,1,1};
                colorSelectBackground[]={0.4,0.4,0.4,1};
                
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
                class Items
                {
                    class BoT
                    {
                        text = "BoT";
                        textRight = "";
                        value = 0;
                        default = 1;
                    };
                    class BoC
                    {
                        text = "BoC";
                        textRight = "";
                        value = 1;
                    };
                };
            };

            //-Weapons Selections
            class Weapon_T: CtrlType
            {
                text="Weapon";
                ATAK_POS(0,(2 + (0.35/2)),1,0.63);
                tooltip="$STR_BCE_TIP_Weapon";
            };
            class AI_Remark_WeaponCombo: MOA_Combo
            {
                idc = idc_D(2020);
                ATAK_POS(0.7,(2 + (0.35/2)),1.5,0.65);
                sizeEx = 0.9 * TextSize;
                onLBSelChanged = "(_this + [17000]) call BCE_fnc_CAS_SelWPN; call BCE_fnc_ATAK_AutoSaveTask;";
                class Items{};
            };
            class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
            {
                idc = idc_D(2021);
                ATAK_POS(2.2,(2 + (0.35/2)),0.7,0.63);
                onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            };
            class Attack_Range_Combo: AI_Remark_ModeCombo
            {
                idc = idc_D(2022);
                ATAK_POS(0.7,(2.65 + (0.35/2)),1.1,0.63);
                tooltip = "$STR_BCE_tip_Attack_Range";
                class Items
                {
                    class 2000m
                    {
                        text = "2000m";
                        value = 2000;
                        default = 1;
                    };
                    class 1500m
                    {
                        text = "1500m";
                        value = 1500;
                    };
                    class 1000m
                    {
                        text = "1000m";
                        value = 1000;
                    };
                };
            };
            class Round_Count_Box: RscEdit
            {
                idc = idc_D(2023);
                ATAK_POS(1.8,(2.65 + (0.35/2)),(1.1/3),0.63);
                Style = 2;
                text = "1";
                sizeEx = 0.9 * TextSize;
                tooltip = "$STR_BCE_tip_Round_Count";
                onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            };
            class Attack_Height_Box: Round_Count_Box
            {
                idc = idc_D(2024);
                ATAK_POS((1.8 + (1.1/3)),(2.65 + (0.35/2)),(2.2/3),0.63);
                tooltip = "$STR_BCE_tip_Attack_Height";
                text = "2000";
            };
            
            //-1~3 lines
            class IP2TG_T9: CtrlType
            {
                idc = 93;
                text="1-3";
                ATAK_POS(0,(3.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_IPBP_Info";
            };
            class IP2TG_EditBnt: BCE_RscButtonMenu
            {
                idc = idc_D(2025);
                ATAK_POS(0.4,(3.6 + (0.35/2)),2.5,0.7);
                sizeEx = TextSize;
                text = "T1 , 360° , 1200m";
                tooltip="$STR_BCE_TIP_IPBP_Info";
                
                //-Style
                colorBackground[] = {0,0,0,0.5};
                colorBackground2[] = {0,0,0,0};
                colorBackgroundFocused[] = {0,0,0,0};

                animTextureDefault="#(argb,8,8,3)color(0,0,0,0.8)";
                animTextureNormal="#(argb,8,8,3)color(0,0,0,0.8)";
                animTextureOver = "#(argb,8,8,3)color(0,0,0,0.5)";
                animTextureFocused = "#(argb,8,8,3)color(0,0,0,0.8)";
                animTexturePressed = "#(argb,8,8,3)color(0,0,0,0.3)";

                size = 0.7 * (((60) - (20))) / 2048 * CustomPhoneH;
                
                onButtonClick = "[nil,'Task_Building',1] call BCE_fnc_ATAK_ChangeTool;";
                
                class Attributes: Attributes
                {
                    align = "center";
                    font = "RobotoCondensedBold_BCE";
                    size = TextMenu(1);
                };
                class TextPos
                {
                    left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
                    top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
                    right = 0;
                    bottom = 0;
                };
            };

            //-Line 4
            class Line4_T9: CtrlType
            {
                idc = 94;
                text="4";
                ATAK_POS(0,(4.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_ELEV";
            };
            class L94_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2026);
                ATAK_POS(0.2,(4.6 + (0.35/2)),2.7,0.7);
                text = "535ft MSL";
                tooltip="$STR_BCE_TIP_ELEV";
                onButtonClick = "[nil,'Task_Building',4] call BCE_fnc_ATAK_ChangeTool;";
            };
            /*class L94_PullBnt: ctrlButton
            {
                idc = idc_D(20260);
                ATAK_POS(2.55,(4.6 + (0.35/2)),0.35,0.7);
                
                style = "0x02 + 0x30 + 0x800";
                colorBackground[] = {0.1,0.1,0.1,0.75};
                sizeEx = 0.85 * TextSize;
                
                tooltip = "Show Info";
                text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                action = "4 call BCE_fnc_ATAK_PullData";
            };*/

            //-Line 5
            class Line5_T9: CtrlType
            {
                idc = 95;
                text="5";
                ATAK_POS(0,(5.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_DESC";
            };
            //-Task Type
            class L95_EditBnt: RscCombo
            {
                idc = idc_D(2027);
                ATAK_POS(0.2,(5.6 + (0.35/2)),2.3,0.7);
                
                wholeHeight = 0.8;
                sizeEx = 0.9 * TextSize;
                font = "PuristaMedium";
                tooltip="$STR_BCE_TIP_DESC";
                
                style="0x10 + 0x200 + 0x02";
                colorText[] = {1,1,1,1};
                colorBackground[]={0,0,0,0.75};
                colorSelect[]={1,1,1,1};
                colorSelectBackground[]={0.2,0.2,0.2,1};
                
                onLBSelChanged = "call BCE_fnc_ATAK_DescType_Changed";
                class Items
                {
                    class Custom
                    {
                        text = "$STR_BCE_DESC_Custom";
                        textRight = "";
                        value = 0;
                        default = 1;
                    };
                    class Open
                    {
                        text = "$STR_BCE_DESC_Open";
                        textRight = "";
                        value = 1;
                        color[]={0.65,0.65,0.65,1};
                    };
                    class Cover: Open
                    {
                        text = "$STR_BCE_DESC_Cover";
                        value = 2;
                    };
                    class treeline: Open
                    {
                        text = "$STR_BCE_DESC_treeline";
                        value = 3;
                    };
                    class Hardstructure: Open
                    {
                        text = "$STR_BCE_DESC_Hardstructure";
                        value = 4;
                    };
                };
            };
            class L95_PullBnt: ctrlButton
            {
                idc = idc_D(20260);
                ATAK_POS(2.55,(5.6 + (0.35/2)),0.35,0.7);
                
                style = "0x02 + 0x30 + 0x800";
                colorBackground[] = {0.1,0.1,0.1,0.75};
                sizeEx = 0.85 * TextSize;
                
                tooltip = "$STR_BCE_ATAK_Show_Info";
                text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                action = "6 call BCE_fnc_ATAK_PullData";
            };
            
            //-Line 6
            class Line6_T9: CtrlType
            {
                idc = 96;
                text="6";
                ATAK_POS(0,(7.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_GRID";
            };
            class L96_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2029);
                ATAK_POS(0.2,(7.6 + (0.35/2)),2.7,0.7);
                text = "XT 123456";
                tooltip="$STR_BCE_TIP_GRID";
                onButtonClick = "[nil,'Task_Building',6] call BCE_fnc_ATAK_ChangeTool;";
            };
            
            //-Line 7
            class Line7_T9: CtrlType
            {
                idc = 97;
                text="7";
                ATAK_POS(0,(8.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_MARK";
            };
            class L97_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2030);
                ATAK_POS(0.2,(8.6 + (0.35/2)),2.7,0.7);
                text = "NO MARKS";
                tooltip="$STR_BCE_TIP_MARK";
                onButtonClick = "[nil,'Task_Building',7] call BCE_fnc_ATAK_ChangeTool;";
            };
            
            //-Line 8
            class Line8_T9: CtrlType
            {
                idc = 98;
                text="8";
                ATAK_POS(0,(9.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_FRND";
            };
            class L98_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2031);
                ATAK_POS(0.2,(9.6 + (0.35/2)),2.7,0.7);
                text = "None";
                tooltip="$STR_BCE_TIP_FRND";
                onButtonClick = "[nil,'Task_Building',8] call BCE_fnc_ATAK_ChangeTool;";
            };
            //-Line 9
            class Line9_T9: CtrlType
            {
                idc = 99;
                text="9";
                ATAK_POS(0,(10.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_EGRS";
            };
            class L99_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2032);
                ATAK_POS(0.2,(10.6 + (0.35/2)),2.7,0.7);
                text = "Back To IP";
                tooltip="$STR_BCE_TIP_EGRS";
                onButtonClick = "[nil,'Task_Building',9] call BCE_fnc_ATAK_ChangeTool;";
            };

            ////////// -5 Line //////////
            class Line1_T5: CtrlType
            {
                idc = 51;
                text="1";
                ATAK_POS(0,(3.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_5Line";
            };
            class L51_EditBnt: RscStructuredText
            {
                idc = idc_D(2040);
                style = 2;
                ATAK_POS(0.2,(3.6 + (0.35/2)),2.7,0.7);
                colorBackground[] = {0.2,0.2,0.2,0.5};
                
                // size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
                size = TextSize;
                text = "“Alpha 1-1” / “Alpha 1-2”";
                tooltip="$STR_BCE_TIP_5Line";
                
                class Attributes
                {
                    align = "center";
                    // valign = "middle";
                    font = "RobotoCondensedBold_BCE";
                    size = TextMenu(0.8);
                };
            };
            
            class Line2_T5: CtrlType
            {
                idc = 52;
                text="2";
                ATAK_POS(0,(4.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_FRND";
            };
            class L52_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2041);
                ATAK_POS(0.2,(4.6 + (0.35/2)),2.7,0.7);
                text = "None";
                tooltip="$STR_BCE_TIP_FRND";
                onButtonClick = "[nil,'Task_Building',1] call BCE_fnc_ATAK_ChangeTool;";
            };
            
            class Line3_T5: CtrlType
            {
                idc = 53;
                text="3";
                ATAK_POS(0,(5.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_GRID";
            };
            class L53_EditBnt: IP2TG_EditBnt
            {
                idc = idc_D(2042);
                ATAK_POS(0.2,(5.6 + (0.35/2)),2.7,0.7);
                text = "None";
                tooltip="$STR_BCE_TIP_GRID";
                onButtonClick = "[nil,'Task_Building',2] call BCE_fnc_ATAK_ChangeTool;";
            };
            
            class Line4_T5: CtrlType
            {
                idc = 54;
                text="4";
                ATAK_POS(0,(6.6 + (0.35/2)),1,0.7);
                tooltip="$STR_BCE_TIP_DESC";
            };
            class L54_EditBnt: L95_EditBnt
            {
                idc = idc_D(2043);
                ATAK_POS(0.2,(6.6 + (0.35/2)),2.3,0.7);
                tooltip="$STR_BCE_TIP_DESC";
            };
            class L54_PullBnt: L95_PullBnt
            {
                idc = idc_D(20430);
                ATAK_POS(2.55,(6.6 + (0.35/2)),0.35,0.7);
                action = "2 call BCE_fnc_ATAK_PullData";
            };
            
            //-Text EditBox
            class New_Task_TG_DESC: RscEdit
            {
                idc = idc_D(2015);
                sizeEx = 0.9 * TextSize;
                ATAK_POS(0.15,(6.5 + (0.35/2)),2.75,0.7);
                
                colorText[] = {0.75,0.75,0.75,1};
                colorBackground[]={0,0,0,0.5};
                tooltip="$STR_BCE_TIP_AddDESC";
                onEditChanged = "(_this + [0]) call BCE_fnc_ATAK_AutoSaveTask";
            };
            class New_Task_GRID_DESC: New_Task_TG_DESC
            {
                idc = idc_D(2016);
                ATAK_POS(0.15,(8.2 + (0.35/2)),2.75,0.7);
                
                text = "$STR_BCE_MarkWith";
                tooltip="";
                onEditChanged = "(_this + [1]) call BCE_fnc_ATAK_AutoSaveTask";
            };
            
            ////// -Separator for Remarks //////
            class Separator: cTab_RscFrame
            {
                idc=3000;
                ATAK_POS(0.1,(11.65 + (0.35/2)),2.8,0.001);
            };
            
            class Remark: Game_Plan_T
            {
                idc=3001;
                text="Remarks/Restrictions";
                ATAK_POS(0.1,(11.7 + (0.35/2)),2.9,1);
                sizeEx = 0.9 * TextSize;
                font = "RobotoCondensedBold_BCE";
                tooltip="$STR_BCE_TIP_Remarks";
            };
            
            class Remark_EditBnt: IP2TG_EditBnt
            {
                idc = 3002;
                ATAK_POS(0.1,(12.7 + (0.35/2)),2.8,0.7);
                text = "No Remarks";
                tooltip="$STR_BCE_TIP_Remarks";
                onButtonClick = "[nil,'Task_Building',10] call BCE_fnc_ATAK_ChangeTool;";
            };
            
            /*class AddRemark: ctrlButton
            {
                idc=3002;
                ATAK_POS((2.4+0.15/2),(11.8 + (0.35/2)),0.4,0.7);
                
                style = "0x02 + 0x30 + 0x800";
                colorBackground[] = {0,0,0,0.3};
                sizeEx = 0.85 * TextSize;
                
                tooltip = "$STR_BCE_TIP_AddRemark";
                text = "a3\3den\data\displays\display3den\panelleft\entitylist_layer_ca.paa";
                
                onButtonClick = "call BCE_fnc_ATAK_addRemark";
            };*/
        };
    };
    //- Task building Components
        class Task_Building: Task_Builder
        {
            class VScrollbar
            {
                scrollSpeed=0;
            };
            
            class controls
            {
                //-Description
                class taskDesc: RscStructuredText
                {
                    idc = idc_D(2004);
                    text = "Desc :";
                    colorBackground[] = {0,0,0,0};
                    ATAK_POS(0,0,3,1);
                    size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
                    class Attributes
                    {
                        font = "RobotoCondensed_BCE";
                        color = "#ffffff";
                        align = "left";
                        shadow = 1;
                        size = TextMenu(0.95);
                    };
                };
                
                class Indicator: RscText
                {
                    idc = idc_D(2011);
                    
                    x = PhoneBFTContainerW(0.1);
                    y = 0.1 * ((60)) / 2048 * CustomPhoneH;
                    w = PhoneBFTContainerW(3);
                    h = phoneSizeH - 0.75 * (((60)) / 2048 * CustomPhoneH);
                };
                
                //-IP
                class New_Task_IPtype: RscToolbox
                {
                    idc = idc_D(2012);
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    
                    rows = 1;
                    columns = 3;
                    strings[] =
                    {
                        "$STR_BCE_Tit_Map_marker",
                        "$STR_BCE_Tit_Click_Map",
                        "$STR_BCE_Tit_OverHead"
                    };
                    
                    font = "RobotoCondensed_BCE";
                    colorBackground[] = {0,0,0,0.3};
                    sizeEx = 0.9 * TextSize;
                    
                    onToolBoxSelChanged = _this + [false,TASK_OFFSET,'cTab_Android_dlg'] call BCE_fnc_ToolBoxChanged;
                };
                class New_Task_MarkerCombo: RscCombo
                {
                    idc = idc_D(2013);
                    ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
                    colorBackground[] = {0.5,0.5,0.5,0.6};
                    colorSelectBackground[] = {0.5,0.5,0.5,0.6};
                    //colorPictureSelected[] = {1,1,1,0};
                    wholeHeight = 0.8;
                    font = "PuristaMedium";
                    sizeEx = 0.85 * TextSize;
                    onMouseButtonClick = "(_this # 0) call BCE_fnc_IPMarkers;";
                    class Items
                    {
                        class NA
                        {
                            text = "$STR_BCE_SelectMarker";
                            data = "[]";
                            default = 1;
                        };
                    };
                };
                class New_Task_IPExpression: RscEdit
                {
                    idc = idc_D(2014);
                    ATAK_POS(1.5,(0.65 + 0.35/2),1.3,0.65);
                    text = "";
                    canModify = 0;
                    sizeEx = 0.85 * TextSize;
                    colorBackground[] = {0,0,0,0};
                    tooltip = "$STR_BCE_tip_ShowResult";
                };
                
                //-TG Description
                class New_Task_TGT: New_Task_IPtype
                {
                    idc = idc_D(20121);
                    columns = 2;
                    strings[] =
                    {
                        "$STR_BCE_Tit_Map_marker",
                        "$STR_BCE_Tit_Click_Map"
                    };
                };

                //-Mark
                class New_Task_GRID_DESC: New_Task_IPExpression
                {
                    idc = idc_D(2016);
                    ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
                    canModify = 1;
                    text = "$STR_BCE_MarkWith";
                };

                //-ERGS
                class New_Task_EGRS_Azimuth: RscToolbox
                {
                    idc = idc_D(2017);
                    ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
                    rows = 1;
                    columns = 8;
                    strings[] =
                    {
                        "N",
                        "NE",
                        "E",
                        "SE",
                        "S",
                        "SW",
                        "W",
                        "NW"
                    };
                    values[] =
                    {
                        0,
                        45,
                        90,
                        135,
                        180,
                        225,
                        270,
                        315
                    };
                    font = "RobotoCondensed_BCE";
                    colorBackground[] = {0,0,0,0.3};
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_EGRS_Bearing: New_Task_GRID_DESC
                {
                    idc = idc_D(2018);
                    ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
                    text = "$STR_BCE_Bearing_ENT";
                };
                class New_Task_EGRS: New_Task_IPtype
                {
                    idc = idc_D(2019);
                    columns = 4;
                    strings[] =
                    {
                        "$STR_BCE_Tit_Azimuth",
                        "$STR_BCE_Tit_Bearing",
                        "$STR_BCE_Tit_Map_marker",
                        "$STR_BCE_Tit_OverHead"
                    };
                    sizeEx = 0.85 * TextSize;
                };
                
                //-Remarks
                class New_Task_FADH: New_Task_IPtype
                {
                    idc = idc_D(2200);
                    columns = 3;
                    strings[] =
                    {
                        "FAD",
                        "FAH",
                        "$STR_BCE_Default"
                    };
                };
                class New_Task_DangerClose_Text: RscText
                {
                    idc = idc_D(2201);
                    ATAK_POS(0.26,(0.3/2 + 0.65*3),2.8,0.65);
                    text = ": Danger Close";
                    sizeEx = 0.9 * TextSize;
                };
                class New_Task_DangerClose_Box: RscCheckBox
                {
                    idc = idc_D(2202);
                    textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
                    
                    x = PhoneBFTContainerW(0.1);
                    y = (0.35/2 + 0.65*3) * ((60)) / 2048 * CustomPhoneH;
                    w = PhoneBFTContainerW(0.3) * (safezoneH/safezonew);
                    h = PhoneBFTContainerW(0.3);
                };
            };
        };
        //- Task Result
        class Task_Result: Task_Building
        {
            class controls
            {
                class taskDesc: RscListBox
                {
                    idc = 11;
                    shadow = 2;
                    
                    colorBackground[] = {0,0,0,0};
                    period = 0;
                    colorSelect[] = {1,1,1,1};
                    colorSelect2[] = {1,1,1,1};
                    colorSelectRight[] = {1,1,1,1};
                    colorSelect2Right[] = {1,1,1,1};
                    colorSelectBackground[] = {0,0,0,0};
                    colorSelectBackground2[] = {0,0,0,0};
                    
                    font = "RobotoCondensed_BCE";
                    sizeEx = TextSize;
                    soundSelect[]={"\A3\ui_f\data\sound\RscListbox\soundSelect",0,1};
                    rowHeight = 0.1 * TextSize;
                    
                    x = 0;
                    y = 0;
                    w = PhoneBFTContainerW(3);
                    h = "SafezoneH";
                };
            };
        };
//- Video Feeds Interface
    #define EMPT_SPAC (0.15 * ((60)) / 2048 * CustomPhoneH)
    class ATAK_Video: ATAK_Message
    {
        class controls
        {
            class Title: BCE_RscButtonMenu
            {
                idc = 5;
                
                x = 0;
                y = 0;
                w = PhoneBFTContainerW(3);
                h = 0.8 * (((60)) / 2048 * CustomPhoneH);
                
                size = 0.7 * (((60)) / 2048 * CustomPhoneH);
                text = "";

                colorBackground[] = {0,0,0,0.5};
                colorBackground2[] = {0,0,0,0.5};
                colorBackgroundFocused[] = {0,0,0,0.5};

                animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";

                onButtonClick = "call BCE_fnc_ATAK_toggleSubListMenu";
                class Attributes: Attributes
                {
                    align = "center";
                    valign = "Bottom";
                };
            };
            //- Sel Other Camera (Helmet, TGP etc)
            class CamSelBox: cTab_RscControlsGroup
            {
                idc = 10;
                //- Scroll
                    class VScrollbar: VScrollbar
                    {
                        width = 0;
                    };
                    class HScrollbar: HScrollbar
                    {
                        height = 0;
                    };
                x = 0;
                y = 0.8 * (((60)) / 2048 * CustomPhoneH);
                w = PhoneBFTContainerW(3);
                h = 0;

                class controls
                {
                    class Type: RscToolbox
                    {
                        idc = 6;
                        
                        x = PhoneBFTContainerW(0.05);
                        y = EMPT_SPAC;
                        w = PhoneBFTContainerW(2.9);
                        h = ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2 - EMPT_SPAC;

                        rows = 1;
                        columns = 2;
                        strings[] =
                        {
                            "$STR_BCE_AC_CAM",
                            "$STR_BCE_Helmet_CAM"
                        };
                        font = "RobotoCondensed_BCE";
                        colorBackground[] = {0,0,0,0.3};
                        sizeEx = 0.8 * TextSize;
                    };
                    class List: RscListbox
                    {
                        idc = 7;
                        colorBackground[]={0,0,0,0.8};
                        sizeEx = TextSize;

                        x = 0;
                        y = ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2 + EMPT_SPAC;
                        w = PhoneBFTContainerW(3);
                        h = phoneSizeH - (0.75 + 0.8) * (((60)) / 2048 * CustomPhoneH) - ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2;
                    };
                };
            };
            class ViewBox: CamSelBox
            {
                idc = 20;
                h = phoneSizeH - (0.75 + 0.8) * (((60)) / 2048 * CustomPhoneH);
                class controls
                {
                    // - Turret Infos + Optional Controls
                        class Track_TG: Title
                        {
                            idc = 11;
                            text = "$STR_BCE_TRACK_TG";
                            
                            colorBackground[] = {0,0,0.5,0.3};
                            colorBackground2[] = {0,0,0.5,0.3};
                            colorBackgroundFocused[] = {0,0,0,0.3};

                            size = 0.8 * TextSize;

                            x = PhoneBFTContainerW(0.05);
                            y = EMPT_SPAC;
                            w = PhoneBFTContainerW(1.45);
                            h = ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2 - EMPT_SPAC;

                            onButtonClick = "[_this#0,0] call BCE_fnc_ATAK_Camera_Controls";
                        };
                        class TG_INFO: RscText
                        {
                            idc = 12;

                            style = 2;
                            text = "";
                            sizeEx = 0.8 * TextSize;
                            colorBackground[]={0,0,0,0.2};

                            x = PhoneBFTContainerW(0.05);
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2;
                            w = PhoneBFTContainerW(1.45);
                            h = ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2 - EMPT_SPAC;
                        };
                        class Vision: Track_TG
                        {
                            idc = 13;
                            text = "";
                            
                            x = PhoneBFTContainerW(1.55);
                            onButtonClick = "[_this#0,1] call BCE_fnc_ATAK_Camera_Controls";
                        };
                        class Sync_Camera: Vision
                        {
                            idc = 14;
                            text = "$STR_BCE_Sync_Zoom";
                            
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize)) / 2;
                            onButtonClick = "[_this#0,2] call BCE_fnc_ATAK_Camera_Controls";
                        };
                    // - Next Turret
                        class TurretTxt: ctrlButton
                        {
                            idc = 46320;
                            text = "";
                            colorBackground[] = {0.25,0.25,0.25,0.8};
                            colorBackgroundActive[] = {0.25,0.25,0.25,0.4};
                            colorBackgroundDisabled[] = {0.25,0.25,0.25,0.8};
                            colorDisabled[] = {1,1,1,1};

                            x = 0;
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (((60)) / 2048 * CustomPhoneH)) - (0.85 * TextSize);
                            w = PhoneBFTContainerW(3);
                            h = 0.85 * TextSize;
                            sizeEx = 0.75 * TextSize;

                            font = "RobotoCondensed_BCE";
                            colorShadow[] = {0,0,0,0.2};

                            offsetPressedX = 0;
                            offsetPressedY = 0;
                            
                            onButtonClick = "[_this # 0,17000] call BCE_fnc_NextTurretButton;";
                        };
                    //- Video Layer
                        class Vic_PIP_Display: RscPicture
                        {
                            idc = 4632;
                            text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
                            x = 0;
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH));
                            w = PhoneBFTContainerW(3);
                            h = phoneSizeH - EMPT_SPAC - 0.75 * (((60)) / 2048 * CustomPhoneH) - (phoneSizeW * 3/5)/3;
                        };
                        class Vic_PIP_No_Signal: TurretTxt
                        {
                            idc = 46310;

                            x = 0;
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH));
                            w = PhoneBFTContainerW(3);
                            h = phoneSizeH - EMPT_SPAC - 0.75 * (((60)) / 2048 * CustomPhoneH) - (phoneSizeW * 3/5)/3;
                            
                            style = 2;
                            text = "$STR_BCE_No_Signal";
                            colorBackground[]={0,0,0,0.4};
                            colorBackgroundActive[] = {0,0,0,0.2};
                            colorBackgroundDisabled[] = {0,0,0,0.4};
                            colorDisabled[] = {1,1,1,0.25};

                            onButtonClick = "";
                            action = "call cTab_Tablet_btnACT";
                        };
                };
            };
        };
    };
    #undef EMPT_SPAC
//- Group Manage
    class ATAK_Group: ATAK_Message
    {
        class controls: controls
        {
            class Title: Title
            {
                idc = 5;
                text = "Group";
                w = PhoneBFTContainerW(2.4);
            };
            class New_Grp: Title
            {
                idc = 6;
                style = "0x02 + 0x0C + 0x0100";
                shadow = 1;
                text = "<img image='MG8\AVFEVFX\data\add.paa' />";

                x = PhoneBFTContainerW(2.4);
                w = PhoneBFTContainerW(0.6);
                
                onButtonClick = "";
            };

            class Group_Box: Group_Box
            {
                idc = 10;
                h = phoneSizeH - 1.55 * (((60)) / 2048 * CustomPhoneH);

                #define TAG_TITLE(NAME,SIZE,ICON) #<img size=SIZE image='a3\ui_f\data\map\markers\military\dot_ca.paa'/><img size=SIZE align='center' image=ICON/><t align='center'> NAME</t>
                class controls
                {
                    class All_Groups: ATAK_Group_Manage_System
                    {
                        idc = 98;
                        class controls: controls
                        {
                            class Tag_Bnt: Tag_Bnt
                            {
                                text = TAG_TITLE(All Groups,'0.8','a3\3den\data\displays\display3den\toolbar\widget_global_ca.paa');
                            };
                            class Msg_bnt: Msg_bnt{};
                        };
                    };
                    class My_Team: All_Groups
                    {
                        idc = 99;
                        class controls: controls
                        {
                            class Tag_Bnt: Tag_Bnt
                            {
                                text = TAG_TITLE(My Team,'0.8','a3\3den\data\displays\display3den\panelright\modegroups_ca.paa');
                            };
                            class Msg_bnt: Msg_bnt{};
                        };
                    };
                };
                #undef TAG_TITLE
            };
        };
    };
