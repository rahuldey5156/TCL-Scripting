set out [open "chainA_sp.dat" w]

set scale 180.0
set sysref [mol new protein_0ns.pdb]
set sys [mol new protein_0ns.pdb]
mol addfile try1.xtc waitfor all


set nf [molinfo $sys get numframes]
puts $nf

for {set f 0} {$f <= $nf} {incr f} {
	molinfo $sys set frame $f
#*	set t [expr {($f*1.0)/1000.0}]
	set t [expr {($f*1.0)/1.0}]
	puts "Frame: $t"
		
	# For each segment of interest (choose firstres and lastres accordingly):

	set sum 0.0
	set fres_b1 307
	set lres_b1 377
	set nres_b1 [expr {($lres_b1 - $fres_b1) + 1}]
        for {set d1 307} {$d1 <= 377} {incr d1} {
	        set sel_ref1 [atomselect $sysref "(chain A) and (resid $d1) and (name CA)"]
	        set n [$sel_ref1 get resname]
		 if {$n != "GLY"} {
#		puts "**B1"
        	set ref_phi1 [$sel_ref1 get phi]
        	set ref_psi1 [$sel_ref1 get psi]
		$sel_ref1 delete	
	
                set sel_b1 [atomselect $sys "(chain A) and (resid $d1) and (name CA)"]
#        	puts "!!B1"
	        set curr_phi1 [$sel_b1 get phi]
                set curr_psi1 [$sel_b1 get psi]
                set delphi1 [expr {$curr_phi1 - $ref_phi1}]
                set delpsi1 [expr {$curr_psi1 - $ref_psi1}]
                set mphi1 [expr {$delphi1/$scale}]
                set mpsi1 [expr {$delpsi1/$scale}]
                set np1 [expr {abs($mphi1)}]
                set ns1 [expr {abs($mpsi1)}]
                set sum [expr {$sum + ((exp(-1*$np1))*(exp(-1*$ns1)))}]
		$sel_b1 delete
		unset ref_phi1 ref_psi1 curr_phi1 curr_psi1 delphi1 delpsi1 mphi1 mpsi1 np1 ns1 
	}
}
        set pval [expr {$sum/62}] 
        puts $out "$t $pval"
	#unset sum_b1


}
close $out
exit

