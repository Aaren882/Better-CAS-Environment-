#include "ATAK_MACRO.hpp"

class ATAK_APPs
{
    //-First Line
        class message: BCE_ATAK_Tool_ICON
        {
            ORDER = 0; //- Default Order (Customizable)
            text = ATAK_APP(Missions);
            onButtonClick = "[_this # 0, 'message'] call BCE_fnc_ATAK_ChangeTool;";
            
            textureNoShortcut=APP_MSG;
        };
        class mission: message
        {
            ORDER = 1;
            text = ATAK_APP(Missions);
            onButtonClick = "[_this # 0, 'mission'] call BCE_fnc_ATAK_ChangeTool;";

            textureNoShortcut="MG8\AVFEVFX\data\missions.paa";
        };
        class VideoFeeds: message
        {
            ORDER = 2;
            text = ATAK_APP(Video Feeds);
            onButtonClick = "[_this # 0, 'VideoFeeds'] call BCE_fnc_ATAK_ChangeTool;";
            
            textureNoShortcut="MG8\AVFEVFX\data\Hcam.paa";
        };
    //-Second Line
        class Photo: message
        {
            ORDER = 3;
            text = ATAK_APP(Quick Pictures);
            onButtonClick = "558 cutRsc ['BCE_PhoneCAM_View','PLAIN',0.3,false];";
            
            textureNoShortcut="MG8\AVFEVFX\data\photo.paa";
        };
        class Groups: Photo
        {
            ORDER = 4;
            text = ATAK_APP(Groups);
            onButtonClick = "[_this # 0, 'Group'] call BCE_fnc_ATAK_ChangeTool;";
            
            textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
        };
        class Route: Photo
        {
            ORDER = 5;
            text = ATAK_APP(Route);
            onButtonClick = "";
            
            textureNoShortcut="MG8\AVFEVFX\data\route.paa";
        };
    
    //-Thired Line
        class Weather: message
        {
            ORDER = 6;
            text = ATAK_APP(Weather);
            onButtonClick = "";
            
            textureNoShortcut="a3\3den\data\displays\display3den\toolbar\intel_ca.paa";
        };
        class BDA_Report: Weather
        {
            ORDER = 7;
            text = ATAK_APP(BDA Report);
            onButtonClick = "";
            
            textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
        };
        
        class settings: VideoFeeds
        {
            ORDER = 8;
            text = ATAK_APP(Settings);
            onButtonClick = "";
            
            textureNoShortcut="MG8\AVFEVFX\data\settings.paa";
        };
};