function schedule = discrete_annealing( optimValues,problem )
%DISCRETE_ANNEALING Summary of this function goes here
%   Detailed explanation goes here


schedule = optimValues.x;


    % Limites para a geometria
     % L1dL0      0.001:1.00 
     % alfa         1.00:1.57
     
%     lb = [0.001 1.00]; 
%     lu = [1 1.57];

  vb = [0.001 0.01];
 
for c = 1:1:2;
    r = floor(10*rand());
    %perturbacao = r*vb(c)*optimValues.temperature(c);
    perturbacao = r*vb(c);
    if c<2
    fprintf('\n\tPertubação L1/L0 = %.6f',perturbacao);
    else
         fprintf('\n\tPertubação Alpha = %.6f',perturbacao);
    end
    %vb(c), optimValues.temperature(c), r,perturbacao, schedule(c), c
  %  perturbacao
    s  = rand(c)-rand(c); % direção
    if s <0 
        schedule(c) = schedule(c) - perturbacao;
    else
        schedule(c) = schedule(c) + perturbacao;
    end
%     
%     if schedule(c)>ub(c)
%         schedule(c) = schedule(c) - ub(c) ;
%     if schedule(c)< lb(c)
%         schedule(c) = schedule(c) + lb(c) ;
end
iter = optimValues.iteration;
temp = optimValues.temperature(1);
best= optimValues.bestfval;
fx = optimValues.fval;
% fprintf('\n Iter %d | Best F(x) %.3f | F(x)  %.3f | Temperatura %.3f ',iter,best,fx,temp);
fprintf('\n\tValor atual: L1/L0 %.3f alpha %.3f | Novos valores: L1/L0 %.3f alpha %.3f\n-------------\n',optimValues.x(1),optimValues.x(2),schedule(1),schedule(2) )
end

