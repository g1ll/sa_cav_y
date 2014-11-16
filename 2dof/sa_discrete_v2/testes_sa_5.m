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
global rtotal;

%estrutura de diretorios
global folder;
global folderz;
global folderg;
global folderw;


format short;

%models = {@temperaturefast @temperatureexp @temperatureboltz @tempboltzexp};
models = {@temphsa}
rtotal = {'constexp1' 't1dt0'};
mrtotal = zeros(1,length(rtotal));
%  vet_t1dt0 = [3 7 10 11 12 14 18];
%  vet_mintmax = [0.0815198 0.0700201 0.0639046 0.0611336 0.0642451 0.0644004 0.0659569];
vet_t1dt0 = [7 10 11 12 14 18];
vet_mintmax = [ 0.0700201 0.0639046 0.0611336 0.0642451 0.0644004 0.0659569];
%vet_mintmax = [0.064249];
%vet_t1dt0 = [12];


n_t1dt0 = length(vet_t1dt0);
n_exec2 = 1;
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(floor(d(6))));
folder = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),'_',num2str(d(4)),'_',num2str(d(5)),'_',num2str(floor(d(6))));
mkdir(strcat('resultados/discreto/',folder));
file = strcat('resultados/discreto/',folder,'/',ds,'_opt_teste_t1dt0_model',num2str(n_t1dt0));
log1 = zeros(1,5);

tt = tic();
ca = 0; %contadot auxiliar
for z=1:1:length(models)
	ca = 0;
	t0 = tic();
	modeltemp = models{z};
	folderz = strcat('model_',func2str(models{z}));
	mkdir(strcat('resultados/discreto/',folder,'/',folderz));	
	for w=1:1:n_t1dt0
    		clc;
    		t1 = tic();
    		t1dt0 = vet_t1dt0(w);
		mintmax = vet_mintmax(w);
		folderw = strcat('t1dt0_',num2str(t1dt0));
		mkdir(strcat('resultados/discreto/',folder,'/',folderz,'/',folderw))
    		fprintf('Opt cav y t1dt0 =  %d\n',t1dt0);
		for g=1:1:n_exec2
		folderg = strcat('test',num2str(g));
			mkdir(strcat('resultados/discreto/',folder,'/',folderz,'/',folderw,'/',folderg));
	    		var_exec_sa;
	    		log1 = [log1;z w t1dt0 popt toc(t1)];
			rtotal{g+1+(n_exec2*ca),z} = popt;
			rtotal{g+1+(n_exec2*ca),5} = t1dt0;
			mrtotal(g+1+(n_exec2*ca),z) = popt;
			mrtotal(g+1+(n_exec*ca),5) = t1dt0;
		end
		ca = ca +1;
	end
	log1 = [log1;z w t1dt0 popt toc(t0)];
end
diary(strcat(file,'.txt'));
diary on
fprintf('\nInicio em : %s',ds);
display('nTempo total:\n');
toc(tt);
d = clock();
ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(d(6)));
fprintf('\nFinalizado em: %s',ds)
display(log1);
display(rtotal);
csvwrite(strcat(file,'.csv'),log1);
csvwrite(strcat(file,'_mrtotal.csv'),mrtotal);
diary off
