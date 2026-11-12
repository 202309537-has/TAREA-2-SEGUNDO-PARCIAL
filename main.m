function main
close all
f=figure('Name','Tarea 2 - Robot 2D','Position',[150 150 850 510]);
ax=axes('Parent',f,'Units','pixels','Position',[285 80 530 385]);

uicontrol('Style','text','Position',[20 460 160 25],'String','CINEMATICA INVERSA','FontWeight','bold');
uicontrol('Style','text','Position',[20 425 90 20],'String','Longitud L1');
eL1=uicontrol('Style','edit','Position',[115 425 75 25],'String','5');
uicontrol('Style','text','Position',[20 390 90 20],'String','Longitud L2');
eL2=uicontrol('Style','edit','Position',[115 390 75 25],'String','4');
uicontrol('Style','text','Position',[20 380 90 20],'String','Altura H');
eH=uicontrol('Style','edit','Position',[115 380 75 25],'String','3');

uicontrol('Style','text','Position',[20 335 90 20],'String','Objetivo X');
eX=uicontrol('Style','edit','Position',[115 335 75 25],'String','6');
uicontrol('Style','text','Position',[20 300 90 20],'String','Objetivo Y');
eY=uicontrol('Style','edit','Position',[115 300 75 25],'String','6');

uicontrol('Style','text','Position',[20 260 90 20],'String','Configuracion');
eC=uicontrol('Style','popupmenu','Position',[115 260 140 25],...
    'String',{'Codo arriba','Codo abajo'});

uicontrol('Style','pushbutton','Position',[40 205 160 35],...
    'String','Mover brazo','Callback',@Mover);
resultado=uicontrol('Style','text','Position',[20 100 240 90],...
    'String','Introduce los datos y pulsa Mover','HorizontalAlignment','left');
uicontrol('Style','text','Position',[20 50 235 35],...
    'String','El punto se mide desde el suelo; la base esta en (0,H).','HorizontalAlignment','left');

q1=0; q2=0;
DibujarBrazo(ax,CalculaPuntos(5,4,0,0,3),9,3);

    function Mover(~,~)
        L1=str2double(get(eL1,'String'));
        L2=str2double(get(eL2,'String'));
        x=str2double(get(eX,'String'));
        y=str2double(get(eY,'String'));
        H=str2double(get(eH,'String'));
        codo=get(eC,'Value');

        if ~all(isfinite([L1 L2 x y])) || L1<=0 || L2<=0 || ~isfinite(H) || H<0
            set(resultado,'String','Error: revisa las longitudes y los datos.');
            return
        end

        % Candado: radio exterior e interior de alcance
        r=sqrt(x^2+(y-H)^2);
        if r>L1+L2 || r<abs(L1-L2)
            set(resultado,'String','Punto fuera del area de alcance.');
            return
        end

        [a1,a2,ok]=CalcularAngulos(L1,L2,x,y-H,codo);
        if ~ok
            set(resultado,'String','No se pueden calcular los angulos.');
            return
        end

        inicio1=q1; inicio2=q2;
        for i=1:30
            t1=inicio1+(a1-inicio1)*i/30;
            t2=inicio2+(a2-inicio2)*i/30;
            P=CalculaPuntos(L1,L2,t1,t2,H);
            DibujarBrazo(ax,P,L1+L2,H);
            drawnow
            pause(0.02)
        end
        q1=a1; q2=a2;
        set(resultado,'String',sprintf('Theta 1 = %.2f grados\nTheta 2 = %.2f grados\nX = %.2f, Y = %.2f',a1*180/pi,a2*180/pi,P(1,3),P(2,3)));
    end
end
