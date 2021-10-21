%% Compute Control parameters for GFL VSC
% Can be used for all GFL models

% current control tuning
    Lf_pu = Lt_pu;
    Rf_pu = Rt_pu;
    wn_i = 3/Tr_i;
    Kp_i = 2*zeta_i*wn_i*Lf_pu/wb-Rf_pu;
    Ti_i = 2*zeta_i/wn_i-Rf_pu/(wn_i^2*Lf_pu/wb);
    Ki_i = Kp_i/Ti_i;
    Kffi = 1;