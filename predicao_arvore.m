% Descrição: Usa a árvore treinada para fazer predições
% Entrada:
%      arvore_treinada: árvore treinada com o conjunto de treinamento
%      conjunto_teste: conjunto de teste para testar a árvore treinada
% Saída:
%      conjunto_predicao: conjunto com as predições realizadas

function [conjunto_predicao] = predicao_arvore( arvore_treinada, conjunto_teste )

    [m,~] = size(conjunto_teste);

    if isempty(arvore_treinada.filhos)
        conjunto_predicao = arvore_treinada.classe;
        return
    end

    for i = 1:m
        amostra = conjunto_teste(i,:);
        if amostra(arvore_treinada.atributo) > arvore_treinada.threshold
              conjunto_predicao(i) = predicao_arvore( arvore_treinada.filhos{1,1},amostra );
        else
              conjunto_predicao(i) = predicao_arvore( arvore_treinada.filhos{1,2},amostra );
        end 
    end
end