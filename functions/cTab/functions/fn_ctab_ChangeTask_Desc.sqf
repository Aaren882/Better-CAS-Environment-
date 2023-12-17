params ["_control","_desc_IDC","_config"];
private ["_display","_description","_config","_text"];

_display = ctrlParent _control;
_description = _display displayCtrl _desc_IDC;

_config = call compile ("configFile >> " + _config);

_text = getText (_config >> ctrlClassName _control >> "BCE_desc");
_text = format ["<t size='%1'>%2</t>",[0.68,0.8] select ("chinese" in language),_text];
_description ctrlSetStructuredText parseText _text;
