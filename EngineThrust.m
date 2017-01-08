function [ T ] = EngineThrust( V, Pars )
%EngineThrust - Computes the engine thrust as a function of velocity and
%other parameters
%   Input:
%   V - Aircraft speed. Unused for now
%   Pars - Relevant parametres. None used for now.
%   Output:
%   T - Total Engine thrust (for all engines combined)

vs = (0:0.025:0.25)*340.3;
ts = [100, 97.5, 95, 94, 94, 89, 92, 92.5, 96, 95, 92.5]*1e-2*0.966457143;


T = 46e3*interp1(vs,ts,V);

end

