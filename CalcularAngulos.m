function [t1,t2,ok]=CalcularAngulos(L1,L2,x,y,codo)
r2=x^2+y^2;
c=(r2-L1^2-L2^2)/(2*L1*L2);
ok=(L1>0 && L2>0 && abs(c)<=1);
t1=0; t2=0;
if ~ok
    return
end
if codo==1
    t2=acos(c);
else
    t2=-acos(c);
end
t1=atan2(y,x)-atan2(L2*sin(t2),L1+L2*cos(t2));
end
