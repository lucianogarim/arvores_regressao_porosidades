%% Escolha o melhor indice e valor de branch para todos os atributos
% Descrição: Usa a variância para escolher o melhor indice
% Entrada:
%      Dados: Dados para construir a árvore
%      tolS: Tolerate(Min) decréscimo de variância
%      tolN: Tolerate(Min) número de nós no dataset
%      Atributos usados: Guarda o índice dos atributos que foram usados
% Saída:
%      Indice: Indice do melhor branch
%      Valor: O valor(threshold) da melhor branch
function [ Indice, Valor ] = escolhe_melhor_branch( dados, tolS, tolN)

    m = size(dados);

    if length(unique(dados(:,m(2)))) == 1% somente um label
        Indice = 0;
        Valor = regLeaf(dados(:,m(2)));
        return;
    end
    
    % Variância dos dados originais
    originalVar = varianceErr(dados);
    melhor_variancia = inf;
    melhor_indice = 0;
    melhor_valor = 0;
    
    todos_atributos = 1:(m(2)-1);
    [~,mf] = size(todos_atributos);
    % Encontrar o melhor branch
    for j = 1:mf % percorre os atributos não utilizados
        valor_unico = unique(dados(:,todos_atributos(j)));
        tamanho_caracter = length(valor_unico);
        
        for i = 1:tamanho_caracter
            valor_temporario = valor_unico(i,:);
            [dados_esquerda,dados_direita] = nova_branch(dados, todos_atributos(j) ,valor_temporario);
            tamanho_esquerda = size(dados_esquerda);
            tamanho_direita = size(dados_direita);
            if tamanho_esquerda(1) < tolN || tamanho_direita(1) < tolN
                continue;
            end
            nova_variancia = varianceErr(dados_esquerda) + varianceErr(dados_direita);
            if nova_variancia < melhor_variancia
                melhor_variancia = nova_variancia;
                melhor_indice = todos_atributos(j);
                melhor_valor = valor_temporario;
            end
        end
    end
    
    if (originalVar - melhor_variancia) < tolS
        Indice = 0;
        Valor = regLeaf(dados(:,m(2)));
        return;
    end

    
    [dados_esquerda, dados_direita] = nova_branch(dados, melhor_indice ,melhor_valor);

    tamanho_esquerda = size(dados_esquerda);
    tamanho_direita = size(dados_direita);
    if tamanho_esquerda(1) < tolN || tamanho_direita(1) < tolN
        Indice = 0;
        Valor = regLeaf(dados(:,m(2)));
        return;
    end
    Indice = melhor_indice;
    Valor = melhor_valor;
end