using DifferentialEquations
using Plots; pyplot();
 
r=0.8
M=780500
x0=M*0.45
etas=20.0
TH=12.0
FBSc=0.5

Joker(u,p,t)=0;
lam0=0.011

dt = 1//(3^(3))
tspan=(0.0, TH)





probX = ODEProblem(Joker,x0,tspan)
solX = solve(probX,Tsit5(),reltol=1e-8,abstol=1e-8)

lam0=solX(TH)-M/2
probL = ODEProblem(Joker,-M/2,tspan)
solL = solve(probL,Tsit5(),reltol=1e-8,abstol=1e-8)

par=[solL, solX]

function f(u,p,t)
	bt=TH-t
	return r*u*(1-u/M)-r*M/4-(solL(bt))/etas
end

function g(u,p,t)
	bt=TH-t
	return  u*r+solX(bt)-M/2.0-2.0*u*r*(solX(bt))/M
end

for i in 1:100
	probX = ODEProblem(f,x0,tspan)
	solX = solve(probX,Tsit5(),reltol=1e-8,abstol=1e-8)

	lam0 = solX(TH)-M/2
	function g(u,p,t)
		bt=TH-t
		return  u*r+solX(bt)-M/2.0-2.0*u*r*(solX(bt))/M
	end
	
	tmpSol=solL
	probL = ODEProblem(g,lam0,tspan)
	solL = solve(probL,Tsit5(),reltol=1e-8,abstol=1e-8)
	counter=1;
	delta=0
	for tt in solL.t
		solL.u[counter]=FBSc*solL(tt)+(1-FBSc)*tmpSol(tt)
		delta=delta+abs(solL(tt)-tmpSol(tt))
		counter=counter+1
	end
	function f(u,p,t)
		bt=TH-t
		return r*u*(1-u/M)-r*M/4-(solL(bt))/etas
	end
end
counter=1;
harvest=solL
for tt in solL.t
	tmpT=TH-tt
	harvest.u[counter]=r*M/4+solL(tmpT)/etas
	counter=counter+1
end
plot(harvest)
plot!(solX)
Nfishes(t)=harvest(t)
quadgk(Nfishes, 0, TH)
