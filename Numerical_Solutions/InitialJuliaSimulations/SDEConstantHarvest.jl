using DifferentialEquations
using Plots; plotly(); # Using the Plotly backend

r=0.8
M=780500
x0=M/2
ss=500;
f(t,u) = r*u*(1-u/M)-r*M/4
g(t,u) = ss*u
dt = 1//(2^(4))
tspan = (0.0,10.0)
prob = SDEProblem(f,g,x0,(0.0,10.0))


sol = solve(prob,SRIW1(),dt=dt)
plot(sol)

monte_prob = MonteCarloProblem(prob)
sol = solve(monte_prob,num_monte=1000,paralle_type=:threads)
summ = MonteCarloSummary(sol,0:0.01:10)
plot(summ,labels="Middle 95%")
summ = MonteCarloSummary(sol,0:0.01:10; quantiles=[0.25,0.75])
plot!(summ,labels="Middle 50%",legend=true)
plot(sol)
