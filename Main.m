Pars.H_h = 1;%m Hidrofol to Hull distance
Pars.Gamma = deg2rad(20); 
Pars.L_H = 10;%m
Pars.rho_w = 1000; %Kg/m^3
Pars.rho_a = 1.225; %Kg/m^3
Pars.W_H = 2.6; %m
Pars.W_h = 2.5; %m
Pars.H_P = 1;
Pars.c_h = 0.001;

Pars.k_wing = 0.0272;
Pars.CD_0_wing = 0.018;
Pars.S_wing = 82; %m^2
Pars.CL_wing = 2.5; %Take-off CL
Pars.TOM = 16000; %Take-off mass
Pars.TOW = Pars.TOM*9.81; %Take-off weight

Pars.H_V = 0.5*Pars.W_H*sin(Pars.Gamma);

%% Optimize for c_h

cs = 0.01:0.01:1;
% TODs = zeros(size(cs));
Ds = zeros(size(cs));
for i = 1:length(cs)
    Pars.c_h = cs(i);
%     [~,~,TOD] = simulate(Pars);
%     TODs(i) = TOD;
    v_TOF = fzero(@(V)Vertical_Force(V,0,Pars), 25);
    vs = [0:0.1:v_TOF]';
    [ ~, ~, ~, ~, D, ~, ~, ~, ~, ~] = GetCurves( vs, Pars );
    Ds(i) = max(D);
end
[~, c_ind] = min(Ds);
Pars.c_h = cs(c_ind)


%% For your viewing pleasure:
close all;

v_TOF = fzero(@(V)Vertical_Force(V,0,Pars), 25);
vs = [0:0.1:v_TOF]';

[ hs, R_H, D_h, D_w, D, B_H, L_h, L_w, L, a ] = GetCurves( vs, Pars );

Ds = [D_w, D_h, R_H];
figure;
area(vs, Ds);
title('Drag force components as a function of m/s velocity');
xlabel('Velocity [m/s]');
ylabel('Drag [N]');
legend('wing', 'hydrofoil', 'hull resistance');

Ls = [L_w, L_h, B_H];
figure;
area(vs, Ls);
title('Lift force components as a function of m/s velocity');
xlabel('Velocity [m/s]');
ylabel('Lift [N]');
legend('wing', 'hydrofoil', 'hull buoyancy');

v_HEM = fzero(@(V)Vertical_Force(V,Pars.H_h,Pars), 25);
v_hSP = fzero(@(V)Vertical_Force(V,Pars.H_V,Pars), 25);
figure; 
hold on;
plot(vs, hs);
plot(v_HEM, Pars.H_h, 'ro')
plot(v_hSP, Pars.H_V, 'ro')
title('Depth of submergence (measured from the bottom of the hydrofoil) vs velocity');

figure;
plot(vs, a);
title('Evolution of acceleration with speed');
xlabel('Speed in m/s');
ylabel('Acceleration in m/s^2');
axis([0 vs(end) 0 max(a)]);

%% Actual simulation

figure;
[V,t,TOD] = simulate(Pars, true);
title('Take-off Simulation');
xlabel('Time in seconds');
ylabel('Speed in m/s');
fprintf('Simulated Take-off distance = %f\n', TOD);


