% Beam Spatial Function analysis
% Shay Kricheli, 2018
clc; clear;
s = 0:0.001:4.75;
X_1 = @(s)(0.618*(sin(s)-sinh(s))-0.629*(cos(s)-cosh(s)));
plot(s, X_1(s));
grid;
axis tight;
h = ylabel('$X(s)$'); set(h,'Interpreter','latex');
h = xlabel('$s$'); set(h,'Interpreter','latex');
set(gca,'fontsize',24);