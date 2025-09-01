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

**Better CAS Environment (BCE)** is a complete overhaul for Arma 3's Combined Arms combat, enhancing communication and battlefield awareness for pilots, gunners, and JTACs.

<p align="center">
   <a href="https://t.co/SE27C5DP4L">
        <img src="https://i.imgur.com/Hh9LjwP.gif">
    </a>
</p>

---

## Features

BCE provides a suite of powerful, immersive tools to elevate your CAS experience:

- **Advanced Targeting & Visuals:** Experience realistic laser designator effects, a helicopter aiming HUD for aim-assist, and integrated turret spotlights/lasers for ground vehicles.

- **ROVER-like Situational Awareness:** Gain a tactical edge with a system inspired by ROVER, featuring live TGP/Gunner video feeds, a 3D HUD with friendly/map icons, and a thermal infantry tracker.

- **Mission & Crew Coordination:** Create and manage 5-line/9-line CAS tasks, Artillery Call for Fire (CFF), control AI air vehicle turrets, and assign JTAC roles. The AV Terminal provides a tactical map, crew lists (TFAR/ACRE2), and brevity code lookups.

- **cTab Integration:** Enjoy a modernized, ATAK-style interface on cTab devices. Access the task builder, live feeds, turret control, and enhanced map tools directly from your tablet or phone.

## Requirements

- Client-side, but server installation is recommended for full customization.
- **ACE3 is highly recommended** for the best experience.

## Tested cTab Versions

- **TF_Ghost_1_4_1:** [Link](https://steamcommunity.com/sharedfiles/filedetails/?id=871504836)
- **Devastator:** [Link](https://steamcommunity.com/sharedfiles/filedetails/?id=2189592034)
- **Sch. J.GrueArbre:** [Link](https://steamcommunity.com/sharedfiles/filedetails/?id=2262006564)
- **Fredipedia:** [Link](https://steamcommunity.com/sharedfiles/filedetails/?id=2511318948)
---

## 🤓 READING
📃 Documentation : https://aarens-base.gitbook.io/aarens-base-docs

🧠 Learning the Concept : https://aarens-base.gitbook.io/aarens-base-docs/learning/basic-fo-idea

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
