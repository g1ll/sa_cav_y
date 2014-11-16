function tabela = cavy_mesh_test( num_testes,criterio ,save_file)
% Realiza teste de malha para a cavidade Y
% num_testes : Define o número de refinamentos na malha
% criterio: criterio para determinar a malha independente ex: menor que 0.0001
% save_file : Define se será salvo um arquivo de log

clc
timer = tic();

%Restrições da cavidade
global fi;
global psi;
fi = 0.05;
psi = 0.5;

%Valores da geometria
HdL = 1;
L1dL0 = 0.5;
t1dt0 = 2;
alpha = 0.94;

tabela = zeros(num_testes:4);

fprintf('\nTabela com Tmax para cada Malha:\n');
fprintf('iter\tN Elementos\tTmax\t(Tmax(j)-Tmax(j+1)/Tmax(j))\n')
for j = 1:1:num_testes
    t = cav_ym([HdL L1dL0 t1dt0 alpha],j);
    tabela(j,:) = [j t(1) t(2) 0];
    fprintf('%d\t%d\t\t%f\t%f\n',tabela(j,:))
end
fprintf('\nTabela com Tmax para cada Malha:\n');


bmesh = [0 0 criterio];

fprintf('\nTabela com Cálculo de Independência de Malha:\n\n');
fprintf('iter\tN Elementos\tTmax\t(Tmax(j)-Tmax(j+1)/Tmax(j))\n')
for j = 1:1:num_testes-1
    tabela(j,4) = (tabela(j,3)-tabela(j+1,3))/tabela(j,3);
    if tabela(j,4) < bmesh(1,3) && bmesh(1,1) == 0
        bmesh = [j tabela(j,2) tabela(j,4)];
        fprintf('%d\t%d\t\t%f\t%f *\n',tabela(j,:));
    else  
        fprintf('%d\t%d\t\t%f\t%f\n',tabela(j,:));
    end
end

fprintf('\n* Malha Independente: \n\t - Refinamentos:   %d \n\t- Elementos:%d\n\t- Erro: %f\n',bmesh);
 fprintf('\n');
   if save_file == 1
        filename = strcat(date,'_',  num2str(hour(now)), num2str(minute(now)), num2str(floor(second(now))),'mesh_test_cav_y.csv');
        csvwrite(filename,tabela);
   end
   toc(timer);
end

