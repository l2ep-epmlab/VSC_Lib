%% Initialization file for model with an output L-filter
% Compute initial state of power and control component
% Can be used for 2-level or MMC VSCs
    
% Compute the delay compensation between control and power parts
    %if (Time_Step == -1)
    %    Solver_Time_Step = 0;
    %else
    %    Solver_Time_Step = Time_Step;
    %end

% Compute Initial Voltage of VSC 
%   from steady-state output transformer model and Loadflow result
    
    R1_pu = Rt_pu/2;
    L1_pu = Lt_pu/2;
    R2_pu = Rt_pu/2;
    L2_pu = Lt_pu/2;
    X1_pu = L1_pu;
    X2_pu = L2_pu;
    Xm_pu = Lm_pu;
    
    Zm_pu = 1/(1/Rm_pu+1/(1i*Xm_pu));

    S0=P0+1i*Q0;
    I2 = conj(S0)/(V0);

    Vm = (R2_pu+1i*X2_pu)*I2 + V0;
    Im = Vm/Zm_pu;

    I1 = I2 + Im;
    V1 = (R1_pu+1i*X1_pu) * I1 + Vm;

    Vm0 = abs(V1);
    Theta_Vm0 = angle(V1) * 180/pi+Theta0;
    
    Vvirt = V1+1i*(Lc_eq-Lc_pu) * I1; % Compute virtual voltage for VI block
    Vvsc0 = abs(Vvirt);
    Theta_Vvsc0 = angle(Vvirt) * 180/pi+Theta0;
    
    %Va0 = Vvsc0*sqrt(2)*Vb1*sin(Theta_vsc0*pi/180);
    %Vb0 = Vvsc0*sqrt(2)*Vb1*sin(Theta_vsc0*pi/180-2*pi/3);
    %Vc0 = Vvsc0*sqrt(2)*Vb1*sin(Theta_vsc0*pi/180+2*pi/3);
    
    Va0 = Vm0*sqrt(2)*Vb1*sin(Theta_Vm0*pi/180);
    Vb0 = Vm0*sqrt(2)*Vb1*sin(Theta_Vm0*pi/180-2*pi/3);
    Vc0 = Vm0*sqrt(2)*Vb1*sin(Theta_Vm0*pi/180+2*pi/3);
    
    Vm0_d = Vvsc0*cos(angle(Vvirt));
    Vm0_q = Vvsc0*sin(angle(Vvirt));
    
    % Given Setpoint in PV bus   
    Vg0_d=V0*cos(Theta0*pi/180-Theta_Vvsc0*pi/180);
    Vg0_q=V0*sin(Theta0*pi/180-Theta_Vvsc0*pi/180);
    Vg0_dq = [Vg0_d ;Vg0_q; 0];
    
    % Initial state of AC grid current : Ig0dq

    Theta_I2 = angle(I2) * 180/pi + Theta0;
    Ig0_d = abs(I2)*cos(Theta_I2*pi/180-Theta_Vvsc0*pi/180);
    Ig0_q = abs(I2)*sin(Theta_I2*pi/180-Theta_Vvsc0*pi/180);
    Ig0_dq = [Ig0_d; Ig0_q; 0];
    
% Generate string to display LF results on Mask
    mo = get_param(gcb,'MaskObject');
    mo.getDialogControl('LF_vsc_str').Prompt = ['V0 = ', num2str(Vvsc0),' pu, Angle = ', num2str(Theta_Vvsc0),'°'];
    mo.getDialogControl('LF_pcc_str').Prompt = ['V0 = ', num2str(V0),' pu, Angle = ', num2str(Theta0),'°'];
    mo.getDialogControl('LF_pcc_Power_str').Prompt = ['P0 = ', num2str(P0),' pu, Q0 = ', num2str(Q0),' pu'];