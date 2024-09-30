source bigdcd.tcl

set out1 [open "tau_pentamer_hydrophobic_sasa.dat" w]

proc dist { frame } {

        global prot chainC_hydrophob out1

	set chainC_hydrophob_solv [measure sasa 1.4 $prot -restrict $chainC_hydrophob]

        puts $out1 "$chainC_hydrophob_solv"

        puts "$frame"

}

set sys1 [mol new protein_0ns.pdb]

set prot [atomselect top "protein"]
set chainC_hydrophob [atomselect top "protein and hydrophobic"]

bigdcd dist auto combine.xtc

bigdcd_wait

