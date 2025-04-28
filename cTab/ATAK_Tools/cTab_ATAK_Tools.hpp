//- Message Interface
    class ATAK_Message: ATAK_AppMenu_Base
    {
        /*x = phoneSizeX + (phoneSizeW * 3/5);
        y = phoneSizeY;*/
        w = phoneSizeW * 2/5;
        h = phoneSizeH - 0.75 * ATAK_POS_H;

        class controls
        {
            class Title: BCE_RscButtonMenu
            {
                idc = 5;
                x = 0;
                y = 0;
                w = PhoneBFTContainerW(3);
                h = 0.8 * ATAK_POS_H;

                size = 0.7 * ATAK_POS_H;
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
                y = 0.8 * ATAK_POS_H;
                w = PhoneBFTContainerW(3);
                h = phoneSizeH - 2.3 * ATAK_POS_H;
            };
            class Contacts_list: RscListbox
            {
                idc = 6;
                colorBackground[] = {0,0,0,0.3};
                colorSelectBackground[] = {0.95,0.95,0.95,0.4};
                sizeEx = 0.8 * (((60) - (20))) / 2048 * CustomPhoneH;

                x = 0;
                y = 0.8 * ATAK_POS_H;
                w = PhoneBFTContainerW(3);
                h = 0;
            };
            class typing: RscEdit
            {
                idc = 11;
                
                x = 0;
                y = phoneSizeH - 1.5 * ATAK_POS_H;
                w = PhoneBFTContainerW(3);
                h = 0.75 * ATAK_POS_H;

                sizeEx = 0.64 * (((60) - (20))) / 2048 * CustomPhoneH;

                colorBackground[]={0,0,0,0.5};
            };
        };
    };
