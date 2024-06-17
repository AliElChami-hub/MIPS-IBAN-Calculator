.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
	# TODO
	
	la $t0 ($a0)  #loading the address of a0 to t0
	
	li $t9 'D'    #adding the D to the buffer
	sb $t9 ($t0)  
	addi $t0 $t0 1  
	
	li $t9 'E'      #adding the E to the buffer
	sb $t9 ($t0)  
	addi $t0 $t0 1 
	
	li $t9 '0'     #adding the 0 to the buffer
	sb $t9 ($t0)   
	addi $t0 $t0 1 
	
	li $t9 '0'       #adding the 0 to the buffer
	sb $t9 ($t0)  
	addi $t0 $t0 1
	
	
	
	
	li $t2 0 # counter for the loop of the blz and knr 
	
	
	loop_BLZ_filling:
	lb $s1 ($a1) #loading the byte from the BLZ buffer into IBAN buffer
	sb $s1 ($t0) #storing the value
	
	addiu $t2 $t2 1 # increment the counter
	addiu $t0 $t0 1 #increment the address
	addiu $a1 $a1 1 #increment the address
	bne $t2 8 loop_BLZ_filling
	
	
	loop_KNR_filling:
	lb $s2 ($a2)  #loading the byte from KNR to IBAN
	sb $s2 ($t0)  #storing the value
	
	addiu $t2 $t2 1 #increment counter
	addiu $t0 $t0 1 #increment address
	addiu $a2 $a2 1  #increment the address
	bne $t2 22 loop_KNR_filling 
	
	
	addiu $sp $sp -20  #using of stack pointer to store the values
	sw $a0 0($sp)
	sw $a1 4($sp)
	sw $a2 8($sp)
	sw $t0 12($sp)
	sw $ra 16($sp)
	
	 
	
	
	jal validate_checksum 
	
	lw $a0 0($sp)
	lw $a1 4($sp)
	lw $a2 8($sp)
	lw $t0 12($sp)
	lw $ra 16($sp)
	
	
	addiu $sp $sp 20  
	
	
	

	

	
	
	
	
	li $t2 98       #putting the value 98 into a register for the subtraction
	sub $t2 $t2 $v0  #subtracting 98 from the remainder to get the value we want
	  
		
	      # filling the values of 00 with actual values:	
		
		la $t7 2($a0) #loading address of 2($a0) to t7 
	
		div $t8 $t2 10   # getting the first value of the 2
		rem $t9 $t2 10   #getting the seconf value of the 2
		addiu $t8 $t8 48  #convertion 

		
	 	sb $t8 ($t7) #storing of the value 
	
		addiu $t7 $t7 1  #incrementing the address by 1
		addiu $t9 $t9 48  #convertion
	
	 	sb $t9 ($t7) #storing the value
	 	 
	
	jr	$ra
