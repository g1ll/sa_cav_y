
function saida= cav_y(vet_4_dof)

%Entrada vet_4_dof : Vetor com valores para quatro graus de liberdade [ HdL L1dL0  t1dt0]


HdL  = vet_4_dof(1);
L1dL0 = vet_4_dof(2);
t1dt0 = vet_4_dof(3);
alfa1 = vet_4_dof(4);

%global parciais;
global fi;
global psi;

% x=1.41;
% HdL = 1.0;
% t1dt0 = 4.0;
% L1dL0 = 0.001;
% alfa1 = x;
%L1dL0 = x(2);


L = (1/HdL)^0.5;
H = HdL*L;
Ld2 = L/2;

%alfa = 0.925;
% resolvendo o sistema de eq. algebricas nao linear
% chutando t0
for t0=0.000001:0.000001:2
L0 = (fi-t0^2*(t1dt0*cos(alfa1)-sin(alfa1)*cos(alfa1)))/(t0*(L1dL0*t1dt0+2));
eq = 1/(t1dt0)*(psi/(L1dL0*L0+L0*sin(alfa1)+t0*cos(alfa1))-2*L0*cos(alfa1))-t0;
b = abs(eq);
if b < 0.00001
   break
   end
end
b;
L1 = L1dL0 * L0;
L0;
t1 = t1dt0 * t0;
t0;
t1d2 = t1/2;
x1 = t1d2;
x3 = x1 + L0 * cos(alfa1);
y3 = L1 + L0 * sin(alfa1);
x4 = x3 - t0 * sin(alfa1);
y4 = y3 + t0 * cos(alfa1);
y5 = L1 + t0 * cos(alfa1);
x5 = x1 - t0 * sin(alfa1);

%teste para ver se angulo < pi/2

if (alfa1>(pi/2))
    saida = inf;
    return;
end
%teste para ver se n�o ocorre repeti��o de graus de liberdade
% nlinhas = size(parciais, 1);
% for i=1:nlinhas
%     if ([alfa1 L1dL0 t1dt0 HdL psi fi] == parciais(i, 3:end))
%         saida = parciais(i,2);
%         return;
%     end
% end

    [pde_fig,ax]=pdeinitGA;
    pdetoolGA('appl_cb',9);
    set(ax,'DataAspectRatio',[1 1 1]);
    set(ax,'PlotBoxAspectRatio',[1.5 1 1]);
    set(ax,'XLim',[-1.0 1.0]);
    set(ax,'YLim',[-0.5 2.5]);
    set(ax,'XTickMode','auto');
    set(ax,'YTickMode','auto');

    % Geometry description:
    pdepoly([x1,...
     x1,...
     x3,...
     x4,...
     x5,...
     -x5,...
     -x4,...
     -x3,...
     -x1,...
     -x1,...
     -Ld2,...
     -Ld2,...
     Ld2,...
     Ld2,...
    ],...
    [ 0,...
     L1,...
     y3,...
     y4,...
     y5,...
     y5,...
     y4,...
     y3,...
     L1,...
     0,...
     0,...
     H,...
     H,...
     0,...
    ],...
     'P1');
    set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','P1')


    % Boundary conditions:
    pdetoolGA('changemode',0)
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
    pdetoolGA('initmesh')
    pdetoolGA('refine')
    pdetoolGA('refine')
    pdetoolGA('refine')
    pdetoolGA('jiggle')

    % PDE coefficients:
    pdeseteq(1,...
    '1.0',...
    '0.0',...
    '(1.0)+(0.0).*(0.0)',...
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
    '0.0';...
    '0.0'])

    % Solve parameters:
    setappdata(pde_fig,'solveparam',...
    char('0','20256','10','pdeadworst',...
    '0.5','longest','0','1E-4','','fixed','Inf'))

    % Plotflags and user data strings:
    setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 7 1 0 0 0 1 1 0 0 0 0 1]);
    setappdata(pde_fig,'colstring','');
    setappdata(pde_fig,'arrowstring','');
    setappdata(pde_fig,'deformstring','');
    setappdata(pde_fig,'heightstring','');

    % Solve PDE:
    pdetoolGA('solve')
    T=get(findobj(get(pde_fig,'Children'),'flat','Tag','PDEPlotMenu'),...
            'UserData');

    Tmax = max(T);
    saida = Tmax;    
    pdetoolGA('exit');