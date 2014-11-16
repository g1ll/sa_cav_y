function opt = dopt_sa_cavy_4(rpsi,rfi,modeltemp,rean,stall)    
% Otimizando a simulacao de cavidade Y com  SA 2DOF 
     clc
  global p_memory;
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
global mintmax;
global dir;

logsa =[];

global fi;
global psi;


global vetor;


% Definindo restricoes de area  e parametros
fi = rfi;
psi = rpsi;


%Configuracao para 2 graus de liberdade L1dL0 e alfa

    % Valores iniciais
    x0 = zeros(1,4);

    %Valores iniciais aleatórios
    
    %HL
    vHL = [0.5 1 2 5 7 10 15 20];
    s_space = length(vHL);
    r =  (((s_space-1)-floor(rand()*s_space))^2)^(1/2)+1;
    x0(1) = vHL(r);
    
    %t1dt0
    vt1dt0 = [2 4 5 9 10 11 12 13 15 17 18 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220];
    s_space = length(vt1dt0);
    r =  (((s_space-1)-floor(rand()*s_space))^2)^(1/2)+1;
    x0(2) = vt1dt0(r);    
    
    %L1dL0
    pl1dl0 = [0.001 0.002 0.003 0.005 0.007 0.01 0.02 0.03 0.05 0.07 0.1 0.3 0.5 0.7 1];
    r =  (((length(pl1dl0)-1)-floor(rand()*length(pl1dl0)))^2)^(1/2)+1;
    x0(3) = pl1dl0(r);
       
    %Alphas
    upb = 1.57;
    lob = 1.00;
    step_a = 0.01;
    x0(4) = (((floor(rand()/step_a)*step_a+1)-upb)^2)^(1/2)+lob;
    
   % x0 = [1 11 0.3 1.56]
   
foldername = strcat(num2str(i),'_sa_d_',date,'_', num2str(hour(now)),'-', num2str(minute(now)),'-', num2str(floor(second(now))),'_psi_',num2str(psi),'_fi_',num2str(fi),'_4dof_results');
dir = strcat('resultados/',date,'/',func2str(modeltemp),'_psi-',num2str(psi),'/',foldername);
mkdir(dir);
filename = strcat(dir,'/',date,'_',num2str(hour(now)),'-', num2str(minute(now)),'-',num2str(floor(second(now))),'_psi_',num2str(psi),'_fi_',num2str(fi),'_4dof_data-diary.txt');

diary (filename);
diary on

system('hostname');
datestr(now,'dd/mm/yyyy-HH:MM:ss')

% SA para cav_y
display('\nSimulated Annealing...Discreted\n');
fprintf('\n\tRestricoes: PSI = %.3f | FI = %.3f\n',psi,fi);
fprintf('\n\tPonto Inicial:  HdL = %.3f  t1dt0 = %.3f  L1dL0 = %.3f  Alpha = %.3f\n',x0);
    
    
    
    %Calcula Geometria Inicial
    %saida, H, L, t1, t0, L1, L0, alfa1
    matrizs =[];
    %matrizs(1,:) = cav_yd([HdL x0(1) t1dt0 x0(2)]);
    try
          matrizs(1,:) = cav_y([x0(1) x0(3) x0(2) x0(4)]); %Nao mostra a simulacao
    catch e
        fprintf('\n\tGeometria invalida para x0 [%.3f %.3f %.3f %.3f]\n',x0);
        matrizs(1,:) = inf;
    end
    %Funcao Objtivo
    fun = @sa_cav_y_4dof; % Para 4 graus de liberdade
    

if mintmax > 0
    optValue  = mintmax; % Valor de referencia pata t1dt0 = 11
else
    optValue  = -inf;
end
fprintf('\n\t Fitness Limit : %.3f\n',optValue);
d = 1; %% Numero iteracoes por amostras
s = stall; %% Parametro StallIterLimit - Maximo de iteracoes sem variacoes no otimo conhecido
rs = rean;%25;%50;%100;
vetor = d_sa_cav_y4(fun,x0,d,s,rs,optValue,modeltemp);
vetor
fprintf('\n\tRestricoes: PSI = %.3f | FI = %.3f\n',psi,fi);
fprintf('\n\t HdL: %.3f  t1dt0: %.3f  L1dL0: %.3f  Alpha: %.3f\n',vetor(1),vetor(2),vetor(3),vetor(4));
fprintf('\nTotal de pontos Visitados: %d',length(p_memory(:,1)));

% Montando geometria otima
%matrizs(2,:) = cav_yd([HdL vetor(1) t1dt0 vetor(2)]);
try
     matrizs(2,:) = cav_y([vetor(1) vetor(3) vetor(2) vetor(4)]);% Nao mostra a simulacao
catch e
        fprintf('\nGeometria invalida para x0 [ %.3f %.3f %.3f %.3f]\n',x0);
        matrizs(2,:) = inf;
end
diary off;
filename = strcat(dir,'/',date,'_', num2str(hour(now)),'-', num2str(minute(now)),'-', num2str(floor(second(now))),'_psi_',num2str(psi),'_fi_',num2str(fi),'_4dof_data');
save(filename,'matrizs');
logsa = [logsa; 0 vetor(1) vetor(2) vetor(3) vetor(4) tmax_min ]
csvwrite(strcat(filename,'.csv'),matrizs);
csvwrite(strcat(filename,'_logsa.csv'),logsa);
csvwrite(strcat(filename,'_pmemory.csv'),p_memory);
dlmwrite(strcat(filename,'.txt'), matrizs, 'delimiter','\t','precision', '%.6f','newline', 'unix')
if i == 0
 toc(t)
 diary off
end


opt = vetor;

end
