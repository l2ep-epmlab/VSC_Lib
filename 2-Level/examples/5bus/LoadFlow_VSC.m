%% Search all VSC block by looking for the MaskType
model2update = bdroot;
VSC_idx = find_system(model2update,'MaskType','VSC');

%% Search All Voltage Source with Inertia by looking for the Masktype
Inertia_idx = find_system(model2update,'MaskType','Inertial_Voltage_source');

%% Enable All Fake Voltage Source for LF computation
for i=1:length(VSC_idx)
    set_param([VSC_idx{i} '/Source_For_LF'],'Commented','off');
    set_param([VSC_idx{i} '/Output_Transformer'],'Commented','on');
    set_param([VSC_idx{i} '/Mean_model'],'Commented','on');
end

for i=1:length(Inertia_idx)
    set_param([Inertia_idx{i} '/Source_For_LF'],'Commented','off');
    set_param([Inertia_idx{i} '/Mean_model'],'Commented','on');
end

%% Compute Loadflow
LF = power_loadflow('-v2',model2update,'solve');

Pb_LF = LF.basePower;

%% Update all VSC with a Masktype equal to 'VSC'
for i=1:length(VSC_idx)
    block_name = get_param(VSC_idx{i},'Name');
    test=find(strcmp({LF.bus.ID},block_name));
    Pb_VSC = eval(get_param(VSC_idx{i},'Sn'));
    
    if (isempty(test)==0)
        %set_param(VSC_idx{i},'V_mag_0',num2str(LF.bus(test).vbase * abs(LF.bus(test).Vbus) / sqrt(3)),'Theta0',num2str(angle(LF.bus(test).Vbus) * 180/pi));
        set_param(VSC_idx{i},'V0',num2str(abs(LF.bus(test).Vbus)),'Theta0',num2str(angle(LF.bus(test).Vbus) * 180/pi));
        set_param(VSC_idx{i},'P0',num2str(real(LF.bus(test).Sbus)*Pb_LF/Pb_VSC),'Q0',num2str(imag(LF.bus(test).Sbus)*Pb_LF/Pb_VSC));
        
        %p.setParameters('V_mag_0') = LF.bus(test).vbase * LF.bus(test).vref / sqrt(3);
        %p.setParameters('Theta0') = LF.bus(test).angle;        
    end
    
    set_param([VSC_idx{i} '/Source_For_LF'],'Commented','on');
    set_param([VSC_idx{i} '/Output_Transformer'],'Commented','off');
    set_param([VSC_idx{i} '/Mean_model'],'Commented','off');     
end

%% Disable All fake voltage source in Voltage Source with Inertia blocks
for i=1:length(Inertia_idx)
    block_name = get_param(Inertia_idx{i},'Name');
    test=find(strcmp({LF.bus.ID},block_name));
    Pb_VSC = eval(get_param(Inertia_idx{i},'Sc'));
    
    if (isempty(test)==0)
        %set_param(VSC_idx{i},'V_mag_0',num2str(LF.bus(test).vbase * abs(LF.bus(test).Vbus) / sqrt(3)),'Theta0',num2str(angle(LF.bus(test).Vbus) * 180/pi));
        %set_param(VSC_idx{i},'V0',num2str(abs(LF.bus(test).Vbus)),'Theta0',num2str(angle(LF.bus(test).Vbus) * 180/pi));
        set_param(Inertia_idx{i},'P0',num2str(real(LF.bus(test).Sbus)*Pb_LF/Pb_VSC)); %,'Q0',num2str(imag(LF.bus(test).Sbus)*Pb_LF/Pb_VSC));
        
        %p.setParameters('V_mag_0') = LF.bus(test).vbase * LF.bus(test).vref / sqrt(3);
        %p.setParameters('Theta0') = LF.bus(test).angle;        
    end
    
    set_param([Inertia_idx{i} '/Source_For_LF'],'Commented','on');
    set_param([Inertia_idx{i} '/Mean_model'],'Commented','off');
end