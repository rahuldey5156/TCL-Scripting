source bigdcd.tcl

set out1 [open "SASA.dat" w]

proc dist { frame } {

        global prot out1

	set chainC_hydrophob_solv [measure sasa 1.4 $prot]

        puts $out1 "$chainC_hydrophob_solv"

        puts "$frame"

}

set sys1 [mol new protein_0ns.pdb]

set prot [atomselect top "protein"]

bigdcd dist auto combine.xtc

bigdcd_wait

exit
