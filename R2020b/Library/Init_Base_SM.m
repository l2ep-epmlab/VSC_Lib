%% Compute Base values
% Can be used for all models
% Index 1 = VSC side
% Index 2 = grid side
    fb = fn;
    Pb = Pn;
    cos_phi_n = Pn/Sn;
    Sb = Pb/cos_phi_n;
    Vn1 = Un1/sqrt(3);
    Vb1 = Vn1;
    Vn2 = Un2/sqrt(3);
    Vb2 = Vn2;
    Ib1 = Sb / (3*Vb1);
    Ib2 = Sb / (3*Vb2);
    Zb = (3*Vb1^2)/Sb;
    wb = 2*pi*fb;  wb_pu=1;
    Lb = Zb/wb;
    Cb = 1/(Zb*wb);
%     Vdcb = Udcn;
%     Idcb = Pb / Vdcb;