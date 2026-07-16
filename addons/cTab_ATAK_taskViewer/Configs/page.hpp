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
  class ATAK_TaskViewer: ATAK_Message
  {
    class controls: controls
    {
      class Title: Title
      {
        idc = 5;
        text = "Tasks";
      };

      class Group_Box: Group_Box
      {
        idc = 10;
        h = QUOTE(phoneSizeH - 1.55 * ATAK_POS_H);
      };
    };
  };