%% Compute Control parameters for Virtual Impedance block
Lc_pu = Lt_pu+Larm_pu/2;
Rc_pu = Rt_pu+Rarm_pu/2;
Lc_eq = Lc_pu + dLc_pu;
Rc_eq = Rc_pu;