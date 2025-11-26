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
        file= QPATHTOF(EH_handlers\fn_AVInfoMenu_toggle.sqf);
      };
      class Tablet_btnACT
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_Tablet_btnACT.sqf";
        file= QPATHTOF(EH_handlers\fn_Tablet_btnACT.sqf);
      };
      class showMenu_toggle
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_showMenu_toggle.sqf";
        file= QPATHTOF(EH_handlers\fn_Tablet_btnACT.sqf);
      };
      
      class onMapDoubleClick
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_onMapDoubleClick.sqf";
        file= QPATHTOF(EH_handlers\fn_Tablet_btnACT.sqf);
      };
      class OnDrawbft
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbft.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawbftAndroid
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftAndroid.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawbftAndroidDsp
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftAndroidDsp.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawbftTAD
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftTAD.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawbftTADdialog
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftTADdialog.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawbftVeh
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawbftVeh.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawHCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawHCam.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class onIfMainPressed
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_onIfMainPressed.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      class OnDrawUAV
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\EH_handlers\fn_OnDrawUAV.sqf";
        file= QPATHTOF(EH_handlers\EH_handlers.sqf);
      };
      
      //-Original Ones
      class onIfKeyDown
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_onIfKeyDown.sqf";
        file= QPATHTOF(EH_handlers\fn_onIfKeyDown.sqf);
      };
      class open
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_open.sqf";
        file= QPATHTOF(EH_handlers\fn_open.sqf);
      };
      class drawBftMarkers
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_drawBftMarkers.sqf";
        file= QPATHTOF(EH_handlers\fn_drawBftMarkers.sqf);
      };
      class drawUserMarkers
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_drawUserMarkers.sqf";
        file= QPATHTOF(EH_handlers\fn_drawUserMarkers.sqf);
      };
      class findUserMarker
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_findUserMarker.sqf";
        file= QPATHTOF(EH_handlers\fn_findUserMarker.sqf);
      };
      class updateInterface
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateInterface.sqf";
        file= QPATHTOF(EH_handlers\fn_updateInterface.sqf);
      };
      class updateLists
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateLists.sqf";
        file= QPATHTOF(EH_handlers\fn_updateLists.sqf);
      };
      class updateUserMarkerList
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_updateUserMarkerList.sqf";
        file= QPATHTOF(EH_handlers\fn_updateUserMarkerList.sqf);
      };
      class createUavCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_createUavCam.sqf";
        file= QPATHTOF(EH_handlers\fn_createUavCam.sqf);
      };
      class createHelmetCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_createHelmetCam.sqf";
        file= QPATHTOF(EH_handlers\fn_createHelmetCam.sqf);
      };
      class deleteHelmetCam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_deleteHelmetCam.sqf";
        file= QPATHTOF(EH_handlers\fn_deleteHelmetCam.sqf);
      };
      class userMenuSelect
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_userMenuSelect.sqf";
        file= QPATHTOF(EH_handlers\fn_userMenuSelect.sqf);
      };
      class setInterfacePosition
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_setInterfacePosition.sqf";
        file= QPATHTOF(EH_handlers\fn_setInterfacePosition.sqf);
      };
      class deleteUAVcam
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_deleteUAVcam.sqf";
        file= QPATHTOF(EH_handlers\fn_deleteUAVcam.sqf);
      };
      class toggleMapTools
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_toggleMapTools.sqf";
        file= QPATHTOF(EH_handlers\fn_toggleMapTools.sqf);
      };
      class onIfClose
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_onIfClose.sqf";
        file= QPATHTOF(EH_handlers\fn_onIfClose.sqf);
      };
      class msg_gui_Load
      {
        // file="MG8\AVFEVFX\functions\cTab\Origin\fn_msg_gui_Load.sqf";
        file= QPATHTOF(EH_handlers\fn_msg_gui_Load.sqf);
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
      file= QPATHTOF(functions\Menu_Widget);
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
