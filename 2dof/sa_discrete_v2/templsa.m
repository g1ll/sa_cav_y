function tempsa = tempksa(optimValues,problem)

  global options; 
  global logsa;
  global nk;

  iter = optimValues.iteration;
  fx = optimValues.fval;
  x = optimValues.x;

  %Salvando log a execucao do algoritmo SA
  if size(logsa) == 0
    logsa = [ iter x(1) x(2) fx];
  else
    logsa = [ logsa; iter x(1) x(2) fx];
  end


  init_temp = options.InitialTemperature;
    k = optimValues.k;
    tempsa = zeros(1,length(k));
    const = 0.9; % Constante de decaimento da temperatura %0.8
    per = 163; %175
    c_iter =max(init_temp)/2; % iteração onde inicia o decaimento de temperatura linear
    for tc = 1:1:length(k)
    
	kl = k(tc)-1-per*floor((k(tc)-1)/per)-1;
	if kl < c_iter
		tempsa(tc) = init_temp(tc);
	else
		tempsa(tc) = init_temp(tc)*1.45-kl*const;
	end

    end
end
 
 
