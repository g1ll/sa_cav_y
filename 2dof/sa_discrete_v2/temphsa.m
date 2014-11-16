function tempsa = temphsa(optimValues,problem)

  global options; 

  init_temp = options.InitialTemperature;
    k = optimValues.k;
    tempsaexp = zeros(1,length(k));
    tempsa = zeros(1,length(k));
    pexp =max(init_temp)/2; % iteração onde inicia o decaimento de temperatura exponencial
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
 
