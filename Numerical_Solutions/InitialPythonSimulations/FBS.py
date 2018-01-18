#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint


def FKutta(t, x, u, f, x0, params):
	h=t[1]-t[0];
	x[0]=x0
	for i in range(0, len(t)-2):
		ti=t[i];
		xi=x[i];
		ui=u[i];
		ui1=u[i+1];
		K1=f(ti, xi, ui, params)
		K2=f(ti+h/2.0, xi+h*K1/2.0, 0.5*(ui+ui1), params)
		K3=f(ti+h/2.0, xi+h*K2/2.0, 0.5*(ui+ui1), params)
		K4=f(ti+h, xi+h*K3, ui1, params)
		x[i+1]=xi+(h/6.0)*(K1+2.0*K2+2.0*K3+K4)
	return [x, u];
	

def BKutta(t, lam, x, u, f, lamT, params):
	h=t[1]-t[0];
	lam[len(t)-1]=lamT;
	for i in range(len(t)-1, 0,-1):
		ti=t[i];
		xi=x[i];
		ui=u[i];
		lami=lam[i]
		xi1=x[i-1]
		ui1=u[i-1];
		K1=f(ti, lami, xi, ui, params)
		K2=f(ti-h/2.0, lami-h*K1/2.0, 0.5*(xi+xi1), 0.5*(ui+ui1), params)
		K3=f(ti-h/2.0, lami-h*K2/2.0, 0.5*(xi+xi1), 0.5*(ui+ui1), params)
		K4=f(ti-h, lami-h*K3, xi1, ui1, params)
		lam[i-1]=lami-(h/6.0)*(K1+2.0*K2+2.0*K3+K4)
	return [x, -lam/alpha, lam];
	


def fun(t, x, u, params):
	r, M, alpha= params;
	return r*x*(1.0-x/M)-r*M/4.0+u;

def lun(t, lam, x, u, params):
	r, M, alpha= params;
#	print(M/2.0 - x-lam*r+2.0*lam*r*x/M)
	return (M/2.0 - x-lam*r+2.0*lam*r*x/M);


r=0.8; M=780500.0; alpha=1.0;
params=[r, M, alpha]

tStop=1.0;
tInc=0.005;
t= np.arange(0.0, tStop, tInc)

x0=2.0;
lamT=0.0;

u=np.ones(len(t));
x=np.ones(len(t));
lam=np.ones(len(t));
for k in range(0, 1000):
	uold=u;
	[x, u] = FKutta(t, x, u, fun, x0, params);
	[x, u, lam]=BKutta(t, lam, x, u, lun, lamT, params);
	u=0.5*(u+uold);


fig = plt.figure(1, figsize=(8,8))

# Plot theta as a function of time
ax1 = fig.add_subplot(311)
ax1.plot(t, x)
ax1.set_xlabel('time')
ax1.set_ylabel('x')

# Plot omega as a function of time
ax2 = fig.add_subplot(312)
ax2.plot(t,lam);
ax2.set_xlabel('time')
ax2.set_ylabel('lam')

# Plot omega vs theta
ax3 = fig.add_subplot(313)
ax3.plot(t, u)
ax3.set_xlabel('time')
ax3.set_ylabel('u')

plt.tight_layout()
plt.show()




