using DifferentialEquations
using Plots; pyplot();
 
x0=1/2
pr=1/4

f(u,p,t) = u*(1-u)-pr
dt = 1//(2^(4))
tspan = (0.0,5.0)


C1(x)=1/2+sqrt(1/4-x)
C2(x)=1/2-sqrt(1/4-x)

prob = ODEProblem(f,x0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
plot(sol,linewidth=1, xaxis="Time (t)", yaxis="u(t) (in number of fishes)", label="0.5M", ylims=(0, 2))
for i=0.1:0.05:1.2
	prob = ODEProblem(f,2*i*x0,tspan)
	sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
	display(plot!(sol,linewidth=1, label="$(i)M", ylims=(0, 2)))
end
plot!(sol.t, t->1,lw=3,ls=:dash,label="Maximum Capacity")
plot!(sol.t, t->C1(pr),lw=3,ls=:dash,label="Stable Equilibrium Point")
#plot!(sol.t, t->C2(pr),lw=3,ls=:dash,label="Unstable Equilibrium Point")

