function [ L_w ] = Wing_Lift( V, Pars )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

L_w = 0.5*Pars.rho_a*V^2* Pars.CL_wing*Pars.S_wing;

end

