% Grid Forming VSC with droop control strategies 

Time_Step2=25e-6; % Simulation time step (s) 
Time_Step= Time_Step2;
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
    
    % Nominal values  
  
    GRD01_Un = 20e3;                % Phase-to-Phase nominal AC grid Voltage [V]
    
    GRD01_Ub =  GRD01_Un;                % Base Phase-to-Phase Voltage value [V]  
    GRD01_Vb =  GRD01_Un/sqrt(3);        % Base simple Volatge value [V]    
    GRD01_Sb =  100e6;                     % Base Apparent power [VA]
    
    GRD01_Zb = GRD01_Ub^2/GRD01_Sb ;     %Base Grid Impedance  

  % Short circuit impedance
 
  SCR = 20;                         % Short Circuit Ratio
  GRD01_Xg_pu = 1/SCR;              % AC line reactor in per-unit [p.u]
  GRD01_Rg_pu = GRD01_Xg_pu/1;     % AC line resistance in per-unit [p.u]
         
  GRD01_Xg = GRD01_Xg_pu*GRD01_Zb;  % AC line reactor in SI (International System of Units) 
   
  GRD01_Lg = GRD01_Xg/wb;           % AC line inductance
  GRD01_Rg  = GRD01_Rg_pu*GRD01_Zb; % AC line resistance 

%%
  % Strategy  1
    VSC01_mp1 = 0.0043;         % gain of the power loop 
    VSC01_wc1 = wb/10;          % low-pass  filter  cut-frequency 