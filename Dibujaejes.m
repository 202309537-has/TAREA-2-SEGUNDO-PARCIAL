function Dibujaejes(L,H)
line([-L L],[0 0],'Color','k','LineWidth',1);
line([0 0],[-L L]+H,'Color','k','LineWidth',1);
xlabel('X')
ylabel('Y')
grid on
axis equal
end
