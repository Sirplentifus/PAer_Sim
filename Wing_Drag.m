function [ D_w ] = Wing_Drag( V, Pars )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

CD_wing = Pars.CD_0_wing + Pars.k_wing*Pars.CL_wing^2;
D_w = 0.5*Pars.rho_a*V^2* CD_wing*Pars.S_wing;

end

