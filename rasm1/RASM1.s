/* --------------------------------- RASM1 --------------------------------- */
@ Purpose: A program that will perform the calculation X = (A + B) - (C + D)
@	   where A, B, C, D are all input by the user during runtime.
@	   The program will perform the calculation and print the result
@	   along with the adresses of the 4 integers input by the user.

@ Author : Utsav Parajuli

	.data

szName:		.asciz	" Name: Utsav Parajuli"
szClass:	.asciz  "Class: CS 3B"
szLab:		.asciz	"  Lab: RASM1"
szDate:		.asciz	" Date: 02/15/2021"

szPrompt:	.asciz	"Enter a whole number: "
szOut:		.asciz  "The addresses of the 4 ints:\n\n"
szOAdd:		.asciz	" + "
szOSub:		.asciz  ") - ("
szOEq:		.asciz	")  = "
szOB:		.asciz  "("
szAO:		.asciz  "  "
szO:		.skip	12
szA:		.skip	12
szAddr:		.skip	9

iX:		.word	0
iA:		.word	0
iB:		.word	0
iC:		.word	0
iD:		.word	0
chLF:		.byte	0x0a
		

	.text

	.global _start		@ Provide program starting address to linker

_start:

	/* --Displaying header-- */
	ldr	r0, =szName	@ load the name into r0
	bl	putstring	@ print the name
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =szClass	@ load the class into r0
	bl	putstring	@ print the class
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =szLab	@ load the lab into r0
	bl	putstring	@ print the lab details
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =szDate	@ load the date into r0
	bl	putstring	@ print the date
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	/* --Getting 1st num from user--*/
	ldr	r0, =szPrompt	@ load the prompt into r0
	bl	putstring	@ print the prompt

	ldr	r0, =szA	@ load into r0 address of szA
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =szA	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r2, =iA		@ R2 points to address of iX
	str	r0, [r2]	@ [r2] iA = R0
 
	ldr	r0, =chLF	@ new line
	bl	putch		@ prints a new line

	/* --Getting 2nd num from user--*/
	ldr	r0, =szPrompt	@ load the prompt into r0
	bl	putstring	@ print the prompt

	ldr	r0, =szA	@ load into r0 address of szA
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

	ldr	r0, =szA	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r3, =iB		@ R3 points to address of iB
	str	r0, [r3]	@ [r3] iB = R0
	
	/* --Getting 3rd num from user--*/
	ldr	r0, =szPrompt	@ load the prompt into r0
	bl	putstring	@ print the prompt

	ldr	r0, =szA	@ load into r0 address of szA
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =szA	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r4, =iC		@ R3 points to address of iC
	str	r0, [r4]	@ [r4] iC = R0
 
	ldr	r0, =chLF	@ new line
	bl	putch		@ prints a new line

	/* --Getting 4th num from user--*/
	ldr	r0, =szPrompt	@ load the prompt into r0
	bl	putstring	@ print the prompt

	ldr	r0, =szA	@ load into r0 address of szA
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

	ldr	r0, =szA	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r5, =iD		@ R5 points to address of iD
	str	r0, [r5]	@ [r5] iD = R0

	@ldr	r0, =chLF	@ r0 points to address of chLF
	@bl	putch		@ prints character

	/* --Displaying result--*/
	ldr	r0, =szOB	@ r0 points to address of szOB
	bl	putstring	@ prints to screen
	
	//Printing first num
	ldr	r0, =iA		@ r0 points to address of iA
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iA

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =szOAdd	@ r0 points to address of szOAdd
	bl	putstring	@ prints to screen

	//Printing second num
	ldr	r0, =iB		@ r0 points to address of iB
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iB

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =szOSub	@ r0 points to address of szOSub
	bl	putstring	@ prints to screen

	//Printing the third num
	ldr	r0, =iC		@ r0 points to address of iC
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iC

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =szOAdd	@ r0 points to address of szOAdd
	bl	putstring	@ prints to screen

	//Printing the fourth num
	ldr	r0, =iD		@ r0 points to address of iD
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iD

	ldr	r1, =szO	@ r1 points to address of szO
	bl	intasc32	@ converting int to ascii

	ldr	r0, =szO	@ r0 points to address of szO
	bl	putstring	@ prints to screen

	ldr	r0, =szOEq	@ r0 points to address of szOEq
	bl	putstring	@ prints to screen

	/* --Getting the result by using the inputs in the equation-- */
	ldr	r2, [r2]	@ r2 = *r2 = integer value stored at iA
	ldr	r3, [r3]	@ r3 = *r3 = integer value stored at iB
	ldr	r4, [r4]	@ r4 = *r4 = integer value stored at iC
	ldr	r5, [r5]	@ r5 = *r5 = integer value stored at iD
	
	//adding the numbers
	add	r0, r2, r3	@ adding contents of r2 and r3 and storing them in r0
	add	r6, r4, r5	@ adding contents of r4 and r5 and storing them in r6
	
	sub	r7, r0, r6	@ subtracting the sum of A + B with the sum of C + D
	ldr	r0, =iX		@ load into r0 address of iX
	str	r7, [r0]	@ [r0] iX = R7
	
	ldr	r0, [r0]	@ r0 = *r0 = integer value stored at iX

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
	ldr	r0, =szOut	@ r0 points to address of szOut
	bl	putstring	@ prints to screen

	//Memory address of first num
	ldr	r0, =iA		@ r0 points to address of iA
	ldr	r1, =szAddr	@ r1 points to address of szAddr
	mov	r2, #8		@ number of nibbles to be displayed
	bl	hexToChar	@ converts hex address to char
	
	ldr	r0, =szAddr	@ r0 points to address of szAddr
	bl	putstring	@ prints to screen

	ldr	r0, =szAO	@ r0 points to address of szAO
	bl	putstring	@ prints to screen

	//Memory address of second num
	ldr	r0, =iB		@ r0 points to address of iB
	ldr	r1, =szAddr	@ r1 points to address of szAddrY
	mov	r2, #8		@ number of nibbles to be displayed
	bl	hexToChar	@ converts hex address to char

	ldr	r0, =szAddr	@ r0 points to address of szAddr
	bl	putstring	@ prints to screen

	ldr	r0, =szAO	@ r0 points to address of szAO
	bl	putstring	@ prints to screen
	
	//Memory address of third num
	ldr	r0, =iC		@ r0 points to address of iC
	ldr	r1, =szAddr	@ r1 points to address of szAddr
	mov	r2, #8		@ number of nibbles to be displayed
	bl	hexToChar	@ converts hex address to char

	ldr	r0, =szAddr	@ r0 points to address of szAddr
	bl	putstring	@ prints to screen

	ldr	r0, =szAO	@ r0 points to address of szAO
	bl	putstring	@ prints to screen

	//Memory address of second num
	ldr	r0, =iD		@ r0 points to address of iD
	ldr	r1, =szAddr	@ r1 points to address of szAddrY
	mov	r2, #8		@ number of nibbles to be displayed
	bl	hexToChar	@ converts hex address to char

	ldr	r0, =szAddr	@ r0 points to address of szAddr
	bl	putstring	@ prints to screen

	ldr	r0, =szAO	@ r0 points to address of szAO
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints character to screen
	bl	putch		@ prints character to screen
       
        mov     r0, #0		@ Set program Exit Status code to 0
        mov     r7, #1		@ Service command code of 1 to terminate program

        svc     0		@ Performs service call to linux
        .end                                                                                                            	
