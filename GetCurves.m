function [ hs, R_H, D_h, D_w, D, B_H, L_h, L_w, L, a ] = GetCurves( vs, Pars )
%GetCurves - Obtain the evolution of the forces
%   Input:
%   vs - velocities in which to calculate the forces
%   Pars - relevant parametres (all of them)
%   Output:
%   hs - depth of submergence (measured from the bottom of the hydrofoil)
%   R_H - hull resistance
%   D_h - hydrofoil drag
%   D_w - wing drag
%   D - total drag
%   B_H - hull buoyancy
%   L_h - hydrofoil lift
%   L_w - wing lift
%   L - total lift
%   a - total horizontal acceleration

h = (Pars.H_h+Pars.H_V+Pars.H_P); %To serve as first guess
hs = zeros(size(vs));
R_H = zeros(size(hs));
D_h = zeros(size(hs));
D_w = zeros(size(hs));

B_H = zeros(size(hs));
L_h = zeros(size(hs));
L_w = zeros(size(hs));

a = zeros(size(hs));
for i = 1:length(vs)
    V = vs(i);
    h = fzero(@(h)Vertical_Force(V,h,Pars), h);
    hs(i) = h;
    R_H(i) = Hull_Resistance(V, hs(i), Pars);    
    D_h(i) = Hydrofoil_Drag( V, hs(i), Pars );
    D_w(i) = Wing_Drag( V, Pars );
    
    B_H(i) = Hull_Buoyancy( hs(i), Pars);
    L_h(i) = Hydrofoil_Lift(V, hs(i), Pars);
    L_w(i) = Wing_Lift(V, Pars);
    
    a(i) = Horizontal_Acceleration( V, h, Pars );
end

D = R_H + D_h + D_w;
L = B_H + L_h + L_w;

end

