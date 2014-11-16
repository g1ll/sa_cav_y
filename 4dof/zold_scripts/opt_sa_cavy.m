%% Otimizando a simula��o de cavidade T com SA

% Definindo restri��es de �rea 
fi = 0.05;
psi = 0.5;

global fi;
global psi;

%Configura��o para 4 graus de liberdade
     % Limites para a geometria
    lb = [0.1 0.1 0.1 0.1]; 
    lu = [2 2 2 2];

    % Valores iniciais
    x0 = [1 0.5 2.0 0.94];

    %Fun��o Objetivo
    fun = @sa_cav_y_4dof; % Para 4 graus de liberdade
      

%Mostra Geometria Inicial
cav_yd(x0);



% SA para cav_y
input('Simulated Annealing...');
d = 1; %% N�mero itera��es por amostras
s = 100; %% Par�metro StallIterLimit - M�ximo de itera��es sem varia��o no �timo conhecido
vetor = sa_cav_y(fun,x0,lb,lu,1,500);

% Montando geometria otima
cav_yd(vetor);