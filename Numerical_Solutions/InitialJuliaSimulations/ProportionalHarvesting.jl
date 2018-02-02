using DifferentialEquations
using Plots; pyplot();
 
r=0.8
M=780500
x0=M*0.5
pr=0.531176
#pr=0.631176
f(u,p,t) = r*u*(1-u/M)-pr*r*u
dt = 1//(2^(4))
tspan = (0.0,24.0)

C1(x)=M
C2(x)=0.0

prob = ODEProblem(f,x0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
Nfishes(t)=r*pr*sol(t)
quadgk(Nfishes, 0, 24.0)
