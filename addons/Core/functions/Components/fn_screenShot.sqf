#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: BCE_fnc_screenShot
Description:
		Takes a screenshot using the Arma_ScreenShot_Extension and returns the jpg file path.

Parameters:
		_fileName - File name  <STRING>

Returns:
		_fileDir - Extension returned picture directory.<STRING>
		_file - Picture jpg file <STRING>
		(Empty ARRAY if error occurred)

Examples
		(begin example)
				["myPicture"] call BCE_fnc_screenShot
		(end)

Author:
		Aaren
---------------------------------------------------------------------------- */

params [["_fileName", ""]];
TRACE_1("fn_screenShot",_this);

//- Use default _fileName => systemTime
if (_fileName isEqualTo "") then {
	private _time = systemTime apply {(["","0"] select (_x < 10)) + (str _x)};
	_time resize 6;

	_fileName = _time joinString "_";
};

private _file = _fileName  + ".jpg";
private _fileDir = format [
	"%1%2", 
	[(BCE_PicFilePath_edit trim ["\", 2]) + "\",""] select (BCE_PicFilePath_edit == ""), 
	_file
];

INFO_1("Try to take a screenShot via BCE screenShot extension. _fileName = '%1'",_fileName);

private _return = toString parseSimpleArray ("Arma_ScreenShot_Extension" callExtension str (toArray _fileDir));

//- Exit it if ERROR
if ("error" in toLowerANSI _return) exitwith {
	ERROR_1("ERROR from Taking Pictrue. %1",_fileDir);
	[]
};

[_return, _file]