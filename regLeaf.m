% Descricao: Função que retorna o valor de um nó folha
% Entrada:
%      Dados: dados para retorna a predição nas folhas
% Saida:
%      leafValue: valor de um nó folha

function [ valor_folha ] = regLeaf( dados )
    m = size(dados);
    valor_folha = mean(dados(:,m(2)));
end