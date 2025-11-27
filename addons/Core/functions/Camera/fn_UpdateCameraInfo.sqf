if !((hasPilotCamera cameraOn) || (Local cameraOn)) exitWith {};

if (
		(time > BCE_TGP_LastUpdate) &&
		(
			(isLaserOn cameraOn) ||
			!(isMultiplayer) ||
			(allUnits findIf {
				(
					((_x getVariable ["TGP_View_EHs",-1]) != -1) ||
					((_x getVariable ["cTab_TGP_View_EH",-1]) != -1) ||
					(_x getVariable ["BCE_TACMap_Visiable",false])
				) &&
				(((_x getVariable ["TGP_View_Selected_Optic",[[],objNull]]) # 1) isEqualTo cameraOn)
			}) > 0
		)
	) then {
	BCE_TGP_LastUpdate = time + 0.035;
	private _info = getPilotCameraTarget cameraOn;
	cameraOn setVariable ["BCE_Camera_Info_Air",[str [_info # 0, _info # 1], str getPilotCameraDirection cameraOn,_info # 2],true];
};
