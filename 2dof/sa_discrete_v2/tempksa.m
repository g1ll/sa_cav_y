function tempsa = tempksa(optimValues,problem)

  global options; 

  init_temp = options.InitialTemperature;
    k = optimValues.k;
    tempsaexp = zeros(1,length(k));
    tempsa = zeros(1,length(k));
    const = 0.9; % Constante de decaimento da temperatura
    c_iter =max(init_temp)/2; % iteração onde inicia o decaimento de temperatura exponencial
    for tc = 1:1:length(k)
    
	if k(tc) > c_iter % Testa se a iteração é maior que a constante de iterações c_iter
		tempsa(tc) = optimValues.temperature(tc)*const;
	else
		tempsa(tc) = init_temp(tc);
	end
	
	 %Forca o reannealing
      while tempsa(tc)<= 1
	tempsa(tc) = tempsa(tc)*100;
      end

    end
end
 
 
