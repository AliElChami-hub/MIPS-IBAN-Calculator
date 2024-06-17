	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
	# TODO
	la $t0, 4($a0) #skip the first 4 bytes
	la $t1, 12($a0) #skip the first 12 bytes

	
	li $t2 8 #counter for the loop for the BLZ loop
	
	loop_for_BLZ:
	lb $s0 ($t0) #storing the content of the IBAN buffer into the BLZ target buffer
	sb $s0 ($a1) 
	addi $t0 $t0 1 #incrementing the IBAN buffer that skipped the first 4 bytes
	addi $a1 $a1 1 #incrementing the BLZ buffer 
	addi $t2 $t2 -1 #decrementing the counter 
	bnez $t2 loop_for_BLZ #the condition for the loop
	
	
	li $t2 10 #counter for the knr loop
	loop_for_KNR:
	lb $s1 ($t1) # storing the content of the IBAN buffer into the KNR target buffer
	sb $s1 ($a2)
	addi $t1 $t1 1 #incrementing the IBAN buffer that skipped the first 12 bytes
	addi $a2 $a2 1 #incrementing the KNR buffer
	addi $t2 $t2 -1 # decrementing the counter
	bnez $t2 loop_for_KNR # the condition for the loop
	
	
	jr	$ra
	
