% Grid Forming VSC with droop control strategies 

% Nominal Frequency (Hz)
fn = 50;   % Nominal frequency [Hz] 
wn = 2*pi*fn;   

% Base frequency

fb = fn;       %  Base Frequency value [Hz]            
wb = wn;       

Time_Step=40e-6; % Simulation time step [s]                 % 

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
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Voltage Source Control Parameters  ------------------------------------------------

  
  GRD00_R = 4/100;          % Droop value frequency support
  GRD00_H= 5;               % equivalent inertia
  
  GRD00_TN = 1;             % Lead Time constant
  GRD00_TD = 6;             % Lag Time constant
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VSC01 Description 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nominal values 

    VSC01_Pn = 1000 * 1e6;                                  % Nom. VSC power [W]  
    VSC01_tan_phi_n = 0;                                    % max tan_phi for the nominal active power
    VSC01_cosPhi_n = cos(atan(VSC01_tan_phi_n));            % Nom. cos(phi)
    VSC01_Sn = VSC01_Pn/VSC01_cosPhi_n;
    VSC01_Un1 = 320 * 1e3;                                  % Nom. phase-to-phase VSC voltage [V]
    VSC01_Vn1 = 320 * 1e3/sqrt(3);
    VSC01_Un2 = 400 * 1e3;                                  % Nom. phase-to-phase grid voltage [V]
    VSC01_Vn2 = 400 * 1e3/sqrt(3);
    VSC01_Udc_n = 640 * 1e3;                                % Nom. DC voltage[V]
    VSC01_ratio = VSC01_Un1/VSC01_Un2;                      % Transformer Ratio
    
    
 %% Base values
    
    VSC01_Pb =      VSC01_Pn;           % Active Power base value  [W]                                
    VSC01_Sb =      VSC01_Sn;           % Apparent Power base value  [VA]
    VSC01_Vb1 =     VSC01_Vn1;          % AC Voltage base value  [V]                         
    VSC01_Udcb =    VSC01_Udc_n;        % DC voltage base value [V]   
    
     
    VSC01_Ib =      VSC01_Sb / (3* VSC01_Vb1);          % AC Current base value  
    VSC01_Zb =      (VSC01_Vb1*sqrt(3))^2 / VSC01_Sb;   % Impedance base value
    VSC01_Lb =      VSC01_Zb / wb;                      % Inductance base value
    VSC01_Cb =      1/(  VSC01_Zb*wb);

    %% Filter parameters
    
    VSC01_Rf_pu = 0.005;                  
    VSC01_Lf_pu = 0.15;                     
    VSC01_Cf_pu = 0.066;                    

    % Values in SI
    VSC01_Rf = VSC01_Rf_pu * VSC01_Zb;      % Transformer resistance [S.I]
    VSC01_Lf = VSC01_Lf_pu * VSC01_Lb;      % Transformer inductance [S.I]
    VSC01_Cf = VSC01_Cf_pu * VSC01_Cb;      % Transformer inductance [S.I]

    %% Transformer parameters
    
    VSC01_Rt_pu = 0.005;                    % Transformer resistance [p.u]
    VSC01_Lt_pu = 0.15;                     % Transformer inductance [p.u]
    
    % Transformer Values in SI
    VSC01_Rt = VSC01_Rt_pu * VSC01_Zb;      % Transformer resistance [S.I]
    VSC01_Lt = VSC01_Lt_pu * VSC01_Lb;      % Transformer inductance [S.I]
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VSC01 Control Parameters  ------------------------------------------------

% Transient Virtual Resistor (Active high-pass Filter) %%
    VSC01_Rv = 0.09;            % Gain of TVR      
    VSC01_W_LF = 60;            %  The  high-pass  filter  cut-frequency          

% Strategy  1
    VSC01_mp1 = 0.0043;         % gain of the power loop 
    VSC01_wc1 = wb/10;          % low-pass  filter  cut-frequency    

% Strategy  2
    VSC01_mp2 = 0.003;         % gain of the power loop 
    VSC01_wc2 = 33.3;           % low-pass  filter  cut-frequency 

% Strategy  3
    VSC01_mp3 = 0.04;           % gain of the power loop / droop parameter
    VSC01_wc3 = 2.5;            % low-pass  filter  cut-frequency
    
    VSC01_T1 = 0.121;           % Lead Lag parameters
    VSC01_T2 = 0.022;
    
 % Strategy  4
    VSC01_H = 5;            % low-pass  filter  cut-frequency
    VSC01_kp = 0.015;
    
% Synchro - PLL

    VSC01_Tr_PLL=0.010;         % Response time of PLL 
    wn_PLL=5/VSC01_Tr_PLL;
    zeta_PLL = 1;
    Kp_PLL_pu = 2*zeta_PLL*wn_PLL/wb;
    Ki_PLL_pu = wn_PLL^2/wb;

% Frequency support

    VSC01_R = 4/100;            % Droop value of the outer frequency loop     

%% Virtual impedance 

I_thresh_pu=1 ;  % Output current limiting threshold to activate DZ0_vi (pu)
DX_DR= 5; %DX_vi/DR_vi
Kp_Rvi_pu=0.676;
    
  %% Initial Active and Reactive power operating points 
 VSC01_P0 =0.9; 
 VSC01_Q0 = 0;
   
 
 % Fixed frequency - Active power variation
 
 VSC01_Delta_P_Value = 0; % Step change on the active power  reference 
 VSC01_Delta_P_Time_Step = 0.2; % Time of active power step change
