% clear
% clc
% Rdr=30;

Vdc1_ref = 640e3;
Vdc2_ref = 500e3;
Vdc_H_ref= Vdc1_ref;
Vdc_L_ref= Vdc2_ref;
Vdc_refH=640e3;
Vdc_refL=500e3;

%%%%%******Per unit base values*******%%%%%%
%%%
Pn =  1000e6;    % MVA
U1n = 320e3;
V1n = U1n/sqrt(3); % V_RMS_LL
cosphin=1;
Sn = Pn/cosphin;
freq = 50;
w=2*pi*50;

%%% Perunitage
Vb = V1n;
wb = w;
Ib = Sn/(3*V1n);
Sb = Sn;
Zb = U1n^2/Sb;
Lb = Zb/w;
wpu = 1;
% MTDC 1
Vbdq = sqrt(3)*Vb;
Ibdq = sqrt(3)*Ib;
Vdcb = Vdc1_ref;
Pdcb = Pn;
Idcb = Pdcb/Vdcb;
Rdcb = Vdcb/Idcb;
% MTDC 2
Vbdq2 = sqrt(3)*Vb;
Ibdq2 = sqrt(3)*Ib;
Vdcb2 = Vdc2_ref;
Pdcb2 = Pn;
Idcb2 = Pdcb2/Vdcb2;
Rdcb2 = Vdcb2/Idcb2;
% DC/DC
Vbdq = sqrt(3)*Vb;
Ibdq = sqrt(3)*Ib;
VdcbH = Vdc_refH;
Pdcb = Pn;
Pb= Pn;
IdcbH = Pdcb/VdcbH;
RdcbH = VdcbH/IdcbH;
Vdcb= VdcbH;
Idcb = Pdcb/VdcbH;
VdcbL = Vdc_refL;
IdcbL = Pdcb/VdcbL;
RdcbL = VdcbL/IdcbL;
ntr_pu= VdcbL/VdcbH;
