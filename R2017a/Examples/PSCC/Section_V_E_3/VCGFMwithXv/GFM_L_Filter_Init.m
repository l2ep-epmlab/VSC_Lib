% Grid Forming VSC with droop control strategies 

Time_Step2=50e-6; % Simulation time step (s) 
Time_Step= Time_Step2;
fb = 50; % Nominal Frequency (Hz)
Ug = 400e3; % Nominal Grid Voltage (V)

SimStart = 1;
Start = 0.3;
dur1 = 0.2;
dur2 = 3;
egfault = 0.1;
Simulation_Time = 5;


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
  SCR2 = 5;                         % Short Circuit Ratio
  GRD00_Xg_pu2 = 1/SCR2;              % AC line reactor in per-unit [p.u]
  GRD00_Rg_pu2 = GRD00_Xg_pu2/10;     % AC line resistance in per-unit [p.u]
         
  GRD00_Xg2 = GRD00_Xg_pu2*GRD00_Zb;  % AC line reactor in SI (International System of Units) 
    
  GRD00_Lg2 = GRD00_Xg2/wb;           % AC line inductance
  GRD00_Rg2  = GRD00_Rg_pu2*GRD00_Zb; % AC line resistance 
%%
  % Strategy  1
    VSC01_mp1 = 0.0043;         % gain of the power loop 
    VSC01_wc1 = wb/10;          % low-pass  filter  cut-frequency 
    
    
      
U_dcn = 640e3;          % DC voltage
Un_VSC = 320e3;            % Converter side voltage

Pn_conv = GRD00_Sb;           % Nominal active power 
Sn_conv = GRD00_Sb;           % Nominal apparent power 

Lc_pu = 0.15;           % per unit in grid base
Rc_pu = Lc_pu/10; 

Enable_Lv = 0;

Lc_virt = (0.15-Lc_pu)*Enable_Lv;

Ub_VSC = Un_VSC;
Zb_VSC = Ub_VSC^2/GRD00_Sb ;     %Base Grid Impedance  
Cb_VSC = 1/(Zb_VSC*wb);
Lb_VSC = Zb_VSC/wb;



Cf_pu = 0.066;
Lf_pu = Lc_pu;
Rf_pu = 0;



n=1;m=-1;

% damping resistance: only usefull for VC grid forming

% Rv_GFM = 0.09 ; % -0.03 for both VC % 0 for both CC -0.4 for CC - sequence and VC for + sequence
% Rv_DVC = -0.2; % 0.2 for both CC % 0 bor both VC % 0 for CC - sequence and VC for + sequence
W_TVR = 60;

 %% Current control
 
 % Filter time constant 
 Tau_f = 0.01;

 % Pole placement method 
  Trp = 1*1e-3;

wn_cc = 1200;
Ki_cc_cp = wn_cc*Rc_pu; 
Kp_cc_cp = wn_cc*Lc_pu/wb; 
   
