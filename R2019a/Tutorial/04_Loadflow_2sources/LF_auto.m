%% open model and init some variables
open('Loadflow4.slx');
P_ref1 = 500e6; Q_ref1 = 100e6;
P_ref2 = 100e6; Q_ref2 = 0;

VSC1_idx = find_system(gcs, 'name', 'VSC1');
VSC2_idx = find_system(gcs, 'name', 'VSC2');
open_system(VSC1_idx,'window','force');
%open_system(VSC2_idx,'window','force');

set_param([VSC1_idx{1} '/Source_For_LF'],'Commented','off');
set_param([VSC1_idx{1} '/Filter'],'Commented','on');
set_param([VSC2_idx{1} '/Source_For_LF'],'Commented','off');
set_param([VSC2_idx{1} '/Filter'],'Commented','on');

msgfig = msgbox("First step, comment out the filter block and uncomment the perfect voltage source");
uiwait(msgfig)

%% Loadflow computation
LF = power_loadflow('-v2','Loadflow4','solve');
VSC1_handle = find_system(VSC1_idx,'FindAll','on','LookUnderMasks','on','IncludeCommented','on','Name','Source_For_LF');
VSC2_handle = find_system(VSC2_idx,'FindAll','on','LookUnderMasks','on','IncludeCommented','on','Name','Source_For_LF');
% For loop to link the loadflow results with the right voltage source
for j = 1:length(LF.vsrc)
    if (VSC1_handle == LF.vsrc(j).handle)
        V1 = abs(LF.vsrc(j).Vt);
        Theta1 = angle(LF.vsrc(j).Vt) * 180/pi;
    end
    if (VSC2_handle == LF.vsrc(j).handle)
        V2 = abs(LF.vsrc(j).Vt);
        Theta2 = angle(LF.vsrc(j).Vt) * 180/pi;
    end
end

tmp = sprintf("Second step, Loadflow computation\n V1 = %4.3f Theta1 = %4.3f\n V2 = %4.3f Theta2 = %4.3f", V1, Theta1, V2, Theta2);
msgfig = msgbox(tmp);
uiwait(msgfig)

%% Controled voltage sources initialization
P_ref = P_ref1;
Q_ref = Q_ref1;
V_Pcc = V1*Vb;
Vm = (P_ref-1i*Q_ref)*(R+1i*X)/(3*V_Pcc)+V_Pcc;
Theta01 = angle(Vm) * 180/pi + Theta1;
Vm_RMS1 = abs(Vm);

P_ref = P_ref2;
Q_ref = Q_ref2;
V_Pcc = V2*Vb;
Vm = (P_ref-1i*Q_ref)*(R+1i*X)/(3*V_Pcc)+V_Pcc;
Theta02 = angle(Vm) * 180/pi + Theta2;
Vm_RMS2 = abs(Vm);

set_param([VSC1_idx{1} '/Source_For_LF'],'Commented','on');
set_param([VSC1_idx{1} '/Filter'],'Commented','off');
set_param([VSC2_idx{1} '/Source_For_LF'],'Commented','on');
set_param([VSC2_idx{1} '/Filter'],'Commented','off');
msgfig = msgbox("Third step: Initialize the controled voltage sources");
uiwait(msgfig)