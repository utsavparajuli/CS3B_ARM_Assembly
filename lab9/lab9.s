/* --- Lab9 --- */
@ Purpose: Will get two integers from the user using
@	   getstring and will compare the two and
@	   store the largest number in r0.

	.data

szA:		.skip	12
szPromptX:	.asciz	" Enter first number: "
szPromptY:	.asciz	"Enter second number: "

num1:		.word	0
num2:		.word	0
chLF:		.byte	0x0a
		
	.text

	.global _start		@ Provide program starting address to linker

_start:
	/* --Getting x from user--*/
	ldr	r0, =szPromptX	@ load the prompt into r0
	bl	putstring	@ print the prompt

	ldr	r0, =szA	@ load into r0 address of szA
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =szA	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r2, =num1	@ R2 points to address of num1
	str	r0, [r2]	@ [r2] num1 = R0
 
	ldr	r0, =chLF	@ new line
	bl	putch		@ prints a new line

	/* --Getting y from user--*/
	ldr	r0, =szPromptY	@ load the prompt into r0
	bl	putstring	@ print the prompt

	ldr	r0, =szA	@ load into r0 address of szA
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

	ldr	r0, =szA	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r3, =num2	@ R3 points to address of num2
	str	r0, [r3]	@ [r3] num2 = R0

	/* --Comparing the two values-- */
	ldr	r4, [r2]	@ r4 = *r2 = integer value stored at num1
	ldr	r5, [r3]	@ r5 = *r3 = integer value stored at num2
	
	cmp	r4, r5		@ comparing if [r4] num1 > [r5] num2
	movgt	r0, r4		@ r0 = r2 if r2 is > r3
	movle	r0, r5		@ r0 = r3 if r2 is <= r3
	
        mov     r0, #0		@ Set program Exit Status code to 0
        mov     r7, #1		@ Service command code of 1 to terminate program

        svc     0		@ Performs service call to linux
        .end                                                                                                          	
