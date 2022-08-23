function arvore_treinada = regressao(dados, poda, kfold, desenhar_arvore, salvar_arvore, validacao_cruzada)

% Coletando os parâmetros de tolerância
tolS = poda.tolS;
tolN = poda.tolN;

% Divisão do conjunto em treino e teste
atributos_usados = [];
[m,n] = size(dados);
divisao = floor(0.8 * m);
treino = dados(1:divisao,:);
teste = dados(divisao+1:m,:);
arvore = cria_arvore(treino, tolS, tolN, atributos_usados);

% Desenha uma árvore de regressão
if strcmp(desenhar_arvore,'Y')
    fprintf('======Desenha a árvore de regressão======\n');
    desenha_arvore(arvore);
end

% Mostra a raiz quadrática média
fprintf('======Calcula a RMSE da árvore de regressão======\n');
arvore_treinada = arvore;
% RMSE no conjunto de treino
predicao_treino = predicao_arvore( arvore_treinada,treino(:,1:(n-1)) );
valor_real = treino(:,n);
rmse_treino = RMSE( valor_real,predicao_treino' );
fprintf('RMSE do conjunto de treino %f\n', rmse_treino);

% RMSE no conjunto de teste
predicao_teste = predicao_arvore( arvore_treinada,teste(:,1:(n-1)) );
valor_real = teste(:,n);
rmse_teste = RMSE( valor_real,predicao_teste' );
fprintf('RMSE do conjunto de teste %f\n', rmse_teste);

% Salvar a árvore de regressão
if strcmp(salvar_arvore,'Y')
    fprintf('======Salva a árvore de regressão em Tree.mat======\n');
    save('Arvore.mat', 'arvore');
end

% Fazer a validação cruzada
if strcmp(validacao_cruzada,'Y')
    
    fprintf('======Validação cruzada 10-fold ======\n');
    [indice_teste, indice_treino] = kCrossV( dados, kfold );
    
    rmse_treino = zeros(1,kfold);
    rmse_teste = zeros(1,kfold);
    
    for i = 1:kfold
        atributos_usados = [];
        treino = dados(indice_treino{1,i},:);
        arvore = cria_arvore(treino, tolS, tolN, atributos_usados);
        arvore_treinada = arvore;
        
        fprintf('==Cross Validation: %d\n', i);
        
        % RMSE no conjunto de treino
        predicao_treino = predicao_arvore( arvore_treinada,treino(:,1:(n-1)) );
        valor_real = treino(:,n);
        rmse_treino(i) = RMSE( valor_real,predicao_treino' );
        fprintf('RMSE do conjunto de treino %f\n', rmse_treino(i));
        
        % RMSE no conjunto de teste
        teste = dados(indice_teste{1,i},:);
        predicao_teste = predicao_arvore( arvore_treinada,teste(:,1:(n-1)) );
        valor_real = teste(:,n);
        rmse_teste(i) = RMSE( valor_real,predicao_teste' );
        fprintf('RMSE do conjunto de teste %f\n', rmse_teste(i));
    end
    
    % Calcula a média do RMSE a partir da validação cruzada
    RMSE_final_treino = mean(rmse_treino);
    RMSE_final_teste = mean(rmse_teste);
    fprintf('======Média do RMSE======\n');
    fprintf('Média do RMSE no conjunto de treinamento %f\n', RMSE_final_treino);
    fprintf('Média do RMSE no conjunto de teste %f\n', RMSE_final_teste);
    
end

end