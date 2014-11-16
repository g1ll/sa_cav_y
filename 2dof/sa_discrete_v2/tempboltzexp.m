function tempsa = tempboltzexp(optimValues,problem)

global options;
global nk;

init_temp = options.InitialTemperature;
k = optimValues.k;
temp = zeros(1:length(k));
tempexp = zeros(1:length(k));
for tc = 1:1:length(k)
 
 if numel(nk)== 0
   nk = zeros(1:length(k));
 end


 if k(tc) < nk(tc)
   nk(tc) = 0;
 end

 
 temp(tc) = init_temp(tc)/log(k(tc)-nk(tc)); %temperatuda de boltz
 tempexp(tc) = init_temp(tc)*0.95^((k(tc)-nk(tc))-init_temp(tc)*0.5); % temperatura exponencial;
 
 if temp(tc) > tempexp(tc) % controle 2 para temperatura exponencial
         temp(tc) = tempexp(tc);
 end
 
 
 if temp(tc) < 0.5
  fprintf('\n Reannealing tempboltzexp:\n');
  temp(tc) = init_temp(tc);
  nk(tc) = optimValues.k(tc);
 end

 tempsa(tc) = temp(tc);
 
end
end