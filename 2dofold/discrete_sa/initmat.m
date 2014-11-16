
%COMANDO PARA CHAMAR O MATLAB DO TERMINAL
%matlab -nodisplay -r "run('/.../.../initmat.m')"

cd /media/echoes/DADOS2/Projetos/matlab/opt/opt_pde/
addpath(genpath('/media/echoes/DADOS2/Projetos/matlab/opt/opt_pde/'));
cd sa_cav_y/2dof
clear all
tp = tic();
%d_opt_sa_cavy2
%dtestes
toc(tp)
exit
