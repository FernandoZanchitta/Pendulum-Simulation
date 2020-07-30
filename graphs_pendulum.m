clc;format long;
buttonPlot();

function [t,x] = pendulum_eq(b,L)
    m = 0.22; g = 9.6486;
    
    %for simplifications
    r = g/L;
    k = 0.074; %obtido no experimento

    %The Pendulum ODE
    f =@(t,x) [x(2); -k*x(2) - r*sin(x(1))];

    %initial conditions
    init = [b; 0];

    %Solve ODE, the time interval is set from 0 to 20 seconds
    [t,x] = ode45(f,[0 30],init);
end



function buttonPlot


% Create a figure window
fig = uifigure;


% Create a UI axes
 ax = uiaxes('Parent',fig,...
             'Units','pixels',...
             'Position', [104, 123, 300, 201]);
         
         
%Create slider for parameters
%fio
 s_l = uislider(fig);
 s_l.Value = 0.25;
 s_l.Limits = [0.25 1.5];
 s_l.Position = [100 100 150 3];
 
 
 
%Angulo inicial
s_b = uislider(fig);
s_b.Value = 0.074;
s_b.Limits = [0 1.5];
s_b.Position = [100 50 150 3];


% s_l.Tag = 'b';
[t,x] = pendulum_eq(s_b.Value,s_l.Value);

% Create a push button
btn1 = uibutton(fig,'push',...
               'Position',[420, 250, 100, 22],...
               'ButtonPushedFcn', @(btn1,event) plotButtonPushed(btn1,ax,x,t));
btn1.Text = 'Resetar';


%Change in Values
s_l.ValueChangedFcn = @(s_l,event) change_value(btn1,s_b.Value,s_l.Value,ax);
s_b.ValueChangedFcn = @(s_b,event) change_value(btn1,s_b.Value,s_l.Value,ax);
[t,x] = pendulum_eq(s_b.Value,s_l.Value);
end


% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(btn1,ax,x,t)
    %Plot the solution
%     grid on; hold on;
    real = dlmread('real.txt');
    plot(ax,t,x(:,1),real(:,1),real(:,2)); 
end


function change_value(btn1,b,l,ax)
[t,x] = pendulum_eq(b,l);
plotButtonPushed(btn1,ax,x,t);
end