class Additional_Fuze
{
  class VT
  {
    displayName = "VT Fuze";
    displayNameShort = "VT";
    description = "Variable Time Fuze";
    Tooltip = "Burst Height (m)";
    condition = "BCE_fnc_FuzeVT";
    class Events
    {
      class OnDetonate
      {
        description = "On Detonate";
        trigger_Condition = "call ";
      };
      class OnImpact
      {
        description = "On Impact";
        trigger_Condition = "call ";
      };
    };
    class Default
    {
      minValue = 5;
      maxValue = 50;
    };
  };
  class Delay
  {
    displayName = "Delay Fuze";
    displayNameShort = "Delay";
    description = "Delay Fuze";
    Tooltip = "Delay Time (Sec)";
    condition = "BCE_fnc_FuzeDelay";
  };
};
