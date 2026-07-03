#include "script_component.hpp"

[] spawn {
waitUntil {!isnil {cTabSettings}};
call BCE_fnc_cTab_postInit;
};


