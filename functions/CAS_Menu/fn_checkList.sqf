params ["_display","_checklist","_vehicle","_skip",["_loop",true],["_include0",true]];

private _list = vehicles Select {
  (_x isKindOf "Air") && (isEngineOn _x) && (playerSide == side _x)
};

private _Task_Type = _display displayCtrl 2107;
private _TaskList = switch (_Task_Type lbValue (lbCurSel _Task_Type)) do {
  //-5 line
  case 1: {
    _display displayCtrl 2005
  };
  //-9 line
  default {
    _display displayCtrl 2002
  };
};

if (
  !(_vehicle in _list) or
   (isnull _checklist) or
  !(ctrlShown _checklist) or
  !(ctrlEnabled _checklist) or
   ((_display displayCtrl 1700) lbIsSelected 0) or
  (
    (ctrlShown _TaskList) &&
    (_loop)
  ) or (
    !(_vehicle isEqualTo (player getVariable ["TGP_View_Selected_Vehicle",objNull])) &&
    (_skip)
  )
) exitWith {};

//-Clear First
lbClear _checklist;

//-Weapons
private _weapons = (typeOf _vehicle) call bis_fnc_weaponsEntityType;

//-Arrange Magazine and correct Weapon
private _Matched = [_vehicle,_weapons,magazinesAllTurrets _vehicle] call {
  params ["_vehicle","_weapons","_magazines"];
  private _a = [];

  {
    private _mag = _x # 0;
    private _turret = _x # 1;
    private _ammo = _x # 2;

    //-Magazine
    {
      private _wpn = _x;
      private _config = configFile >> "CfgWeapons" >> _wpn;
      private _muzzles = getArray (_config >> "muzzles");

      if (_wpn in (_vehicle weaponsTurret _turret)) then {
        if (count _muzzles > 1) then {
          {
            private _WPN_Mags = getArray (_config >> _x >> "magazines");
            if (
              (_mag in _WPN_Mags) &&
              !(_wpn isKindOf ["Laserdesignator_mounted", configFile >> "CfgWeapons"]) &&
              ((getText (_config >> "simulation")) != "cmlauncher")
            ) then {
              _a pushBackUnique [_wpn,_mag,_turret,_x];
            };
          } forEach _muzzles;
        } else {
          private _WPN_Mags = getArray (_config >> "magazines");
          if (
            (_mag in _WPN_Mags) &&
            !(_wpn isKindOf ["Laserdesignator_mounted", configFile >> "CfgWeapons"]) &&
            ((getText (configFile >> "CfgWeapons" >> _wpn >> "simulation")) != "cmlauncher")
          ) then {
            _a pushBackUnique [_wpn,_mag,_turret,"this"];
          };
        };
      };
    } forEach _weapons;
  } forEach _magazines;

  _a
};

//-Merge weapons and pylons
private _uniquePylons = _Matched apply {
  _x params ["_wpn","_mag","_turret","_muzzle"];

  //-Firing Modes Filter
  private _All_modes = getArray (configFile >> "CfgWeapons" >> _wpn >> "modes");
  private _modes = ((configProperties [configFile >> "CfgWeapons" >> _wpn, "isClass _x && (getNumber (_x >> 'showToPlayer') == 1)", true]) apply {
    configName  _x
  }) select {
    _x in _All_modes
  };
  private _modes = if (count _modes == 0) then {
    _All_modes
  } else {
    _modes
  };

  private _count = ({
    _x params ["_m","_c"];
    (_m == _mag) && (_c > 0)
  } count (magazinesAmmo [_vehicle, true])) max 1;

  private _name = getText (configFile >> "CfgWeapons" >> _wpn >> "DisplayName");
  private _type = getText (configFile >> "CfgMagazines" >> _mag >> "displayNameShort");
  private _formatName = trim format ["%1 %2",_name ,_type];

  //-Correct muzzle
  private _ammo = if (_muzzle == "this") then {
    (weaponState [_vehicle,_turret,_wpn]) # 4
  } else {
    (weaponState [_vehicle,_turret,_wpn,_muzzle]) # 4
  };

  [_formatName, _ammo*_count, _wpn, _mag, _modes, _turret, _muzzle]
};

if !(_include0) then {
  _uniquePylons = _uniquePylons select {(_x # 1) > 0};
};

//-Check List
{
  _x params ["_WeapName","_Count","_class","_mag","_modes","_turret","_muzzle"];

  private _index = _checklist lbAdd (format ["%1",_WeapName]);

  _checklist lbSetTextRight [_index, format ["x%1",_Count]];
  _checklist lbSetData [_index, str ([_WeapName,_class] + [_modes] + [_turret] + [_Count,_muzzle])];

  if (_loop) then {
    _checklist lbSetPicture [_index,"\a3\ui_f\data\Map\Markers\Military\dot_CA.paa"];
  };

  if (_Count > 0) then {
    _checklist lbSetcolor [_index, [1, 1, 1, 1]];
    if (_loop) then {
      _checklist lbSetPictureColor [_index, [1, 1, 1, 1]];
      _checklist lbSetPictureRight [_index,"\a3\ui_f\data\Map\Diary\Icons\diaryAssignTask_ca.paa"];
      _checklist lbSetPictureRightColor [_index, [0, 1, 0, 1]];
    };
  } else {
    _checklist lbSetcolor [_index, [1, 1, 1, 0.3]];
    if (_loop) then {
      _checklist lbSetPictureColor [_index, [1, 1, 1, 0.3]];
      _checklist lbSetPictureRight [_index,"\a3\ui_f\data\Map\Diary\Icons\diaryUnassignTask_ca.paa"];
      _checklist lbSetPictureRightColor [_index, [1, 0, 0, 1]];
    };
  };

} foreach _uniquePylons;

_checklist lbSetCurSel (uiNameSpace getVariable ["BCE_CAS_MainList_selected", 0]);

if (_loop) then {
  _this set [3,true];
  [BCE_fnc_checkList, _this, 1] call CBA_fnc_WaitAndExecute;
};
