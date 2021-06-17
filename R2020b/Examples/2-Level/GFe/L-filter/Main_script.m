%% ========================================================================
%  Define simulation parameters

%  Taoufik QORIA
%  L2EP - Electrical Engineering and Power Electronics Lab Lille
%
%  October 2018
%  ========================================================================
          
%% Simulation Parameters (for the user - optional)
sim.T_start = 0;        % Simulation start time [s] 
sim.T_stop = 5;       % Simulation end time [s] 
sim.Sim_type = 'fixed'; % Simulation type: {fixed} or {variable} time step
sim.T_step = 5e-5;     % Simulation time step (if fixed) [s]
Ts= sim.T_step;
Ts_Power = Ts;

%% Base Values
    Pb = 1000 * 1e6;
    Ub = 320 * 1e3;
    fb = 50;
    wb = 2*pi*fb;
    wb_pu = 1;
    cosPhi_b = 1;
    Sb = Pb / cosPhi_b;
    Vb = Ub/sqrt(3);
    Ib = Sb / (Ub);
    Zb = Ub / Ib;
    Lb = Zb / wb;
    Cb = 1 / (Zb * wb);

%% Nominal Parameters
% VSC
    model.num = 1;
    Pn = 1000 * 1e6;            % Nom. VSC power [W]
        
    cosPhi_n = 1;  % Nom. cos(phi)
    Un = 320 * 1e3;                 % Nom. phase-to-phase VSC voltage [V]
    fn = 50;
    freq= fn;                       % Nom. frequency [Hz]
    wn = 2*pi*fn;                   % Nom. angular velocity [rad/s]
    Udc_n = 640 * 1e3;              % Nom. DC voltage[V]
    Sn = Pn / cosPhi_n;             % Nom. apparent power [VA]

% Low-pass filter    
    Rf_pu = 0.005 * ones(1,model.num);             % Low-pass filter resistance Rf [p.u.]
    Lf_pu = 0.15 * ones(1,model.num);             % Low-pass filter inductance Lf [p.u.]
    Cf_pu = 0.066* ones(1,model.num);             % Low-pass filter capacitance Cf [p.u.]                 

    Lf = Lf_pu * Lb;
    Rf = Rf_pu * Zb;
    Cf = Cf_pu * Cb; 
    Cp   = 0.0005;
  

% Transformers
    R_transformer_pu = 0.005 * Sb ./ Sn;    % Transformer resistances [p.u]
    L_transformer_pu = 0.15 * Sb ./ Sn;     % Transformer inductances [p.u]
    
    R_transformer = R_transformer_pu * Zb;
    L_transformer = L_transformer_pu * Lb;
    

%% Grid    

    SCR = 3;
    Usrc0_pu = 1;
    X_grid_pu=Usrc0_pu/SCR;    % Grid inductance [p.u]
    R_grid_pu = X_grid_pu*Lb*wb/(10*Zb);         % Grid resistance [p.u]
    L_grid_pu = X_grid_pu;
    
    R_grid = R_grid_pu * Zb;
    L_grid = L_grid_pu * Lb;
    X_grid = L_grid * wb;
    
  SCR_F = 1.2;                         % Short Circuit Ratio
  SCR_I = 2;                         % Short Circuit Ratio 
  X_TI = 1/SCR_I;
  
  X1_pu = 1/SCR_F;              % AC line reactor in per-unit [p.u]
  R1_pu = X1_pu/10;     % AC line resistance in per-unit [p.u]

  L_1 = X1_pu*Zb/wb;  % AC line reactor in SI (International System of Units) 
  R_1  = R1_pu*Zb; % AC line resistance 

  X2_pu = X1_pu/SCR_I/(X1_pu-1/SCR_I);
  R2_pu = X2_pu/10;     % AC line resistance in per-unit [p.u]

  L_2 = X2_pu*Zb/wb;  % AC line reactor in SI (International System of Units) 
  R_2  = R2_pu*Zb; % AC line resistance 
    
    
%% "Dispatcher" Set Points
    P_set = 0;              % Active power set point for VSC [p.u]
    Q_set = 0;                   % Reactive power set point for VSC [p.u]    
    Ve = 1;
    V_pcc_set = 1; 
    w0 = 1;
%% Matrix Transformations               
    M_clarke = sqrt(2/3) * [   1     ,    -1/2     ,    -1/2     ;...
                               0     ,  sqrt(3)/2  , -sqrt(3)/2  ;...
                          1/sqrt(2)  ,  1/sqrt(2)  ,  1/sqrt(2) ];
    
    M_clarke_inv = sqrt(2/3) * [   1   ,    0        ,  sqrt(2)/2  ;...
                                 -1/2  ,  sqrt(3)/2  ,  sqrt(2)/2  ;...
                                 -1/2  ,  -sqrt(3)/2 ,  sqrt(2)/2 ];             

    theta0 = 0;
    M_transform_inv = sqrt(2/3) * [   sin(theta0)     ,    cos(theta0)     ,    1/sqrt(2)     ;...
                                      sin(theta0-2*pi/3)     ,  cos(theta0-2*pi/3)  , 1/sqrt(2)  ;...
                                      sin(theta0+2*pi/3)     ,  cos(theta0+2*pi/3)  ,  1/sqrt(2) ];
    f_sw = 5e3;                    
%% Upper Control Parameters for grid-feeding

% Current PI controller   
    Tr_i = 5 * 1e-3;                   % Time response [s]
    D_i = 0.707;                       % Damping factor
     Kp_i = 0.4001;                     % Proportional current gain
    Ki_i = 171.8873;                    % Integral current gain
    Kffi = 1;                          % Current feed forward (enabled)
    Ti_i = Kp_i / Ki_i;
        
    % PLL-SRF 
    
    VSC01_Tr_PLL=10;         % Response time of PLL (ms)
%     wn_PLL=5/VSC01_Tr_PLL;
%     zeta_PLL = 1;
%     Kp_PLL_pu = 2*zeta_PLL*wn_PLL/wb;
%     Ki_PLL_pu = wn_PLL^2/wb;
    
    % Power controller
    
    Ki_po =  39; 
           
%% ======================================================================== 
%% Initialisation

i_q_set  =(sqrt(Ve-(L_transformer_pu*w0*P_set)^2)- V_pcc_set)/(L_transformer_pu*w0);
theta_g = atan(-X_TI*w0*P_set/sqrt(Ve-(X_TI*w0*P_set)^2))*180/pi;
v_m_d =   - L_transformer_pu*w0*i_q_set + V_pcc_set;
v_m_q =   L_transformer_pu*w0*P_set;
theta_m = atan(v_m_q/v_m_d)*180/pi;
V_m  = sqrt(v_m_d^2+v_m_q^2);
phi_g = atan2(i_q_set,P_set);
I_g   =   sqrt(i_q_set^2 + P_set^2);
In_c = (sqrt(2)*Ib/sqrt(3))*[I_g*sin(phi_g) I_g*sin(-2*pi/3-phi_g) I_g*sin(2*pi/3-phi_g)];

