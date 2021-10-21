% Results are obtained from the lodflow program of SimpowerSystem
V1 = 0.9827;
Theta = 0.2265;

% Inputs definition
V1 = Un / sqrt(3) * V1;
P = 500e6; Q = 100e6;

% Quasi-static expression of V2
% 3*V1*conj(I) = (P+jQ)

Vm = (P-1i*Q)*(R+1i*X)/(3*V1)+V1;

Vm_RMS = abs(Vm);

Theta0 = angle(Vm) * 180/pi + Theta;