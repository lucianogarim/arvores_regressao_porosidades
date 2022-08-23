% Descrição: Função que calcula variancia para cada conjunto de dados
% Entrada:
%      dados: dados para calcular a variância
% Saída:
%      variancia: variância dos dados

function [ variancias ] = varianceErr( dados )
    m = size(dados);
    dataVar = var(dados(:,m(2)));
    variancias = dataVar * (m(1)-1);
end