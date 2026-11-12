function P=CalculaPuntos(L1,L2,t1,t2,H)
x1=L1*cos(t1);
y1=H+L1*sin(t1);
x2=x1+L2*cos(t1+t2);
y2=y1+L2*sin(t1+t2);
P=[0 x1 x2;H y1 y2];
end
