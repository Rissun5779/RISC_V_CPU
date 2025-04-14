C++:
	If i, k stored in $s3, $s5, seven[0] base address stored in $s6.

	while(seven[i]=k)
		i=i+1;

Mips;

Loop:
	sll 	 $t0, $s3, 2
	add	 $t0, $t0, $s6
	lw	 $t1, 0($t0)
	bne	 $t1, $s5, exit
	addi 	 $s3, $s3, 1
	j	 Loop

exit:
	exit
