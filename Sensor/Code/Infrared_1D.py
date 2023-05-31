import u3
import time
import numpy as np
import matplotlib.pyplot as plt
import scipy
d = u3.U3()
Distance = []
Time = []
t = 0
maxT = 3
def f(x, a):
    return x*0+a
while t < maxT: 
    ainValue = d.getAIN(0)
    Distance.append(ainValue)
    Time.append(t)
    time.sleep(0.01)
    t += 0.01
d.close()
popt, pcov = scipy.optimize.curve_fit(f, Time, Distance)
perr = np.sqrt(np.diag(pcov))
print(popt, perr)

