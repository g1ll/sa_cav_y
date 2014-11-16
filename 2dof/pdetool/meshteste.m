function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',9);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[1.3333333333333333 1 1.3333333333333333]);
set(ax,'XLim',[-1 1]);
set(ax,'YLim',[0 1.5]);
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

% Geometry description:
pdepoly([ 0.030637999999999999,...
 0.030637999999999999,...
 0.34723876255656111,...
 0.32249679747634924,...
 0.0058960349197881116,...
 -0.0058960349197881116,...
 -0.32249679747634924,...
 -0.34723876255656111,...
 -0.030637999999999999,...
 -0.030637999999999999,...
 -0.5,...
 -0.5,...
 0.5,...
 0.5,...
],...
[ 0,...
 0.26840216240391401,...
 0.70190284323497354,...
 0.71997276874587635,...
 0.28647208791481682,...
 0.28647208791481682,...
 0.71997276874587635,...
 0.70190284323497354,...
 0.26840216240391401,...
 0,...
 0,...
 1,...
 1,...
 0,...
],...
 'P1');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','P1')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(14,...
'neu',...
1,...
'0',...
'0')
pdesetbd(13,...
'neu',...
1,...
'0',...
'0')
pdesetbd(12,...
'neu',...
1,...
'0',...
'0')
pdesetbd(11,...
'neu',...
1,...
'0',...
'0')
pdesetbd(10,...
'neu',...
1,...
'0',...
'0')
pdesetbd(9,...
'dir',...
1,...
'1',...
'0')
pdesetbd(8,...
'dir',...
1,...
'1',...
'0')
pdesetbd(7,...
'dir',...
1,...
'1',...
'0')
pdesetbd(6,...
'dir',...
1,...
'1',...
'0')
pdesetbd(5,...
'dir',...
1,...
'1',...
'0')
pdesetbd(4,...
'dir',...
1,...
'1',...
'0')
pdesetbd(3,...
'dir',...
1,...
'1',...
'0')
pdesetbd(2,...
'dir',...
1,...
'1',...
'0')
pdesetbd(1,...
'dir',...
1,...
'1',...
'0')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
pdetool('initmesh')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'1.0',...
'(1.0)+(1.0).*(0.0)',...
'(1.0).*(1.0)',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0';...
'1.0';...
'1.0';...
'1.0';...
'1.0';...
'0.0'])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');
