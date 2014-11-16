% Bateria de testes
clear all
global vetor
global i;
global options;
global n_iter;
global tmax_min;

format short;

n_exec = 30;
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(3)),'-',num2str(d(2)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(d(6)));
filename2 = strcat('resultados/discreto/',ds,'_testes_',num2str(n_exec));
resultados = zeros(n_exec,6);
for i=1:1:n_exec
    clc;
    t = tic();
    fprintf('Teste %d\n',i);
    %d_opt_sa_cavy;
    d_opt_sa_cavy2;
    resultados(i,:) = [i vetor(1) vetor(2) tmax_min n_iter toc(t)];
end
diary(strcat(filename2,'.txt'));
diary on
display(options);
display(resultados);
csvwrite(strcat(filename2,'.csv'),resultados);
diary off
