function [ a_H ] = Horizontal_Acceleration( V, h, Pars )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

F_H = EngineThrust( V, Pars ) - Hydrofoil_Drag( V, h, Pars ) ...
    - Hull_Resistance( V, h, Pars ) - Wing_Drag( V, Pars );
a_H = F_H/Pars.TOM;

end

