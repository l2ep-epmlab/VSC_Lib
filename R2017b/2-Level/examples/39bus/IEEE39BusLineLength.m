%
%IEEE 39 bus standard for EMT simulation
% Estimation of line length
%
% estimation of line length for IEEE 39 bus model.
% the original specification does not give the line length.
% therefore, we try to estimate them
% the propagation speed of overhead line is just below the speed of light
% 300000 km/s typically for positive sequence.
% How to do it?
% 1- find Cpos in F and Lpos in H like in the original model. (positive sequence value)
% 2- find a length len (km) that makes the 1/(sqrt(Lpos.Cpos)*len close to
% 290000-295000 km/s

% carefull, the paper value are in Pu
% test pour ligne 3-4
% Rpu=0.0013; Xpu=0.0213; Bpu=0.2214; %in pu from paper.
% w=2*pi*60;
% S=100e6;
% Vb=345e3; %base voltage,from the model
% Zb=Vb*Vb/S;
% 
% L=Xpu*Zb/w;
% C=Bpu/Zb/w;
% C = 4.9341e-007 ;
% L = 0.0672 ;



%% inter area lines

TL_1_39_len=105;
% check : 1/sqrt(0.079*1.67e-6)*105=  2.8908e+005  ok, near but below 300000.
TL_3_4_len=53;
% check: 1/sqrt(0.067*0.493e-6)*53 = 2.9162e+005
TL_16_17_len=26;
% check: 1/sqrt(0.028*0.299e-6)*26= 2.8416e+005
TL_13_14_len=32;
% check: 1/sqrt(0.032*0.384e-6)*32= 2.8868e+005
TL_4_14_len=33;
% 1/sqrt(0.041*0.308e-6)*33= 2.9366e+005

%% East System
TL_16_24_len=15;
%1/sqrt(0.019*0.152e-6)*16=2.9773e+005
TL_24_23_len=88;
%1/sqrt(0.111*0.805e-6)*88=2.9439e+005
TL_16_21_len=46;
%1/sqrt(0.043*0.568e-6)*46 =2.9434e+005
TL_21_22_len=47;
%1/sqrt(0.044*0.572e-6)*47 = 2.9626e+005
TL_15_16_len=31.5;
%1/sqrt(0.03*0.381e-6)*31.5 =2.9464e+005
TL_16_19_len=61;
%1/sqrt(0.062*0.677e-6)*61 =2.9774e+005
TL_22_23_len=33;
%1/sqrt(0.03*0.411e-6)*33=2.9719e+005
TL_14_15_len=70;
%1/sqrt(0.069*0.816e-6)*70=2.9500e+005

%% North System
TL_26_29_len=200;
%1/sqrt(0.197*2.293e-6)*200=2.9757e+005
TL_26_28_len=151;
%1/sqrt(0.15*1.739e-6)*151 =2.9565e+005
TL_28_29_len=48;
%1/sqrt(0.048*0.555e-6)*48 =2.9409e+005
TL_25_26_len=101;
%1/sqrt(0.102*1.143e-6)*101= 2.9580e+005
TL_26_27_len=46.5;
%1/sqrt(0.046*0.534e-6)*46.5 =2.9669e+005
TL_2_25_len=28;
%1/sqrt(0.027*0.325e-6)*28 =2.9891e+005
TL_17_27_len=59;
%1/sqrt(0.055*0.717e-6)*59 =2.9711e+005
TL_17_18_len=26;
%1/sqrt(0.026*0.294e-6)*26 =2.9738e+005
TL_3_18_len=42;
%1/sqrt(0.042*0.476e-6)*42 =2.9704e+005
TL_2_2_len=49;
%1/sqrt(0.048*0.573e-6)*49=2.9546e+005
TL_1_2_len=134;
%1/sqrt(0.13*1.56e-6)*134 =2.9756e+005

%% West system
TL_4_5_len=32.5;
%1/sqrt(0.04*0.299e-6)*32.5 =2.9718e+005
TL_5_6_len=14;
% 1/sqrt(0.014*0.162e-6)*14= 2.9397e+005
TL_6_11_len=26.5;
%1/sqrt(0.026*0.31e-6)*26.5= 2.9517e+005
TL_5_8_len=32;
%1/sqrt(0.035*0.329e-6)*32 =2.9821e+005
TL_6_7_len=25.5;
%1/sqrt(0.029*0.252e-6)*25.5 =2.9829e+005
TL_10_13_len=14;
% 1/sqrt(0.014*0.162e-6)*14= 2.9397e+005
TL_10_11_len=14;
% 1/sqrt(0.014*0.162e-6)*14= 2.9397e+005

TL_9_39_len=136;
%1/sqrt(0.079*2.674e-6)*136 = 2.9590e+005
TL_7_8_len=15;
%1/sqrt(0.015*0.174e-6)*15 = 2.9361e+005
TL_8_9_len=93;
%1/sqrt(0.115*0.848e-6)*93 = 2.9781e+005

%% Excitation System format (AVR_Data)
% All machines use IEEE type 1 synchronous machine voltage regulator combined to an exciter
% 1. Low pass filter time constant (Tr) sec
% 2. Regulator gain (Ka)
% 3. regulator time constant (Ta) sec
% 4. Lead-lag compensator time constant (Tb) sec
% 5. Lead-lag compensator time constant (Tc) sec
% 6. Terminal voltage (pu)
% 7. Lower limit for regulator output (Emin)   
% 8. Upper limit for regulator output (Emax)
%     1    2      3      4     5     6       7    8
  AVR_Data=[...
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5];
 
C0=829.7e-9;
L0=3.220e-3;
R0=1;
Ns=120*60/(2); %Nominal speed of synchronous machines
s=10;
PSSModel=1;%1:No pSS //1:MB 
%% Power System Stabilizer Format (MB)
% Applied power system stabilizer is MBPSS with simplified settings
% Note: All machines use MBPSS with same configuration 
% 1: Global gain (G)
% 2: Frequency of low frequency band (FL) Hz
% 3: Gain of low frequency band (KL)
% 4: Frequency of intermediate frequency band (FI) Hz
% 5: Gain of intermediate frequency band (KI)
% 6: Frequency of high frequency band (FH) Hz
% 7: Gain of high frequency band (KH)
%   1    2  3     4   5      6  7
MB=[1   0.2 30   1.25 40    12 160];
