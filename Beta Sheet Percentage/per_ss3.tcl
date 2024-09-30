set out1 [open "total_percentage_beta_sheet.dat" w]

set first 0
set last 3002

for {set f $first} {$f < $last} {incr f} {

	mol new protein_0ns.pdb
	mol addfile combine.xtc first $f last $f waitfor all

	set sel [atomselect top "sheet and name CA"]
	
	set t [$sel num]

	mol delete top

	puts $out1 "$t"

}

close $out1
exit
