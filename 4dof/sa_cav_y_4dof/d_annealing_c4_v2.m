function schedule = d_annealing( optimValues,problem )
	
	debug = 0; %IMPRIME DEBUG
	point_memory = 1; % SE IGUAL A 1 VERIFICA PONTOS REPETIDOS
	geovalid = 1; %VERIFICA SE PONTO POSSUI UMA GEOMETRIA VÁLIDA
	
	global options;
	
	
	%Variáveis de estado do SA
	iter = optimValues.iteration;
	best= optimValues.bestfval;
	fx = optimValues.fval;
	x = optimValues.x;
	atual = optimValues.x;
	k = optimValues.k;
	
	
	%Discretização H/L
	vHL = [0.5 1 2 5 7 10 15 20];
	%vHL = [0.2 0.5 1 2 5 7 10 15 18 20 22 28 30];
	
	%Discretização t1dt0
	vt1dt0 = [2 4 5 9 10 11 12 13 15 17 18 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220];
	
	%Valores para L1/L0
	vl1dl0 = [0.0010 0.0020 0.0030 0.0050 0.0070 0.010 0.020 0.030 0.050 0.070 0.10 0.30 0.50 0.70 1];
	
	
	%Limites e alpha
	upb = 1.57;
	lob = 1.00;
	step_a = 0.01;
	
	% Total de pontos no espaço de busca
	% 222720
	
	%Inicializando memória de pontos já visitados
	if point_memory ==1
	  global p_memory; %matriz com pontos já visitados (Evitar propor pontos repetidos)
	  if isempty(p_memory)
		  p_memory = zeros(1,4);
	  end
	  contsort = 0; 
  	end
	equal = 1; %Força entrada no primeiro while
  	contgeo = 0;

  	while equal == 1%ENQUANTO (1) O PONTO GERADO FOR REPETIDO, CONTINUA A GERAR NOVO PONTO
  		equal = 0;
		%schedule = optimValues.x;
		schedule = optimValues.bestx;
		% PARA (1) GERACAO DE NOVOS PONTOS PARA CADA VARIAVEL
		for c = 1:1:4
			perturbacao = 0;
            		temp = optimValues.temperature(c);
            		init_temp = options.InitialTemperature(c);
                	steplen = +inf;
                	stepmax = -inf;
		
			while steplen > stepmax %ENQUANTO (2) A DISTANCIA DO PONTO FOR MAIOR QUE A MÁXIMA ACEITA, GERA NOVO PONTO
				if c==1
                    			s_space = length(vHL);
                    			r =  (((s_space-1)-floor(rand()*s_space))^2)^(1/2)+1;
					perturbacao = vHL(r)-schedule(c);
					p_vet = find(vHL==schedule(c));	
					if isempty(p_vet)
					
%  					  display(schedule);
%  					  display(p_vet);
					  p_vet = s_space;
%  					  display(p_vet);
					  while isempty(p_vet)
					    p_vet = find(vHL == schedule(c));
%  					    display(p_vet);
					  end
					end
					strvar = 'H/L'; % Nome da variavel para impressao de debug
				elseif c == 2
					s_space = length(vt1dt0);
					r =  (((s_space-1)-floor(rand()*s_space))^2)^(1/2)+1;
					perturbacao = vt1dt0(r)-schedule(c);
					p_vet = find(vt1dt0==schedule(c));
					strvar = 't1/t0'; % Nome da variavel para impressao de debug
					if isempty(p_vet)
%  					  display(schedule);
%  					  display(p_vet);
					  p_vet = s_space;
%  					  display(p_vet);
					  while isempty(p_vet)
					    p_vet = find(vt1dt0 == schedule(c));
%  					    display(p_vet);
					  end
					end
				elseif c == 3			
					s_space = length(vl1dl0);
					r =  (((s_space-1)-floor(rand()*s_space))^2)^(1/2)+1;
					perturbacao = vl1dl0(r)-schedule(c);
					p_vet = find(vl1dl0 == schedule(c));
					if isempty(p_vet)
%  					  display(schedule);
%  					  display(p_vet);
					  p_vet = s_space;
