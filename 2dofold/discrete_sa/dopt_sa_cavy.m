function opt = dopt_sa_cavy(valuet1dt0)    
% Otimizando a simulacao de cavidade Y com  SA 2DOF 
     clc
  
global i;
if isreal(i)
   clc
else
    i=0;
    t = tic();
end
    
    
format short
global logsa;
global tmax_min;

logsa =[];

global fi;
global psi;
global HdL;
global t1dt0;


global vetor;
global salpha_c;


%estrutura de diretorios

global folder;
global folderz;
global folderw;


salpha_c = 0;

% Definindo restricoes de area  e parametros
fi = 0.05;
psi = 0.3;

%Valores de HdL e t1dt0 fixados
HdL = 1.0;
t1dt0 = valuet1dt0;  



%Configuracao para 2 graus de liberdade L1dL0 e alfa

    % Valores iniciais
    x0 = zeros(1,2);

    %Valores iniciais aleatórios
    
    %L1dL0
    pl1dl0 = [0.001 0.002 0.003 0.005 0.007 0.01 0.02 0.03 0.05 0.07 0.1 0.3 0.5 0.7 1];
    r =  (((length(pl1dl0)-1)-floor(rand()*10))^2)^(1/2)+1;
    x0(1) = pl1dl0(r);
       
    %Alphas
    upb = 1.57;
    lob = 1.00;
    step_a = 0.01;
    x0(2) = (((floor(rand()/step_a)*step_a+1)-upb)^2)^(1/2)+lob;
    
   % x0 = [0.005 1.55]
    
    display(x0);
    
    
    %Calcula Geometria Inicial
    %saida, H, L, t1, t0, L1, L0, alfa1
    matrizs =[];
    %matrizs(1,:) = cav_yd([HdL x0(1) t1dt0 x0(2)]);
    try
          matrizs(1,:) = cav_y([HdL x0(1) t1dt0 x0(2)]); %Nao mostra a simulacao
    catch e
        fprintf('\nGeometria inválida para x0 [ %.3f %.3f]\n',x0);
        matrizs(1,:) = inf;
    end
    %Funcao Objtivo
    fun = @sa_cav_y_2dof; % Para 2 graus de liberdade
    


%arquivo
if isempty(folder)
 foldername = strcat(num2str(i),'_sa_d_',date,'_', num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_results');
else
 foldername = strcat(folder,'/',folderz,'/',folderw,'/',num2str(i),'_sa_d_',date,'_', num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_results');
end
mkdir(strcat('resultados/discreto/',foldername));
filename = strcat('resultados/discreto/',foldername,'/',date,'_',  num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_data-diary.txt');
diary (filename);
diary on


% SA para cav_y
display('\nSimulated Annealing...Discreted\n');

%optValue  = 0.06119; % Valor de referencia pata t1dt0 = 11
optValue  = -inf;
d = 1; %% Numero iteracoes por amostras
s = 100; %% Parametro StallIterLimit - Maximo de iteracoes sem variacoes no otimo conhecido
rs = s;
vetor = d_sa_cav_y2(fun,x0,d,s,rs,optValue);
vetor
fprintf('\n\t HdL: %.3f  L1dL0: %.3f  t1dt0: %.3f  Alpha: %.3f\n',HdL,vetor(1),t1dt0,vetor(2));


% Montando geometria otima
%matrizs(2,:) = cav_yd([HdL vetor(1) t1dt0 vetor(2)]);
matrizs(2,:) = cav_y([HdL vetor(1) t1dt0 vetor(2)]);% Nao mostra a simulacao

diary off;
filename = strcat('resultados/discreto/',foldername,'/',date, num2str(hour(now)),'_', num2str(minute(now)),'_', num2str(floor(second(now))),'t1dt0_',num2str(t1dt0),'_2dof_data');
save(filename,'matrizs');
logsa = [logsa; 0 vetor(1) vetor(2) tmax_min ]
csvwrite(strcat(filename,'.csv'),matrizs);
csvwrite(strcat(filename,'_logsa.csv'),logsa);
dlmwrite(strcat(filename,'.txt'), matrizs, 'delimiter','\t','precision', '%.6f','newline', 'unix')
if i == 0
 toc(t)
 diary off
end


opt = vetor;

end
