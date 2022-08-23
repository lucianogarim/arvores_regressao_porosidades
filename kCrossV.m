% Descrição: Validação cruzada k-Fold
% Entrada:
%      dados: dados para realizar validação cruzada
%      foldNum: k-Fold
% Saída:
%      indice_teste: indices conjunto testes
%      indice_treino: indices conjunto treino

function [indice_teste, indice_treino] = kCrossV( dados,foldNum )

    [m,~] = size(dados);
    dataNum = floor(m/foldNum);
    idx = randperm(m);
    
    for i = 1:foldNum

        startIndex = dataNum * (i-1) + 1;
        endIndex = dataNum * i;
        indice_teste{i} = idx(startIndex:endIndex);
        indice_treino{i} = setdiff(idx,indice_teste{i},'stable');
    end
    
end