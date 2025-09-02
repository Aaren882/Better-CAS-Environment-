class BCE_HCAM_View: BCE_PhoneCAM_View
{
  name = "BCE_HCAM_View";
  onLoad = "uiNamespace setVariable ['BCE_HCAM_View', _this # 0]; 'BCE_HCAM_View' call BCE_fnc_ATAK_CamInit;";
  class controlsBackground: controlsBackground
  {
    //- Frame
      class frame_left_up_h: frame_left_up_h{};
      class frame_left_up_v: frame_left_up_v{};
      class frame_right_down_h: frame_right_down_h{};
      class frame_right_down_v: frame_right_down_v{};
      class frame_left_down_h: frame_left_down_h{};
      class frame_left_down_v: frame_left_down_v{};
      class frame_right_up_h: frame_right_up_h{};
      class frame_right_up_v: frame_right_up_v{};

      //- Middle
      class middle_left_v: middle_left_v{};
      class middle_left_up_h: middle_left_up_h{};
      class middle_left_down_h: middle_left_down_h{};
      class middle_right_v: middle_right_v{};
      class middle_right_up_h: middle_right_up_h{};
      class middle_right_down_h: middle_right_down_h{};

    //- Hints
      delete Bnt_hint;
      class Exit_hint: RscText
      {
        idc = 15;
        style = 2;
        x = safezoneX;
        y = (safezoneY + safezoneH - (0.09 * safezoneW)) - (0.8 * (0.1));
        w = safezoneW;
        h = 0.1;
        text = "Press “Space” to Exit Camera";
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
      };
  };
  class controls: controls
  {
    delete Resolution_Info;
    //- Bottom Left
    class User_Info: User_Info{};
    class Group_Info: Group_Info{};

    //- Bottom Right
    class Time: Time{};
    class Date: Date{};

    //- GRID info
    class GRID: GRID{};
  };
};