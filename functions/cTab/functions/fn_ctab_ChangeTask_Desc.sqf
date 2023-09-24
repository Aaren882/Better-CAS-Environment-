params ["_control","_desc_IDC","_config"];

_display = ctrlParent _control;
_description = _display displayCtrl _desc_IDC;

_config = call compile ("configFile >> " + _config);

_text = getText (_config >> ctrlClassName _control >> "BCE_desc");
_description ctrlSetStructuredText parseText (_text call BCE_fnc_formatLanguage);
