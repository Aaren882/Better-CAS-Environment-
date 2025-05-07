class ATAK_Buttons
{
    class MissionSend_Menu
    {
        onLoad = "BCE_fnc_ATAK_bnt_SendMission"; //- [ALL the Buttons]
        clickEvents[] = {
            "BCE_fnc_ATAK_DataReceiveButton",
            "cTab_Tablet_btnACT",
            "BCE_fnc_ATAK_ShowTaskResult"
        };
    };
    class TaskBuilding_Menu
    {
        onLoad = "BCE_fnc_ATAK_bnt_TaskBuilding"; //- [ALL the Buttons]
        clickEvents[] = {
            "BCE_fnc_ATAK_DataReceiveButton",
            "cTab_Tablet_btnACT",
            "BCE_fnc_ATAK_ShowTaskResult"
        };
    };
    class Group_Menu
    {
        onLoad = "BCE_fnc_ATAK_bnt_Group"; //- [ALL the Buttons]
        clickEvents[] = {
            ""
        };
    };
    class Message_Menu
    {
        onLoad = "BCE_fnc_ATAK_bnt_Message"; //- [ALL the Buttons]
        clickEvents[] = {
            "ATAK_bnt_MessageSend_Click"
        };
    };
    class VideoFeeds_Menu
    {
        onLoad = "BCE_fnc_ATAK_bnt_VideoFeeds"; //- [ALL the Buttons]
        clickEvents[] = {
            "ATAK_bnt_VideoFeeds_Click"
        };
    };
};