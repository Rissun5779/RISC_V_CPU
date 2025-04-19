;i, j, k in $s0, $s1, $s2 ,and A[0] in $s3.
;C:
;  k=0;
;  k=i+1;
;  j=A[k];

start:
   add	$s2, $0, $0
   addi $s2, $s0, 1
   sll  $t0, $s2, 2
   add  $t1, $t0, $s3 =>1
   lw   $s1, 0($t1)   =>1


; f=g-A[5], f,g,h,i,h => $s0~$s4
; A[0] $s5, B[0] $s6
start:
	lw     $t0, 20($s5)
	sub    $s0, $s1, $t0


; f=g-A[B[2]],f,g,h,i,h => $s0~$s4
; A[0] $s5, B[0] $s6
start:
	lw     $t0, 8($s6)
	sll    $t0, $t0, 2
	add    $t1, $t0, $s5
	lw     $t2, 0($t1)
	sub    $s0, $s1, $t2

; f=(16*i-8)/4, f,g,h,i,h => $s0~$s4
; A[0] $s5, B[0] $s6
start:
	sll    $t0, $s3, 4
	addi   $t1, $t0, -8
	srl    $t1, $t1, 2
	add    $s0, $t1, $0	 	
	

	
