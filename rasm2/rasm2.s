@ ***************************************************************************
@ Name:		Utsav Parajuli
@ Program:	RASM2.s
@ Class:	CS 3B
@ Lab:		RASM2
@ Date:		March 14, 2020
@ Purpose:
@	Input numeric information from the keyboard, perform addition, subtraction,
@	multiplication, and division. Check for overflow upon all operations.
@ ***************************************************************************


	.data
@ Class Header
szName:	  .asciz "Name:    	Utsav Parajuli"
szProg:   .asciz "Program:	rasm2.asm"
szClass:  .asciz "Class:  	CS 3B"
szDate:	  .asciz "Date:	 	March 14, 2021"


@ Input Prompt
szFNum:	  .asciz "Enter your first number:  "
szSNum:   .asciz "Enter your second number: "

@ Output Prompt
szOSum:	  .asciz "The sum is "
szODif:	  .asciz "The difference is "
szOMul:	  .asciz "The product is "
szOQuo:	  .asciz "The quotient is "
szORem:	  .asciz "The remainder is "
szOut:    .asciz "Thanks for using my program!! Good Day!"

@ Error Messages
szDiv0:   .asciz "You cannot divide by 0. Thus, there is NO quotient or remainder"
szInv:	  .asciz "INVALID NUMERIC STRING. RE-ENTER VALUE"
szOvr:    .asciz "OVERFLOW OCCURED. RE-ENTER VALUE"
szOvrAdd: .asciz "OVERFLOW OCCURED WHEN ADDING"
szOvrDif: .asciz "OVERFLOW OCCURED WHEN SUBTRACTING"
szOvrMul: .asciz "OVERFLOW OCCURED WHEN MULTIPLYING"
szLimit:  .asciz "The limit of numbers EXCEEDED"

@ String values
szBuffer: .skip	512		@ buffer for input
szNum:	  .skip	12		@ string for input
szSum:	  .skip	12		@ string for sum of numbers
szDif:	  .skip 12		@ string for difference of numbers
szMul:	  .skip 12		@ string for product of numbers
szQuo:	  .skip 12		@ string for quotient of numbers
szRem:	  .skip	12		@ string for remainder of numbers

@ Integer values
iNum1:	  .word	0		@ the first number input
iNum2:	  .word	0		@ the second number input
iSum:	  .word	0		@ the sum of numbers
iDif:	  .word	0		@ the difference of numbers
iMul:	  .word	0		@ the product of numbers
iQuo:	  .word	0		@ the quotient of numbers
iRem:	  .word	0		@ the remainder of numbers

@ Extras
chLF:		.byte	0x0A	@ hex 10 for new line
iLimitNum:	.word	12	@ the limit for entering numeric strings


	.text

	.global _start		@ Provide program starting address to linker

_start:
	@-------------------------- HEADER -------------------------------@
	@-----------------------------------------------------------------
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =szName		@ loads the address of szName into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =szProg		@ loads the address of szProg into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch
	
	ldr	r0, =szClass		@ loads the address of szClass into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =szDate		@ loads the address of szDate into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

