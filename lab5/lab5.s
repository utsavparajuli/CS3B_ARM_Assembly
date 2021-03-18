/* -- Lab5.s */
/* This is a comment */
@ This is also a comment
@ Author : Utsav Parajuli

	.data
szMsg1: .asciz	"The sun did not shine."
szMsg2: .asciz	"It was too wet to play."
chCr:	.byte	10

	.text
	.global _start		@ Provide program starting address to linker

_start:
	ldr	r0, =szMsg1	@ load into r0 address of szMsg1
	bl	putstring	@ branch and link external function

	ldr	r0, =chCr	@ load into r0 address of chCr
	bl	putch		@ branch and link external function

	ldr	r0, =szMsg2	@ load into r0 address of szMsg2
	bl	putstring	@ branch and link external function

	ldr	r0, =chCr	@ load into r0 address of chCr
	bl	putch		@ branch and link external function

	mov	R0, #7		@ Set program Exit Status code to 7.
	mov	R7, #1		@ Service command code of 1 to terminate pgm.

	svc	0		@ Perform Service Call to Linux.
	.end
