function saida= sa_cav_y_2dof( vet_2_dof )
%DRIVER_SA_CAV_Y Summary of this function goes here
%   Detailed explanation goes here

%fixando os Valores HdL = 1, t1dt0
global HdL;
global t1dt0;

saida = inf;

try      
        vetor=[HdL vet_2_dof(1) t1dt0 vet_2_dof(2)];
       saida =cav_y(vetor);
 catch error
     saida = inf;
end

end

