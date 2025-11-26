/*
	Name: cTab_fnc_onIfclose

	Author(s):
		Gundy

	Description:
		Closes the currently open interface and remove any previously registered eventhandlers.

	Parameters:
		No Parameters

	Returns:
		BOOLEAN - TRUE

	Example:
		[] call cTab_fnc_onIfclose;
*/

private ["_displayName","_mapScale","_ifType","_player","_playerKilledEhId","_vehicle","_vehicleGetOutEhId","_draw3dEhId","_aceUnconciousEhId","_acePlayerInventoryChangedEhId","_backgroundPosition","_backgroundPositionX","_backgroundPositionY","_backgroundConfigPositionX","_backgroundConfigPositionY","_xOffset","_yOffset","_backgroundOffset","_mapTypes","_targetMapName","_targetMapIDC","_targetMapCtrl"];

// remove helmet and UAV cameras
[] call cTab_fnc_deleteHelmetCam;
[] call cTab_fnc_deleteUAVcam;

if !(isNil "cTabIfOpen") then {
	// [_ifType,_displayName,_player,_playerKilledEhId,_vehicle,_vehicleGetOutEhId]
	cTabIfOpen params [
		"_ifType",
		"_displayName",
		"_player",
		"_playerKilledEhId",
		"_vehicle",
		"_vehicleGetOutEhId",
		"_draw3dEhId",
		"_aceUnconciousEhId",
		"_acePlayerInventoryChangedEhId"
	];

	if (!isNil "_playerKilledEhId") then {_player removeEventHandler ["Killed",_playerKilledEhId]};
	if (!isNil "_vehicleGetOutEhId") then {_vehicle removeEventHandler ["GetOut",_vehicleGetOutEhId]};
	if (!isNil "_draw3dEhId") then {removeMissionEventHandler ["Draw3D",_draw3dEhId]};
	if (!isNil "_aceUnconciousEhId") then {["medical_onUnconscious",_aceUnconciousEhId] call ace_common_fnc_removeEventHandler};
	if (!isNil "_acePlayerInventoryChangedEhId") then {["playerInventoryChanged",_acePlayerInventoryChangedEhId] call ace_common_fnc_removeEventHandler};

	// remove notification system related PFH
	if !(isNil "cTabProcessNotificationsPFH") then {
		[cTabProcessNotificationsPFH] call CBA_fnc_removePerFrameHandler;
		cTabProcessNotificationsPFH = nil;
	};

	//- if the on hovered markerColor hasn't turned back
	(localNamespace getVariable ["cTab_Marker_CurHov",[-1]]) params ["_hovSel","_hovCol","_hovmarker"];
	if (_hovSel > -1) then {
		localNamespace setVariable ["cTab_Marker_CurHov",nil];
		_hovmarker setMarkerColorLocal _hovCol;
	};

	// don't call this part if we are closing down before setup has finished
	if (!cTabIfOpenStart) then {
		if ([_displayName] call cTab_fnc_isDialog) then {
			private [];
			// convert mapscale to km
			_mapScale = cTabMapScale * cTabMapScaleFactor / 0.86 * (safezoneH * 0.8);

			// get the current position of the background control
			_backgroundPosition = [_displayName] call cTab_fnc_getBackgroundPosition;
			_backgroundPositionX = _backgroundPosition # 0 # 0;
			_backgroundPositionY = _backgroundPosition # 0 # 1;

			// get the original position of the background control
			_backgroundConfigPositionX = _backgroundPosition # 1 # 0;
			_backgroundConfigPositionY = _backgroundPosition # 1 # 1;

			// calculate x and y as offsets to the original
			_xOffset = _backgroundPositionX - _backgroundConfigPositionX;
			_yOffset = _backgroundPositionY - _backgroundConfigPositionY;

			// figure out if the interface position has changed
			_backgroundOffset = [[],[_xOffset,_yOffset]] select (_xOffset != 0 || _yOffset != 0);

			// update map state 
				_mapTypes = [_displayName,"mapTypes"] call cTab_fnc_getSettings;
				_targetMapName = [_displayName,"mapType"] call cTab_fnc_getSettings;;
				_targetMapIDC = [_mapTypes,_targetMapName] call cTab_fnc_getFromPairs;
				_targetMapCtrl = (uiNamespace getVariable _displayName) displayCtrl _targetMapIDC;

			// Save mapWorldPos and mapScaleDlg of current dialog so it can be restored later
			[_displayName,[["mapWorldPos",[_targetMapCtrl] call cTab_fnc_ctrlMapCenter],["mapScaleDlg",_mapScale],["dlgIfPosition",_backgroundOffset]],false] call cTab_fnc_setSettings;
		};
	};

	uiNamespace setVariable [_displayName, displayNull];
	_player setVariable ["BCE_TACMap_Visiable",false,true];
	cTabIfOpen = nil;
};

cTabCursorOnMap = false;
cTabIfOpenStart = false;

true
