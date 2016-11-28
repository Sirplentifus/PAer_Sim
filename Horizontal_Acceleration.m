function [ a_H ] = Horizontal_Acceleration( V, h, Pars )
%Horizontal_Acceleration - Compute horizontal acceleration

F_H = EngineThrust( V, Pars ) - Hydrofoil_Drag( V, h, Pars ) ...
    - Hull_Resistance( V, h, Pars ) - Wing_Drag( V, Pars );
a_H = F_H/Pars.TOM;

end

