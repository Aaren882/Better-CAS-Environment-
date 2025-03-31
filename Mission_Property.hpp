/* 
    This file is used to define the mission properties for the BCE mission/task Builder

    Ex. 9Line, 5Line, etc.
 */

//- #NOTE IMPROTANT - Mission Types For Each Category
// #LINK - functions/CAS_Menu/fn_onLoad_BCE_Holder.sqf
class BCE_Mission_Default
{
    class AIR
    {
        9Line = "AIR_9_LINE";
        5Line = "AIR_5_LINE";
    };
    class GND
    {
        CFF = "CFF";
    };
};
class BCE_Mission_Property
{
    //- Event Functions (PREFIX : "BCE_TaskBuilding_")
    Event_Functions[] = {
        "Opened",
        "Enter",
        "Clear",
        "SendData", //- "Data Send" to the TaskUnit
        "DataSent", //- "Data is Sent" to the TaskUnit
        "Element_SelChanged", //- For the ToolBox Selection
        "LBTaskUnitChanged", //- For the "TaskUnit <DROPBOX>" Selection
        "TaskUnitChanged", //- For the "TaskUnit <OBJECT>" Selection
        "LBTaskTypeChanged" //- For the "TaskType <DROPBOX>" Selection
    };
    //- FIRST From Category
    class AIR //- Air Fire Support
    {
        // : NO Inheritance
        class AIR_9_LINE
        {
            displayName = "9 Line"; //- Localiziable displayName

            class Variable
            {
                TaskUnit = "TGP_View_Selected_Vehicle"; //- Where the TaskUnit is stored
                name = "BCE_CAS_9Line_Var"; //- Where the data is stored
                default = "[[""NA"",0],[""NA"","""",[],[0,0]],[""NA"",180],[""NA"",200],[""NA"",15],[""NA"",""--""],[""NA"","""",[],[0,0],[]],[""NA"",""1111""],[""NA"","""",[],[0,0],""""],[""NA"",0,[],nil,nil],[""NA"",-1,[]]]";
                Map_Infos[] = {
                    "",
                    "IP_BP_Point",
                    "",
                    "",
                    "",
                    "",
                    "Air_TGT_Point",
                    "",
                    "FRD_Point",
                    "EGRS_Point"
                };
                
                //- Check if the Task is able to send
                // (VAR # 0) != "NA"
                InvaildMsg = "$STR_BCE_Error_Task9";
                Vaild_Lines[] = {0,6,8,9};
            };
   
            Controls[] = 
            {
                {
                    "","New_Task_CtrlType",
                    "","New_Task_AttackType",
                    "",
                    "AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
                },
                {
                    "New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression"
                },
                {},
                {},
                {},
                {"New_Task_TG_DESC"},
                {"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
                {"New_Task_GRID_DESC"},
                {"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression","New_Task_FRND_DESC"},
                {"New_Task_EGRS","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_MarkerCombo"},
                {"New_Task_FADH","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_DangerClose_Text","New_Task_DangerClose_Box"}
            };
            /* {
                {20110,2011,20111,20112,20113,2020,2021,2022,2023,2024},
                {2012,2013,2014},
                {},
                {},
                {},
                {2015},
                {20121,2013,2014},
                {2016},
                {2012,2013,2014,2016},
                {2019,2018,2014,2017,2013},
                {2200,2018,2014,2017,2201,2202}
            } */
            Descriptions[] = {
                "$STR_BCE_DECS_GAMEPLAN",
                "$STR_BCE_DECS_IPBP_NoKey",
                "$STR_BCE_DECS_HDG",
                "$STR_BCE_DECS_DIST",
                "$STR_BCE_DECS_ELEV",
                "$STR_BCE_DECS_DESC",
                "$STR_BCE_DECS_GRID",
                "$STR_BCE_DECS_MARK",
                "$STR_BCE_DECS_FRND",
                "$STR_BCE_DECS_EGRS",
                "$STR_BCE_DECS_Remarks"
            };
            
            //- Events
            class Events
            {
                Opened = "BCE_fnc_DblClick9line";
                Enter = "BCE_fnc_DataReceive9line";
                SendData = "BCE_fnc_SendData9line";
                DataSent = "BCE_fnc_DataSent_AIR";
                Element_SelChanged = "BCE_fnc_SelChanged_AIR";
                LBTaskTypeChanged = "BCE_fnc_LBTaskTypeChanged"; //- For the TaskType Selection
                LBTaskUnitChanged = "BCE_fnc_LBTaskUnitChanged"; //- For the TaskUnit Selection
                Clear = "BCE_fnc_clearTask9line"; //- Clear All the data
            };
        };
        class AIR_9_LINE_ATAK: AIR_9_LINE
        {
            Controls[] = 
            {
                {
                    "","New_Task_CtrlType",
                    "","New_Task_AttackType_Combo",
                    "",
                    "AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
                },
                {
                    "New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression"
                },
                {},
                {},
                {},
                {"New_Task_TG_DESC"},
                {"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
                {"New_Task_GRID_DESC"},
                {"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression","New_Task_FRND_DESC"},
                {"New_Task_EGRS","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_MarkerCombo"},
                {"New_Task_FADH","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_DangerClose_Text","New_Task_DangerClose_Box"}
            };
            class Events: Events
            {
                LBTaskTypeChanged = "BCE_fnc_ATAK_TaskTypeChanged"; //- For the TaskType Selection
            };
        };
        class AIR_5_LINE
        {
            displayName = "5 Line"; //- Localiziable displayName

