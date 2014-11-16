function tempsa = tempksa(optimValues,problem)

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
    const = 0.9; % Constante de decaimento da temperatura
    c_iter = 100; % Número de iterações em que a temperatura permanecerá constante
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
 
 
