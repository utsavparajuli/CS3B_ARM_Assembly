@ Author: Utsav Parajuli

@ Purpose: A program that will get 2 integers from the user and check and display
@	   if they are equal greater than or less than one another


	.data

@ OUTPUT PROMPTS
szPrompt1:	.asciz	"Please enter the first number: "
szPrompt2:	.asciz  "Please enter the second number: "
szOEq:		.asciz	" = "
szOLt:		.asciz	" < "
szOGt:		.asciz	" > "
chLF:		.byte	0x0a

@ USER INPUT
szX:		.skip	12
szY:		.skip	12

@ NUMBERS TO STORE
iX:		.word	0
iY:		.word	0

	.text
	
	.global _start	@Proving program starting address to linker

_start:

	//getting first number	
	ldr	r0, =szPrompt1	@ load the address of szPrompt1 into r0
	bl	putstring	@ prints the prompt

	ldr	r0, =szX	@ load into r0 the address of szX
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (upto R1 bytes)

	ldr	r0, =szX	@ now converting the string to int
	bl	ascint32	@ r0 will contain the result

	ldr	r2, =iX		@ r2 points to address of iX
	str	r0, [r2]	@ [r2] iX = r0


	//getting second  number
	ldr	r0, =szPrompt2	@ load the address of szPrompt2 into r0
	bl	putstring	@ prints the prompt

	ldr	r0, =szY	@ load into r0 the address of szX
	mov	r1, #13		@ the largest number that can be read in +1

	bl	getstring	@ read in from stdin (upto R1 bytes)

	ldr	r0, =szY	@ now converting the string to int
	bl	ascint32	@ r0 will contain the result

	ldr	r3, =iY		@ r2 points to address of iY
	str	r0, [r3]	@ [r3] iY = r0


	ldr	r2, [r2]	@ r2 = *r2
	ldr	r3, [r3]	@ r3 = *r3

	cmp	r2, r3		@ comparing contents of r2 and r3
	beq	equals		@ branches to a label if the numbers are equal
	blt	less_than	@ branches to the label if less than
	bgt	greater_than	@ branches to the label if greater than


//The numbers are equal
equals:
	ldr 	r0, =chLF	@ r0 contains the address of chLF
	bl	putch		@ prints the character to screen

	ldr	r0, =szX	@ r0 contains the address of szX
	bl	putstring	@ prints to screen

	ldr	r0, =szOEq	@ r0 contains the address of szEq
	bl	putstring	@ prints to screen

	ldr	r0, =szY	@ r0 contains the address of szY
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 contains the address of chLF
	bl	putch		@ prints the character to screen

	b	end		@ goes to the end


//x < y
less_than:
	ldr 	r0, =chLF	@ r0 contains the address of chLF
	bl	putch		@ prints the character to screen

	ldr	r0, =szX	@ r0 contains the address of szX
	bl	putstring	@ prints to screen

	ldr	r0, =szOLt	@ r0 contains the address of szEq
	bl	putstring	@ prints to screen

	ldr	r0, =szY	@ r0 contains the address of szY
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 contains the address of chLF
	bl	putch		@ prints the character to screen

	b	end		@ goes to the end


//x > y
greater_than:
	ldr 	r0, =chLF	@ r0 contains the address of chLF
	bl	putch		@ prints the character to screen

	ldr	r0, =szX	@ r0 contains the address of szX
	bl	putstring	@ prints to screen

	ldr	r0, =szOGt	@ r0 contains the address of szEq
	bl	putstring	@ prints to screen

	ldr	r0, =szY	@ r0 contains the address of szY
	bl	putstring	@ prints to screen

	ldr	r0, =chLF	@ r0 contains the address of chLF
	bl	putch		@ prints the character to screen

	b	end		@ goes to the end

end:
	mov	r0, #0		@ Exit status code set to 0
	mov	r7, #1		@ Service command code 1 will terminate

	svc 0			@ Issue linux command to terminate the program
	.end
