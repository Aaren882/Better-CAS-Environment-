params ["_group",["_interfaceInit",false],"_isDialog","_settings"];
_settings params ["_page","","",["_PgComponents",createHashMap]];

//- Get Page data
  private _PG_data = _PgComponents getOrDefault [_page,[]];
  _PG_data params ["_line"];

private _title = _group controlsGroupCtrl 5;
private _contacts = _group controlsGroupCtrl 6;
private _list = _group controlsGroupCtrl 10;
private _typing = _group controlsGroupCtrl 11;
private _commitTime = {[_this, 0] select _interfaceInit};
private _playerEncryptionKey = call cTab_fnc_getPlayerEncryptionKey;
private _msgArray = cTab_player getVariable ["cTab_messages_" + _playerEncryptionKey,[]];

//- get Msg sender's name (un-read Msgs only)
  private _Msg_received = (_msgArray select {0 == (_x # 2)}) apply {(_x # 0) select [8]};

//- Remove Message Display icon
  cTabRscLayerMailNotification cutText ["", "PLAIN"];

//- Layout
  _list ctrlSetFade ([1,0] select (_line < 1));
  _list ctrlCommit (0.25 call _commitTime);
  
  _contacts ctrlSetFade ([1,0] select (_line > 0));
  _contacts ctrlSetPositionH ([0,(ctrlPosition _list) # 3] select (_line > 0));
  _contacts ctrlCommit (0.2 call _commitTime);

  _contacts ctrlEnable (_line > 0);
  _list ctrlEnable (_line < 1);
  _typing ctrlEnable (_line < 1);

// if (_interfaceInit) exitWith {};

//- Get Contactor
private _previus = [_displayName, "Contactor"] call cTab_fnc_getSettings;
private _contactor = if (lbSize _contacts > 0) then {
  private _c = _contacts lbData (lbCurSel _contacts);
  [_displayName, [["Contactor",_c]],false] call cTab_fnc_setSettings;
  _c
} else {
  _previus
};

//- Clear all Lists
  {ctrlDelete _x} count allControls _list;
  lbClear _contacts;

//- on Showing Sub-Menu Contactors (exitWith)
  if (_line > 0) exitWith {
    
    //- Get Contactors 
      private _plrList = playableUnits;
      private _validSides = call cTab_fnc_getPlayerSides;
    
    //- Sel Null
      _contacts lbAdd "--";
      _contacts lbSetCurSel 0;

      if (_plrList findIf {true} < 0) then {_plrList pushBack cTab_player};
      {
        if ((side _x in _validSides) && {isPlayer _x} && {[_x,ctab_core_leaderDevices] call cTab_fnc_checkGear}) then {
          private _data = str _x;
          private _name = format [
            "%1:%2 (%3)",
            groupId group _x,
            [_x] call CBA_fnc_getGroupIndex,
            name _x
          ];
          private _index = _contacts lbAdd _name;
          _contacts lbSetData [_index, _data];
          
          if (_previus == _data) then {
            _contacts lbSetCurSel _index;
            _title ctrlSetStructuredText parseText _name;
          };

          //- Highlight un-read msg
          if (_Msg_received find _name > -1) then {
            private _count = str ({_x == _name} count _Msg_received);
            _contacts lbSetPictureRight [_index, "\MG8\AVFEVFX\data\mail.paa"];
            _contacts lbSetTextRight [_index, "+" + _count];
          };
        };
        false
      } count _plrList;
      localNamespace setVariable ['cTab_msg_playerList', _plrList];
  };
  

//- sort out the correct "_contactor" name (STRING)
  {
    if (str _x == _contactor) exitWith {
      _contactor = name _x;
    };
  } count ([cTab_player] + playableUnits);

//- exit on none "_contactor" Selected
  if (_contactor == "") exitWith {
    _title ctrlSetStructuredText parseText format ['"%1"',localize "STR_BCE_None"];
  };
_title ctrlSetStructuredText parseText _contactor;

//- Msg Sort
  private _index = 0;
  private _size_H = 0;
  private _time_AC = 0;
  private _Update_Var = false;
  {
    _x params ["_title","_msgBody","_msgState"];
    private _sep = _title find "-";

    //- Skip on empty
      if (_sep < 0) then {continue};
    
    private _name = (_title select [_title find "("]) trim ["() ", 0];

    //- Skip on Diff Contactor
      if (_contactor != _name) then {continue};
    
    private _time = _title select [0,_sep];
    private _time_s = (_time splitString ":") apply {parseNumber _x};
    private _chatRoom = (_title select [_sep]) trim ["- ", 0];

    //- Sent
    private _size = 1 max (ceil (count _msgBody / 37));

    //- on every 30 mins
      //- on more than (30 mins)
        _time_s = abs((_time_s # 0) * 60 + (_time_s # 1));

      if ((_time_s - _time_AC) >= 30) then {
        private _size = 0.8;
        private _ctrlMsg = [_list,4, ["--",_time,"--"] joinString " "] call BCE_fnc_ATAK_msg_Line_Create;
        private _ctrl_H = (ctrlPosition _ctrlMsg) # 3;

        _ctrlMsg ctrlSetPositionY _size_H;
        _ctrlMsg ctrlSetPositionH (_ctrl_H * _size);
        _ctrlMsg ctrlCommit 0;
        
        _size_H = _size_H + (_ctrl_H * _size);
        _index = _index + 1;
      };
      _time_AC = _time_s;
      
    //- get how many "\t" in the message
      _msgBody = toString Flatten((toArray _msgBody) apply {
        if (10 == _x) then {
          _size = _size + 1;
          toArray "<br/>"
        } else {
          _x
        };
      });

    private _txt = if (_msgState == 2) then {
      _msgBody
    } else {
      //- Receives
      _size = _size + 1;
      _name = format [
        "<t shadow='2' color='#ffffff'>%1 <t valign='middle' size='0.55'>(%2)</t> :</t>",
        _name,
        _time
      ];
      [_name,_msgBody] joinString "<br/>"
    };
    
    //- If Message is un-Read => Read
      if (_msgState == 0) then {
        _Update_Var = true;
        _msgArray set [_forEachIndex, [_title,_msgBody,1]];
      };

    private _ctrlMsg = [_list,_msgState,_txt] call BCE_fnc_ATAK_msg_Line_Create;
    private _ctrl_H = (ctrlPosition _ctrlMsg) # 3;

    _ctrlMsg ctrlSetPositionY _size_H;
    _ctrlMsg ctrlSetPositionH (_ctrl_H * _size);
    _ctrlMsg ctrlCommit 0;
    
    //- sorting Data
      _size_H = _size_H + (_ctrl_H * _size);
      _index = _index + 1;
  } forEach _msgArray;

//- Need to Update Message 
  if (_Update_Var) then {
    cTab_player setVariable ["cTab_messages_" + _playerEncryptionKey, _msgArray];
    ["ctab_messagesUpdated"] call CBA_fnc_localEvent;
  };
_list spawn {
  uiSleep 0.1;
  _this ctrlSetScrollValues [1, -1];
};