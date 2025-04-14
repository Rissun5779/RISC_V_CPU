// 假設 i 和 n 分別儲存在 $s3 和 $s4，數組的基底地址儲存在 $s6。
// 目的是找到第一個大於 n 的數字，並將該數字儲存在 $s5。

C:
int i = 0;
while (seven[i] <= n) {
    i = i + 1;
}

s5 = seven[i];  // 將找到的數字儲存在 $s5

Mips:

.text
.global	main

main:
	add	 $s3, $0, $0

Loop:
	sll	 $t0, $s3, 2
	add	 $t1, $t0, $s6
	lw	 $t2, 0($t1)
	bgt	 $t2, $s4, exit
	addi	 $s3, $s3, 1
	j	 Loop

exit:
	add	 $s5, $0, $t2
	li	 $v0, 10
	syscall
