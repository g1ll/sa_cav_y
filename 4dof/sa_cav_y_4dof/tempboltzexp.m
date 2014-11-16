function tempsa = tempboltzexp(optimValues,problem)

global options;
global logsa;
global nk;

iter = optimValues.iteration;
fx = optimValues.fval;
x = optimValues.x;

%Salvando log a execucao do algoritmo SA
if size(logsa) == 0
   logsa = [ iter x(1) x(2) x(3) x(4) fx];
else
   logsa = [ logsa; iter x(1) x(2) x(3) x(4) fx];
end


init_temp = options.InitialTemperature;
atual_temp = optimValues.temperature;
  k = optimValues.k;
  tempsaboltz = zeros(1,length(k));
  tempsaexp = zeros(1,length(k));
  tempsa = zeros(1,length(k));
  for tc = 1:1:length(k)
  
      tempsaboltz(tc) = init_temp(tc)/log(k(tc));%-nk(tc)); %temperatuda de boltz
      tempsaexp(tc) = init_temp(tc)*0.95^((k(tc))-init_temp(tc)*0.5); % temperatura exponencial;
      
      if tempsaboltz(tc) > tempsaexp(tc) % controle 2 para temperatura exponencial
	      tempsa(tc) = tempsaexp(tc);
	      %fprintf('\nControle temp exp %.6f\n',temp(tc));
      else
	      tempsa(tc) = tempsaboltz(tc);
	  % fprintf('\nControle temp boltz  %.6f\n',temp(tc));
      end
      %Forca o reannealing
      while tempsa(tc)<= 0.9
	tempsa(tc) = tempsa(tc)*100;
      end
  end

end
