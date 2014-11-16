function saida= sa_cav_y_2dof( x )
%DRIVER_SA_CAV_Y Summary of this function goes here
%   Detailed explanation goes here

%fixando os Valores HdL = 1, t1dt0
global HdL;
global t1dt0;
global logsa np;

np = np + 1;

saida = inf;

try      
     vetor=[HdL x(1) t1dt0 x(2)];
     saida =cav_y(vetor);
 catch error
     saida = inf;
end
%Salvando log a execucao do algoritmo SA
  if isempty(logsa)
    logsa = [ np x saida];
  else
    logsa = [ logsa; np x saida];
  end

end

