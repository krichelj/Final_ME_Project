% Beam’s Complete Vibration analysis
% Shay Kricheli, 2018

clc; clear;
Q = 100; %quality factor
zeta = 1/(2*Q); %damping ratio
open_system('duffing_simulation.slx'); % open the simulink model
tau = 1000; % run time
gamma = 1/(4*Q); %control effort
K = 0; % driving amplitude
sim = sim('duffing_simulation','StartTime','0','StopTime',num2str(tau)); %perform the simulation
T = sim.get('T');
T_dot = sim.get('T_dot');

s = 0:0.001:4.75;
X = @(s)(0.618*(sin(s)-sinh(s))-0.629*(cos(s)-cosh(s)));
Y = X(s);


plot(linspace(0,tau,size(T,1)),T(:,1));
grid;
axis tight;
h = ylabel('$T (\tau)$'); set(h,'Interpreter','latex');
h = xlabel('$\tau$'); set(h,'Interpreter','latex');
set(gca,'fontsize',22);
pbaspect([2 1 1]);

plot(T(:,1),T_dot(:,1));
grid;
axis tight;
h = ylabel('$\frac{dT(\tau)}{d\tau}$'); set(h,'Interpreter','latex');
h = xlabel('$T (\tau)$'); set(h,'Interpreter','latex');
set(gca,'fontsize',22);
pbaspect([1 1 1]);

filename = 'testAnimated.gif';
h = figure;
set(h,'color','white');
 for timeIndex=9700:size(T,1)
%      plot3(s,zeros(1,4751),Y*T(timeIndex));
     plot(s, Y*T(timeIndex));
     grid; 
     axis([0 4.75 -0.5 0.5]);
     hh = ylabel('$u(s,\tau)$'); set(hh,'Interpreter','latex');
     hh = xlabel('$s$'); set(hh,'Interpreter','latex');
     drawnow;
     frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 

      % Write to the GIF File 
      if timeIndex == 9700 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.1); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1); 
      end 
     
 end

for i=1:6
    subplot(3,2,i);
    if (i<4)
        plot(s, Y*T(9902+3*(i-1)));
    elseif (i==4)
        plot(s, Y*T(9914));
    elseif (i==5)
        plot(s, Y*T(9926));
    else
        plot(s, Y*T(9929));
    end
    axis([0 4.75 -0.5 0.5]);
    grid;
    set(gca,'fontsize',22);
    h = ylabel('$u_1 (s,\tau)$'); set(h,'Interpreter','latex');
    h = xlabel('$s$'); set(h,'Interpreter','latex');
%     pbaspect([1 2 2]);
end
