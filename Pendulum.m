clc; clear all;

%Feito Por: Fernando Zanchitta
% Necessário instalar Image Processing Toolbox

%the system parameters;
L = 0.5; g = 9.6465;
%for simplifications
r = g/(L);
k = 0.074;

%The Pendulum ODE
f =@(t,x) [x(2); -k*x(2) - r*sin(x(1))];

%initial conditions
init = [pi/11;0];

%Solve ODE, the time interval is set from 0 to 10 seconds
[t,x] = ode45(f,[0 30],init);
%Animation
%Origin
O = [0 0];
axis(gca,'equal'); %aspect ratio of the plot
axis([-0.7 0.7 -0.7 0.2]);%The limits of the plot
grid on;

%button



%loop for animation
for i = 1:length(t)
    %mass point
    P = L*[sin(x(i)) -cos(x(i))];
    % Circle in origin
    O_circ = viscircles(O,0.01);
    %pendulum 
    pend = line([O(2) P(1)], [O(1) P(2)]);
    %Ball
    ball = viscircles(P,0.03,'Color','r','LineWidth',2);
    
    %Time interval to update the plot
    pause(0.001);
    
    %delete the previous objects if it is not the final loop
    if i<length(t)
        delete(pend);
        delete(ball);
        delete(O_circ);
    end
end
    
    