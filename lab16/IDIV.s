@ Author : Utsav Parajuli

@ Subroutine IDIV: This method will divide two numbers and return the integer
@		   result.

@ R0: Must contain the integer to be divided
@ R1: Must contain the integer to be divided by
@ LR: Contains the return address

@ Returned register contents
@	R0: R0/R1

@ AAPCS v2020Q2 Required registers are preserved

	.data

	.global IDIV		@ Provide program starting address to Linker

	.text

negativeX:
	mov	r4, #-1		@ moves a constant -1 to r4
	mvn	r0, r0		@ negate r0
	add	r0, r0, #1	@ add 1 to r0
	bal	cont1		@ branch always to cont1

negativeY:
	mov	r5, #-1		@ moves a constant -1 to r5
	mvn	r1, r1		@ negate r1
	add	r1, r1, #1	@ add 1 to r1
	bal	cont2		@ branch always to cont2

IDIV:
	@ Preserve AAPCS REQUIRED Registers
	push	{r4-r11}
	push	{sp}

	@sdiv	r0, r0, r1	@ divide r0/r1 and store result in r0

	mov	r3, #0		@ counter for the loop
	mov	r4, #1		@ mov 1 to r4 positive sign bit for the first num
	mov	r5, #1		@ mov 1 to r5 positive sign bit for the second num

	cmp	r0, #0		@ compare r0 with 0
	blt	negativeX	@ if the first num is negative the we will branch to negativeX

	cmp	r0, r1		@ compare r0 with r1
	blt	x_Lt_y		@ if the first number is less than second



cont1:
	cmp	r1, #0		@ compare r1 with 0
	blt	negativeY	@ second num is negative

cont2:
	mul	r6, r4, r5	@ multiplies r4 and r5 and stores in r6

div_loop:
	subs	r0, r0, r1	@ subtract x with y
	add	r3, r3, #1	@ increment counter

	cmp	r0, r1		@ compares r0 with r1
	blt	end		@ if r0 is less than r1 we will branch to end

	b	div_loop	@ branches top of loop

end:
	@mul	r0, r6, r0	@ multiply sign bit to remainder
	mul	r3, r6, r3	@ multiply sign bit to the result

	mov	r0, r3		@ moves the result to r0

	pop	{sp}
	pop	{r4-r11}

	bx	lr

x_Lt_y:
	mov	r0, #0		@ mov 0 to r0

	pop	{sp}
	pop	{r4-r11}

	bx	lr
	.end
