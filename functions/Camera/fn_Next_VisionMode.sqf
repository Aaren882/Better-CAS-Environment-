private _n_counts = player getVariable ["TGP_View_Optic_Mode", 2];
_n_counts = _n_counts + 1;
_n_counts = [_n_counts, 2] select (_n_counts > 5);
player setVariable ["TGP_View_Optic_Mode", _n_counts];

_n_counts