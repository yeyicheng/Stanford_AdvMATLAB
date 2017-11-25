clc;
clear all;

syms rho u v p e gamma c

% Find e with respect to p
e = solve(p == (gamma-1)*(e-rho*(u^2+v^2)/2), e);

% Define quantities
U = [rho;rho*u;rho*v;e];
V = [rho;u;v;p];
F = [rho*u;rho*(u^2)+p;rho*u*v;(e+p)*u];
G = [rho*v;rho*v*u;rho*(v^2)+p;(e+p)*v];

% Compute jacobians
dUdV = jacobian(U,V);
dFdV = jacobian(F,V);
dGdV = jacobian(G,V);

% Find expressions for A and B
A = dUdV\dFdV;
B = dUdV\dGdV;

% Eliminate gamma and p with equation gamma*p == rho*c^2
A = subs(A, gamma*p, rho*c^2);
B = subs(B, gamma*p, rho*c^2);

% Eigenvalue decomposition
[vecA, valA] = eig(A);
[vecB, valB] = eig(B);