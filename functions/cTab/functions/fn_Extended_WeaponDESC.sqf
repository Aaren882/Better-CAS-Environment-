params ["_control",["_lbCurSel",-1]];

_display = ctrlParent _control;
_desc = _display displayCtrl (17000 + 1788);

//-Exit if it's empty
if (_lbCurSel == -1) exitWith {
  _desc ctrlSetStructuredText parseText "No Info...";
};

uiNameSpace setVariable ['BCE_CAS_MainList_selected', _lbCurSel];

(call compile (_control lbData _lbCurSel)) params ["_WeapName","_class","","","","","_mag"];

_text = getText (configFile >> "CfgMagazines" >> _mag >> "descriptionShort");
_desc_text = [_text, ["\n","</br>"] select ("</br>" in _text)] call CBA_fnc_split;

//-Weapon Type
_type = "";
[
  ["CannonCore","Cannon"],
  ["MGun","Gun"],
  ["RocketPods","Rocket"],
  ["","Missile",getNumber (configFile >> "CfgWeapons" >> _class >> "weaponLockSystem") > 0],
  ["weapon_LGBLauncherBase","Bomb"],
  ["Mk82BombLauncher","Bomb"],
  ["USAF_BombLauncherBase","Bomb"]
] apply {
  private ["_id","_condition"];
  _x params ["","_id",["_condition",_class isKindOf [_x # 0, configFile >> "CfgWeapons"]]];
  _type = [_type,_id] select _condition;
};

//-Description formattig
if ("USAF" in _class) then {
  private _index = _desc_text find ((_desc_text select {":" in _x}) # 0);
  _desc_text insert [_index, [format ["Type: %1",_type]]];

  //-USAF Weapons
  _desc_text = _desc_text apply {
    if (":" in _x) then {
      private ["_i","_str"];
      _i = 0;
      _str = (_x splitString ":") apply {
        private _str = [format ["<t size='0.7' color='#e3c500'> %1</t>",trim _x], format [" %1",trim _x]] select (_i == 0);
        _i = _i + 1;
        _str
      };
      //-output
      _str joinString ":";
    } else {
      format ["<t color='#FFD9D9D9'>%1</t><br/>",trim _x]
    };
  } joinString "<br/>";
} else {
  //-Others
  private ["_range","_config","_guidance","_warhead"];

  _desc_text = _desc_text joinString "";

  //-Ammo selection
  _range = 0;
  _class = getText (configFile >> "CfgMagazines" >> _mag >> "Ammo");
  _config = configFile >> "CfgAmmo" >> _class;

  //-if the new Targeting Sensor is applied
  _guidance = if (isClass (_config >> "Components" >> "SensorsManagerComponent")) then {
    ("true" configClasses (_config >> "Components" >> "SensorsManagerComponent" >> "Components")) apply {
      private ["_name"];
      _name = getText (_x >> "componentType");
      _range = _range max (getNumber (_x >> "GroundTarget" >> "maxRange"));

      switch _name do {
        case "LaserSensorComponent": {
          "Laser"
        };
        case "DataLinkSensorComponent": {
          "Data-L"
        };
        case "IRSensorComponent": {
          "IR"
        };
        case "ActiveRadarSensorComponent": {
          "Active-Rad"
        };
        case "PassiveRadarSensorComponent": {
          ["Anti-Rad","Pass-Rad"] select (getNumber (_x >> "allowsMarking") == 0);
        };
        default {
          ""
        };
      };
    };
  } else {
    _range = getNumber (_config >> "missileLockMaxDistance");
    ["laserLock","irLock"] apply {
      private _name = getNumber (_config >> _x);
      if (_name > 0) then {
        switch _x do {
          case "laserLock": {
            "Laser"
          };
          case "irLock": {
            "IR"
          };
        };
      } else {
        ""
      };
    };
  };

  _guidance = _guidance select {_x != ""};

  if (getNumber (_config >> "FIR_AWS_GPS_Bomb_Guide") > 0) then {
    _guidance = ["GPS"] + _guidance;
  };

  if (_desc_text == "") then {
    _desc_text = "No Info...";
  };

  _desc_text = format [
    "%1<br/><br/> Type: <t size='0.7' color='#e3c500'>%2</t><br/> Guidance: <t size='0.7' color='#e3c500'>%3</t><br/> Max Range: <t size='0.7' color='#e3c500'>%4</t><br/>",
    _desc_text,
    _type,
    [_guidance joinString "/","N/A"] select (count _guidance == 0),
    [format ["%1 km",_range/1000],"N/A"] select (_range == 0)
  ];
};

if (_desc_text == "") then {
  _desc_text = "None Description.";
};

_text = format ["<t size='0.9'>%1</t> :<br/> %2",_WeapName,_desc_text];
_desc ctrlSetStructuredText parseText _text;