//- Task Building Page
    #define CATEGORY_H 1
    class Task_Builder: ATAK_Message
    {
        class controls
        {
            //- Background (for ControlGroup)
                class Background: RscBackground
                {
                    idc = 20;
                    text="";
                    colorBackground[] = {0,0,0.5,0.1};
                    x = 0;
                    y = CATEGORY_H * ATAK_POS_H;
                    w = PhoneBFTContainerW(3);
                    h = phoneSizeH - ((CATEGORY_H + 0.75) * ATAK_POS_H);
                };
            class ListCategory: ctrlToolboxPictureKeepAspect
            {
                idc = idc_D(2102);
                ATAK_POS(0,0,3,CATEGORY_H);
                colorBackground[] = {0,0,0,0.3};
                rows = 1;
                columns = 3;
                sizeEx = 0.9 * TextSize;
                strings[] =
                {
                    "\MG8\AVFEVFX\data\airSupport.paa",
                    "\MG8\AVFEVFX\data\artiliry.paa",
                    "\MG8\AVFEVFX\data\other_options.paa"
                };
                tooltips[] =
                {
                    "Air Fire Support",
                    "Ground Fire Support",
                    "Others"
                };

                //- Connects to => "BCE_Mission_Property" Category
                data[] = {
                    "AIR", //- Air
                    "GND", //- Ground
                    "OTR"  //- Others
                };
            };
        };
    };
    //- TASK GROUPs (9 Line, 5 Line etc)
        #include "\MG8\AVFEVFX\cTab\ATAK_Tools\Mission\AIR.hpp"
        #include "\MG8\AVFEVFX\cTab\ATAK_Tools\Mission\GND.hpp"
    #undef CATEGORY_H
    //- Task building Components
        class Task_Building: Task_Builder
        {
            class VScrollbar
            {
                scrollSpeed=0;
            };
            
            //- Inherit from #LINK - cTab/ATAK_Tools/cTab_ATAK_Tools.hpp
            class controls: BCE_Mission_Build_Controls
            {
                class taskDesc: taskDesc
                {
                    ATAK_POS(0,0,3,1);
                    size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
                    class Attributes: Attributes
                    {
                        size = TextMenu(0.95);
                    };
                };
                
                /*class Indicator: RscText
                {
                    idc = idc_D(2011);
                    
                    x = PhoneBFTContainerW(0.1);
                    y = 0.1 * ((60)) / 2048 * CustomPhoneH;
                    w = PhoneBFTContainerW(3);
                    h = phoneSizeH - 0.75 * ATAK_POS_H;
                };*/
                class New_Task_IPtype: New_Task_IPtype
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.9 * TextSize;
                    // onToolBoxSelChanged = _this + [false,TASK_OFFSET,'cTab_Android_dlg'] call BCE_fnc_ToolBoxChanged;
                };
                /* class New_Task_CFF_OT_Info: New_Task_CFF_OT_Info
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.9 * TextSize;
                }; */
                class New_Task_MarkerCombo: New_Task_MarkerCombo
                {
                    ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
                    sizeEx = 0.85 * TextSize;

                    colorBackground[] = {0.3,0.3,0.3,1};
                    colorSelect[]={1,1,1,1};
                    colorSelectBackground[]={0.4,0.4,0.4,1};
                };
                class New_Task_IPExpression: New_Task_IPExpression
                {
                    ATAK_POS(1.5,(0.65 + 0.35/2),1.4,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                //-TG Description
                class New_Task_TGT: New_Task_TGT
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.9 * TextSize;
                };
                class New_Task_GRID_DESC: New_Task_GRID_DESC
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_GRID_DESC_Air_5line: New_Task_GRID_DESC_Air_5line
                {
                    ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_FRND_DESC: New_Task_FRND_DESC
                {
                    ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_EGRS_Azimuth: New_Task_EGRS_Azimuth
                {
                    ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_EGRS_Bearing: New_Task_EGRS_Bearing
                {
                    ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_EGRS: New_Task_EGRS
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_FADH: New_Task_FADH
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_DangerClose_Text: New_Task_DangerClose_Text
                {
                    ATAK_POS(0.26,(0.3/2 + 0.65*3),2.8,0.65);
                    sizeEx = 0.9 * TextSize;
                };
                class New_Task_DangerClose_Box: New_Task_DangerClose_Box
                {
                    x = PhoneBFTContainerW(0.1);
                    y = (0.35/2 + 0.65*3) * ((60)) / 2048 * CustomPhoneH;
                    w = PhoneBFTContainerW(0.3) * (safezoneH/safezonew);
                    h = PhoneBFTContainerW(0.3);
                };

                //- Call for Fire
                class New_Task_CFF_CtrlType: New_Task_CFF_CtrlType
                {
                    ATAK_POS(0.1,0.35/2,2.8,0.65);
                    sizeEx = 0.9 * TextSize;
                };
                class New_Task_CFF_TOT: New_Task_CFF_TOT
                {
                    ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
                    sizeEx = 0.85 * TextSize;
                };
                class New_Task_CFF_ETA: New_Task_CFF_ETA
                {
                    ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
                    size = 0.9 * TextSize;

                    class Attributes: Attributes
                    {
                        size = 0.9;
                        align = "center";
                        valign = "Middle";
                    };
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
        class Task_CFF_List: ATAK_Message
        {
            class controls: controls
            {
                class ListCategory: RscToolbox
                {
                    idc = idc_D(2102);
                    ATAK_POS(0,0,3,0.8);
                    colorBackground[] = {0,0,0,0.3};
                    rows = 1;
                    columns = 2;
                    sizeEx = 0.9 * TextSize;
                    strings[] =
                    {
                        "MISSION",
                        "ARCHIVES"
                    };
                    tooltips[] =
                    {
                        "Missions",
                        "Archives"
                    };
                };
                class Group_Box: Group_Box
                {
                    idc = 10;
                    h = phoneSizeH - 1.55 * ATAK_POS_H;
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
                h = 0.8 * ATAK_POS_H;
                
                size = 0.7 * ATAK_POS_H;
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
                y = 0.8 * ATAK_POS_H;
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
                        h = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC;

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
                        y = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 + EMPT_SPAC;
                        w = PhoneBFTContainerW(3);
                        h = phoneSizeH - (0.75 + 0.8) * ATAK_POS_H - ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2;
                    };
                };
            };
            class ViewBox: CamSelBox
            {
                idc = 20;
                h = phoneSizeH - (0.75 + 0.8) * ATAK_POS_H;
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
                            h = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC;

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
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2;
                            w = PhoneBFTContainerW(1.45);
                            h = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC;
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
                            
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2;
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
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * ATAK_POS_H) - (0.85 * TextSize);
                            w = PhoneBFTContainerW(3);
                            h = 0.85 * TextSize;
                            sizeEx = 0.75 * TextSize;

                            font = "RobotoCondensed_BCE";
                            colorShadow[] = {0,0,0,0.2};

                            offsetPressedX = 0;
                            offsetPressedY = 0;
                            
                            onButtonClick = "[_this # 0,17000] call BCE_fnc_NextTurretButton;";
                        };
                    // - Video Layer
                        class Vic_PIP_Display: RscPicture
                        {
                            idc = 4632;
                            text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
                            x = 0;
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH));
                            w = PhoneBFTContainerW(3);
                            h = phoneSizeH - EMPT_SPAC - 0.75 * ATAK_POS_H - (phoneSizeW * 3/5)/3;
                        };
                        class Vic_PIP_No_Signal: TurretTxt
                        {
                            idc = 46310;

                            x = 0;
                            y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH));
                            w = PhoneBFTContainerW(3);
                            h = phoneSizeH - EMPT_SPAC - 0.75 * ATAK_POS_H - (phoneSizeW * 3/5)/3;
                            
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
                h = phoneSizeH - 1.55 * ATAK_POS_H;

                #define TAG_TITLE(NAME,SIZE,ICON) #<img size=SIZE image='a3\ui_f\data\map\markers\military\dot_ca.paa'/><img size=SIZE align='center' image=ICON/><t align='center'> NAME</t>
                class controls
                {
                    class All_Groups: ATAK_Group_Manage_System
                    {
                        idc = 100;
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
                        idc = 101;
                        y = 0.7 * (((60)) / 2048 * CustomPhoneH);
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
