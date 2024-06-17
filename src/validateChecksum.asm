.data
		buffer: .space 24
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	
	#for $ra and $a0
	# TODO 
	la $t0 4($a0)
	#addiu $t0 $t0 4 # skip DE68 
	
	la $t1 buffer # pointer to buffer
	
	li $t3 0 #the counter for the loop/																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
	
	
	loop_for_filling_the_buffer:
	lb $s1 ($t0) #extract digit 
	
	sb $s1 ($t1) # store in target buffer
	addiu $t0 $t0 1 # next digit
	addiu $t3 $t3 1 # next counter 
	addiu $t1 $t1 1 # next index in target  buffer
	
	bne $t3 18 loop_for_filling_the_buffer
	
	
	li $t3 2 #redo for 2nd loop
	la $t0 ($a0)
	
	loop_for_shifting_the_first_2_elements:
	lb $s0 ($t0) #extract D,E 
	move $t4 $s0 #put D,E in temp
	addiu $t4 $t4 -55 #convertion from ascii letter to integers 
	
	rem $s0 $t4 10 # calculating the remainder (lsb) 
	div $s1 $t4 10 #get next digit (msb)
	
	addi $s1 $s1 48  #conversion
	sb $s1 ($t1)  #stroing the value
	addi $t1 $t1 1
	
	addi $s0 $s0 48  #conversion
	sb $s0 ($t1)  #storing the value
	addi $t1 $t1 1
	
	addi $t0 $t0 1 #get to next char of IBAN (from D to E)
	
	addi $t3 $t3 -1
	bnez $t3 loop_for_shifting_the_first_2_elements
	
	
	la $t5 2($a0)  #loading the address to t5 
	
	lb $s0 ($t5)    #storing the value
	sb $s0 ($t1)
	addi $t5 $t5 1  #increment address
	addi $t1 $t1 1  #increment the buffer address
	
	lb $s0 ($t5)  #storing the value
	sb $s0 ($t1)
	
 
	
	
	
	la $a0 buffer	#loading the address of the buffer to a0 for the arguement
	li $a1 24       #loading the length of the buffer as an argument 
	li $a2 97       #loading the divisor 
	
	
	
	move $t5 $ra #store return address in t5
	
	jal modulo_str
	
	move $ra $t5  
	
	
	jr	$ra
