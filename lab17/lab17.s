@ Author: Utsav Parajuli
@ Lab:	  17
@ Date:	  March 22

@ Purpose: We will write a program that will calculate the factorial of a number

	.data

szIP:	.asciz	"Please enter a number: "
szOP:	.asciz	"The factorial is "
szX:	.skip	12
szR:	.skip	12
iX:	.word	0
iR:	.word	0
chLF:	.byte	0x0A

	.text
	.global _start

_start:
	ldr	r0, =szIP	@ load address of szIP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szX	@ load address of szX into r0
	mov	r1, #13		@ max num of input allowed +1

	bl	getstring	@ gets the string input

	bl	ascint32	@ branches to ascint32 will convert the string to ascii

	ldr	r1, =iX		@ r1 will contain the address of iX
	str	r0, [r1]	@ r1 [iX] = r0

	bl	fact		@ calls the function fact and r0 will contain the result

	ldr	r1, =iR		@ r1 will contain the address of iR
	str	r0, [r1]	@ r1 [ix] = r0

	ldr	r0, =chLF	@ load address of chLF into r0
	bl	putch		@ branches to putch

	ldr	r0, =szOP	@ load address of szOP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =iR		@ load address of iR into r0
	ldr	r0, [r0]	@ r0 = *r0
	ldr	r1, =szR	@ load address of szR into r1
	bl	intasc32	@ branches to intasc32

	ldr	r0, =szR	@ load address of szR into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ load address of chLF into r0
	bl	putch		@ branches to putch

	mov	r0, #0
	mov	r7, #1

	svc	0
	.end
