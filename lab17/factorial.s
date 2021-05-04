@ Author: Utsav Parajuli
@ This function will calculate the factorial of a given number and return the result

@ R0: Number to calculate the factorial of
@ LR: Contains the return address

@ Returned register contents
@	R0: R0!
@ AAPCS v2020Q2 Required registers are preserved

	.global fact		@ Provides program starting address to linker

fact:
	@ Preserve AAPCS Required Registers
	push	{r1, r2, lr}
	
@-------BASE CASE----------
	cmp	r0, #0		@ compares r0 and 0
	beq	base		@ branches to base (the base case)

	cmp	r0, #1		@ compares r0 and 1
	beq	base		@ branches to base (the base case)

@-------RECURSIVE CASE-----
	mov	r1, r0		@ move the contents of r0 to r1
 	
	sub	r0, r0, #1	@ subtract 1 from r0

	bl	fact		@ recursive call (n-1)

	mul	r2, r1, r0	@ multiply contents of r0 and r1 put into r2

	mov	r0, r2		@ mov the contents of r2 into r0

	pop	{r1, r2, lr}

	bx	lr
	
base:
	mov	r0, #1		@ moves 1 into r0
	pop	{r1, r2, lr}
	bx	lr

	.end	
