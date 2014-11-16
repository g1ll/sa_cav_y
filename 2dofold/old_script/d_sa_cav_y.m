function [x,fval,exitflag,output] = d_sa_cav_y(fun,x0,d,s,optValue)
% This is an auto generated MATLAB file from Optimization Tool.
global options
% Start with the default options
options = saoptimset;
% Modify options setting
options = saoptimset(options,'Display', 'diagnose','DisplayInterval',d,'StallIterLimit',s,'TemperatureFcn',@temperatureexp,'ObjectiveLimit',optValue,'DataType','custom','AnnealingFcn',@discrete_annealing);
[x,fval,exitflag,output] = ...
simulannealbnd(fun,x0,[],[],options);