%  					  display(p_vet);
					  while isempty(p_vet)
					    p_vet = find(vl1dl0 == schedule(c));
%  					    display(p_vet);
					  end
					end
					strvar = 'L1/L0'; % Nome da variavel para impressao de debug
				else
                    			perturbacao = (((floor(rand()/step_a)*step_a+1)-upb)^2)^(1/2)+lob-schedule(c);
					steplen = ((perturbacao)^2)^(1/2); %DISTANCIA (PASSO) DO PONTO ATUAL PARA O PONTO PROPOSTO
					stepmax = ceil((upb-lob)*temp)/init_temp;%DEFININDO A DISTANCIA MAXIMA ACEITA PARA O NOVO PONTO
					strvar = 'Alpha';
				end
				
				if c ~= 4
				  dist_p = r - p_vet;
				  steplen = ((dist_p)^2)^(1/2);%DISTANCIA (PASSO) DO PONTO ATUAL PARA O PONTO PROPOSTO
				  stepmax = ceil(s_space*temp/init_temp);%DEFININDO A DISTANCIA MAXIMA ACEITA PARA O NOVO PONTO
				end
				
			end %FIM ENQUANTO (2)
			schedule(c)  = schedule(c)+perturbacao;
			if debug == 1
			  fprintf(' \n| p %s = %.3f ; steplen = %.3f : stepmax = %.3f',strvar,perturbacao,steplen,stepmax);
			  fprintf(' Schedule atual %s = %.3f',strvar,atual(c));
			  fprintf(' Pertubacao %s = %.3f',strvar,perturbacao);
			  fprintf(' Schedule %s = %.3f\n',strvar,schedule(c));
		      end
		      
		end	
		
		
		% CONTROLE DE PONTOS REPETIDOS COM p_memory
		if point_memory == 1 && equal == 0 %REALIZA A VERIFICAÇÃO DE PONTOS REPETIDOS SE point_memory for igual a 1
		    
		    for i = 1:1:length(p_memory(:,1))
        		  if (sum(p_memory(i,:) == schedule))== 4 && contsort < 100
        			if debug ==1
				  fprintf('\n Pontos ja sorteados ! %d\n',contsort);
				  display(p_memory(i,:));
				  display(schedule);
        			end
        			equal = 1;
        			contsort = contsort + 1;
        		  end
        	    end
		    
        	    if equal == 0
        		  p_memory = [p_memory; schedule];
        		  
        		%VERIFICA SE GEOMETRIA É VÁLIDA
			if geovalid ==1
			    try
				cav_yg([schedule(1) schedule(3) schedule(2) schedule(4)]);
			    catch
				contgeo = contgeo + 1; %INCREMENTA CONTADOR DE GEOMETRIAS INVALIDAS
				if debug == 1
				  fprintf('\n geometria invalida ! %d\n',contgeo);
				end
				
				if contgeo < 1000; %EVITA QUE FIQUE PRESO NO LOOP, APÓS 100 GEOMETRIAS INVALIDAS A GEOMETRIA SERA ACEITA
				  equal = 1; %SENDO IGUAL A 1, O PRIMEIRO WHILE E REPETIDO E UM NOVO PONTO DEVERA SER GERADO
				end
		            end
		        end  
        	    end
		end

  	end %FIM ENQUANTO (1) VOLTA APENAS SE O PONTO E REPETIDO, DO CONTRARIO SEGUE O ALGORITMOS
    
	%fprintf('\n Iter %d | Best F(x) %.3f | F(x)  %.3f | Temperatura %.3f | k = %d\n ',iter,best,fx,temp(1),k);
	if debug == 1
	  fprintf('\n\tMelhor Ponto:H/L = %.3f t1dt0 = %.3f L1/L0 %.3f alpha %.3f\n\tPonto Atual:H/L = %.3f t1dt0 = %.3f L1/L0 %.3f alpha %.3f\n\t Novo Ponto: H/L = %.3f t1dt0 = %.3f  L1/L0 %.3f alpha %.3f\n-------------\n',optimValues.bestx,atual,schedule)
	end
	
end
