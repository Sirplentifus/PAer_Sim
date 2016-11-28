function [ hs, R_H, D_h, D_w, D, B_H, L_h, L_w, L, a ] = GetCurves( vs, Pars )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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

