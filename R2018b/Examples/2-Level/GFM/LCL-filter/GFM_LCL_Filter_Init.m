% Grid Forming VSC with droop control strategies 

% Nominal Frequency (Hz)
fn = 50;   % Nominal frequency [Hz] 
wn = 2*pi*fn;   

% Base frequency

fb = fn;       %  Base Frequency value [Hz]            
wb = wn;       

Time_Step=50e-6; % Simulation time step [s]                 % 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Voltage Source Description  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% Nominal values  
  
    GRD00_Un = 400 * 1e3;                % Phase-to-Phase nominal AC grid Voltage [V]
    
    GRD00_Ub =  GRD00_Un;                % Base Phase-to-Phase Voltage value [V]  
    GRD00_Vb =  GRD00_Un/sqrt(3);        % Base simple Volatge value [V]    
    GRD00_Sb =  1e9;                     % Base Apparent power [VA]
    
    GRD00_Zb = GRD00_Ub^2/GRD00_Sb ;     %Base Grid Impedance  

% Short circuit impedance
 
  SCR = 20;

  GRD00_Xg_pu = 1/SCR;              % AC line reactor in per-unit [p.u]
  GRD00_Rg_pu = GRD00_Xg_pu/10;     % AC line resistance in per-unit [p.u]

  GRD00_Xg = GRD00_Xg_pu*GRD00_Zb;  % AC line reactor in SI (International System of Units) 
    
  GRD00_Lg = GRD00_Xg/wb;           % AC line inductance
  GRD00_Rg  = GRD00_Rg_pu*GRD00_Zb; % AC line resistance 
  
% Paralell impedances (sudden variation of the SCR)

  SCR_F = 1.2;                         % Short Circuit Ratio
  SCR_I = 3;                         % Short Circuit Ratio 
  
  X1_pu = 1/SCR_F;              % AC line reactor in per-unit [p.u]
  R1_pu = X1_pu/10;     % AC line resistance in per-unit [p.u]

  L_1 = X1_pu*GRD00_Zb/wb;  % AC line reactor in SI (International System of Units) 
  R_1  = R1_pu*GRD00_Zb; % AC line resistance 

  X2_pu = X1_pu/SCR_I/(X1_pu-1/SCR_I);
  R2_pu = X2_pu/10;     % AC line resistance in per-unit [p.u]

  L_2 = X2_pu*GRD00_Zb/wb;  % AC line reactor in SI (International System of Units) 
  R_2  = R2_pu*GRD00_Zb; % AC line resistance 