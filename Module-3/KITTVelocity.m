%Module 3 EPO4 A05 2020-2021
%Car physics and dynamics

%constants:
m=13; %kg
b=0.0015; %Nm^-1s
c=0.02 %Nm^-2s^2
Fa_max = 80; %N
Fb_max = 120; %N

plot(out.simout.time, out.simout.signals.values)
legend('Velocity');
title('Velocity versus time for a Simulink defined KITT car starting at v=1 m/s');
xlabel('time(s)');
ylabel('velocity(m/s)');