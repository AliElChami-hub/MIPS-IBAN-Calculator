	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
	# TODO
	
	
	addi $t0 $a1 0 #counter for the whole loop
	addi $t1 $0 0 #initialise of the remainder 
	add $t2, $zero, $0 
	
	
	
	
Loop_Modulos:	
	lb $s0 ($a0) # store the contents
	addi $s0 $s0 -48 #convert the string(ascii) to a decimal or integer
	mul $t1 $t1 10 # remainder times 10
	add $t1 $t1 $s0 # addition to the previous value
	div $t1 $t1 $a2 # dividing in order to get the remainder
	addi $t0 $t0 -1 # decrement of the counter 
	addi $a0 $a0 1 #incrementing 
	mfhi $t1   #getting the remainder 
	bnez $t0 Loop_Modulos
	move $v0 $t1
	
	
	
	
	jr	$ra
