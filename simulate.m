function [V,t,D] = simulate(Pars, plot)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if(nargin>=2 && plot)
    opts=odeset('Events',@(t,V)events(t,V,Pars),'OutputFcn',@odeplot);
else
    opts=odeset('Events',@(t,V)events(t,V,Pars));
end

[t,V]=ode45(@(t,V)odefun(t,V,Pars),[0 500],0,opts);

D = trapz(t, V);

end

function [value,isterminal,direction] = events(~,V,Pars)
% Locate the time when submergence passes through zero in a decreasing 
% direction and stop integration.
value = fzero(@(h)Vertical_Force(V,h,Pars), 1); % detect h = 0
isterminal = 1; % stop the integration
direction = -1; % negative direction
end

function [acc] = odefun(~,V, Pars)

h = fzero(@(h)Vertical_Force(V,h,Pars), 1.001); 
acc = Horizontal_Acceleration(V, h, Pars);
end