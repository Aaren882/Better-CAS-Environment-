/*
  Name: cTab_fnc_updateLists

  Author(s):
    Gundy, Riouken

  Description:
    Update lists of cTab units and vehicles
    Lists updated:
      cTabBFTmembers
      cTabBFTgroups
      cTabBFTvehicles
      cTabUAVlist
      cTabHcamlist

    List format (all except cTabHcamlist):
      Index 0: Unit object
      Index 1: Path to icon A
      Index 2: Path to icon B (either group size or wingmen)
      Index 3: Text to display
      Index 4: String of group index

  Parameters:
    NONE

  Returns:
    BOOLEAN - Always TRUE

  Example:
    call cTab_fnc_updateLists;
*/

private ["_cTabUAVlist","_cTabHcamlist","_validSides","_playerEncryptionKey","_playerVehicle","_playerGroup","_updateInterface"];
disableSerialization;

_validSides = call cTab_fnc_getPlayerSides;
_playerVehicle = vehicle cTab_player;
_playerGroup = group cTab_player;

/*
cTabBFTmembers --- GROUP MEMBERS
*/
cTabBFTmembers = ((units cTab_player) apply {
  [
    nil,
    [_x,_x call cTab_fnc_getInfMarkerIcon,"",name _x,str([_x] call CBA_fnc_getGroupIndex), getPosASLVisual _x, getDirVisual _x]
  ] select ((_x != cTab_player) && {[_x,ctab_core_personneldevices] call cTab_fnc_checkGear});
}) select {!isnil {_x}};

/*
cTabBFTgroups --- GROUPS
Groups on our side that player is not a member of. Use the leader for positioning if he has a Tablet or Android.
Else, search through the group and use the first member we find equipped with a Tablet or Android for positioning.
*/
cTabBFTgroups = (allGroups apply {
  if ((side _x in _validSides) && {_x != _playerGroup}) then {
    _leader = objNull;
    call {
      if ([leader _x,ctab_core_leaderDevices] call cTab_fnc_checkGear) exitWith {_leader = leader _x;};
      {
        if ([_x,ctab_core_leaderDevices] call cTab_fnc_checkGear) exitWith {_leader = _x;};
      } count units _x;
    };
    if !(IsNull _leader) then {
      _groupSize = count units _x;
      _sizeIcon = call {
        if (_groupSize <= 3) exitWith {"\A3\ui_f\data\map\markers\nato\group_0.paa"};
        if (_groupSize <= 9) exitWith {"\A3\ui_f\data\map\markers\nato\group_1.paa"};
        "\A3\ui_f\data\map\markers\nato\group_2.paa"
      };
      [_leader,"\A3\ui_f\data\map\markers\nato\b_inf.paa",_sizeIcon,groupID _x,"", getPosASL _leader]
    } else {
      nil
    };
  } else {
    nil
  };
}) select {!isnil {_x}};

