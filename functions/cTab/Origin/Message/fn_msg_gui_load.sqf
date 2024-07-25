#include "\cTab\shared\cTab_gui_macros.hpp"
private ["_displayName","_display","_playerEncryptionKey","_msgArray","_plrList","_validSides"];

disableSerialization;

_displayName = cTabIfOpen # 1;
_display = uiNamespace getVariable _displayName;

_playerEncryptionKey = call cTab_fnc_getPlayerEncryptionKey;
_msgArray = cTab_player getVariable [format ["cTab_messages_%1",_playerEncryptionKey],[]];

_plrList = playableUnits;

// since playableUnits will return an empty array in single player, add the player if array is empty
if (_plrList findIf {true} < 0) then {_plrList pushBack cTab_player};
_validSides = call cTab_fnc_getPlayerSides;

// turn this on for testing, otherwise not really usefull, since sending to an AI controlled, but switchable unit will send the message to the player himself
/*if (count _plrList < 1) then { _plrList = switchableUnits;};*/

uiNamespace setVariable ['cTab_msg_playerList', _plrList];

switch (true) do {
  //- ATAK Message interface
  case (_displayName find "Andorid" > -1): {
    _group = _display displayCtrl (17000 + 4650);
    _msgControl = _group controlsGroupCtrl 10;
    
  };
  default {
    _msgControl = _display displayCtrl IDC_CTAB_MSG_LIST;
    _plrlistControl = _display displayCtrl IDC_CTAB_MSG_RECIPIENTS;
    lbClear _msgControl;
    lbClear _plrlistControl;

    {
      _x params ["_title","","_msgState"];
      
      private _img = call {
        if (_msgState == 0) exitWith {"\cTab\img\icoUnopenedmail.paa"};
        if (_msgState == 1) exitWith {"\cTab\img\icoOpenmail.paa"};
        if (_msgState == 2) exitWith {"\cTab\img\icon_sentMail_ca.paa"};
      };
      private _index = _msgControl lbAdd _title;
      _msgControl lbSetPicture [_index,_img];
      _msgControl lbSetTooltip [_index,_title];
    } count _msgArray;

    {
      if ((side _x in _validSides) && {isPlayer _x} && {[_x,ctab_core_leaderDevices] call cTab_fnc_checkGear}) then {
        private _index = _plrlistControl lbAdd format ["%1:%2 (%3)",groupId group _x,[_x] call CBA_fnc_getGroupIndex,name _x];
        _plrlistControl lbSetData [_index,str _x];
      };
    } count _plrList;

    lbSort [_plrlistControl, "ASC"];
  };
};

true