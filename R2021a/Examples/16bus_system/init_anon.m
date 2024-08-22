clear all

disp('_______   16 bus System based on anonymized RTE Data  _________')
disp('_______     Yahya Lamrani _________')
disp('_______     L2EP Team _________')

Ts=5e-6;
wb=2*pi*50;

%% Control parameters

%Delay
Ctrl_Delay = 100e-6;

%GFL outer loops
wp = 10;
wq = 10;
wv = 50;
wlpf  = 300;
%GFL current control
wcc = 1200;

%% Nominal parameters of circuit

% GEN

%HVDC1
Snom1 = 1e6*sqrt(1330^2 + (0.3*1330)^2);
Pnom1 = 1330e6;
Pref1 = 1325.94e6/Snom1;
% Qref1 = ; %PV bus

%HVDC7
Snom3 = 1044e6;
Pnom3 = 1e9;
Pref3 = 976.94e6/Snom3;
Qref3 = -162.113e6/Snom3;

%RES9
Snom4 = 1e6*sqrt(64.4^2 + (0.3*64.4)^2);
Pnom4 = 64.4e6;
Pref4 = 9.27803e6/Snom4;
Qref4 = 0;

%RES15
Snom5 = 1e6*sqrt(19^2 + (0.3*19)^2);
Pnom5 = 19e6;
Pref5 = 2.47385e6/Snom5;
Qref5 = 0;

%REs12
Snom6 = 1e6*sqrt(450^2 + (0.3*450)^2);
Pnom6 = 450e6;
Pref6 = 90e6/Snom6;
Qref6 = -147e6/Snom6;


Vb = Ub/sqrt(3);
Ib = Sb/(sqrt(3)*Ub);
Zb = Ub^2/Sb;
Lb = Zb/wb;
Cb = 1/(Zb*wb);

% Pour eq statcom
Ub_statcom = 225e3;
Sb_statcom = 140e6;
Zb_statcom = Ub_statcom^2/Sb_statcom;
Lb_statcom = Zb_statcom/wb;
