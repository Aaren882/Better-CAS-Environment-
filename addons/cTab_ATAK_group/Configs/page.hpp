class ATAK_AppMenu_Base;

//- Message Interface
	class ATAK_Message: ATAK_AppMenu_Base
	{
		class controls
		{
			class Title;
			class Group_Box;
		};
	};
//- Group Manage
  class ATAK_Group: ATAK_Message
  {
    class controls: controls
    {
      class Title: Title
      {
        idc = 5;
        text = "Group";
        w = QUOTE(PhoneBFTContainerW(2.4));
      };
      class New_Grp: Title
      {
        idc = 6;
        style = "0x02 + 0x0C + 0x0100";
        shadow = 1;
        text = QSTRUCTURE_IMAGE(Core,data\add.paa);

        x = QUOTE(PhoneBFTContainerW(2.4));
        w = QUOTE(PhoneBFTContainerW(0.6));
        
        onButtonClick = "";
      };

      class Group_Box: Group_Box
      {
        idc = 10;
        h = QUOTE(phoneSizeH - 1.55 * ATAK_POS_H);
      };
    };
  };
