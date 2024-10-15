_result = switch (BCE_Access_list) do
{
  case 0: {false};
  case 1: {true};
  case 2: {(isFormationLeader player) or (player getVariable ["BCE_is_JTAC",false])};
  case 3: {player getVariable ["BCE_is_JTAC",false]};
  case 4: {isFormationLeader player};
};

missionNamespace setVariable ["TGP_View_Terminal_canUseTurret",_result,true];

_result
