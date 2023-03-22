%% Initialization file for model with an output L-filter
% Compute initial state of power and control component
% Can be used for 2-level or MMC VSCs

% Compute the delay compensation between control and power parts
    %if (Time_Step == -1)
%         Solver_Time_Step = 0;
%     else
%         Solver_Time_Step = Time_Step;
%     end

% Compute Initial Voltage of VSC 
%   from steady-state output transformer model and Loadflow result

    % steady-state model of output transformer
    R1_pu = Rt_pu/2;
    L1_pu = Lt_pu/2;
    R2_pu = Rt_pu/2;
    L2_pu = Lt_pu/2;
    X1_pu = L1_pu;
    X2_pu = L2_pu;
    Xm_pu = Lm_pu;
    wb_pu = 1;
    
    Zmag_pu = 1/(1/Rm_pu+1/(1i*Xm_pu));
    S0=P0+1i*Q0;
    I2 = conj(S0)/(V0);
    Vmag = (R2_pu+1i*X2_pu)*I2 + V0;
    Imag = Vmag/Zmag_pu;
    I1 = I2 + Imag;
    V1 = (R1_pu+1i*X1_pu) * I1 + Vmag;
    Vc = V1; % Initial capacitor voltage
    
    Vvirt = V1+1i*(Lc_eq-Lt_pu) * I1; % Compute virtual voltage for VI block
    
    %Steady-state model of LC Filter
    Is = I1 + 1i*Cf_pu*V1;
    Theta_Is = angle(Is) * 180/pi+Theta0;
    Vm = (1i*Lf_pu+Rf_pu)*Is+ V1;  % Initial output bridge voltage
    
% Generate string to display LF results on Mask
    
    mo = get_param(gcb,'MaskObject');
    mo.getDialogControl('LF_pcc_str').Prompt = ['V0 = ', num2str(V0),' pu, Angle = ', num2str(Theta0),'°'];
    mo.getDialogControl('LF_pcc_Power_str').Prompt = ['P0 = ', num2str(P0),' pu, Q0 = ', num2str(Q0),' pu'];

% Initial current and voltage states calculation 
% Mainly for control loops initialization

% Compute initial internal voltages
    Vc_0 = abs(Vc); % compute initial capacitor voltage magnitude
    Theta_Vc_0 = angle(Vc) * 180/pi+Theta0;
    Vvsc0 = abs(Vvirt); % Initial virtual voltage
    Theta_Vvsc0 = angle(Vvirt) * 180/pi+Theta0;
  
% Given Setpoint in PV bus   
    Vg0_d=V0*cos(Theta0*pi/180-Theta_Vvsc0*pi/180);
    Vg0_q=V0*sin(Theta0*pi/180-Theta_Vvsc0*pi/180);
    Vg0_dq = [Vg0_d ;Vg0_q; 0];
 
% Initial state of AC grid current : Ig0dq

    Theta_I2 = angle(I2) * 180/pi + Theta0;
    Ig0_d = abs(I2)*cos(Theta_I2*pi/180-Theta_Vvsc0*pi/180);
    Ig0_q = abs(I2)*sin(Theta_I2*pi/180-Theta_Vvsc0*pi/180);
    Ig0_dq = [Ig0_d; Ig0_q; 0];
 
% Initial state of capacitor voltage : eg0dq

    Eg0_d = Vc_0*cos(Theta_Vc_0*pi/180-Theta_Vvsc0*pi/180);
    Eg0_q = Vc_0*sin(Theta_Vc_0*pi/180-Theta_Vvsc0*pi/180);
    Eg0_dq = [Eg0_d; Eg0_q; 0];
 
% Initial state of VSC Current : Is0dq

    Is0_d = abs(Is) * cos(Theta_Is*pi/180-Theta_Vvsc0*pi/180);
    Is0_q = abs(Is) * sin(Theta_Is*pi/180-Theta_Vvsc0*pi/180);
    Is0_dq = [Is0_d; Is0_q; 0];

% Initial state of Modulation Voltage : Vm0dq

    Vm0 = abs(Vm);
    Theta_Vm0 = angle(Vm)*180/pi + Theta0;
    Vm0_d = Vm0 * cos(Theta_Vm0*pi/180-Theta_Vvsc0*pi/180);
    Vm0_q = Vm0 * sin(Theta_Vm0*pi/180-Theta_Vvsc0*pi/180);

    Va0 = sqrt(2)*Vb1*Vm0*sin(Theta_Vm0*pi/180);
    Vb0 = sqrt(2)*Vb1*Vm0*sin(Theta_Vm0*pi/180-2*pi/3);
    Vc0 = sqrt(2)*Vb1*Vm0*sin(Theta_Vm0*pi/180+2*pi/3);
    Vabc0 = [Va0 Vb0 Vc0];
    
    %Vvsc0 = abs(Vvirt);
    %Theta_Vvsc0 = angle(Vvirt) * 180/pi+Theta0;

    mo.getDialogControl('LF_vsc_str').Prompt = ['V0 = ', num2str(Vvsc0),' pu, Angle = ', num2str(Theta_Vvsc0),'°'];