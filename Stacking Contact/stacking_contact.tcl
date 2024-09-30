set out1 [open stacking_contact.dat w]

set sys [mol new protein_0ns.pdb]
mol addfile combine.xtc waitfor all

set x1 [atomselect $sys "chain A and not hydrogen"]
set y1 [atomselect $sys "chain B and not hydrogen"]

set x2 [atomselect $sys "chain C and not hydrogen"]
set y2 [atomselect $sys "chain D and not hydrogen"]

set x3 [atomselect $sys "chain E and not hydrogen"]

set all [atomselect $sys all]

set nf [molinfo top get numframes]

for {set f 0} {$f < $nf} {incr f} {

	molinfo top set frame $f
	$all update

	set c [measure contacts 5.0 $x1 $y1]
	set t [lindex $c 0]
	set p [llength $t]

	set c2 [measure contacts 5.0 $y1 $x2]
        set t2 [lindex $c2 0]
        set p2 [llength $t2]

	set c4 [measure contacts 5.0 $x2 $y2]
        set t4 [lindex $c4 0]
        set p4 [llength $t4]

	set c6 [measure contacts 5.0 $y2 $x3]
        set t6 [lindex $c6 0]
        set p6 [llength $t6]

	set total_Hbond [expr {$p+$p2+$p4+$p6}]
	puts $out1 "$total_Hbond"

}

close $out1
exit
