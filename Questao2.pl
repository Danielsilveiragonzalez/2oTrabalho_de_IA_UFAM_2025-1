% 🌐 Modelo Probabilístico: Diagnóstico do Sistema de Tensão

% Variáveis:
% str               = cond_rua_neve (rua coberta de neve)
% flw               = volante_gasto (volante desgastado)
% r                 = dinamo_desliza (dínamo desliza)
% v                 = tensao_presente (tensão é detectada)

% Probabilidades marginais

0.10::volante_gasto.               % 10% de chance de o volante estar desgastado
volante_ok :- \+volante_gasto.     % 90% de chance (complementar)

cond_rua_neve.                     % A rua está coberta de neve (fato lógico fixo)
evidence(cond_rua_neve, true).     % Informamos ao modelo que a evidência é verdadeira

% Probabilidades auxiliares (condicionais)

0.75::prob_r_quando_gasto.         % Se volante está gasto e rua com neve → 75% chance do dínamo deslizar
0.45::prob_r_quando_ok.            % Se volante está bom e rua com neve → 45% chance do dínamo deslizar

0.85::prob_v_se_dinamo.            % Se dínamo desliza → 85% de chance de tensão
0.15::prob_v_se_nao_dinamo.        % Se não desliza → 15% de chance de tensão

% Regras de dependência causal

dinamo_desliza :- cond_rua_neve, volante_gasto, prob_r_quando_gasto.
dinamo_desliza :- cond_rua_neve, volante_ok,    prob_r_quando_ok.

tensao_presente :- dinamo_desliza, prob_v_se_dinamo.
tensao_presente :- \+dinamo_desliza, prob_v_se_nao_dinamo.

% Consulta ao modelo

query(tensao_presente).
