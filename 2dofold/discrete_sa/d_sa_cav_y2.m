function [x,fval,exitflag,output] = d_sa_cav_y2(fun,x0,d,s,rs,optValue)
% This is an auto generated MATLAB file from Optimization Tool.
global options
global tmax_min;
global n_iter;
% Start with the default options
options = saoptimset;
% Modify options setting
options = saoptimset(options,'Display', 'diagnose');
options = saoptimset(options,'DisplayInterval',d);
options = saoptimset(options,'StallIterLimit',s);
options = saoptimset(options,'TemperatureFcn',@tempboltzexp);
options = saoptimset(options,'ObjectiveLimit',optValue);
options = saoptimset(options,'DataType','custom');
options = saoptimset(options,'InitialTemperature',[100 100]);
options = saoptimset(options,'AnnealingFcn',@d_annealing_c2);
options = saoptimset(options,'ReannealInterval ',rs);
options = saoptimset(options,'AcceptanceFcn ',@acceptancesa);

[x,fval,exitflag,output] = ...
simulannealbnd(fun,x0,[],[],options);

tmax_min = fval;
n_iter = output.iterations;
