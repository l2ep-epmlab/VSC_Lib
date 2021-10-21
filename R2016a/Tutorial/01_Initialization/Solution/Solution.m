% Inputs definition
V1 = Un / sqrt(3);
P = 500e6; Q = 100e6;

% Quasi-static expression of V2
% 3*V1*conj(I) = (P+jQ)

V2 = (P-1i*Q)*(R+1i*X)/(3*V1)+V1;