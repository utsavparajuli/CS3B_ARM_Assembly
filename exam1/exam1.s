
@	Exam1
@	Class  : CS3B 3:30pm
@	Author : Utsav Parajuli
	
@	Program that will take in 2 integer inputs form user and use the formula 2(x + 2y)

	.data

@ CLASS HEADER
szName:		.asciz	"Author: Utsav Parajuli"
szDate:		.asciz	"Date: 03/08/2021"
szProgram:	.asciz  "Program: Exam 1"

@ OUPUT PROMPTS
szPromptX:	.asciz	"Enter x: "
szPromptY:	.asciz  "Enter y: "
szOAdd:		.asciz	" + "
szOMult:	.asciz 	"*"
szOEq:		.asciz 	" = "
szOSpace:	.asciz 	"  "
szOB:		.asciz  "("
szOCB:		.asciz 	")"
sznum2:		.asciz 	"2"
chLF:		.byte	0x0a

@ INPUT STRINGS
szX:		.skip	12
szY:		.skip	12
szR:		.skip	12


@ INTEGER VARIABLES FOR NUMBERS
iX:		.word	0
iY:		.word	0
iR:		.word	0

		

	.text

	.global _start		@ Provide program starting address to linker

_start:

	/* --Displaying header-- */
	ldr	r0, =szName	@ load the name into r0
	bl	putstring	@ print the name
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =szDate	@ load the date into r0
	bl	putstring	@ print the date
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =szProgram	@ load the program into r0
	bl	putstring	@ print the program details
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character

	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character
	ldr	r0, =chLF	@ load the character into r0
	bl	putch		@ print the character



	/* --Getting 1st num from user--*/
	ldr	r0, =szPromptX	@ load the promptX into r0
	bl	putstring	@ print the promptX

	ldr	r0, =szX	@ load into r0 address of szX
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =szX	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r2, =iX		@ R2 points to address of iX
	str	r0, [r2]	@ [r2] iX = R0



	/* --Getting 2nd num from user--*/
	ldr	r0, =szPromptY	@ load the promptY into r0
	bl	putstring	@ print the promptY

	ldr	r0, =szY	@ load into r0 address of szY
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (up to R1 bytes) and
				@ store into string pointed by R0

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

	ldr	r0, =szY	@ now converting the string to int
	bl	ascint32	@ R0 will contain the result

	ldr	r3, =iY		@ R3 points to address of iY
	str	r0, [r3]	@ [r3] iY = R0



	/* --Displaying result--*/
	ldr	r0, =sznum2	@ r0 points to address of sznum2
	bl	putstring	@ prints to screen
	
	ldr	r0, =szOB	@ r0 points to address of szoB
	bl	putstring	@ prints to screen

	ldr	r0, =szX	@ r0 points to address of szX
	bl	putstring	@ prints to screen

	ldr	r0, =szOAdd	@ r0 points to address of szOAdd
	bl	putstring	@ prints to screen

	ldr	r0, =sznum2	@ r0 points to address of sznum2
	bl	putstring	@ prints to screen

	ldr	r0, =szOMult	@ r0 points to address of szOMult
	bl	putstring	@ prints to screen

	ldr	r0, =szY	@ r0 points to address of szY
	bl	putstring	@ prints to screen

	ldr	r0, =szOCB	@ r0 points to address of szOCB
	bl	putstring	@ prints to screen

	ldr	r0, =szOEq	@ r0 points to address of szOEq
	bl	putstring	@ prints to screen


	/* --Getting the result by using the inputs in the equation-- */
	ldr	r2, [r2]	@ r2 = *r2 = integer value stored at iX
	ldr	r3, [r3]	@ r3 = *r3 = integer value stored at iY
	
	
	//Calculating the result
	add	r0, r3, r3	@ y*2 and storing in r0
	add	r0, r0, r2	@ adding contents of r0 and r2 and storing them in r0 x + 2*y

	add	r0, r0, r0	@ 2(x + 2*y) and storing in r0

	ldr	r5, =iR		@ load into r5 address of iR
	str	r0, [r5]	@ [r7] iR = R5

	ldr	r1, =szR	@ r1 points to address of szR
	bl	intasc32	@ converting int to ascii

	/* --Printing the results-- */
	ldr	r0, =szR	@ r0 points to address of szR
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints character in screen
	
	ldr	r0, =chLF	@ r0 points to address of chLF
	bl	putch		@ prints a character to screen

	ldr	r2, =iX		@ r2 points to address of iX
	ldr	r3, =iY		@ r3 points to address of iY
	
        
	//Exiting program
	mov     r0, #0		@ Set program Exit Status code to 0
        mov     r7, #1		@ Service command code of 1 to terminate program

        svc     0		@ Performs service call to linux
        .end                                                                                                            	
