class AirplaneHUD
{
	topLeft="HUD_top_left";
	topRight="HUD_top_right";
	bottomLeft="HUD_bottom_left";
	borderLeft=0;
	borderRight=0;
	borderTop=0;
	borderBottom=0;
	color[]={1,1,1,1};
	helmetMountedDisplay=1;
	helmetPosition[]={-0.037500001,0.0375,0.1};
	helmetRight[]={0.075,0,0};
	helmetDown[]={0,-0.075,0};
	font="LucidaConsoleB";
	turret[]={-2};
	class Bones
	{
		class WeaponAim
		{
			type="vector";
			source="weapon";
			pos0[]={0.5,0.5};
			pos10[]={0.73400003,0.73000002};
		};
		class ImpactPoint
		{
			type="vector";
			source="ImpactPointToView";
			pos0[]={0.5,0.5};
			pos10[]={0.73400003,0.73000002};
		};
		class WeaponAimRelative: WeaponAim
		{
			source="weapontoview";
		};
	};
	class Draw
	{
		alpha="user10";
		color[]=
		{
			"user7",
			"user8",
			"user9"
		};
		condition="on*user11";
		class Rockets
		{
			condition="rocket";
			class Rocket
			{
				type="line";
				width=4.5;
				points[]=
				{
					
					{
						"ImpactPoint",
						{0.0099999998,-0.035},
						1
					},
					
					{
						"ImpactPoint",
						{-0.0099999998,-0.035},
						1
					},
					{},
					
					{
						"ImpactPoint",
						{0.0099999998,0.035},
						1
					},
					
					{
						"ImpactPoint",
						{-0.0099999998,0.035},
						1
					},
					{},
					
					{
						"ImpactPoint",
						{0,-0.035},
						1
					},
					
					{
						"ImpactPoint",
						{0,0.035},
						1
					},
					{}
				};
			};
		};
		class MGun
		{
			condition="mgun";
			alpha="user3";
			color[]=
			{
				"user0",
				"user1",
				"user2"
			};
			class Dot
			{
				type = "polygon";
				texture = "a3\data_f\light_flare_ca.paa";
				points[]=
				{
					
					{
						
						{
							"WeaponAimRelative",
							{0.01,0.01},
							1
						},
						
						{
							"WeaponAimRelative",
							{-0.01,0.01},
							1
						},
						
						{
							"WeaponAimRelative",
							{-0.01,-0.01},
							1
						},
						
						{
							"WeaponAimRelative",
							{0.01,-0.01},
							1
						}
					}
				};
			};
		};
	};
};