            class Variable
            {
                name = "BCE_CAS_5Line_Var"; //- Where the data is stored
                default = "[[""NA"",0],[""NA"","""",[],[0,0],""""],[""NA"",""111222""],[""NA"",""--"",""""],[""NA"",-1,[]]]";
                Map_Infos[] = {
                    "",
                    "FRD_Point",
                    "Air_TGT_Point"
                };
                Drawn_Tasks[] = {
                    {}
                };
                //- Check if the Task is able to send
                InvaildMsg = "$STR_BCE_Error_Task5";
                Vaild_Lines[] = {0,1,2};
            };

            //- Maybe use UI Controls would be better
            Controls[] = {
                {
                    "","New_Task_CtrlType",
                    "","New_Task_AttackType",
                    "",
                    "AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
                },
                {"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression","New_Task_GRID_DESC_Air_5line"},
                {"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
                {"New_Task_TG_DESC","New_Task_GRID_DESC"},
                {"New_Task_FADH","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_DangerClose_Text","New_Task_DangerClose_Box"}
            };
            /* {
                {20110,2011,20111,20112,20113,2020,2021,2022,2023,2024},
                {2012,2013,2014,2016},
                {20121,2013,2014},
                {2015,2016},
                {2200,2018,2014,2017,2201,2202}
            } */
            Descriptions[] = {
                "$STR_BCE_DECS_GAMEPLAN",
                "$STR_BCE_DECS_FRNDMark",
                "$STR_BCE_DECS_TGT",
                "$STR_BCE_DECS_DESCMark",
                "$STR_BCE_DECS_Remarks"
            };

            //- Events
            class Events
            {
                Opened = "BCE_fnc_DblClick5line";
                Enter = "BCE_fnc_DataReceive5line";
                SendData = "BCE_fnc_SendData5line";
                DataSent = "BCE_fnc_DataSent_AIR";
                Element_SelChanged = "BCE_fnc_SelChanged_AIR";
                LBTaskTypeChanged = "BCE_fnc_LBTaskTypeChanged"; //- For the TaskType Selection
                Clear = "BCE_fnc_clearTask5line"; //- Clear All the data
            };
        };
        class AIR_5_LINE_ATAK: AIR_5_LINE
        {
            Controls[] = {
                {
                    "","New_Task_CtrlType",
                    "","New_Task_AttackType_Combo",
                    "",
                    "AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
                },
                {"New_Task_IPtype","New_Task_MarkerCombo","New_Task_IPExpression","New_Task_GRID_DESC_Air_5line"},
                {"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
                {"New_Task_TG_DESC","New_Task_GRID_DESC"},
                {"New_Task_FADH","New_Task_EGRS_Bearing","New_Task_IPExpression","New_Task_EGRS_Azimuth","New_Task_DangerClose_Text","New_Task_DangerClose_Box"}
            };

            class Events: Events
            {
                TaskUnitChanged = "BCE_fnc_ATAK_TaskUnitChanged_AIR"; //- For the TaskUnit Selection
                LBTaskTypeChanged = "BCE_fnc_ATAK_TaskTypeChanged"; //- For the TaskType Selection
            };
        };
    };
    class GND //- Ground Fire Support
    {
        class CFF
        {
            displayName = "Call For Fire"; //- Localiziable displayName
            class Variable
            {
                TaskUnit = "BCE_CFF_Selected_Veh"; //- Where the TaskUnit is stored
                name = "BCE_CFF_Var"; //- Where the data is stored
                default = "[[""NA"",0],[""NA"","""",[],[0,0],""""],[""NA"",""111222""],[""NA"",""--"",""""],[""NA"",[]]]";
                Map_Infos[] = {};
                
                //- Check if the Task is able to send
                // (VAR # 0) != "NA"
                InvaildMsg = "";
                Vaild_Lines[] = {0};
            };

            Controls[] = {
                {
                    "TaskType_GND",
                    "AI_Remark_WeaponCombo","AI_Remark_ModeCombo","Attack_Range_Combo","Round_Count_Box","Attack_Height_Box"
                },
                {},
                {"New_Task_TGT","New_Task_MarkerCombo","New_Task_IPExpression"},
                {"New_Task_TG_DESC","New_Task_GRID_DESC"},
                {"New_Task_CFF_CtrlType","New_Task_CFF_TOT","New_Task_IPExpression","New_Task_CFF_ETA"}
            };
            Descriptions[] = {
                "$STR_BCE_DECS_GAMEPLAN",
                "$STR_BCE_DECS_FRNDMark",
                "$STR_BCE_DECS_TGT",
                "$STR_BCE_DECS_DESCMark",
                "在沒有指定管制方法的情況下，射擊任務將以「準備就緒時」(When Ready) 執行。<br/><br/>在基礎學校您可能會使用的另外兩個選項是「聽我口令」(At My Command, AMC) 和「目標時間」(Time on Target, TOT)。"
            };

            //- Events
            class Events
            {
                Opened = "BCE_fnc_DblClickCFF";
                Enter = "BCE_fnc_DataReceive_CFF";
                Element_SelChanged = "BCE_fnc_SelChanged_CFF";
                LBTaskUnitChanged = "BCE_fnc_LBTaskUnitChanged"; //- For the TaskUnit Selection
                TaskUnitChanged = "BCE_fnc_TaskUnitChanged_CFF"; //- For the TaskUnit Selection
                Clear = ""; //- Clear All the data
            };
        };
        class CFF_ATAK: CFF
        {
            class Events: Events
            {
                TaskUnitChanged = "BCE_fnc_ATAK_TaskUnitChanged_CFF"; //- For the TaskUnit Selection
                LBTaskTypeChanged = "BCE_fnc_ATAK_TaskTypeChanged"; //- For the TaskUnit Selection
            };
        };
    };
};