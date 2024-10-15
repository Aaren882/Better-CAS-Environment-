params ["_control",["_lbCurSel",-1]];
private ["_display","_desc","_text","_desc_text","_type"];

_display = ctrlParent _control;
_desc = _display displayCtrl (17000 + 1788);

//-Exit if it's empty
if (_lbCurSel == -1) exitWith {
  _desc ctrlSetStructuredText parseText localize "STR_BCE_No_Info";
};

uiNameSpace setVariable ['BCE_CAS_MainList_selected', _lbCurSel];

(call compile (_control lbData _lbCurSel)) params ["_WeapName","_class","","","","","_mag"];

_text = getText (configFile >> "CfgMagazines" >> _mag >> "descriptionShort");
_desc_text = [_text, ["\n","</br>"] select ("</br>" in _text)] call CBA_fnc_split;

//-Weapon Type
_type = "";
[
  ["CannonCore","STR_BCE_Cannon"],
  ["MGun","STR_BCE_Gun"],
  ["RocketPods","STR_BCE_Rocket"],
  ["","STR_BCE_Missile",getNumber (configFile >> "CfgWeapons" >> _class >> "canLock") > 0],
  ["weapon_LGBLauncherBase","STR_BCE_Bomb"],
  ["Mk82BombLauncher","STR_BCE_Bomb"],
  ["USAF_BombLauncherBase","STR_BCE_Bomb"],
  ["USAF_LGBLauncherBase","STR_BCE_Bomb"]
] apply {
  private ["_id","_condition"];
  _x params ["","_id",["_condition",_class isKindOf [_x # 0, configFile >> "CfgWeapons"]]];
  _type = [_type, localize _id] select _condition;
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

        //-tell what guidance systems it has
        if ("/" in _x) then {
          _x = (_x splitString "/") apply {
            switch _x do {
              case "Laser": {
                localize "STR_BCE_Laser"
              };
              case "IR": {
                localize "STR_BCE_IR"
              };
              case "Radar": {
                localize "STR_BCE_Radar"
              };
              case "Anti-Radiation Homing": {
                localize "STR_BCE_Anti_Rad"
              };
              default {
                _x;
              };
            };
          } joinString "/";
        };
        
        private _str = [format ["<t size='0.7' color='#e3c500'> %1</t>",trim _x], format [" %1",trim _x]] select (_i == 0);
        _i = _i + 1;
        
        _str;
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
      private ["_name","_result"];
      _name = getText (_x >> "componentType");
      _range = _range max (getNumber (_x >> "GroundTarget" >> "maxRange"));

      _result = switch _name do {
        case "LaserSensorComponent": {
          "STR_BCE_Laser"
        };
        case "DataLinkSensorComponent": {
          "STR_BCE_Data_L"
        };
        case "IRSensorComponent": {
          "STR_BCE_IR"
        };
        case "ActiveRadarSensorComponent": {
          "STR_BCE_Active_Rad"
        };
        case "PassiveRadarSensorComponent": {
          ["STR_BCE_Anti_Rad","STR_BCE_Pass_Rad"] select (getNumber (_x >> "allowsMarking") == 0);
        };
        default {
          ""
        };
      };

      localize _result
    };
  } else {
    _range = getNumber (_config >> "missileLockMaxDistance");
    ["laserLock","irLock"] apply {
      private _name = getNumber (_config >> _x);
      if (_name > 0) then {
        switch _x do {
          case "laserLock": {
            "STR_BCE_Laser"
          };
          case "irLock": {
            "STR_BCE_IR"
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
    _desc_text = localize "STR_BCE_No_Info";
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
  _desc_text = localize "STR_BCE_No_Info";
};

_text = format ["<t size='0.9'>%1</t> :<br/> %2",_WeapName,_desc_text];
{ 
  _x params ["_i","_t",["_add",""]]; 
  _text = [_text, _i, (localize _t) + _add] call CBA_fnc_replace; 
} count [ 
  ["Type","STR_BCE_Type"], 
  ["Guidance","STR_BCE_Guidance"], 
  ["Weight","STR_BCE_Weight"], 
  ["Max Range","STR_BCE_Max_Range"], 
  ["Warhead:","STR_BCE_Warhead"], 
  ["Cost","STR_BCE_Cost"], 
  ["Function","STR_BCE_Function"],
  ["Power Requirements","STR_BCE_Power_Requirements"],
  ["CLASSIFIED TOP SECRET","STR_BCE_Classified"],
  ["Classified","STR_BCE_Classified"],
  ["Payload","STR_BCE_Payload"],
  ["None","STR_BCE_None"]
];

_desc ctrlSetStructuredText parseText _text;
