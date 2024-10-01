source bigdcd.tcl

set out1 [open "number_water.dat" w]

proc dist { frame } {

	global out1

	set sel2 [atomselect top "name OW and within 3.8 of protein"]

	set n1 [$sel2 num]

	puts $out1 "$n1"

	puts "$frame"

}

set sys1 [mol new system_0ns.pdb]

bigdcd dist auto combine.xtc

bigdcd_wait

exit
