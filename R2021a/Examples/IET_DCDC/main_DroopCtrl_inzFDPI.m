% clear
% clc
% Rdr=30;
main_PU;

%%%%%******Initialising the system from inz load flow solution*******%%%%%%
lamda1 =0.5;
lamda2=0.5;
%script_fmincon_loadflowFD;
load inz_Loadflow.mat

%%% Références %%%
Pref1_1= -400e6;
Pref1_2= 200e6;
Pref2_1= -400e6; 
Pref2_2= 600e6;
Pref_dc_dc= 200e6;
Pn = 1000e6;

Sr=10e9; % limite de rampe en puissance
% Qref=0e6;
Qref_dc_dc=0e6;

Vdc1_ref = 640e3;
Vdc2_ref = 500e3;
Vdc_H_ref= Vdc1_ref;
Vdc_L_ref= Vdc2_ref;
% Vdc_H_ref= Vdc_dc1;
% Vdc_L_ref= Vdc_dc2;

Pref1_i= P11*Pn;
Pref2_i= P21*Pn;
Pref_dc_dci= Pdcdc*Pn;
Vdc11= x(1)*Vdc1_ref;
Vdc_dc1= x(2)*Vdc1_ref;
Vdc12= x(3)*Vdc1_ref;
Vdc21= x(4)*Vdc2_ref;
Vdc_dc2= x(5)*Vdc2_ref;
Vdc22= x(6)*Vdc2_ref;
% Vdcpi1= Vdcpi1*Vdc1_ref;
% Vdcpi12= Vdcpi12*Vdc1_ref;
% Vdcpi2= Vdcpi2*Vdc2_ref;
% Vdcpi22= Vdcpi22*Vdc2_ref;


D1=1;   % droop control implemented in MTDC1
D2=1;   % droop control implemented in MTDC2
load 'Small signal model.mat'
%init_ROM_MTDC1_inzFDPI_pu
%init_ROM_MTDC2_inzFDPI_pu
%init_ROM_dc_dc_inzFDPI_pu