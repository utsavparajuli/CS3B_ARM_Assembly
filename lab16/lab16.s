@ Author: Utsav Parajuli

@ Purpose: A program that will get 2 integers from the user and divide and display the result


	.data

@ OUTPUT PROMPTS
szName:	.asciz  "Name: Utsav Parajuli\nAssignment: Lab 16\nDate: 03/22/2021\n"
szPX:	.asciz	"Enter x: "
szPY:	.asciz  "Enter y: "
szOEq:	.asciz	" = "
szOD:	.asciz	" / "
chLF:	.byte	0x0a

@ USER INPUT
szX:	.skip	12
szY:	.skip	12
szR:	.skip	12

@ NUMBERS TO STORE
iX:	.word	0
iY:	.word	0
iR:	.word	0	

	.text
	
	.global _start		@ Proving program starting address to linker

_start:
	ldr	r0, =szName	@ load the address of szName into r0
	bl	putstring	@ prints the name

	ldr	r0, =chLF	@ loads address of chLF into r0
	bl	putch		@ prints a new line
	
	//getting first number	
	ldr	r0, =szPX	@ load the address of szPX into r0
	bl	putstring	@ prints the prompt

	ldr	r0, =szX	@ load into r0 the address of szX
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (upto R1 bytes)

	ldr	r0, =szX	@ now converting the string to int
	bl	ascint32	@ r0 will contain the result

	ldr	r2, =iX		@ r2 points to address of iX
	str	r0, [r2]	@ [r2] iX = r0


	//getting second  number
	ldr	r0, =szPY	@ load the address of szPY into r0
	bl	putstring	@ prints the prompt

	ldr	r0, =szY	@ load into r0 the address of szX
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (upto R1 bytes)

	ldr	r0, =szY	@ now converting the string to int
	bl	ascint32	@ r0 will contain the result

	ldr	r3, =iY		@ r2 points to address of iY
	str	r0, [r3]	@ [r3] iY = r0


	ldr	r0, [r2]	@ r2 = *r2
	ldr	r1, [r3]	@ r3 = *r3
	bl	IDIV		@ calling IDIV

	ldr	r1, =szR	@ loads address of szR into r1
	
	bl	intasc32	@ converts int to ascii

	ldr	r0, =chLF	@ loads address of chLF into r0
	bl	putch		@ prints a new line

	ldr	r0, =szX	@ loads address of szX into r0
	bl	putstring	@ prints the number

	ldr	r0, =szOD	@ loads address of szOD into r0
	bl	putstring	@ prints the output

	ldr	r0, =szY	@ loads the address of szY into r0
	bl	putstring	@ prints the output

	ldr	r0, =szOEq	@ loads the address of szOEq into r0
	bl	putstring	@ prints the second number

	ldr	r0, =szR	@ loads contents of szR into r0
	bl	putstring	@ prints the result
	
	ldr	r0, =chLF	@ loads address of chLF into r0
	bl	putch		@ prints a new line
	
	mov	r0, #0		@ Exit status code set to 0
	mov	r7, #1		@ Service command code 1 will terminate

	svc 0			@ Issue linux command to terminate the program
	.end
