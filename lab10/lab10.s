@ Author : Utsav Parajuli
@ Purpose: Familiarizing with the CPSR register

	.data

iX:	.word	0xDEADBEEF
iY:	.word	0xCAFEBABE

	.text
	
	.global _start

_start:

	ldr 	r6, =iX		@ load the address of iX into r6
	ldr 	r7, =iY		@ load the address of iY into r7

	ldr 	r6, [r6]	@ r6 = *r6
	ldr 	r7, [r7]	@ r7 = *r7

	add 	r0, r6, r7	@ adds the contents of r6 and r7 and stores into r0
	adc	r1, r6, r7	@ adds with carry the contents of r6 and r7 and stores into r1

	sub	r2, r6, r7	@ subtracts the contents of of r6 with r7 and stores into r2
	sbc	r3, r6, r7	@ subtacts with carry the contents of r6 with r7 and stores into r3
	
	rsb	r4, r6, r7	@ reverse subtracts the contents of r6 with r7 and stores into r4
	rsc	r5, r6, r7	@ reverse subtracts with carry the contents of r6 with r7 and stores into r5

	mov r0, #0		@ Set program Exit Status code to 0
	mov r7, #1		@ Service command code of 1 to terminate program

	svc 0			@ Performs service call to linux
	.end

