% Adelr Equation analysis
% Shay Kricheli

clc; clear;
t0 = 0;
time_series = 0:0.1:100; 

for B = 3:5
    RunAdler(B, time_series,t0)
end

function RunAdler (B, time_series, t0)
    AdlerPlotter (10, -1 , 2 , time_series , t0, B, 1);
    AdlerPlotter (2, -0.1 , 1.2 , time_series , t0, B, 2);
    AdlerPlotter (1.1, -0.01 , 1.02 , time_series , t0, B, 3);
    AdlerPlotter (1.01, -0.001 , 1.002 , time_series , t0, B, 4);
    AdlerPlotter (1.001, -0.0001 , 1.0002 , time_series , t0, B, 5);
    AdlerPlotter (1.0001, -0.00001 , 1.00002 , time_series , t0, B, 6);
end

function AdlerPlotter (start, jump , final, t, t0, B, iteration)

    l = 1;
    for K = start:jump: final
        eta = (K^2 - 1)^(0.5);
        AdlerSol{l} = 2*atan(1/K + eta/K*tan(eta*B*(t-t0)/2));
        subplot(3,3,l);
        plot(t,AdlerSol{l});
        axis([0 100 -5 5]);
        xL = xlim; yL = ylim;
        line(xL, [0 0], 'Color','black');
        line([0 0], yL , 'Color','black');
        grid;
        h = ylabel('$\phi (t)$'); set(h,'Interpreter','latex');
        h = xlabel('$t$'); set(h,'Interpreter','latex');
        set(gca,'fontsize',16);
        l = l + 1;
    end
    print(strcat ('TimeDomain',num2str(iteration),'B',num2str(B)),'-djpeg') % save photo
    clf;
    for v = 1:l-1
        FourierAdler = fft(AdlerSol{v});
        omega = (0:length(FourierAdler)-1)*20/length(FourierAdler);
        subplot(3,3,v);
        plot(omega,abs(FourierAdler),'r',omega+20*ones(1,1001),abs(FourierAdler),'r')
        axis([15 25 0 40]);
        grid;
        h = ylabel('$K (\omega)$'); set(h,'Interpreter','latex');
        h = xlabel('$\omega$'); set(h,'Interpreter','latex');
        set(gca,'fontsize',16);
    end
    print(strcat ('FreqDomain',num2str(iteration),'B',num2str(B)),'-djpeg') % save photo
end