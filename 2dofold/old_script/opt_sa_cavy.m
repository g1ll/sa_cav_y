%% Otimizando a simulação de cavidade T com  SA 2DOF 
clear all
% Definindo restrições de área 
fi = 0.05;
psi = 0.3;

global fi;
global psi;

%Configuração para 2 graus de liberdade L1dL0 e alfa
     % Limites para a geometria
     % L1dL0      0.001:1.00 
     % alfa         1.00:1.57
     
    lb = [0.001 1.00]; 
    ub = [1 1.57];

    % Valores iniciais
    x0 = [0.001 1.00];

    %Função Objtivo
    fun = @sa_cav_y_2dof; % Para 2 graus de liberdade
    
    %Valores de HdL e t1dt0 fixados
    HdL = 1.0;
   %t1dt0 = 11;
   t1dt0 = 11;  
   

%arquivo
foldername = strcat(date,'_', num2str(hour(now)),'-', num2str(minute(now)),'-', num2str(floor(second(now))),'_','t1dt0_',num2str(t1dt0),'_2dof_results');
mkdir(strcat('resultados/',foldername));
filename = strcat('resultados/',foldername,'/',date,'_',  num2str(hour(now)),'-', num2str(minute(now)),'-', num2str(floor(second(now))),'_','t1dt0_',num2str(t1dt0),'_2dof_data-diary.txt');
diary (filename);
diary on

%Mostra Geometria Inicial
%saida, H, L, t1, t0, L1, L0, alfa1
matrizs =[];
%matrizs(1,:) = cav_yd([HdL x0(1) t1dt0 x0(2)]);
matrizs(1,:) = cav_y([HdL x0(1) t1dt0 x0(2)]); %Não mostra a simulação



% SA para cav_y
input('\nSimulated Annealing...\n Double Vector');

optValue   = 0.0611; % Valor de referência pata t1dt0 = 11
optValue = -inf;
d = 1; %% Número iterações por amostras
s = 500; %% Parâmetro StallIterLimit - Máximo de iterações sem variação no ótimo conhecido
vetor = sa_cav_y(fun,x0,lb,ub,d,s,optValue);
fprintf(' \n\tHdL: %.3f  L1dL0: %.3f  t1dt0: %.3f  Alpha: %.3f\n',HdL,vetor(1),t1dt0,vetor(2));


% Montando geometria otima
%matrizs(2,:) = cav_yd([HdL vetor(1) t1dt0 vetor(2)]);
matrizs(2,:) = cav_y([HdL vetor(1) t1dt0 vetor(2)]);% Nao mostra a simulação

diary off;
filename = strcat('resultados/',foldername,'/',date, num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_data');
save(filename,'matrizs');
csvwrite(filename,matrizs);
dlmwrite(strcat(filename,'.txt'), matrizs, 'delimiter','\t','precision', '%.6f', ...
         'newline', 'unix')
