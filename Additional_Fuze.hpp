class Additional_Fuze
{
  class VT
  {
    displayName = "VT Fuze";
    displayNameShort = "VT";
    description = "Variable Time Fuze";
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
      maxRange = 300;
    };
  };
};