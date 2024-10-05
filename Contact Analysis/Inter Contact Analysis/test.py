import pandas as pd
import numpy as np
import MDAnalysis as mda

#Path of contact map file
file = pd.read_csv("inter_contact.dat", header=None, delim_whitespace=True)

#Converting all rows into columns
df1 = pd.DataFrame(file)
data1 = df1.values.flatten()

df2 = pd.DataFrame(data1)

#Path of pdb file
u = mda.Universe("protein_0ns.pdb")
sel = u.select_atoms("all")

#No of residues
x = sel.residues.resids
#Getting resnames
y = sel.residues.resnames

results = []

#Creating list of possible residues in contact
for i in range(len(x)):
    for j in range(len(x)):
        results.append([x[i], y[i], x[j], y[j]])

final_result = np.array(results)
res = np.unique(final_result, axis=0)

df_array = pd.DataFrame(res)

result = pd.concat([df_array, df2], axis=1, ignore_index=True)

datas = pd.DataFrame(result)
datas[0] = pd.to_numeric(datas[0], errors='coerce')
datas[2] = pd.to_numeric(datas[2], errors='coerce')
datas[4] = pd.to_numeric(datas[4], errors='coerce')

#Conditions for checking contacts
for i in range(len(datas.iloc[:,0])):
    if datas.iloc[i,0] - datas.iloc[i,2] > 5 and datas.iloc[i,4] >= 0.2:   #We are identifying residues that have a gap > 5 and the contact >= 0.2
        print(datas.iloc[i,0], datas.iloc[i,1], datas.iloc[i,2], datas.iloc[i,3], datas.iloc[i,4])
