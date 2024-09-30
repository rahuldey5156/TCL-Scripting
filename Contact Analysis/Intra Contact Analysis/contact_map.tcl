set out1 [open "A.dat" w]

set sys [mol new protein_0ns.pdb]
mol addfile combine.xtc step 2 waitfor all

set nf [molinfo top get numframes]

for {set res 306} {$res < 379} {incr res} {
        set sc1 [atomselect top "(chain A) and (resid $res) and (not hydrogen)"]

        set row ""

        for {set r2 306} {$r2 < 379} {incr r2} {
                set count 0.0
                set sc2 [atomselect top "(chain A) and (resid $r2) and (not hydrogen)"]

                for {set f 0} {$f < $nf} {incr f } {
                        molinfo top set frame $f
                        $sc1 update
                        $sc2 update

                        set con [measure contacts 7.0 $sc1 $sc2]

			set con1 [llength [lindex $con 0]]

                        if {$con1 >= 1.0} {
                                set count [expr {$count + 1}]
                        }
                }
                mol delete $sc2
                set prob [expr {$count/(1.0*$nf)}]

                lappend row "$prob"
        }
        mol delete $sc1
        puts $out1 "$row"

        unset row
        puts "fin res: $res"

}
mol delete $sys
close $out1






