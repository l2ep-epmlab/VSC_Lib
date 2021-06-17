% Grid Forming VSC with droop control strategies 

Time_Step=50e-6; % Simulation time step (s) 

fb = 50; % Nominal Frequency (Hz)
Ug = 400e3; % Nominal Grid Voltage (V)

%% Grid Parameters
    wb = 2*pi*fb;
% Nominal values  
  
    GRD00_Un = Ug;                % Phase-to-Phase nominal AC grid Voltage [V]
    
    GRD00_Ub =  GRD00_Un;                % Base Phase-to-Phase Voltage value [V]  
    GRD00_Vb =  GRD00_Un/sqrt(3);        % Base simple Volatge value [V]    
    GRD00_Sb =  1e9;                     % Base Apparent power [VA]
    
    GRD00_Zb = GRD00_Ub^2/GRD00_Sb ;     %Base Grid Impedance  

  % Short circuit impedance
 
  SCR = 20;                         % Short Circuit Ratio
  GRD00_Xg_pu = 1/SCR;              % AC line reactor in per-unit [p.u]
  GRD00_Rg_pu = GRD00_Xg_pu/10;     % AC line resistance in per-unit [p.u]
         
  GRD00_Xg = GRD00_Xg_pu*GRD00_Zb;  % AC line reactor in SI (International System of Units) 
    
  GRD00_Lg = GRD00_Xg/wb;           % AC line inductance
  GRD00_Rg  = GRD00_Rg_pu*GRD00_Zb; % AC line resistance 

%%
  % Strategy  1
    VSC01_mp1 = 0.0043;         % gain of the power loop 
    VSC01_wc1 = wb/10;          % low-pass  filter  cut-frequency 