
dir = '/localHome/gill/sa_cav_y/4dof/'; %SERVER
%dir = '/mnt/media/Dados/Arquivos/Estudos/Mestrado/Projetos/matlab/opt/opt_pde/01_sa_cav_y/4dof/'; %LOCAL PC
%dir = 'media/Dados/Arquivos/Estudos/Mestrado/Projetos/matlab/opt/opt_pde/01_sa_cav_y/4dof/'; %LOCAL NOTE

cd(dir);
addpath(genpath(dir));
cd sa_cav_y_4dof/

psi = 0.4
fi = [0.01 0.05 0.1 0.15 0.2];
schedule = @temperatureexp;
resa = 100;
stalsa = 1000;

for i=1:1:length(fi)
  dopt_sa_cavy_4(psi,fi(i),schedule,resa,stalsa)
end

exit