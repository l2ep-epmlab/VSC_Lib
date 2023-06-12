%% Grid Forming VSC with droop control strategies 

Time_Step=10e-6; % Simulation time step (s) 

fb = 50; % Nominal Frequency (Hz)
Ug = 400e3; % Nominal Grid Voltage (V)

%% Grid Parameters
    wb = 2*pi*fb;
    
% Nominal values  
  
    Un = Ug;           % Phase-to-Phase nominal AC grid Voltage [V]  
    Ub = Un;           % Base Phase-to-Phase Voltage value [V]  
    Vb = Un/sqrt(3);   % Base simple Volatge value [V]    
    Sb = 1e9;          % Base Apparent power [VA]  
    Zb = Ub^2/Sb ;     % Base Grid Impedance  

% Short circuit impedance

    X_pu = 0.15;      % AC filter reactor in per-unit [p.u]
    R_pu = 0.005;     % AC filter resistance in per-unit [p.u]
    X    = X_pu*Zb;  % AC filter reactor in SI (International System of Units) 
    L    = X/wb;     % AC filter inductance
    R    = R_pu*Zb;  % AC filter resistance 