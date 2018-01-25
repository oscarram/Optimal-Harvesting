import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

def fun(x, t, params):
	r, M, alpha= params;
	return r*x*(1.0-x/M)-(r*M/4.0);

r=0.8; M=780500.0; alpha=9.9;
params=[r, M, alpha]

tStop=12.0;
tInc=1./1200.;
t= np.arange(0.0, tStop, tInc)
x0=0.45*M;


# Call the ODE solver
psoln = odeint(fun, x0, t, args=(params,))

fig = plt.figure(1, figsize=(8,8))

# Plot theta as a function of time
ax1 = fig.add_subplot(111)
ax1.plot(t, psoln)
ax1.set_xlabel('time')
ax1.set_ylabel('x')


# Plot theta as a function of time
#ax2 = fig.add_subplot(211)
#ax2.plot(t, control(t))
#ax2.set_xlabel('time')
#ax2.set_ylabel('x')

plt.tight_layout()
plt.show()
