#include "CBA_Setting.hpp"

//-All Infos from types of task list 
if (hasInterface) exitWith {
  _set_TaskBuilder_Vars = {
  	private ["_config","_offset"];
  	params ["_config",["_offset",0]];

  	_classes = ["CAS_TaskList_9","CAS_TaskList_5"] apply {
  		"true" configClasses (_config >> "controls" >> _x >> "items");
  	};

  	[
  		(_classes apply {
  			_x apply {
  				getArray (_x >> "Expression_idc") apply {_x + _offset}
  			}
  		}),
  		(_classes apply {
  			_x apply {
  				getText (_x >> "textRight")
  			}
  		})
  	]
  };

  //-Set all Task IDCs
  AVT_Task_TaskItems = (configFile >> "RscDisplayAVTerminal") call _set_TaskBuilder_Vars;

  #if __has_include("\cTab\config.bin")
    cTab_Task_TaskItems = [configFile >> "cTab_Tablet_dlg" >> "controls" >> "Task_Builder",17000] call _set_TaskBuilder_Vars;
  #endif
};
