% Bateria de testes
global vetor
global i;
global options;
global n_iter;
global tmax_min;
global t1dt0;
global modeltemp;
global popt;
global mintmax;

%estrutura de diretorio
global folder;
global folderz;
global folderg;
global folderw;


format short;

n_exec = 5;
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(d(6)));
if isempty(folder)
	filename2 = strcat('resultados/discreto/',ds,'_testes_',num2str(n_exec));
else
	filename2 = strcat('resultados/discreto/',folder,'/',folderz,'/',folderw,'/',folderg,'/',ds,'_testes_',num2str(n_exec));
end
resultados = zeros(n_exec,6);
for i=1:1:n_exec
    clc;
    t2 = tic();
    fprintf('Teste %d\n',i);
    dopt_sa_cavy(t1dt0,modeltemp);
    resultados(i,:) = [i vetor(1) vetor(2) tmax_min n_iter toc(t2)];
end
nopt=(sum(resultados(:,4) <= mintmax));
popt = nopt*100/n_exec;
resultados = [resultados; 0 0 n_exec nopt popt 0]
diary(strcat(filename2,'.txt'));
diary on
display(options);
display(resultados);
csvwrite(strcat(filename2,'.csv'),resultados);
diary off
