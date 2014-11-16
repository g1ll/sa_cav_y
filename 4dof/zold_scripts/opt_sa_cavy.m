%% Otimizando a simulação de cavidade T com SA

% Definindo restrições de área 
fi = 0.05;
psi = 0.5;

global fi;
global psi;

%Configuração para 4 graus de liberdade
     % Limites para a geometria
    lb = [0.1 0.1 0.1 0.1]; 
    lu = [2 2 2 2];

    % Valores iniciais
    x0 = [1 0.5 2.0 0.94];

    %Função Objetivo
    fun = @sa_cav_y_4dof; % Para 4 graus de liberdade
      

%Mostra Geometria Inicial
cav_yd(x0);



% SA para cav_y
input('Simulated Annealing...');
d = 1; %% Número iterações por amostras
s = 100; %% Parâmetro StallIterLimit - Máximo de iterações sem variação no ótimo conhecido
vetor = sa_cav_y(fun,x0,lb,lu,1,500);

% Montando geometria otima
cav_yd(vetor);