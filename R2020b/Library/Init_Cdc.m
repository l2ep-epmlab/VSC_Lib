%% Initialization specific for model with an output DC Link

% DC Link capacitor computation
    C_DC = H_DC/1000*Pb/(1/2*Udcn^2);
    set_param([gcb '/DC_Link_1'],'Capacitance',num2str(C_DC*2));
    set_param([gcb '/DC_Link_2'],'Capacitance',num2str(C_DC*2));