function [x,fval,exitflag,output] = sa_cavt(fun,x0,lb,ub,d,s)
% This is an auto generated MATLAB file from Optimization Tool.

% Start with the default options
options = saoptimset;
% Modify options setting
options = saoptimset(options,'Display', 'diagnose','DisplayInterval',d,'StallIterLimit',s);
[x,fval,exitflag,output] = ...
simulannealbnd(fun,x0,lb,ub,options);
