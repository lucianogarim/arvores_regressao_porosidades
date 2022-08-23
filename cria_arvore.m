%% Criação da árvore por processo recursivo
% Descrição: Usa o melhor valor e índice para criar branches recursivamente.
% Entrada:
%      Dados: dados para constuir a árvore
%      tolS: Tolerate(Min) decréscimo de variância
%      tolN: Tolerate(Min) número de nós no dataset
%      Atributos usados: Guarda o índice dos atributos que foram usados
% Saída:
%      Árvore: Árvore de decisão baseada em struct

function [ arvore ] = cria_arvore( dados,tolS,tolN,atributos_usados )
    
    nome_atributos = {'AMP','PHASE','RAI','FLAT','SWT'};
    arvore = struct('nome', [], 'filhos', [], 'classe', [], 'atributo', [], 'threshold', []);
    
    [fIndex,val] = escolhe_melhor_branch(dados, tolS, tolN);
    
    % fIndex == 0 significa um nó folha
    if fIndex == 0
        arvore.nome = [];
        arvore.atributo = [];
        arvore.classe = val;
        arvore.threshold = [];
        arvore.filhos = cell(0);
        return
    else
        arvore.nome = nome_atributos{fIndex};
        arvore.atributo = fIndex;
        arvore.classe = [];
        arvore.threshold = val;
        atributos_usados = [atributos_usados, fIndex];
    end
    
    % Use o melhor indice e valor para dividir os dados a direita e esquerda
    [esquerda,direita] = nova_branch(dados, fIndex, val);
    % Use tree.kids para salvar os nós filhos recursivamente
    arvore.filhos = {cria_arvore( esquerda,tolS,tolN,atributos_usados), cria_arvore( direita,tolS,tolN,atributos_usados)};
    
end