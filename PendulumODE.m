clc; clear all;

format long;
%the system parameters;
m = 0.3; L = 0.5; g = 9.6485;
%for simplifications
r = g/L;
k = 0.074;

%The Pendulum ODE
f =@(t,x) [x(2); -k*x(2) - r*sin(x(1))];

%initial conditions
init = [pi/11; 0];

%Solve ODE, the time interval is set from 0 to 20 seconds

[t,x] = ode45(f,[0 30],init);


%Plot the solution
ax = nexttile;
grid on; hold on;
xlabel(ax,'Time (s)');
ylabel(ax,'Amplitude');


%Dados do Experimento real:
real = dlmread('real.txt');
dx = sin(x(:,1));
%Plot 1 - Simulation vs Real Experiment
 plot(ax,t,dx,real(:,1),real(:,2),'linewidth',1.5);
 legend({'Simulação','Experimento'});

 
%Simple pendulum without any resistence:
f1 =@(t1,x1) [x1(2); -r*sin(x1(1))];


%Solve ODE, the time interval is set from 0 to 30 seconds
[t1,x1] = ode45(f1,[0 30],init);


%secondplot
ax1 = nexttile;
hold on; grid on;
plot(ax1,real(:,1),real(:,2),t1,x1(:,1),'linewidth',1.5);
legend({'Experimento','Pêndulo Simples'});
xlabel(ax1,'Time (s)');
ylabel(ax1,'Amplitude');
 
