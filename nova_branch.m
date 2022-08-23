%% Dividi o conjunto de dados
% Descrição: Usa o melhor índice e valor de branch para dividir os dados em esquerda e direita
% Entrada:
%      Dados: Dados para fazer branch
%      feature: O indice da melhor branch
%      valor: O valor(threshold) da melhor branch
% Saída:
%      dados_esquerda: dados_esquerda 
%      dados_direita: dados_direita 

function [ dados_esquerda, dados_direita ] = nova_branch( dados, atributo, valor )
  
    [m,~] = size(dados);
    DataTemp = dados(:,atributo)';% transforma para um modelo de linha
    
    todos_indices = 1:m;
    indice_esquerda = todos_indices(DataTemp > valor);
    indice_direita = todos_indices(DataTemp <= valor);
    
    [~,n_esquerda] = size(indice_esquerda);
    [~,n_direita] = size(indice_direita);
    
    if n_esquerda>0 && n_direita>0
        dados_esquerda = dados(indice_esquerda,:);
        dados_direita = dados(indice_direita,:);
    elseif n_esquerda == 0
            dados_esquerda = [];
            dados_direita = dados;
    elseif n_direita == 0
            dados_direita = [];
            dados_esquerda = dados;
    end
end