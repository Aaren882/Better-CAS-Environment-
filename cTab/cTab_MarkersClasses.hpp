class cTab_CfgMarkers
{
    class OPFOR
    {
        Category = "NATO_OPFOR";
        MarkerColor = "colorOPFOR";
        color[]=
		{
			"(profilenamespace getvariable ['Map_OPFOR_R',0])",
			"(profilenamespace getvariable ['Map_OPFOR_G',1])",
			"(profilenamespace getvariable ['Map_OPFOR_B',1])",
			"(profilenamespace getvariable ['Map_OPFOR_A',0.8])"
		};
    };
    class BLUFOR
    {
        Category = "NATO_BLUFOR";
        MarkerColor = "colorBLUFOR";
        color[]=
		{
			"(profilenamespace getvariable ['Map_BLUFOR_R',0])",
			"(profilenamespace getvariable ['Map_BLUFOR_G',1])",
			"(profilenamespace getvariable ['Map_BLUFOR_B',1])",
			"(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"
		};
    };
    class CIV
    {
        Category = "NATO_Civilian";
        MarkerColor = "ColorCIV";
        color[]=
        {
            "(profilenamespace getvariable ['MAP_CIVILIAN_R',0.4])",
            "(profilenamespace getvariable ['Map_CIVILIAN_G',0])",
            "(profilenamespace getvariable ['Map_CIVILIAN_B',0.5])",
            "(profilenamespace getvariable ['Map_CIVILIAN_A',1])"
        };
    };
    class Generic
    {
        Category = "draw";
        Hide_Direction = 1; //- Won't Draw Direction on cTab
    };
};