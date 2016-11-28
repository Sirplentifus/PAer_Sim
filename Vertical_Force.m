function [ F_V ] = Vertical_Force( V, h, Pars )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

L = Hull_Buoyancy(h, Pars) + Hydrofoil_Lift(V, h, Pars) + Wing_Lift(V, Pars);
F_V = L- Pars.TOW;

end

