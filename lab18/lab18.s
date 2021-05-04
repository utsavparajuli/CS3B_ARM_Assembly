@ Author:  Utsav Parajuli
@ Lab:     18
@ Purpose: Testing the string length function

	.data

szLen:		.skip	12

szOut1:		.asciz	"The length of "
szOut2:		.asciz	" is "

szString:	.asciz	"Cat in the hat"

chLF:		.byte	0x0A

	.text

	.global _start		@ Provide program start address to linker

_start:
	ldr	r0, =chLF	@ Load into r0 the address of chLF
	bl	putch		@ branches to putch

	ldr	r0, =szOut1	@ Load into r0 the address of szOut1
	bl	putstring	@ branches to putstring

	ldr	r0, =szString	@ Load into r0 the address of szString
	bl	putstring	@ branches to putstring

	ldr	r0, =szOut2	@ Load into r0 the address of szOut2
	bl	putstring	@ branches to putstring

	ldr	r0, =szString	@ Load into r0 the address of szString
	bl	String_Length	@ branches to the function String_Length

	ldr	r1, =szLen	@ Load into r0 the address of szLen
	bl	intasc32	@ branches to intasc32

	ldr	r0, =szLen	@ Load into r0 the address of szLen
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load into r0 the address of chLF
	bl	putch		@ branches to putch

	mov	r0,#0
	mov	r7, #1

	svc	0	

	.end
