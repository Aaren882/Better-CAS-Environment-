if (!hasInterface) exitWith {};

ctab_rangefinder_lastPosition = [];
ctab_rangefinder_last = 0;

ctab_rangefinder_lastPosition = [];
ctab_rangefinder_binoculars = ["Rangefinder", "Laserdesignator", "Laserdesignator_02", "Laserdesignator_02_ghex_F", "Laserdesignator_03", "Laserdesignator_03_ghex_F"];

//- #NOTE - these are used for "cTab_1erGTD" 
  addUserActionEventHandler ["gunElevAuto", "Activate", {
    call ctab_rangefinder_fnc_handleRangeFinderKey;
  }];

  ["ace_vector_rangefinderData", { 
    params ["_distance", "_azimuth", "_inclination"];
    private _position = (eyePos player) vectorAdd ([_distance, _azimuth, _inclination] call CBA_fnc_polar2vect);
    ["ctab_rangefinder_data", [_position, _distance]] call CBA_fnc_localEvent;
  }] call CBA_fnc_addEventHandler;

  //- "ctab_rangefinder_data" (RangeFinder Data)
    ["ctab_rangefinder_data", {
      params ["_position", "_distance"];

      format ['[%1] (%2) %3: data %4', 'CTAB', 'rangefinder', 'INFO', _position] call CBA_fnc_log;
      
      //- Can NOT be the same position
      if (ctab_rangefinder_lastPosition isNotEqualTo _position) then {
        
        //- Reset Variables
          ctab_rangefinder_lastPosition = _position;
          ctab_rangefinder_last = 0;

        ['cTab_Tablet_dlg',[['mode','BFT']]] call cTab_fnc_setSettings;
        ['cTab_Android_dlg',[['mode','BFT']]] call cTab_fnc_setSettings;
      };
    }] call CBA_fnc_addEventHandler;

  //- "ctab_interface_open" (RangeFinder)
    ["ctab_interface_open", { 
      params ["_display", "_displayName", "_player", "_vehicle"];

      if (
        ctab_rangefinder_lastPosition findIf {true} > -1 && 
        ctab_rangefinder_last == 0 && 
        {[_displayName] call cTab_fnc_isDialog}
      ) then {

        private _targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;
        private _mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
        private _targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
        private _targetMapCtrl = _display displayCtrl _targetMapIDC;

        //- Focus to the POS
          _targetMapCtrl ctrlMapAnimAdd [0, ctrlMapScale _targetMapCtrl, ctab_rangefinder_lastPosition];
          ctrlMapAnimCommit _targetMapCtrl;
        
        //- Set Last time
          ctab_rangefinder_last = time + 5;
      };
    }] call CBA_fnc_addEventHandler;
