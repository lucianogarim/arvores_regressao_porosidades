% Descrição: Calcula o RMSE entre o conjunto de predição e os valores reais
% Entrada:
%      predição: predição obtida pelo treinamento
%      valor real: dados reais
% Saída:
%      rmse: O valor do RMSE

function [rmse] = RMSE( valor_real,predicao )
    
    [m,~] = size(valor_real);
    rmse = sqrt(sum((valor_real - predicao).^2 / m));
    %R = corrcoef(valor_real,predicao);
    %R.*R
end