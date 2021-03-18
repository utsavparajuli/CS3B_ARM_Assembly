@ Author:  Utsav Parajuli
@ Lab:	   12
@ Date:	   03/15/2021

@ Purpose: Prompt the user to enter their grade (0-100) amd display the
@	   corresponding letter grade.

	.data

@ Input Prompt
szIP:	.asciz	"Please enter your grade(0-100) : "


@ Input
szO:	.skip	12	@ Buffer for input

@ Data
iA:	.word	90
iB:	.word	80
iC:	.word	70
iD:	.word	65
iG:	.word	0	@ User input

@ Output
szOA:	.asciz	"You have an A"
szOB:	.asciz	"You have a B"
szOC:	.asciz	"You have a C"
szOD:	.asciz	"You have a D"
szOF:	.asciz	"You have a F"
szOL:	.asciz	"Too Low"
szOH:	.asciz	"Too High"
chLF:	.byte	0x0A

	.text
	.global _start

_start:
	@=====================INPUT===============================
	ldr	r0, =chLF	@ Load the address of chLF into r0
	bl	putch		@ branches to putch

	ldr	r0, =szIP	@ Loads the address of szIP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szO	@ Load the address of szO into r0
	mov	r1, #13		@ the largest number that can be read +1
	bl	getstring	@ read from stdin (up to R1 bytes)

	ldr	r0, =szO	@ Loads the address of szO into r0
	bl	ascint32	@ branches to ascint32 will convert ascii to int

	ldr	r2, =iG		@ Loads the address of iG into r2
	str	r0, [r2]	@ will store the value in r0 into address pointed by r2

	ldr	r2, [r2]	@ r2 = *r2

	cmp	r2, #0		@ compares r2 and 0
	blt	low_		@ branches to low
	
	cmp	r2, #100	@ compares r2 and 100
	bgt	high_		@ branches to high

	b	cont_		@ branches to continue

	@===================PROCESSING============================
	
	@==================LOW===============
low_:
	ldr	r0, =szOL	@ Loads the address of szOL into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load the address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end

	@===============HIGH===============
high_:
	ldr	r0, =szOH	@ Loads the address of szOH into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load the address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end

cont_:
	@=============CHECKING WHAT GRADE================
	ldr	r2, =iG		@ Loads the address of iG into r0 
	ldr	r2, [r2]	@ r2 = *r2

	ldr	r3, =iA		@ Loads the address of iA into r3
	ldr	r3, [r3]	@ r3 = *r3

	cmp	r2, r3		@ Compares r2 and r3
	bge	grade_A		@ branches to grade_A

	ldr	r3, =iB		@ Loads the address of iB into r3
	ldr	r3, [r3]	@ r3 = *r3

	cmp	r2, r3		@ Compares r2 and r3
	bge	grade_B		@ branches to grade_B

	ldr	r3, =iC		@ Loads the address of iC into r3
	ldr	r3, [r3]	@ r3 = *r3

	cmp	r2, r3		@ Compares r2 and r3
	bge	grade_C		@ branches to grade_C

	ldr	r3, =iD		@ Loads the address of iD into r3
	ldr	r3, [r3]	@ r3 = *r3

	cmp	r2, r3		@ Compares r2 and r3
	bge	grade_D		@ branches to grade_D

	ldr	r3, =iD		@ Loads the address of iD into r3
	ldr	r3, [r3]	@ r3 = *r3

	cmp	r2, r3		@ Compares r2 and r3
	blt	grade_F		@ branches to grade_F


grade_A:
	ldr	r0, =szOA	@ Loads address of szOA into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Loads address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end


grade_B:
	ldr	r0, =szOB	@ Loads address of szOB into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Loads address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end

grade_C:
	ldr	r0, =szOC	@ Loads address of szOC into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Loads address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end


grade_D:
	ldr	r0, =szOD	@ Loads address of szOD into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Loads address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end

grade_F:
	ldr	r0, =szOF	@ Loads address of szOF into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Loads address of chLF into r0
	bl	putch		@ branches to putch

	b	end_		@ branches to end


	@========================END========================
end_:
	ldr	r0, =chLF	@ Loads address of chLF into r0
	bl	putch		@ branches to putch

	mov	r0, #0		@ Exit status code set to 0
	mov	r7, #1		@ Service command 1 will terminate

	svc	0		@ Issue linux command to terminate program
	
	.end


