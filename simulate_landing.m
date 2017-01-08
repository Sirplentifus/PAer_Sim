function [V,t,D] = simulate_landing(Pars, plot)
%simulate - Simulates the take-off process
%   Input:
%   Pars - relevant parameters (all of them)
%   plot - 

if(nargin>=2 && plot)
    opts=odeset('Events',@(t,V)events(t,V,Pars),'OutputFcn',@odeplot);
else
    opts=odeset('Events',@(t,V)events(t,V,Pars));
end

[t,V]=ode45(@(t,V)odefun_landing(t,V,Pars),[0 500],Pars.v_TOF*1.2,opts);

D = trapz(t, V);

end

function [value,isterminal,direction] = events(~,V,Pars)
% Locate the time when velocity passes through zero in a decreasing 
% direction and stop integration.
value = V-0.5; % detect v = 0
isterminal = 1; % stop the integration
direction = -1; % negative direction
end

function [acc] = odefun_landing(~,V, Pars)
h = depth(0,Pars);
acc = -(Hull_Resistance( V, h, Pars ) + Wing_Drag( V, Pars ))/Pars.TOM;
end

function [h] = depth(V, Pars)
    if(V >= Pars.v_TOF)
        h = -1e-3;
    else
        h = fzero(@(h)Vertical_Force(V,h,Pars), 1.001); 
    end
end