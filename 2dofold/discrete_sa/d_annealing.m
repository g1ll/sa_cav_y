function schedule = d_annealing( optimValues,problem )
	
	global options;
	%parametro global para configurar tipo de proposta para o novo ponto
	global type_stepmax;
	global salpha;
	global salpha_c;
	%Variáveis de estado do SA
	init_temp = options.InitialTemperature;
	iter = optimValues.iteration;
	best= optimValues.bestfval;
	fx = optimValues.fval;
	x = optimValues.x;
	atual = optimValues.bestx;
	k = optimValues.k;
	%Discretização do espaço de busca
	% Limites para a geometria
	% L1dL0       0.001:1.00
	% alfa         1.00:1.57
	%Limites e alpha
	upb = 1.57;
	lob = 1.00;
	step_a = 0.01;
	%Valores para L1/L0
	vl1dl0 = [0.001 0.002 0.003 0.005 0.007 0.01 0.02 0.03 0.05 0.07 0.1 0.3 0.5 0.7 1];
	%Controle para não passar por pontos repetidos
	if salpha_c == 0
        	salpha = lob:step_a:upb;
        	salpha = zeros(length(salpha)*length(vl1dl0),2);
	end
	contsort = 0;
	equal = 1;

	while equal == 1 %ENQUANTO (1) O PONTO GERADO FOR REPETIDO, CONTINUA A GERAR NOVO PONTO
		equal = 0;
		%schedule = optimValues.x;
		schedule = optimValues.bestx;

		% PARA (1) GERACAO DE NOVOS PONTOS PARA CADA VARIAVEL
		for c = 1:1:2;
			perturbacao = 0;
            		temp = optimValues.temperature(c);
                	steplen = +inf;
                	stepmax = -inf;
		
			while steplen > stepmax %ENQUANTO (2) A DISTANCIA DO PONTO FOR MAIOR QUE A MÁXIMA ACEITA, GERA NOVO PONTO
				if c<2
                    			r =  (((length(vl1dl0)-1)-floor(rand()*20))^2)^(1/2)+1;
                    			perturbacao = vl1dl0(r)-schedule(c);
					strvar = 'L1/L0'; % Nome da variavel para impressao de debug
				else
                    			perturbacao = (((floor(rand()/step_a)*step_a+1)-upb)^2)^(1/2)+lob-schedule(c);
					strvar = 'Alpha';
				end
				%DISTANCIA (PASSO) DO PONTO ATUAL PARA O PONTO PROPOSTO
				steplen = ((perturbacao)^2)^(1/2);
				
				%DEFININDO A DISTANCIA MAXIMA ACEITA PARA O NOVO PONTO
				if isempty(type_stepmax) || type_stepmax == 1
					% type_stepmax = 1 >> DEFINIDO COMO UMA PORCENTAGEM DO PONTO ATUAL, ESTA PORCENTAGEM E BASEADA NA TEMPERATURA
                    			stepmax = schedule(c)*temp/100; %annealing temp percent
                    			if stepmax <= schedule(c)*0.1 % annealing temp percent min
                    				stepmax = schedule(c)*temp/10;
                    			end
				elseif type_stepmax == 2
					%type_stepmax = 2 >> DEFINIDO COMO SEMPRE 10% DO PONTO ATUAL
					stepmax = schedule(c)*0.1; % 2 - annealing 10 percent schedule
				elseif type_stepmax == 3
            	     			stepmax = schedule(c)*temp; % 3 - annealing fast (matlab default)
				else
	             			stepmax = schedule(c)*temp^(1/2); % 4 -  annealing boltz (matlab default)
				end

			end %FIM ENQUANTO (2)
			schedule(c)  = schedule(c)+perturbacao;
			
			%DEBUG			
			%fprintf(' \n| p %s = %.3f ; steplen = %.3f : stepmax = %.3f',strvar,perturbacao,steplen,stepmax);
               		%fprintf(' Schedule atual %s = %.3f',strvar,schedule(c));
               		%fprintf(' Pertubacao %s = %.3f',strvar,perturbacao);
               		%fprintf(' Schedule %s = %.3f\n',strvar,schedule(c));
		end
	
		% CONTROLE DE PONTOS REPETIDOS
    		if salpha_c == 0
        		salpha_c = 1;
        		salpha(salpha_c,:) = schedule;
		else      
        		%fprintf('\nSALPHA_C %d\n',salpha_c);
        		%display(salpha);
        		for j = 1:1:salpha_c            
                		%fprintf( '%d-',j);
           			if salpha(j,1) == schedule(1) && salpha(j,2) == schedule(2) && contsort  < options.StallIterLimit
					% DEVERÁ SER GERADO UM NOVO PONTO
                			equal = 1; %Força a continuar no ENQUANTO (1)                
                			
					%fprintf('\n\tAlpha  e L1dL0 iguais  [  %.3f   %.3f ] = [  %.3f   %.3f ] | Sorteando novas solucoes...\n',salpha(j,1) ,salpha(j,2),schedule(1),schedule(2));
                			j = salpha_c;
                			contsort = contsort + 1;
           		 	else               
               				%fprintf('\n\tAlpha  e L1dL0 diferentes  [  %.3f   %.3f ] = [  %.3f   %.3f ]',salpha(j,1) ,salpha(j,2),schedule(1),schedule(2));
           		 	end
        		end
			% SENDO UM NOVO PONTO ESTE É GUARDADO NA MATRIZ DE PONTOS SALPHA
        		if equal ==0
                		salpha_c = salpha_c+1;  
                		salpha(salpha_c,:) = schedule;
        		end
    		end %FIM CONTROLE DE PONTOS REPEDITOS
	end %FIM ENQUANTO (1) VOLTA APENAS SE O PONTO E REPETIDO, DO CONTRARIO SEGUE O ALGORITMOS
    
	fprintf('\n Iter %d | Best F(x) %.3f | F(x)  %.3f | Temperatura %.3f | k = %d\n ',iter,best,fx,temp,k);
	fprintf('\n\tValor atual: L1/L0 %.3f alpha %.3f | Novos valores: L1/L0 %.3f alpha %.3f\n-------------\n',atual(1),atual(2),schedule(1),schedule(2) )
end
