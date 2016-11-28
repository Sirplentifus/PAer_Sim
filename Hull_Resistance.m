function [ R_H ] = Hull_Resistance( V, h, Pars )
%Hull_Resistance - Computes the drag and buoyancy of the hull at water level h
%   Input:
%   V - velocity
%   h - water depth measured from bottom of hydrofoil
%   Pars - all the necessary parameters. Must contain:
%       H_h - the distance between the hydrofoil and the hull
%       Gamma - the dihedral angle of the hydrofoil (also describes hull
%           triangular part)
%       L_H - length of the hull
%       rho_w - water density
%       W - width of the hull
%   Output:
%   R_H - Resistance force experienced by the hull
%   B_H - Buoyancy
H_V = 0.5*Pars.W_H*sin(Pars.Gamma);

if(h >= Pars.H_h+H_V)
    S_H_wet = Pars.W_H*Pars.L_H/cos(Pars.Gamma) + Pars.L_H*(h-Pars.H_h-H_V);
elseif(h >= Pars.H_h)
    S_H_wet = 2*Pars.L_H/(cos(Pars.Gamma)*sin(Pars.Gamma))*(h-Pars.H_h);
else
    S_H_wet = 0;
end

m =(0.012-0.01)/(20-2);
b = 0.01;

f = m*(Pars.L_H/0.3048)+b;
a = f*S_H_wet/0.3048^2;
%0.51444444
Hydroplanning_Resistance = (a*(V*1.94384)^2)*4.44822;

if(Hydroplanning_Resistance<0)
    error('Negative Resistance');
end

C_v = V/sqrt(9.81*Pars.W_H);

C_r = 0.0011*C_v^3 - 0.0221*C_v^2 + 0.1062*C_v - 0.0149;

delta = Hull_Buoyancy(h,Pars);

C_delta = delta/(Pars.rho_w*Pars.W_H^3*9.81);
C_delta_0 = Pars.TOM/(Pars.rho_w*Pars.W_H^3);

C_r_corr = C_r*C_delta/C_delta_0;

if(C_v < 0.289245)
    C_r_corr = 0.04838629156*C_v;
end

Water_Resistance = C_r_corr*Pars.rho_w*Pars.W_H^3*9.81;

R_H = Hydroplanning_Resistance + Water_Resistance;

