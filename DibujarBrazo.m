function DibujarBrazo(ax,P,L,H)
axes(ax)
cla
hold on
Dibujaejes(L,H);
plot(P(1,:),P(2,:),'-o','LineWidth',4,'MarkerSize',8);
plot(0,H,'ks','MarkerFaceColor','k','MarkerSize',10);
xlim([-L L])
ylim([min(-L,H-L) max(L,H+L)])
title('Brazo de dos eslabones')
hold off
end
