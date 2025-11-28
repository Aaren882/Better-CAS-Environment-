class CfgFunctions
{
  //- overwrite for "1erGTD"
  class cTab_core
  {
    class function
    {
      // file="MG8\AVFEVFX\functions\cTab\Origin\Extra";
      file= QPATHTOF(functions\Extra);
      class toggleInterface;
    };
  };
  
	class cTab
  {
    class Functions
    {
      class AVInfoMenu_toggle
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_AVInfoMenu_toggle.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_AVInfoMenu_toggle.sqf);
      };
      class Tablet_btnACT
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_Tablet_btnACT.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_Tablet_btnACT.sqf);
      };
      class showMenu_toggle
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_showMenu_toggle.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_showMenu_toggle.sqf);
      };
      
      class onMapDoubleClick
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_onMapDoubleClick.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_onMapDoubleClick.sqf);
      };
      class OnDrawbft
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbft.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawbft.sqf);
      };
      class OnDrawbftAndroid
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftAndroid.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawbftAndroid.sqf);
      };
      class OnDrawbftAndroidDsp
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftAndroidDsp.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawbftAndroidDsp.sqf);
      };
      class OnDrawbftTAD
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftTAD.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawbftTAD.sqf);
      };
      class OnDrawbftTADdialog
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftTADdialog.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawbftTADdialog.sqf);
      };
      class OnDrawbftVeh
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftVeh.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawbftVeh.sqf);
      };
      class OnDrawHCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawHCam.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawHCam.sqf);
      };
      class onIfMainPressed
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_onIfMainPressed.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_onIfMainPressed.sqf);
      };
      class OnDrawUAV
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawUAV.sqf";
        file= QPATHTOF(functions\EH_handlers\fn_OnDrawUAV.sqf);
      };
      
      //-Original Ones
      class onIfKeyDown
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_onIfKeyDown.sqf";
        file= QPATHTOF(functions\fn_onIfKeyDown.sqf);
      };
      class open
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_open.sqf";
        file= QPATHTOF(functions\fn_open.sqf);
      };
      class drawBftMarkers
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_drawBftMarkers.sqf";
        file= QPATHTOF(functions\fn_drawBftMarkers.sqf);
      };
      class drawUserMarkers
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_drawUserMarkers.sqf";
        file= QPATHTOF(functions\fn_drawUserMarkers.sqf);
      };
      class findUserMarker
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_findUserMarker.sqf";
        file= QPATHTOF(functions\fn_findUserMarker.sqf);
      };
      class updateInterface
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateInterface.sqf";
        file= QPATHTOF(functions\fn_updateInterface.sqf);
      };
      class updateLists
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateLists.sqf";
        file= QPATHTOF(functions\fn_updateLists.sqf);
      };
      class updateUserMarkerList
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateUserMarkerList.sqf";
        file= QPATHTOF(functions\fn_updateUserMarkerList.sqf);
      };
      class createUavCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_createUavCam.sqf";
        file= QPATHTOF(functions\fn_createUavCam.sqf);
      };
      class createHelmetCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_createHelmetCam.sqf";
        file= QPATHTOF(functions\fn_createHelmetCam.sqf);
      };
      class deleteHelmetCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_deleteHelmetCam.sqf";
        file= QPATHTOF(functions\fn_deleteHelmetCam.sqf);
      };
      class userMenuSelect
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_userMenuSelect.sqf";
        file= QPATHTOF(functions\fn_userMenuSelect.sqf);
      };
      class setInterfacePosition
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_setInterfacePosition.sqf";
        file= QPATHTOF(functions\fn_setInterfacePosition.sqf);
      };
      class deleteUAVcam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_deleteUAVcam.sqf";
        file= QPATHTOF(functions\fn_deleteUAVcam.sqf);
      };
      class toggleMapTools
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_toggleMapTools.sqf";
        file= QPATHTOF(functions\fn_toggleMapTools.sqf);
      };
      class onIfClose
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_onIfClose.sqf";
        file= QPATHTOF(functions\fn_onIfClose.sqf);
      };
      class msg_gui_Load
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_msg_gui_Load.sqf";
        file= QPATHTOF(functions\fn_msg_gui_Load.sqf);
      };
    };

    //- #TODO : MOVE THESE TO "cTab" folder
    class BCE_Marker
    {
      // file="MG8\AVFEVFX\functions\cTab\functions\Marker";
      file= QPATHTOF(functions\Marker);
      class Marker_Edittor;
      class NextMarkerID;
      class DrawMarkerDir;
      /* #if __has_include("\z\ace\addons\map_gestures\config.bin")
        class MapPointer;
        class onDrawMapPointer;
      #endif*/
      // #if __has_include("\z\ctab\addons\rangefinder\config.bin")
        class DrawRangefinder_ACE;
      // #endif
      class FinishEDIT_Marker;
      class PlaceMarker;
      class Add_to_MarkerList;
      class DrawArea;
    };
    class BCE_Widget
    {
      // file="MG8\AVFEVFX\functions\cTab\functions\Menu_Widget";
      file= QPATHTOEF(cTab,functions\Menu_Widget);
      class onMarkerSelChanged;
      class onMarkerTextEditted;
      class onMarkerOpacityChanged;
      class Update_MarkerItems;
      class toggleWeather;
      class toggleMarkerWidget;
      class toggleTADMarkerDropper;
      class SwitchMarkerWidget;
    };
  };
};
