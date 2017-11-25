% Plot profiles
load pressure_displacement_profiles

% Plot initial -Cp and shape
fig1=figure;
[axe,hline1,hline2] = plotyy(initial.x,-initial.cp,optimal.x,-optimal.cp);
set(hline1, 'LineWidth', 2, 'LineStyle', '-', 'Color', 'k');
set(hline2, 'LineWidth', 2, 'LineStyle', '--', 'Color', 'k');

% Plot optimal -Cp and shape
hold(axe(1));
plot(initial.x,-initial.cp,'k-','LineWidth',2);
hold(axe(2));
plot(optimal.x,optimal.disp,'k--','LineWidth',2);
% Set up legend, labels, etc.
legend('Initial(cp)','Initial(Shape)','Optimal(cp)','Optimal(Shape)');
set(axe(1), 'yTick', -1.2:0.2:1);
set(axe(2), 'yTick', -0.1:0.1:0.6);
ylabel(axe(1), '-cp');
ylabel(axe(2), 'Distance transverse to airfoil');
xlabel("Distance along airfoil");

% Plot initial and optimal shapes only
fig2 = figure;
[axe,hline1,hline2] = plotyy(initial.x,initial.disp,optimal.x,optimal.disp);
set(hline1, 'LineWidth', 2, 'LineStyle', '-', 'Color', 'k');
set(hline2, 'LineWidth', 2, 'LineStyle', '--', 'Color', 'k');
legend('Initial(Shape)','Optimal(Shape)');

% Save to eps and use fixPS
print(fig1,'-depsc2','Hwk1Prob3_starter1');
print(fig2,'-depsc2','Hwk1Prob3_starter2');
