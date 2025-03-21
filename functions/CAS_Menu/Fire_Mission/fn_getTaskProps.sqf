/*
  NAME : BCE_fnc_getTaskProps
  
  Get Mission/Task from "BCE_Mission_Property"
  # LINK .\fn_getTaskProps.sqf

  Params : 
    "_taskID"  :  Index Number (0,1,2...)
    "_cateSel" :  Index Number (0,1,2...)
  
  RETURN : [
    "Variable Name"      : Default is Class name
    "Default Value"      : For Variable Editting
    "Events (HashMap)"   : Functions
    "displayName"        : just displayName
  ]
*/
params [
  ["_taskType", ""]
];

private _props = localNamespace getVariable "BCE_Mission_Property";

// #SECTION - Initial/Refresh Variable on _this => Empty Variables
  if (
    isnil {_props} ||
    isnil {localNamespace getVariable "BCE_Mission_Cate"}
  ) then {
    private _categories = "true" configClasses (configFile >> "BCE_Mission_Property");
    private _event_Func = getArray (configFile >> "BCE_Mission_Property" >> "Event_Functions");
    private _build_Components = createHashMap; //- Hashmap of Building Components
    
    //- Check mission/Task Categories
    private _map = _categories apply {

      private _propStore = (configProperties [_x]) apply {
        
        private _taskCfg = _x;
        private _taskClass = configName _taskCfg;
        private _displayName = [_taskCfg, "displayName", ""] call BIS_fnc_returnConfigEntry;

        //- Variable Props
          private _varName = [_taskCfg >> "Variable", "name", _taskClass] call BIS_fnc_returnConfigEntry;
          private _default = [_taskCfg >> "Variable", "default", "[]"] call BIS_fnc_returnConfigEntry;
          private _Map_Infos = [_taskCfg >> "Variable", "Map_Infos", []] call BIS_fnc_returnConfigEntry;
        
        //- Eventhandlers List
          private _events = _event_Func apply {
            [
              _x,
              [_taskCfg >> "Events", _x, ""] call BIS_fnc_returnConfigEntry
            ]
          };
        
        //- Get Mission Control list => #LINK - Mission_Controls.hpp
          private _IDCs_List = [_taskCfg, "Controls", []] call BIS_fnc_returnConfigEntry;
          private _build_Desc = [_taskCfg, "Descriptions", []] call BIS_fnc_returnConfigEntry;

          private _Components = [];
          {
            /* 
              #NOTE - Separate into Different Variables
              -- Push Elements
                [
                  The Variable Name in "localNamespace", //- "BCE_CAS_9Line_Var_1", "BCE_CAS_9Line_Var_2"
                  "Description"
                ] 
            */
            private _var = format ["#%1_%2",_varName, _forEachIndex];
            localNamespace setVariable [_var, _x];

            _Components pushBack [
              _var,
              _build_Desc # _forEachIndex
            ];
          } forEach _IDCs_List;
        
          //- Set Components
            _build_Components set [_varName, _Components];

        /* 
        #NOTE - Save => localNamespace "#PROP_AIR_9_LINE_ATAK"
        [
          "Variable Name",     : Default is Class name
          "Default Value",     : For Variable Editting
          "Events (HashMap)"   : Functions
          "Map Info (VarName)" : Map Info Display
          "displayName"        : - Less use, I think
        ] */
        private _varStore = format ["#PROP_%1", toUpperANSI _taskClass];
        
        localNamespace setVariable [
          _varStore,
          [
            _varName,
            parseSimpleArray _default,
            createHashMapFromArray _events,
            _Map_Infos,
            _displayName //- Less use, I think
            // _taskClass
          ]
        ];

        _varStore
      };


      /* [
        "Category Name" (Key),  : Category Class name
        "Property Name from Above"   : For Variable Editting
      ] */
      [toUpperANSI (configName _x), _propStore]
    };

      _props = createHashMapFromArray _map;
      localNamespace setVariable ["BCE_Mission_Property", _props]; //- Save Values
    
    //- Save Components
      localNamespace setVariable ["BCE_Mission_Build_Components", _build_Components];
  };

//- Return
localNamespace getVariable [format ["#PROP_%1", _taskType], []];

/* private _categories = localNamespace getVariable ["BCE_Mission_Cate", []];
private _cate = _categories # _cateSel;

//- Return
((_props get _cate) # _curType) */