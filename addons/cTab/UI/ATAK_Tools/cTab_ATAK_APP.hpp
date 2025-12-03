#include "ATAK_MACRO.hpp"
#include "ATAK_Buttons.hpp"

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
        ATAK_Buttons = "Message_Menu"; //- #LINK - cTab/ATAK_Tools/ATAK_Buttons.hpp
      };
      
      onButtonClick = "[_this # 0] call BCE_fnc_ATAK_ChangeTool;";
      
      text = ATAK_APP(Message);
      textureNoShortcut=APP_MSG;
    };
    class mission: message
    {
      class Menu_Property
      {
        ORDER = 1;
        PAGE_CTRL = "Task_Builder";
        Opened = "BCE_fnc_ATAK_mission_Init";
        ATAK_Buttons = "MissionSend_Menu";
        /* Pages[] = {
          // { "CTRL_CLASS" , "OPENED" , "ATAK_Buttons" }
          {"Task_Building", "BCE_fnc_ATAK_mission_SUB_TaskBuilding"},
          {"Task_CFF_List", "BCE_fnc_ATAK_mission_SUB_TaskCFFList"},
          {"Task_CFF_Action", "BCE_fnc_ATAK_mission_SUB_TaskCFF_Action"},
          {"Task_Result", "BCE_fnc_ATAK_mission_SUB_TaskResult"}
        }; */
        class Pages
        {
          class Task_Building
          {
            PAGE_CTRL = "Task_Building";
            Opened = "BCE_fnc_ATAK_mission_SUB_TaskBuilding";
            ATAK_Buttons = "TaskBuilding_Menu";
          };
          class Task_CFF_List
          {
            PAGE_CTRL = "Task_CFF_List";
            Opened = "BCE_fnc_ATAK_mission_SUB_TaskCFFList";
            ATAK_Buttons = "Task_CFF_List_Menu";
          };
          class Task_CFF_Action
          {
            PAGE_CTRL = "Task_CFF_Action";
            Opened = "BCE_fnc_ATAK_mission_SUB_TaskCFF_Action";
            LastPage = "Task_CFF_List"; //- ClassName of the page
            ATAK_Buttons = "Task_CFF_Action_Menu";
          };
          class Task_Result
          {
            PAGE_CTRL = "Task_Result";
            Opened = "BCE_fnc_ATAK_mission_SUB_TaskResult";
            // ATAK_Buttons = "TaskBuilding_Menu";
          };
        };
      };

      text = ATAK_APP(Missions);
			textureNoShortcut = QPATHTOEF(Core,data\missions.paa);
    };
    class VideoFeeds: message
    {
      class Menu_Property
      {
        ORDER = 2;
        PAGE_CTRL = "ATAK_Video";
        Opened = "BCE_fnc_ATAK_VideoFeeds_Init";
        ATAK_Buttons = "VideoFeeds_Menu";
      };

      text = ATAK_APP(Video Feeds);
			textureNoShortcut = QPATHTOEF(Core,data\Hcam.paa);
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
			textureNoShortcut = QPATHTOEF(Core,data\photo.paa);
    };
    class Group: message
    {
      class Menu_Property
      {
        ORDER = 4;
        PAGE_CTRL = "";
        // PAGE_CTRL = "ATAK_Group";
        // Opened = "BCE_fnc_ATAK_Group_Init";
        // ATAK_Buttons = "Group_Menu";
      };

      text = ATAK_APP(Groups);
      textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
    };
    class Route: message
    {
      class Menu_Property
      {
        ORDER = 5;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(Route);
			textureNoShortcut = QPATHTOEF(Core,data\route.paa);
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
    class BDA_Report: message
    {
      class Menu_Property
      {
        ORDER = 7;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(BDA Report);
      textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
    };
    
    class settings: message
    {
      class Menu_Property
      {
        ORDER = 8;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(Settings);
			textureNoShortcut = QPATHTOEF(Core,data\settings.paa);
    };
};