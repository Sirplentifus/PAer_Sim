function [ B_H ] = Hull_Buoyancy( h, Pars )
%Hull_Forces - Computes the buoyancy of the hull at water level h
%   Input:
%   h - water depth measured from bottom of hydrofoil
%   Pars -y all the necessary parameters. Must contain:
%       H_h - the distance between the hydrofoil and the hull
%       Gamma - the dihedral angle of the hydrofoil (also describes hull
%           triangular part)
%       L_H - length of the hull
%       rho_w - water density
%       W - width of the hull
%   Output:
%   B_H - Buoyancy
H_V = 0.5*Pars.W_H*sin(Pars.Gamma);

if(h >= Pars.H_h+H_V)
    S_H_front = 0.5*H_V*Pars.W_H + (h-Pars.H_h-H_V)*Pars.W_H;
elseif(h >= Pars.H_h)
    S_H_front = 0.5*(h-Pars.H_h)*Pars.W_H;
else
    S_H_front = 0;
end

V_H = S_H_front*Pars.L_H;
B_H = V_H*Pars.rho_w*9.81;


