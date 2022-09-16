%% Compute Control parameters for GFM VSC
% Can be used for all GFM models
  
% PLL derivation of the parameters
    wn_PLL=5/Tr_PLL;
    zeta_PLL = 1;
    Kp_PLL_pu = 2*zeta_PLL*wn_PLL/wb;
    Ki_PLL_pu = wn_PLL^2/wb;
    
% Grid-Forming control tuning
    % Set the chosen strategy
        if (gainpopup == 1)
            Chosen_Strategy = 1;
        elseif (gainpopup == 2)
            if (Param_Inertia == 1)
                Chosen_Strategy = 2;
            elseif (Param_Inertia == 2)
                Chosen_Strategy = 3;
            end
        end
    % Inertia Less
    %wn_Inertia_Less = 2*pi*f_Inertia_Less;
    %Ki_Inertia_Less = Lt_pu*wn_Inertia_Less^2/wb;
    %Kp_Inertia_Less = 2*zeta_Inertia_Less*wn_Inertia_Less*Lt_pu/wb;
    Kp_Inertia_Less = Lt_pu/wb / (Tr_Inertia_Less / 3000);
    
    % With Inertia
    Kc = 1/(Lt_pu);
    kp_GFo = zeta_GFo*sqrt(2/(H_GFo*wb*Kc));
    kd = 2*H_GFo*kp_GFo*Kc*wb;

% Virtual Impedance tuning
    X_VI = roots([1/DX_DR^2+1 2*Lt_pu Lt_pu^2-1/I_Max_VI_pu^2]);
    X_VI = max(X_VI);
    Kp_Rvi_pu = X_VI/(DX_DR*(I_Max_VI_pu-1)); 

% Current Loop tuning
    Kp_CC = 3*Lt_pu*f_CC*2*pi/(3*wb);
    w_ff = 2*pi*f_FF;
    
% Set the frequency droop gain
    R = R_percent / 100;