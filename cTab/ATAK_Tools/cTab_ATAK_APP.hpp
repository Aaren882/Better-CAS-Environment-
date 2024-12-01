#include "ATAK_MACRO.hpp"

class ATAK_APPs
{
    //-First Line
        class message: BCE_ATAK_Tool_ICON
        {
            class Menu_Property
            {
                ORDER = 0; //- Default Order (Customizable)
                PAGE_CTRL = "ATAK_Message"; //- which "Control Class" switch to
                Opened = "BCE_fnc_ATAK_message_Init";
            };
            
            onButtonClick = "[_this # 0] call BCE_fnc_ATAK_ChangeTool;";
            
            text = ATAK_APP(Missions);
            textureNoShortcut=APP_MSG;
        };
        class mission: message
        {
            class Menu_Property
            {
                ORDER = 1;
                PAGE_CTRL = "Task_Builder";
                Opened = "BCE_fnc_ATAK_mission_Init";
                Pages[] = {
                    // { "CTRL_CLASS" , "OPENED" }
                    {"Task_Building", "BCE_fnc_ATAK_mission_SUB_TaskBuilding"},
                    {"Task_Result", "BCE_fnc_ATAK_mission_SUB_TaskResult"}
                };
            };

            text = ATAK_APP(Missions);
            textureNoShortcut="MG8\AVFEVFX\data\missions.paa";
        };
        class VideoFeeds: message
        {
            class Menu_Property
            {
                ORDER = 2;
                PAGE_CTRL = "ATAK_Video";
                Opened = "BCE_fnc_ATAK_VideoFeeds_Init";
            };

            text = ATAK_APP(Video Feeds);
            textureNoShortcut="MG8\AVFEVFX\data\Hcam.paa";
        };
    //-Second Line
        class Photo: message
        {
            class Menu_Property
            {
                ORDER = 3;
                PAGE_CTRL = "";
            };

            onButtonClick = "558 cutRsc ['BCE_PhoneCAM_View','PLAIN',0.3,false];";
            
            text = ATAK_APP(Quick Pictures);
            textureNoShortcut="MG8\AVFEVFX\data\photo.paa";
        };
        class Group: Photo
        {
            class Menu_Property
            {
                ORDER = 4;
                PAGE_CTRL = "ATAK_Group";
                Opened = "BCE_fnc_ATAK_Group_Init";
            };

            onButtonClick = "[_this # 0] call BCE_fnc_ATAK_ChangeTool;";
            
            text = ATAK_APP(Groups);
            textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
        };
        class Route: Group
        {
            class Menu_Property
            {
                ORDER = 5;
                PAGE_CTRL = "";
            };

            text = ATAK_APP(Route);
            textureNoShortcut="MG8\AVFEVFX\data\route.paa";
        };
    
    //-Thired Line
        class Weather: message
        {
            class Menu_Property
            {
                ORDER = 6;
                PAGE_CTRL = "";
            };

            text = ATAK_APP(Weather);
            textureNoShortcut="a3\3den\data\displays\display3den\toolbar\intel_ca.paa";
        };
        class BDA_Report: Weather
        {
            class Menu_Property
            {
                ORDER = 7;
                PAGE_CTRL = "";
            };

            text = ATAK_APP(BDA Report);
            textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
        };
        
        class settings: VideoFeeds
        {
            class Menu_Property
            {
                ORDER = 8;
                PAGE_CTRL = "";
            };

            text = ATAK_APP(Settings);
            textureNoShortcut="MG8\AVFEVFX\data\settings.paa";
        };
};