function tempsa = temphsa(optimValues,problem)

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
    k = optimValues.k;
    tempsaexp = zeros(1,length(k));
    tempsa = zeros(1,length(k));
    pexp = 100; % iteração onde inicia o decaimento de temperatura exponencial
    for tc = 1:1:length(k)
    
	if k(tc) > pexp % controle 2 para temperatura exponencial
		tempsaexp(tc) = init_temp(tc)*0.95^((k(tc))-pexp); % temperatura exponencial;
		tempsa(tc) = tempsaexp(tc);
		%fprintf('\nControle temp exp %.6f\n',temp(tc));
	else
		tempsa(tc) = init_temp(tc);
	    % fprintf('\nControle temp boltz  %.6f\n',temp(tc));
	end
      %Forca o reannealing
      while tempsa(tc)< 1
	tempsa(tc) = tempsa(tc)*100;
      end

    end
end
 
