%  % Bateria de testes
%  global vetor
%  global i;
%  global options;
%  global n_iter;
%  global tmax_min;
%  global modeltemp;
%  global popt;
%  global mintmax;
%  global rtotal;
%  
%  %estrutura de diretorios
%  global folder;
%  global folderz;
%  global folderg;
%  global folderw;
%  
%  
%  format short;
%  
%  models = {@temperaturefast @temperatureexp @temperatureboltz @tempboltzexp};
%  rtotal = {'fast' 'exp' 'boltz' 'boltzexp' 't1dt0'};
%  mrtotal = zeros(1,5);
%  vet_psi = [0.3];
%  %vet_fi = [0.01 0.05 0.1 0.2];
%  vet_fi = [0.05];
%  
%  n_psi = length(vet_psi);
%  n_exec2 = 1;%20;
%  d = clock();
%  ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(floor(d(6))));
%  folder = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),'_',num2str(d(4)),'_',num2str(d(5)),'_',num2str(floor(d(6))));
%  mkdir(strcat('resultados/discreto/',folder));
%  file = strcat('resultados/discreto/',folder,'/',ds,'_opt_teste_psi');
%  log1 = zeros(1,5);
%  
%  tt = tic();
%  ca = 0; %contadot auxiliar
%  for z=1:1:length(models)
%  	ca = 0;
%  	t0 = tic();
%  	modeltemp = models{z};
%  	folderz = strcat('model',num2str(z));
%  	mkdir(strcat('resultados/discreto/',folder,'/',folderz));	
%  	for w=1:1:n_psi
%      		clc;
%      		t1 = tic();
%      		psi = vet_psi(w);
%      		folderw = strcat('psi_',num2str(psi));
%      		for f = 1:1:length(vet_fi(1,:));
%  		fi = vet_f(w,f);
%  		folderw = strcat(folderw,'_fi_',num2str(fi));
%  		mkdir(strcat('resultados/discreto/',folder,'/',folderz,'/',folderw));
%      		fprintf('Opt cav y psi =  %d\n',psi);
%  		for g=1:1:n_exec2
%  			folderg = strcat('test',num2str(g));
%  			mkdir(strcat('resultados/discreto/',folder,'/',folderz,'/',folderw,'/',folderg));
%  	    		var_exec_sa;
%  %  	    		log1 = [log1;z w t1dt0 popt toc(t1)];
%  %  			rtotal{g+1+(n_exec2*ca),z} = popt;
%  %  			rtotal{g+1+(n_exec2*ca),5} = t1dt0;
%  %  			mrtotal(g+1+(n_exec2*ca),z) = popt;
%  %  			mrtotal(g+1+(n_exec*ca),5) = t1dt0;
%  		end
%  		end
%  		ca = ca +1;
%  	end
%  	log1 = [log1;z w t1dt0 popt toc(t0)];
%  end
%  diary(strcat(file,'.txt'));
%  diary on
%  fprintf('\nInicio em : %s',ds);
%  display('nTempo total:\n');
%  toc(tt);
%  d = clock();
%  ds = strcat(num2str(d(1)),'-',num2str(d(2)),'-',num2str(d(3)),':',num2str(d(4)),':',num2str(d(5)),':',num2str(d(6)));
%  fprintf('\nFinalizado em: %s',ds)
%  display(log1);
%  display(rtotal);
%  csvwrite(strcat(file,'.csv'),log1);
%  csvwrite(strcat(file,'_mrtotal.csv'),mrtotal);
%  diary off

%dopt_sa_cavy_4(.3,.05,@temperaturefast);
%dopt_sa_cavy_4(.3,.05,@temperatureexp);
%dopt_sa_cavy_4(.3,.05,@temperatureboltz);
%dopt_sa_cavy_4(.3,.05,@tempboltzexp);
%dopt_sa_cavy_4(.3,.05,@temphsa);
dopt_sa_cavy_4(.3,.05,@tempksa);