/*
cTabBFTvehicles --- VEHICLES
Vehciles on our side, that are not empty and that player is not sitting in.
*/
cTabBFTvehicles = (vehicles apply {
  if ((side _x in _validSides) && {count (crew _x) > 0} && {_x != _playerVehicle}) then {
    private ["_groupID","_name","_customName","_iconA","_iconB"];
    _groupID = "";
    _name = "";
    _customName = _x getVariable ["cTab_groupId",""];
    call {
      if !(_customName == "") exitWith {
        _name = _customName;
      };
      if (group _x == _playerGroup) then {
        _groupID = str([_x] call CBA_fnc_getGroupIndex)
      };
      _name = groupID group _x;
    };
    //_iconA = "";
    _iconB = "";

    _iconA = switch true do {
      case (_x isKindOf "MRAP_01_base_F"): {
        "\cTab\img\b_mech_inf_wheeled.paa"
      };
      case (_x isKindOf "MRAP_02_base_F"): {
        "\cTab\img\b_mech_inf_wheeled.paa"
      };
      case (_x isKindOf "MRAP_03_base_F"): {
        "\cTab\img\b_mech_inf_wheeled.paa"
      };
      case (_x isKindOf "Wheeled_APC_F"): {
        "\cTab\img\b_mech_inf_wheeled.paa"
      };
      case (_x isKindOf "Truck_F"): {
        [
          "\A3\ui_f\data\map\markers\nato\b_support.paa",
          "\A3\ui_f\data\map\markers\nato\b_motor_inf.paa"
        ] select (getNumber (configOf _x >> "transportSoldier") > 2);
      };
      case (_x isKindOf "Car_F"): {
        "\A3\ui_f\data\map\markers\nato\b_motor_inf.paa"
      };
      case (_x isKindOf "UAV"): {
        "\A3\ui_f\data\map\markers\nato\b_uav.paa"
      };
      case (_x isKindOf "UAV_01_base_F"): {
        "\A3\ui_f\data\map\markers\nato\b_uav.paa"
      };
      case (_x isKindOf "Helicopter"): {
        _iconB = "\cTab\img\icon_air_contact_ca.paa";
        "\A3\ui_f\data\map\markers\nato\b_air.paa"
      };
      case (_x isKindOf "Plane"): {
        _iconB = "\cTab\img\icon_air_contact_ca.paa";

        "\A3\ui_f\data\map\markers\nato\b_plane.paa"
      };
      case (_x isKindOf "Tank"): {
        [
          "\A3\ui_f\data\map\markers\nato\b_armor.paa",
          "\A3\ui_f\data\map\markers\nato\b_mech_inf.paa"
        ] select (getNumber (configOf _x >> "transportSoldier") > 6);
      };
      case (_x isKindOf "MBT_01_arty_base_F"): {
        "\A3\ui_f\data\map\markers\nato\b_art.paa"
      };
      case (_x isKindOf "MBT_01_mlrs_base_F"): {
        "\A3\ui_f\data\map\markers\nato\b_art.paa"
      };
      case (_x isKindOf "MBT_02_arty_base_F"): {
        "\A3\ui_f\data\map\markers\nato\b_art.paa"
      };
      case (_x isKindOf "StaticMortar"): {
        "\A3\ui_f\data\map\markers\nato\b_mortar.paa"
      };
      default {
        ""
      };
    };
    call {
      if (_iconA == "" && {!(_x isKindOf "Static")} && {!(_x isKindOf "StaticWeapon")}) then {_iconA = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";};
      if (_iconA == "") exitWith {};
      [_x,_iconA,_iconB,_name,_groupID, getPosASLVisual _x, getDirVisual _x]
    };
  } else {
    nil
  };
}) select {!isnil {_x}};

/*cTabUAVlist --- UAVs*/
_cTabUAVlist = call BCE_fnc_getCompatibleAVs;

_cTabHcamlist = allUnits select {
  if (side _x in _validSides) then {
    private _helmet = headgear _x;
    (_helmet in cTab_helmetClass_has_HCam) || (getNumber (configfile >> "CfgWeapons" >> _helmet >> "CTAB_Camera") != 0) || {[_x,["ItemcTabHCam"]] call cTab_fnc_checkGear}
  } else {
    false
  };
};

// array to hold interface update commands
_updateInterface = [];

// replace the global list arrays in the end so that we avoid them being empty unnecessarily
if !(cTabUAVlist isEqualTo _cTabUAVlist) then {
  cTabUAVlist = _cTabUAVlist;
  _updateInterface pushBack ["uavListUpdate",true];
};
if !(cTabHcamlist isEqualTo _cTabHcamlist) then {
  cTabHcamlist = _cTabHcamlist;
  _updateInterface pushBack ["hCamListUpdate",true];
};

// call interface updates
if (count _updateInterface > 0) then {
  [_updateInterface] call cTab_fnc_updateInterface;
};

true
