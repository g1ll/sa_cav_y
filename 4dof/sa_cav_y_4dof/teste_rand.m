clc
%vHL = [0.5 1 2 5 7 10 15 20];
vHL = [0.2 0.5 1 2 5 7 10 15 18 20 22 28 30];
	
%Discretização t1dt0
vt1dt0 = [2 4 5 9 10 11 12 13 15 17 18 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220];
	
%Valores para L1/L0
vl1dl0 = [0.0010 0.0020 0.0030 0.0050 0.0070 0.010 0.020 0.030 0.050 0.070 0.10 0.30 0.50 0.70 1];

%estrutura de celulas com todos os vetores
m = {vHL;vt1dt0;vl1dl0};
vet_nm = {'vHL','vt1dt0','vl1dl0'};
cel_result = {0;0;0};

for w=1:1:3

    vet = m{w,:};
    %display(vet);
    iter = length(vet)*500; % calculando o numero de amostras
    rp = zeros(1,iter); % vetor com pontos aleatorios
    
    %estrutura de repeticao para geracao de numeros
    for i=1:1:iter
      rp(i) = rand_vet(vet);
    end

    %display(rp);

    result = [vet;zeros(1,length(vet))];

    for i=1:1:length(vet)
      for j=1:1:iter
	result(2,i) = sum(rp(1,:)==vet(1,i))*100/length(rp);
      end
    end

    %display(result);
    
    cel_result{w,:} = result;
    fprintf('\nVetor : %3.f');
    display(vet_nm{w});
    display(cel_result{w,:});
end