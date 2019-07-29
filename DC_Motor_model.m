%% Variables:

J = 0.01;   %% (J)  = moment of inertia of the rotor in kg.m^2
Kb = 0.01;  %% (Kb) = back EMF Constant/ genaric electric constant(V*s)/rad
Kf = 0.1;   %% (Kf) = motor viscous friction constant in N.m.s
Km = 0.01;  %% (Km) = motor constant, sometimes called motorsize constant
            %%        Km = N*m/sqrt (W)
L = 0.5;    %% (L)  = electrical inductance in H
R = 1;      %% (R)  = electrical resistance in Ohms
%% Not used Current i sub a generates a torque . 

%% References https://en.wikipedia.org/wiki/Motor_constants
%%            http://www.cs.mun.ca/av/old/teaching/cs/notes/motors_quad.pdf
%%            http://ctms.engin.umich.edu/CTMS/index.php?example=MotorSpeed&section=SystemModeling
%% SISO (Single Input Single Output) state-space model of DC Motor.
%% d/dt [w/i] = [-Kf/j Km/j; -Kb/L -R/L]*[W/i]+[0; 1/L]*v 
%% where w is angular velocity 
%% y = [1 0]*[w/i\+[0]*v

%% applied voltage "v" is the input.
%% Shaft speed w, is the output. 
%% Current i and shaft speed w are the two states

A = [-Kf/J Km/J; -Kb/L -R/L];
B = [0; 1/L];
C = [1 0];
D = 0;

motor = ss(A, B, C, D,...
    'InputName','v', 'OutputName','y', 'StateName', {'w','i'})
amp = tf(5,[1/1000 1]) %% applies a gain of 5, and a bandwidth 1000 radians/ second

plant = motor * amp;
plant.StateName{3} = 'x3'
%% (first method of stability analysis)
%% pole(plant) %% uncomment to run a pole stability, negative values 
%%      indicate a stable plant. 
%%
%% second method of analizing stability
%% isstable(plant) %% command returns ans= 1 if the system is stable,
%%      returns 0 if not stable. 

%% step(plant) %% Graphs step response (time, amplitude). Right click graph
%%      and enable "charicteristics" and "setting time"

%% run DC_Motor_model.m %% Program execute command
