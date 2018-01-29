using DifferentialEquations
using Plots; pyplot();
 
r=0.8
M=780500
x0=M/2
pr=r/2

f(u,p,t) = r*u*(1-u/M)-pr*u
dt = 1//(2^(4))
tspan = (0.0,10.0)


C1(x)=M
C2(x)=0.0

prob = ODEProblem(f,x0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
plot(sol,linewidth=2, xaxis="Time (t)", yaxis="u(t) (in number of fishes)", label="0.5M")
for i=0.15:0.15:1.8
	prob = ODEProblem(f,2*i*x0,tspan)
	sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
	display(plot!(sol,linewidth=2, label="$(i)M"))
end
plot!(sol.t, t->C2(t),lw=3,ls=:dash,label="Unstable Equilibrium Point")
plot!(sol.t, t->C1(t)/2,lw=3,ls=:dash,label="Stable Equilibrium Point")
plot!(sol.t, t->C1(t),lw=3,ls=:dash,label="Stable Equilibrium Point")

