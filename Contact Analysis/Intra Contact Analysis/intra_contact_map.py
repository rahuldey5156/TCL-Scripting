import os
import numpy as np
import pandas as pd

# Get list of all .dat files in the current directory
dat_files = [f for f in os.listdir() if f.endswith('.dat')]

# List to store the data from all files
data_list = []

# Loop through each .dat file in the current directory
for filename in dat_files:
    # Load the data, assuming space or tab as delimiter and ignoring the first row (header)
    data = np.loadtxt(filename)
    data_list.append(data)

# Convert list of arrays into a 2D array
data_array = np.array(data_list)
average = np.mean(data_array, axis=0)

#Save this to a datafile
np.savetxt('intra_contact.dat', average, delimiter='\t')







