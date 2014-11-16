% Bateria de testes
clear all
global vetor
global i;
global options;
global n_iter;
global tmax_min;
global t1dt0;
global type_stepmax;

%estrutura de diretorios
global folder;
global folderz;
global folderw;

format short;

vet_t1dt0 = [3 7 10 11 12 14 18]

n_exec = length(vet_t1dt0);
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(floor(d(6))));
folder = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),'_',num2str(d(4)),'_',num2str(d(5)),'_',num2str(floor(d(6))));
mkdir(strcat('resultados/discreto/',folder));
file = strcat('resultados/discreto/',folder,'/',ds,'_opt_teste_t1dt0_stepmax',num2str(n_exec));
log1 = zeros((n_exec*4)+5,4);

tt = tic();
for z=1:1:1
	t0 = tic();
	type_stepmax = z;
	folderz = strcat('stepmax_',num2str(z));
	mkdir(strcat('resultados/discreto/',folder,'/',folderz));
	for w=1:1:n_exec
    		clc;
    		t1 = tic();
    		t1dt0 = vet_t1dt0(w);
		folderw = strcat('t1dt0_',num2str(t1dt0));
		mkdir(strcat('resultados/discreto/',folder,'/',folderz,'/',folderw))
    		fprintf('Opt cav y t1dt0 =  %d\n',t1dt0);
    		var_exec_sa
    		log1(w,:) = [w type_stepmax t1dt0 toc(t1)];
	end
	log1 = [log1;w type_stepmax t1dt0 toc(t0) ]
end
diary(strcat(file,'.txt'));
diary on
display('\nInicio em : %s',ds);
display('nTempo total:\n');
toc(tt);
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(d(6)));
display('\nFinalizado em: %s',ds)
display(log1);
csvwrite(strcat(file,'.csv'),log1);
diary off
