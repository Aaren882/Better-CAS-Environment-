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
                data[] = {
                    "AIR", //- Air
                    "GND", //- Ground
                    "OTR"  //- Others
                };
                onToolBoxSelChanged = "[] call BCE_fnc_ATAK_updateTaskControl";
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
                    
                    shadow = 1;
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
                    // - Video Layer
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
