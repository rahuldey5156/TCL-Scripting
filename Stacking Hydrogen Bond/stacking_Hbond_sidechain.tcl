set out1 [open stacking_Hbond_sidechain.dat w]

set sys [mol new protein_0ns.pdb]
mol addfile combine.xtc waitfor all

set x1 [atomselect $sys "chain A and sidechain"]
set y1 [atomselect $sys "chain B and sidechain"]

set x2 [atomselect $sys "chain C and sidechain"]
set y2 [atomselect $sys "chain D and sidechain"]

set x3 [atomselect $sys "chain E and sidechain"]

set all [atomselect $sys all]

set nf [molinfo top get numframes]

for {set f 0} {$f < $nf} {incr f} {

	molinfo top set frame $f
	$all update

	set c [measure hbonds 3.0 20 $x1 $y1]
	set t [lindex $c 0]
	set p [llength $t]

	set c1 [measure hbonds 3.0 20 $y1 $x1]
        set t1 [lindex $c1 0]
        set p1 [llength $t1]

	set c2 [measure hbonds 3.0 20 $y1 $x2]
        set t2 [lindex $c2 0]
        set p2 [llength $t2]

	set c3 [measure hbonds 3.0 20 $x2 $y1]
        set t3 [lindex $c3 0]
        set p3 [llength $t3]

	set c4 [measure hbonds 3.0 20 $x2 $y2]
        set t4 [lindex $c4 0]
        set p4 [llength $t4]

	set c5 [measure hbonds 3.0 20 $y2 $x2]
        set t5 [lindex $c5 0]
        set p5 [llength $t5]

	set c6 [measure hbonds 3.0 20 $y2 $x3]
        set t6 [lindex $c6 0]
        set p6 [llength $t6]

	set c7 [measure hbonds 3.0 20 $x3 $y2]
        set t7 [lindex $c7 0]
        set p7 [llength $t7]

	set total_Hbond [expr {$p+$p1+$p2+$p3+$p4+$p5+$p6+$p7}]
	puts $out1 "$total_Hbond"

}

close $out1
exit
