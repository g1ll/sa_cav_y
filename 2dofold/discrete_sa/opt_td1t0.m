% Bateria de testes
clear all
global vetor
global i;
global options;
global n_iter;
global tmax_min;
global t1dt0;

format short;

vet_t1dt0 = [3 7 10 11 12 14 18]

n_exec = length(vet_t1dt0);
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(3)),'-',num2str(d(2)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(d(6)));
filename2 = strcat('resultados/discreto/',ds,'_opt_t1dt0_',num2str(n_exec));
resultados = zeros(n_exec,7);
for i=1:1:n_exec
    clc;
    t = tic();
    fprintf('Opt cav y t1dt0 =  %d\n',vet_t1dt0(i));
    t1dt0 = vet_t1dt0(i);
    var_exec_sa
    resultados(i,:) = [i vetor(1) vetor(2) tmax_min n_iter vet_t1dt0(i) toc(t)];
end
diary(strcat(filename2,'.txt'));
diary on
display(options);
display(resultados);
csvwrite(strcat(filename2,'.csv'),resultados);
diary off
