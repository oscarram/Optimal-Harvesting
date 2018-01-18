#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

def f(y, t, params):
    P, lamb = y      # unpack current values of y
    r, M, alpha, z0, z1 = params  # unpack parameters
    derivs = [P, -r*lamb]      # list of dy/dt=f functions
    return derivs

#For this implementation we assume fixed grid with constant 
def fn(yn,t,T):
	s= t[1]-t[0]
	

# Parameters
r = 0.8          # quality factor (inverse damping)
M = 780500.0         # forcing amplitude
alpha = 0.5     # drive frequency

# Initial values
P0 = 389482.0     # initial Popultation
lamb0 = r*M/4     # initial angular velocity

# Bundle parameters for ODE solver
params = [r, M, alpha, np.sin, np.cos]

# Bundle initial conditions for ODE solver
y0 = [P0, lamb0]

# Make time array for solution
tStop = 200.
tInc = 0.05
t = np.arange(0., tStop, tInc)

# Call the ODE solver
psoln = odeint(f, y0, t, args=(params,))

# Plot results
fig = plt.figure(1, figsize=(8,8))

# Plot theta as a function of time
ax1 = fig.add_subplot(311)
ax1.plot(t, psoln[:,0])
ax1.set_xlabel('time')
ax1.set_ylabel('theta')

# Plot omega as a function of time
ax2 = fig.add_subplot(312)
ax2.plot(t, psoln[:,1])
ax2.set_xlabel('time')
ax2.set_ylabel('omega')

# Plot omega vs theta
ax3 = fig.add_subplot(313)
twopi = 2.0*np.pi
ax3.plot(psoln[:,0]%twopi, psoln[:,1], '.', ms=1)
ax3.set_xlabel('theta')
ax3.set_ylabel('omega')
ax3.set_xlim(0., twopi)

plt.tight_layout()
plt.show()
