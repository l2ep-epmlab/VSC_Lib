% DC source selection
%    if (DC_source == 1)
%        H_DC_Link = inf;
%    else
%        H_DC_Link = 0;
%    end
% Average Model parameters
    Carm = 1/3*Pb/Vdcb^2*Hc/1000;
    
% Differential Current controller (CCSC)

    HL = 1/2*Larm_pu*Lb*Idcb^2/Pb; 
    Diff_CC_wn = 2*pi*Diff_CC_fn;
    Diff_CC_ki= 2*HL*Diff_CC_wn*Diff_CC_wn;
    Diff_CC_kp= (4*Diff_CC_zeta*Diff_CC_wn*HL)-(Rarm_pu);
    %Lf_pu = Lt_pu;
    %Rf_pu = Rt_pu;
    %wn_i = 3/Tr_i;
    %Kp_i = 2*zeta_i*wn_i*Lf_pu/wb-Rf_pu;
    %Ti_i = 2*zeta_i/wn_i-Rf_pu/(wn_i^2*Lf_pu/wb);
    %Ki_i = Kp_i/Ti_i;
    %Kffi = 1;
    
    %Diff_CC_ki = Rarm_pu*Diff_CC_wn;
    %Diff_CC_kp = Larm_pu/wb*Diff_CC_wn;

%% Energy Sum W tot Per phase control design
    Hc_W    = 0.5*Carm*(Udcn^2)/Pn;    
    wn_Wtot     = 2*pi*fn_Wtot;
    Kp_Wtot_pu  = 2*zeta_Wtot*wn_Wtot*2*Hc_W;
    Ki_Wtot_pu  = wn_Wtot*wn_Wtot*2*Hc_W;

%% Control difference (balancing)  W diff Per phase control design  
    wn_Wdiff    = 2*pi*fn_Wdiff;
    Kp_Wdiff_pu = 2*zeta_Wdiff*wn_Wdiff*2*Hc_W;
    Ki_Wdiff_pu = wn_Wdiff*wn_Wdiff*2*Hc_W;