clear all

% Nominal Frequency (Hz)
fn = 50;   % Nominal frequency [Hz] 
wn = 2*pi*fn;   

% Base frequency

fb = fn;       %  Base Frequency value [Hz]            
wb = wn;       

Time_Step=50e-6; % Simulation time step [s] 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Grid Description  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% Nominal values  
  
    Un = 400 * 1e3;                % Phase-to-Phase nominal AC grid Voltage [V]
    Sn = 1e9;
    
  
  % base Value
  
    Ub =  Un;                % Base Phase-to-Phase Voltage value [V]  
    Vb =  Un/sqrt(3);        % Base simple Volatge value [V]    
    Sb =  Sn;                     % Base Apparent power [VA]
    
    Zb = Ub^2/Sb ;     %Base Grid Impedance  
    wb = wn;

    
  SCR = 20;
  Xg_pu = 1/SCR;              % AC line reactor in per-unit [p.u]
  Lg_pu = Xg_pu;
  Rg_pu = Xg_pu/10;     % AC line resistance in per-unit [p.u]
         
  Xg = Xg_pu*Zb;  % AC line reactor in SI (International System of Units) 
    
  Lg = Xg/wb;           % AC line inductance
  Rg  = Rg_pu*Zb; % AC line resistance 
 
%%  Converter
  
U_dcn = 640e3;          % DC voltage
Un_VSC = 320e3;            % Converter side voltage
Pn_conv = Sn;           % Nominal active power 
Sn_conv = Sn;           % Nominal apparent power 

Lc_pu = 0.15;

% damping resistance  : only usefull for VC grid forming

Rv_GFM = 0.09;
W_TVR = 60;


% CC grid forming    current loop gain
Tr_C_loop = 2e-3;
k_C_loop = 3*Lc_pu/(Tr_C_loop*wb);

Tau_f = 0.01;


% active power loop

Tr_P_loop = 100e-3;
mp_P_loop = 3*Lc_pu/(Tr_P_loop)/wb;

% inertial effect

H_GFM = 5;
zeta_GFM = 0.7;

%   PI controller

kd_PI = zeta_GFM*sqrt(2*Lc_pu/(H_GFM*wb));
wn_PI = sqrt(wb/(2*H_GFM*(Lc_pu + Lg_pu)));

% VSM controller

K_VSM = 2*H_GFM*kd_PI*wb/Lc_pu;




