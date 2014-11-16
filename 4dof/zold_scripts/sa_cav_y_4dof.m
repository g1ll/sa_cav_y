function saida= sa_cav_y_4dof( vet_4_dof )
%DRIVER_SA_CAV_Y Summary of this function goes here
%   Detailed explanation goes here
saida = inf;
try
       saida =cav_y(vet_4_dof);
 catch error
     saida = inf;
end

end

