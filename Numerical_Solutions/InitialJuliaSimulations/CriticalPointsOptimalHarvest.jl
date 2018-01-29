using DifferentialEquations
using Plots; pyplot();
 
f(u) = u.*(1-u)
x = linspace(0,1,2000);
y=f(x)
p=plot(x, x->0,lw=4,ls=:dash,label="x-Axis")
for i=0.0:0.05:0.6
	y=f(x)-i
	display(plot!(x,y,xaxis="x", yaxis="dx/dt", lw=3, label="h=$(i)rM", xlims=(0,1),  ylims=(-1/5, 1/4)))
end


#C1(x)=M
#C2(x)=0.0

#prob = ODEProblem(f,x0,tspan)
#sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
#plot(sol,linewidth=2, xaxis="Time (t)", yaxis="u(t) (in number of fishes)", label="0.5M")
#for i=0.3:0.3:1.8
#	prob = ODEProblem(f,2*i*x0,tspan)
#	sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
#	display(plot!(sol,linewidth=2, label="$(i)M"))
#end
#plot!(sol.t, t->C2(t),lw=3,ls=:dash,label="Unstable Equilibrium Point")
#plot!(sol.t, t->C1(t),lw=3,ls=:dash,label="Stable Equilibrium Point")
