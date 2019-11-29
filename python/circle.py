# -- coding = utf-8 --

import numpy as np
import matplotlib.pyplot as plt

r = 2.0
a,b = (0., 0.)

theta = np.arange(0, 2*np.pi, 0.01)

x = a + 1.3 * r * np.cos(theta)
y = b + r * np.sin(theta)
z = np.cos(theta)
x1 = a + 1.8 * r * np.cos(theta)
x_egg = []
for i in z:
    if i < 0:
        x_egg.append(a + 1.4 * r * i)
    else:
        x_egg.append(a + 1.9 * r * i)
fig = plt.figure() 
axes = fig.add_subplot(111) 

# axes.plot(x, y)
# axes.plot(x1, y)
axes.plot(x_egg,y)
axes.axis('equal')
plt.show()

'''
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse

fig = plt.figure(0)
ax = fig.add_subplot(111, aspect='equal')
e = Ellipse(xy = (0,2), width = 1.81 * 2, height = 0.94 * 2, angle = 27.6)
ax.add_artist(e)

e.set_facecolor("blue")
plt.xlim(-2, 2)
plt.ylim(0.5, 3.5)
ax.grid(True)
plt.title("50% Probablity Contour - Homework 4.2")

plt.show()
'''
