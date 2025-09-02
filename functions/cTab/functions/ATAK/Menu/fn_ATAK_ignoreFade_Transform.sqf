//- call BCE_fnc_ATAK_ignoreFade_Transform;
// Simply ignore Fade Transformation when updating ("showMenu")

private _display = uiNamespace getVariable (cTabIfOpen # 1);
private _background = _display displayCtrl 4660;
_background setVariable ["Anim_fadeIgnore", true];