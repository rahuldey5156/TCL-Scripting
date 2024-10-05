import os

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.ticker import MultipleLocator
plt.rcParams["font.family"] = "Times New Roman"

plt.rcParams.update({'font.size': 22})
plt.rcParams['axes.linewidth'] = 1.5

data_file = 'inter_contact.dat'
data = pd.read_csv(data_file, header=None, delim_whitespace=True)
data[data > 1.0] = np.nan
#data[data < -8.0] = np.nan


### Change these values if you need
axes_limits = [1, 73]
axes_limits1 = [1, 73]
delta = 100
cbar_labels = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]


##the 100 sets the number of color bings to make, helps make the plot become smooth
cmap = plt.get_cmap('Blues',delta)
#Sets any value that appears over the vmax (maximum value) to be white
cmap.set_over('white')
#Creates 1000 levels, this will force the plot to become smooth
levels = [x for x in np.arange(0,1.0,0.01)]
plt.contourf([x for x in range(axes_limits[0], axes_limits[1] + 1)], [x for x in range(axes_limits1[0], axes_limits1[1] + 1)], data, delta, cmap = cmap, vmin=0.0, vmax=1.0)

ax = plt.gca()

ax.tick_params(which='both', length=8, width=1.5, direction = 'in',labelsize=24)
ax.tick_params(which='minor', length=4, width = 1.5)

#ax.xaxis.set_major_locator(MultipleLocator(10))
#ax.yaxis.set_major_locator(MultipleLocator(10))

plt.xlabel('residue index', fontsize = 30)
plt.ylabel('residue index', fontsize = 30)

plt.xticks(fontsize = 30)
plt.yticks(fontsize = 30)

ax.set_xticks(np.arange(5,74,20))
ax.set_yticks(np.arange(5,74,20))
plt.grid(visible=True, which='major')
cbar = plt.colorbar()

cbar.ax.tick_params(labelsize=26)
cbar.set_ticks(cbar_labels)
ax.tick_params(which='both',length=6,width=1.5,labelsize=24)
ax.set_xticklabels(np.arange(310,379,20))
ax.set_yticklabels(np.arange(310,379,20))

plt.tight_layout()
plt.show()
