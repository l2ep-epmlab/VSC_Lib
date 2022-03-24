%% Compute Control parameters for GFL VSC
% Can be used for all GFL models
if zeta_choice == 1
    zeta_i = 0.707;
    wn_i = 3/Tr_i;
end
if zeta_choice == 2
    zeta_i = 1;
    wn_i = 5/Tr_i;
end
% current control tuning by pole placement
    Lf_pu = Lt_pu;
    Rf_pu = Rt_pu;
    Kp_i = 2*zeta_i*wn_i*Lf_pu/wb-Rf_pu;
    Ti_i = 2*zeta_i/wn_i-Rf_pu/(wn_i^2*Lf_pu/wb);
    Ki_i = Kp_i/Ti_i;
