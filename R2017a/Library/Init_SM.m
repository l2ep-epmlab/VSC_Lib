%
Ism = I1 + conj(Paux/V1);

Ssm = V1*conj(Ism);
Psm = real(Ssm);
Qsm = imag(Ssm);
cos_phi = Psm/abs(Ssm);
sin_phi = Qsm/abs(Ssm);
phi = atan(Qsm/Psm);

Vsum = abs(V1);
Vangle = angle(V1);
Isum = abs(Ism);
Iangle = angle(Ism);
% current init
ia0 = Isum ;
ib0 = Isum ;
ic0 = Isum ;

pha0 = Iangle*180/pi;
phb0 = Iangle*180/pi -120;
phc0 = Iangle*180/pi + 120;

Xaaqu = SM_Ll + SM_Lmq;
Xaadu = SM_Ll + SM_Lmd;
Rau = SM_Rs;

deltai = atan((Xaaqu*Isum*cos_phi-Rau*Isum*sin_phi)/...
              (Vsum+Xaaqu*Isum*sin_phi+Rau*Isum*cos_phi));...
                     
delta0 = (deltai + Vangle)*180/pi-90;

Isqu = Isum*cos(phi+deltai);
Isdu = Isum*sin(phi+deltai);
Vsqu = Vsum*cos(deltai);

Ifdu = 1/SM_Lmd*(Vsqu + Rau*Isqu + Xaadu*Isdu);
Efdu = SM_Rf * Ifdu;
N = SM_Rf/SM_Lmd;
Vfu0 = Efdu/N;

Cmu0 = Psm + Rau*Isum*Isum;