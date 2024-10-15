#include "\MG8\AVFEVFX\HEMTT_FLAGs.hpp"

private _time = systemTime apply {(["","0"] select (_x < 10)) + (str _x)};
_time resize 6;

private _display = uiNamespace getVariable ["BCE_PhoneCAM_View",displayNull];

//- Print Grid
_grid = _display displayCtrl 55;
_grid ctrlSetBackgroundColor [0,0,0,0.3];
_grid ctrlSetText format["GRID :%1", [getPosVisual player,10] call BCE_fnc_POS2Grid];

_grid = _display displayCtrl 55;

private _ctrls = (allControls _display) apply {
  if (50 > ctrlIDC _x) then {
    _x ctrlshow false;
    _x
  } else {
    controlNull
  };
};

[{
  params ["_file","_ctrls", "_grid"];
  _return = toString parseSimpleArray ("Arma_ScreenShot_Extension" callExtension str (toArray _file));
  
  {
    if (isNull _x) then {continue};
    _x ctrlshow true;
  } forEach _ctrls;

  _grid ctrlSetBackgroundColor [0,0,0,0];
  _grid ctrlSetText "";

  //- Exit it if ERROR
  if ("error" in toLowerANSI _return) exitwith {
    systemChat str format ["ERROR from Taking Pictrue. %1", _return];
  };

  playSound3D ["\MG8\AVFEVFX\sound\CameraShutter.wss", player, false, getPosASL player, 3, 1, 15];

  #if __has_include("\MG8\DiscordMessageAPI\config.bin")
    if !(BCE_SSE_Webhook_Send_fn) exitWith {};
    [
      {
        params ["_file","_unit","_map"];
        ([_unit] call BCE_fnc_getUnitParams) params ["","_unitName","_title"];
        //- Send Discord Message
        [
          BCE_SSE_Webhook_list,
          "",
          "",
          "",
          false,
          _file,
          [
            //- Embeds
            [
              format [localize "STR_BCE_SSE_OPERATION_NAME", missionName],
              "",
              "",
              true
            ]
          ],
          [ //- Fields for each Embed
            [
              [localize "STR_BCE_SSE_SERVER_NAME", format["`%1`",serverName], false],
              [localize "STR_BCE_SSE_FROM", format ["```%1%2```", profileName, ["[" + _unitName + "]", ""] select (_unitName == "")],true],
              ["", "",true],
              [format["“%1” :",_map], format ["```%1```", _unit call BIS_fnc_locationDescription],true],
              ["","",false],
              [localize "STR_BCE_SSE_UNIT", format ["```%1```", [_title, localize "str_special_none"] select (_title == "")],true]
            ]
          ]
        ] call DiscordAPI_fnc_sendMessage;
      },
      [
        _return,
        player,
        worldName
      ],1
    ] call CBA_fnc_waitAndExecute;
  #endif
},
  [
    format [
      "%1%2.%3", 
      [(BCE_PicFilePath_edit trim ["\", 2]) + "\",""] select (BCE_PicFilePath_edit == ""), 
      _time joinString "_", 
      ["jpg","png"] # BCE_PicFile_list
    ], 
    _ctrls, 
    _grid
  ], 0.2
] call CBA_fnc_waitAndExecute;