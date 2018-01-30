using DifferentialEquations
using Plots; plotly(); # Using the Plotly backend

ss=0.1;
x0=1/2
TH=6.3
f(u,p,t) = u*(1-u)-1/4
g(u,p,t) = ss*u
dt = 1//(2^(4))
tspan = (0.0,TH)
prob = SDEProblem(f,g,x0, tspan)


sol = solve(prob,SRIW1(),dt=dt)
plot(sol, ylims=(0, 1))

monte_prob = MonteCarloProblem(prob)
sol = solve(monte_prob,num_monte=2300,paralle_type=:threads)
summ = MonteCarloSummary(sol,0:0.01:TH)
plot(summ,labels="Middle 95%", ylims=(0,1))
summ = MonteCarloSummary(sol,0:0.01:TH; quantiles=[0.25,0.75])
plot!(summ,labels="Middle 50%",ylims=(0,1), legend=true)
plot(sol)
