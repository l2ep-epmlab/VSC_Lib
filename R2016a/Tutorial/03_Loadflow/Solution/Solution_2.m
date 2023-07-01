LF = power_loadflow('-v2','Loadflow1','solve');
P_ref = 500e6;
Q_ref = 100e6;

Vn = Un/sqrt(3);

V_Pcc = LF.bus(1).Vbus*Vn;
Vm = (P_ref-1i*Q_ref)*(R+1i*X)/(3*V_Pcc)+V_Pcc;


Theta0 = angle(Vm) * 180/pi;
Vm_RMS = abs(Vm);
