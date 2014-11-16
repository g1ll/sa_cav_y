% Otimizando a simulação de cavidade T com  SA 2DOF 



% Definindo restrições de área 
global fi;
global psi;

global salpha_c;
salpha_c = 0;
fi = 0.05;
psi = 0.3;


%Configuração para 2 graus de liberdade L1dL0 e alfa
 

    % Valores iniciais
    x0 = [0.001 1.00];
    
    %Valores iniciais aleatórios
    
    %L1dL0
    pl1dl0 = [0.001 0.005 0.007 0.01 0.05 0.3 0.5 1];
    r =  (((length(pl1dl0)-1)-floor(rand()*10))^2)^(1/2)+1;
    x0(1) = pl1dl0(r);
       
    %Alpha
    upb = 1.57;
    lob = 1.00;
    step_a = 0.01;
    x0(2) = (((floor(rand()/step_a)*step_a+1)-upb)^2)^(1/2)+lob;
    
    

    %Função Objtivo
    fun = @sa_cav_y_2dof; % Para 2 graus de liberdade
    
    %Valores de HdL e t1dt0 fixados
    HdL = 1.0;
   %t1dt0 = 11;
   t1dt0 = 11;  
   

%arquivo
foldername = strcat('sa_d_',date,'_', num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_results');
mkdir(strcat('resultados/discreto/',foldername));
filename = strcat('resultados/discreto/',foldername,'/',date,'_',  num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_data-diary.txt');
diary (filename);
diary on

%Mostra Geometria Inicial
%saida, H, L, t1, t0, L1, L0, alfa1
matrizs =[];
%matrizs(1,:) = cav_yd([HdL x0(1) t1dt0 x0(2)]);
matrizs(1,:) = cav_y([HdL x0(1) t1dt0 x0(2)]); %Não mostra a simulação



% SA para cav_y
display('Simulated Annealing...Discreted');

%optValue  = 0.06119; % Valor de referência pata t1dt0 = 11
optValue  = -inf;
d = 1; %% Número iterações por amostras
s = 150; %% Parâmetro StallIterLimit - Máximo de iterações sem variação no ótimo conhecido
vetor = d_sa_cav_y(fun,x0,d,s,optValue);
vetor
fprintf(' \n\tHdL: %.3f  L1dL0: %.3f  t1dt0: %.3f  Alpha: %.3f\n',HdL,vetor(1),t1dt0,vetor(2));


% Montando geometria otima
%matrizs(2,:) = cav_yd([HdL vetor(1) t1dt0 vetor(2)]);
matrizs(2,:) = cav_y([HdL vetor(1) t1dt0 vetor(2)]);% Nao mostra a simulação

diary off;
filename = strcat('resultados/discreto/',foldername,'/',date, num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_data');
save(filename,'matrizs');
csvwrite(filename,matrizs);
dlmwrite(strcat(filename,'.txt'), matrizs, 'delimiter','\t','precision', '%.6f', ...
         'newline', 'unix')
