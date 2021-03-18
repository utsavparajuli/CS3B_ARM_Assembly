/* --- Lab7 --- */
@ Purpose: Setting up the initial stages for RASM-1
@	   Will get two integers from the user using
@	   getstring and will add the sum and display the
@	   result. Will also output the adresses of both the variable
@	   addresses.

	.data

szA:		.skip	12
szPromptX:	.asciz	"Enter x: "
szPromptY:	.asciz	"Enter y: "
szOAdd:		.asciz	" + "
szOEq:		.asciz	" = "
szX:		.asciz  "&x = "
szY:		.asciz  "&y = "
szO:		.skip	12
szAddrX:	.skip	9
szAddrY:	.skip	9

iX:		.word	0
iY:		.word	0
iR:		.word	0
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

	ldr	r2, =iX		@ R2 points to address of iX
	str	r0, [r2]	@ [r2] iX = R0
 
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

	ldr	r3, =iY		@ R3 points to address of iY
	str	r0, [r3]	@ [r3] iY = R0

	ldr	r0, =iX		@ r0 points to address of iX
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iX

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =szOAdd	@ r0 points to address of szOAdd
	bl	putstring	@ peints to screen

	ldr	r0, =iY		@ r0 points to address of iY
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iY

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =szOEq	@ r0 points to address of szOEq
	bl	putstring	@ prints to screen

	/* --Adding the values of two inputs-- */
	ldr	r2, [r2]	@ r2 = *r2 = integer value stored at iX
	ldr	r3, [r3]	@ r3 = *r3 = integer value stored at iY
	
	add	r4, r2, r3	@ adding contents of r2 and r3 and storing them in r4
	
	ldr	r0, =iR		@ load into r0 address of iR
	str	r4, [r0]	@ [r0] iR = R4
	
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iR

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	/* --Printing the results-- */
	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints character in screen
	
	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen
	
	/* --Printing the memory address-- */
	ldr	r0, =iX		@ r0 points to address of iX
	ldr	r1, =szAddrX	@ r1 points to address of szAddrX
	mov	r2, #8		@ number of nibbles to be displayed
	bl	hexToChar	@ converts hex address to char

	ldr	r0, =szX	@ r0 points to address of szX
	bl	putstring	@ prints to screen

	ldr	r0, =szAddrX	@ r0 points to address of szAddrX
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen
       
	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

	ldr	r0, =iY		@ r0 points to address of iY
	ldr	r1, =szAddrY	@ r1 points to address of szAddrY
	mov	r2, #8		@ number of nibbles to be displayed
	bl	hexToChar	@ converts hex address to char

	ldr	r0, =szY	@ r0 points to address of szY
	bl	putstring	@ prints to screen

	ldr	r0, =szAddrY	@ r0 points to address of szAddrY
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

        mov     r0, #0		@ Set program Exit Status code to 0
        mov     r7, #1		@ Service command code of 1 to terminate program

        svc     0		@ Performs service call to linux
        .end                                                                                                            	
