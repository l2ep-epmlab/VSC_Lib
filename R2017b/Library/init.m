clear all;
clc;
Time_Step = 50e-6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GRID SPECIFICATION

% Nominal and base GRID values
fn = 50;                             % [Hz] nominal frequency 
wn = 2*pi*fn;   
fb = fn;
wb = wn;

%%%%%%%%%%%
% LINE L0102 specification   
L0102_Un = 400 * 1e3;                % [V] Phase-to-Phase nominal RMS voltage
L0102_Sn = 100e6;                    % [VA] nominal apparent power
L0102_SCR = 20;                      % [] Short Circuit Ratio
L0102_XbyR = 10;                     % [] RL series line model, ratio X_u/R_u
% Per-Unit system
L0102_Ub = L0102_Un;                 % [V] base Phase-to-Phase voltage
L0102_Vb = L0102_Ub/sqrt(3);         % [V] base Phase-to-Neutral voltage
L0102_Sb = L0102_Sn;                 % [VA] base power
L0102_Zb = L0102_Ub^2/L0102_Sb ;     % [Ohm] base impedance  
% Model parameters
L0102_X_u = 1/L0102_SCR;             % [pu] RL series AC line model, reactance
L0102_R_u = L0102_X_u/L0102_XbyR;    % [pu] RL series AC line model, resistance
L0102_X = L0102_X_u*L0102_Zb;   
L0102_L = L0102_X/wb;
L0102_R = L0102_R_u*L0102_Zb; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD FLOW


LoadFlow_VSC