num_1:
	@--------------------------- INPUT ---------------------------------@
	@-------------------------------------------------------------------

	@Clearing the buffer
	ldr	r0, =szBuffer		@ loads the address of szBuffer into r0
	mov	r1, #0			@ r1 = 0
	str	r1, [r0, #0]		@ Store 0 into r0[0]

	@Getting the input
	ldr	r0, =szFNum		@ loads the address of szFNum into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =szBuffer		@ loads the address of szBuffer into r0
	mov	r1, #13			@ the largest number that can be in +1

	bl	getstring		@ read in from stdin (up to R1 bytes) and
					@ store into string pointed by R0

	@ Checking if input is NULL
	ldr	r0, [r0, #0]		@ Loading the value of first index of input into r0
	cmp	r0, #0			@ Comparing value of r0 and null char
	beq	end_			@ Branch to end if the user input null for the number


	@ Convering the string input to an int
	ldr	r0, =szBuffer		@ load into r0 the address of szBuffer (contains the number input)
	bl	ascint32		@ R0 will contain the int representation of input

	ldr	r2, =iNum1		@ load into r2 the address of iNum1
	str	r0, [r2]		@ [r2] iNum1 = R0

	@ Checking invalid inputs
	bcs	inv_input_1		@ branch to inv_input_1 if Carry Flag C == 1 (when the numeric string is invalid)
	bvs	ovf_input_1		@ branch to ovf_input_1 if Overflow Flag O == 1 (when the input overflows)

	
num_2:
	@--------------------------- INPUT ---------------------------------@
	@-------------------------------------------------------------------
	@Clearing the buffer
	ldr	r0, =szBuffer		@ loads the address of szBuffer into r0
	mov	r1, #0			@ r1 = 0
	str	r1, [r0, #0]		@ Store 0 into r0[0]

	@Getting the input
	ldr	r0, =szSNum		@ loads the address of szSNum into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =szBuffer		@ loads the address of szBuffer into r0
	mov	r1, #13			@ the largest number that can be in +1

	bl	getstring		@ read in from stdin (up to R1 bytes) and
					@ store into string pointed by R0

	@ Checking if input is NULL
	ldr	r0, [r0, #0]		@ Loading the value of first index of input into r0
	cmp	r0, #0			@ Comparing value of r0 and null char
	beq	end_			@ Branch to end if the user input null for the number

	@ Convering the string input to an int
	ldr	r0, =szBuffer		@ load into r0 the address of szBuffer (contains the number input)
	bl	ascint32		@ R0 will contain the int representation of input

	ldr	r3, =iNum2		@ load into r3 the address of iNum2
	str	r0, [r3]		@ [r3] iNum2 = R0

	@ Checking invalid inputs
	bcs	inv_input_2		@ branch to inv_input_2 if Carry Flag C == 1 (when the numeric string is invalid)
	bvs	ovf_input_2		@ branch to ovf_input_2 if Overflow Flag O == 1 (when the input overflows)

	b	sum			@ branch to the sum and continue the program

limit_reached_1:
	ldr	r0, =szLimit
	bl	putstring
	ldr	r0, =chLF
	bl	putch
	b	num_1

inv_input_1:
	ldr	r0, =szInv		@ loads the address of szInv into r0
	bl	putstring		@ branches to the function putstring
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch
	b	num_1			@ branches to the subroutine num_1 (user will be able to retry)

ovf_input_1:
	ldr	r0, =szOvr		@ loads the address of szOvr into r0
	bl	putstring		@ branches to the function putstring
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch
	b	num_1			@ branches to the subroutine num_1 (user will be able to retry)

inv_input_2:
	ldr	r0, =szInv		@ loads the address of szInv into r0
	bl	putstring		@ branches to the function putstring
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch
	b	num_2			@ branches to the subroutine num_2 (user will be able to retry)

ovf_input_2:
	ldr	r0, =szOvr		@ loads the address of szOvr into r0
	bl	putstring		@ branches to the function putstring
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch
	b	num_2			@ branches to the subroutine num_2 (user will be able to retry)

sum:
	@ --------------------------- ADDITION ---------------------------- @
	@ ----------------------------------------------------------------
	ldr	r2, [r2]		@ r2 = *r3
	ldr	r3, [r3]		@ r3 = *r3

	adds	r0, r2, r3		@ adds the contents of r2 and r3 and stores the signed result in r0
	bvs	add_ovf			@ branch to the add_ov if V == 1

	ldr	r4, =iSum		@ loads the address of iSum into r4
	str	r0, [r4]		@ stores the value in r0 to the address pointed by r4
	
	ldr	r1, =szSum		@ loads the address of szsum into r1
	bl	intasc32		@ branches to the function intasc32

	ldr	r0, =szOSum		@ loads the address of szOSum into r0
	bl	putstring		@ branches to the function putstring
	
	ldr	r0, =szSum		@ loads the address of szSum into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	diff			@ branches to the function diff

add_ovf:
	ldr	r0, =szOvrAdd		@ loads the address of szOverAdd into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	diff			@ branches to the function diff

diff:
	@ --------------------------- DIFFERENCE ---------------------------- @
	@ ----------------------------------------------------------------

	subs	r0, r2, r3		@ subracts the signed of first number and the second and stores in r0
	bvs	diff_ovf		@ branch to the diff_ov if V == 1

	ldr	r4, =iDif		@ loads the address of iDif into r4
	str	r0, [r4]		@ stores the value of r0 to the address pointed by r4

	ldr	r1, =szDif		@ loads the address of szDif into r1
	bl	intasc32		@ branches to the function intasc32

	ldr	r0, =szODif		@ loads the address of szODif into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =szDif		@ loads the address of szDif into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	mult			@ branches to the function mult


diff_ovf:
	ldr	r0, =szOvrDif		@ loads the address of szOverDif into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	mult			@ branches to the function mult

mult:
	@ --------------------------- PRODUCT ---------------------------- @
	@ ----------------------------------------------------------------

	smull	r0, ip, r2, r3		@ multiplies the first and second number and stores the result in r0
	cmp	ip, r0, ASR #31		@ compares and shifts r0 31 bits to the right
	bne	mult_ovf		@ branch to the mult_ovf if not equals

	ldr	r4, =iMul		@ loads the address of iMul into r4
	str	r0, [r4]		@ stores the value of r0 into the address pointed by r4

	ldr	r1, =szMul		@ loads the address of szMul into r1
	bl	intasc32		@ branches to the function intasc32

	ldr	r0, =szOMul		@ loads the address of szOMul into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =szMul		@ loads the address of szMul into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch
	
	cmp	r3, #0			@ Comparing r3 and 0
	beq	div_zero		@ branch to div_zero if r3 == 0
	b	div			@ branch to div

mult_ovf:

	ldr	r0, =szOvrMul		@ loads the address of szOvrMul into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	div			@ branches to the function div

div:
	@ --------------------------- QUOTIENT ---------------------------- @
	@ ----------------------------------------------------------------

	@Calculating The Quotient
	sdiv	r0, r2, r3		@ divides r2/r3 and stores the result in r0

	ldr	r4, =iQuo		@ loads the address of iQuo into r0
	str	r0, [r4]		@ Store the value in r0 into the address pointed by r4

	ldr	r1, =szQuo		@ loads the address of szQuo into r0
	bl	intasc32		@ convert integer to ascii

	ldr	r0, =szOQuo		@ loads the address of szOQuo into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =szQuo		@ loads the address of szQuo into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	@ --------------------------- REMAINDER ---------------------------- @
	@ -----------------------------------------------------------------
	sdiv	r0, r2, r3		@ divides r2/r3 and stores the result in r0
	mul	r5, r0, r3		@ r5 = r0 * r3
	sub	r0, r2, r5		@ r5 = r2 - r0

	ldr	r4, =iRem		@ loads the address of iRem into r0
	str	r0, [r4]		@ Store the value in r0 into the address pointed by r4

	ldr	r1, =szRem		@ loads the address of szRem into r0
	bl	intasc32		@ convert integer to ascii

	ldr	r0, =szORem		@ loads the address of szORem into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =szRem		@ loads the address of szRem into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	new_run			@ branches to the new_run function

div_zero:

	ldr 	r0, =szDiv0		@ loads the address of szDiv0 into r0
	bl	putstring		@ branches to the function putstring

new_run:
	
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	b	num_1			@ branches to the function num_1 (the user is able to enter another set of data
	
	@ --------------------------- END OF PROGRAM ---------------------------- @
	@ -----------------------------------------------------------------------
	
end_:
	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =szOut		@ loads the address of szOut into r0
	bl	putstring		@ branches to the function putstring

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	ldr	r0, =chLF		@ loads the address of chLF into r0
	bl	putch			@ branches to the function putch

	mov	r0, #0			@ Set program status code to 0
	mov	r7, #1			@ Service code of 1 to terminate

	svc	0			@ Perform service call to Linux

	

	.end
