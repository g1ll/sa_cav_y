function schedule = discrete_annealing2( optimValues,problem )
%DISCRETE_ANNEALING Summary of this function goes here
%   Detailed explanation goes here
global options
global salpha;
global salpha_c;


    % Limites para a geometria
     % L1dL0      0.001:1.00 
     % alfa         1.00:1.57
     
     %Discretizado como GA
    init_temp = options.InitialTemperature;
    iter = optimValues.iteration; 
    best= optimValues.bestfval;
    fx = optimValues.fval;
    x = optimValues.x;
    atual = optimValues.bestx;
    k = optimValues.k;
   
   upb = 1.57;
   lob = 1.00;
   step_a = 0.01;
   %pl1dl0 = [0.001  0.003 0.005 0.007 0.01 0.03 0.05 0.07 0.1]; 
   pl1dl0 = [0.001 0.002 0.003 0.005 0.007 0.01 0.02 0.03 0.05 0.07 0.1 0.3 0.5 0.7 1];
   
   if salpha_c == 0
        salpha = lob:step_a:upb;
        salpha = zeros(length(salpha)*length(pl1dl0),2);
   end
   contsort = 0;
   equal = 1;
while equal == 1
    equal = 0;
    
    %schedule = optimValues.x;
    schedule = optimValues.bestx;

    for c = 1:1:2;
        %perturbacao = r*vb(c)*optimValues.temperature(c);
            
            perturbacao = 0;
            temp = optimValues.temperature(c); 
            if c<2
                steplen = +inf;
                stepmax = -inf;
                while steplen > stepmax%|| steplen < (schedule(c)*temp/100)*0.5;
                    r =  (((length(pl1dl0)-1)-floor(rand()*20))^2)^(1/2)+1;
                    perturbacao = pl1dl0(r)-schedule(c);
                    steplen = ((perturbacao)^2)^(1/2);
                    %stepmax = schedule(c)*temp/100; %annealing temp percent
                    %if stepmax <= schedule(c)*0.1 % annealing temp percent min
                    %    stepmax = schedule(c)*temp/10;
                    %end

		    %outros métodos de annealing
		     %stepmax = schedule(c)*0.1; % 2 - annealing 10 percent schedule
            	     stepmax = schedule(c)*temp; % 3 - annealing fast (matlab default)
	             %stepmax = schedule(c)*temp^(1/2); % 4 -  annealing boltz (matlab default)


                    %fprintf(' \n\t\t| pL = %.3f ; steplen = %.3f : lu = %.3f, lb = %.3f|',perturbacao,steplen,schedule(c)*temp/100,(schedule(c)*temp/100)*0.5);
                end
                %fprintf(' \n\t\t| pL = %.3f ; steplen = %.3f : stepmax = %.3f',perturbacao,steplen,stepmax);
                %fprintf('\n\tSchedule atual L1/L0 = %.3f',schedule(c) );
                schedule(c)  = schedule(c)+perturbacao;
                %fprintf('\n\tPertubacao L1/L0 = %.3f',perturbacao);
                %fprintf('\n\tSchedule L1/L0 = %.3f\n',schedule(c) );
                
            else
                steplen = +inf;                
                stepmax = -inf;
                while steplen > stepmax %|| steplen < (schedule(c)*temp/100)*0.5;
                    perturbacao = (((floor(rand()/step_a)*step_a+1)-upb)^2)^(1/2)+lob-schedule(c);
                    steplen = ((perturbacao)^2)^(1/2);
                    %stepmax = schedule(c)*temp/100; %annealing temp percent
                    %if stepmax <= schedule(c)*0.1 % annealing temp percent min
                    %    stepmax = schedule(c)*temp/10;
                    %end

		    %outros métodos de annealing
		     %stepmax = schedule(c)*0.1; % 2 - annealing 10 percent schedule
            	     stepmax = schedule(c)*temp; % 3 - annealing fast (matlab default)
	             %stepmax = schedule(c)*temp^(1/2); % 4 -  annealing boltz (matlab default)

                    %fprintf(' \n\t\t| pA = %.3f ; steplen = %.3f : lu = %.3f, lb = %.3f|',perturbacao,steplen,schedule(c)*temp/100,(schedule(c)*temp/100)*0.5);
                end                
                   %fprintf(' \n\t\t| pA = %.3f ; steplen = %.3f : stepmax = %.3f|',perturbacao,steplen,stepmax);
                   % fprintf('\n\tSchedule atual Alpha = %.3f',schedule(c) );
                   schedule(c) = schedule(c) + perturbacao;
                   %fprintf('\n\tPerturbacao Alpha = %.3f',perturbacao );
                  %fprintf('\n\tSchedule Alpha = %.3f\n',schedule(c) );
            end
    end
%  Evitando espaços repetidos
    if salpha_c == 0
        salpha_c = 1;
        salpha(salpha_c,:) = schedule;
    else      
        %fprintf('\nSALPHA_C %d\n',salpha_c);
        %display(salpha);
        for j = 1:1:salpha_c            
                %fprintf( '%d-',j);
           if salpha(j,1) == schedule(1) && salpha(j,2) == schedule(2) && contsort  < options.StallIterLimit
                equal = 1;                
                %fprintf('\n\tAlpha  e L1dL0 iguais  [  %.3f   %.3f ] = [  %.3f   %.3f ] | Sorteando novas solucoes...\n',salpha(j,1) ,salpha(j,2),schedule(1),schedule(2));
                j = salpha_c;
                contsort = contsort + 1;
            else               
                %fprintf('\n\tAlpha  e L1dL0 diferentes  [  %.3f   %.3f ] = [  %.3f   %.3f ]',salpha(j,1) ,salpha(j,2),schedule(1),schedule(2));
            end
        end
        if equal ==0
                salpha_c = salpha_c+1;  
                salpha(salpha_c,:) = schedule;
        end
    end
end
    
    %vb(c), optimValues.temperature(c), r,perturbacao, schedule(c), c
  %  perturbacao
%     s  = rand(c)-rand(c); % direção
%     if s <0 
%         schedule(c) = schedule(c) - perturbacao;
%     else
%         schedule(c) = schedule(c) + perturbacao;
%     end
%     
%     if schedule(c)>ub(c)
%         schedule(c) = schedule(c) - ub(c) ;
%     if schedule(c)< lb(c)
%         schedule(c) = schedule(c) + lb(c) ;

fprintf('\n Iter %d | Best F(x) %.3f | F(x)  %.3f | Temperatura %.3f | k = %d\n ',iter,best,fx,temp,k);
fprintf('\n\tValor atual: L1/L0 %.3f alpha %.3f | Novos valores: L1/L0 %.3f alpha %.3f\n-------------\n',atual(1),atual(2),schedule(1),schedule(2) )
end

