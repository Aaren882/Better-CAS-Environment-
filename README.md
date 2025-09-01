# Better CAS Environment

<p align="center">
   <a href="https://github.com/Aaren882/Better-CAS-Environment-/releases/latest">
      <img src="https://img.shields.io/github/v/release/Aaren882/Better-CAS-Environment-?label=Latest&color=blue&logo=github" >
   </a>
   <img src="https://img.shields.io/steam/size/2853828143?label=File%20Size&logo=steam" >
   <img src="https://img.shields.io/steam/views/2853828143?label=Steam%20Views&logo=steam" >
   <img src="https://img.shields.io/steam/subscriptions/2853828143?label=Steam%20Downloads&logo=steam" >
</p>

<p align="center">
   <a href="https://discord.gg/QYCuYpDBgf">
        <img src="https://img.shields.io/badge/Discord_Join-Here-blue?style=for-the-badge&logo=discord">
    </a>
</p>

## What Does It Do?

This mod is to provide better communication for Close Air Support or Air Support missions

Laser Designator Effect

1. ### Visual Effect for Laser Designators

    should compat with most of the aircraft mods

2. ### Ground unit Laser (men, Ground Vehicles [Vanilla])

   * Helicopter Aiming HUD
   * For Aim Assist (Compat Vanilla ,Enhanced Littlebird ,and RHSUSAF UH-60)
   * TGP and Gunner Feeds(Equip AV Terminal)

3. ### Basically ROVER System[en.wikipedia.org]

   * 3D Friendly Tracker
   * 3D Compass
   * 3D Map Icon
   * Human tracker (in *Thermal Mode* , Thermal Improve compatible) *(FPS Impact)*
   * 3D LandMark Icon
   * Touch Marker [for TGP Viewers and Current Turret] [Default Key: M {Toggle Mouse Cursor}]

4. ### SpotLight and Laser for Turret Gunners (ACE Self Action)

   Should compat with the Most of the vehicles from the other mods

5. ### 3D Compass For TGP and Gunner Camera

   provide directional awareness

6. ### Turret Control System

   to AI crew only
   Unit Trait System (JTAC Role)
   [via ACE action , Vanilla Command Tab]
   TAC View (AV Terminal)
   * Player POS
   * Dark mode
   * Show All connectable Air vehicles
   * Waypoints
   * Targeting POS from Current Connected Vehicle
   * Add "Live Camera Feed" FOV  
etc

7. ### Task Builder (5 line ,9 line) [AV Terminal]

   * Demo Video
   * Avaliable for Player or AI (Plane and V-44X GunShip USAF AC-130U only if it’s AI)
   * Task Receiver (for Player aircrafts)
   * Brevity Codes for lookup
   * Crew List
   * Crew Info details
   * Radio Rack List (compat with TFAR , ACRE2 Require ACE)

8. ### cTab Compatibility

   * More modernized UI Looking
   * More convenient controls for cTab
   * Add Task Builder Compat
   * Add "Map DarkMode" + "Enhanced Map" + "Enhanced GPS" Compat for cTab
   * Add Air Vehicle "Live Feeds" + "Turret Control"
   * Add "Check List" + "Weapon Descriptions"
   * Add Current Task info on Current connected vehicle
   * Make Android Phone able to dispaly current UIs Other than BFT
   * Change "F5" Hot key into "open Task Builder"
   * Add more Functionalities for Tablet BFT
   * Add Turret FOV on TAD

* ### cTab Tested mods

  　- TF_Ghost_1_4_1: <https://steamcommunity.com/sharedfiles/filedetails/?id=871504836>  
  　- Devastator: <https://steamcommunity.com/sharedfiles/filedetails/?id=2189592034>  
  　- Sch. J.GrueArbre: <https://steamcommunity.com/sharedfiles/filedetails/?id=2262006564>  
  　- Fredipedia: <https://steamcommunity.com/sharedfiles/filedetails/?id=2511318948>  

### *Client Side (Load on Server for more Customization)

### *Recommend ACE

[![alt 文字](https://i.imgur.com/Hh9LjwP.gif "")](https://t.co/SE27C5DP4L)

---

## For Modders

```c++
class CfgVehicles
{
  class Your_Aircraft
  {
    LaserDesignator_Offset[] = {0,0,0}; //{X,Y,Z} Pilot camera (LaserDesignator)

    class Turrets
    {
      class Turret_01
      {
          Detached_Optic = 0; // {0,1} Use calculation instead of AttachTo Bone (TGP View)
          LaserDesignator_Offset[] = {0,0,0}; //{X,Y,Z} Turret

          //-Turret Gunner Actions
          Laser_Offset[] = {0,0,0};  //-{X,Y,Z}
          SpotLight_Offset[] = {0,0,0};  //-{X,Y,Z}
          LightFromLOD=0;//-{0,1}attach light to "memoryPointGunnerOptics" instead of default "{0,0.5,-0.35}" 
          Laser_Memory = "Memory_point";//-or the offset would be "{0,0,0}" (Ground Vehicle Default is "{-0.2,0,-0.1}")
          Light_Memory = "Memory_point";//-or would be the offset of [memoryPointGunnerOptics]
      };
    };
  };
};
```
