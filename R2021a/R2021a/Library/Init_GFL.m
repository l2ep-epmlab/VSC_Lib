%% Compute Control parameters for GFL VSC
% Can be used for all GFL models

% current control tuning
    Lf_pu = Lc_eq; %Lt_pu;
    Rf_pu = Rc_eq; %Rt_pu;
    %wn_i = 3/Tr_i;
    %Kp_i = 2*zeta_i*wn_i*Lf_pu/wb-Rf_pu;
    %Ti_i = 2*zeta_i/wn_i-Rf_pu/(wn_i^2*Lf_pu/wb);
    %Ki_i = Kp_i/Ti_i;
    %Kffi = 1;
    
%     Ki_i = Rt_pu*wn_i;
%     Kp_i = Lt_pu/wb*wn_i;
    
    Ki_i = Rc_eq*wn_i;
    Kp_i = Lc_eq/wb*wn_i;