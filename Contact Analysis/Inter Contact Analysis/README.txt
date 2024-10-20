Step 1. Identify the pair of chains that are in contact
Step 2. Name the output file accordingly as per the chains in the tcl script
Step 3. Replace the chain ids in contact and their start and end resids in the tcl script
Step 4. Run the tcl script to get the inter contact
Step 5. Repeat the same steps for the other pairs of chains in contact
Step 6. After calculating the contacts for all the pairs, run the script inter_contact_map.py
Step 7. To generate the plot of inter contact, run the script inter_contact_plot.py

Additional Step: To identify the residues that have contacts higher than a specific required value, run the script test.py
To run this step, inter_contact.dat and pdb file is required.

###########################

Requirement:
1. pdb file
2. xtc file
