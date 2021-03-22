@ Author:  Utsav Parajuli
@ Date:	   03/21/2021
@ Lab:	   14
@ Purpose: Replicating the collatz problem

	.data

szIP:	.asciz	"Please enter the number: "
szOP:	.asciz	"It took "
szOP2:	.asciz	" steps."
szI:	.skip	12
szI2:	.skip	12

iStep:	.word	0

iNum:	.word	0
chLF:	.byte	0x0A

	.text
	.global _start

_start:
	ldr	r0, =szIP	@ loading address of szIP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI	@ loading address of szI into r0
	mov	r1, #13		@ max num of input
	bl	getstring	@ branches to getstring

	ldr	r0, =chLF	@ loading address of chLF into r0
	bl	putch		@ branches to putch

	ldr	r0, =szI	@ loading szI into r0
	bl	ascint32	@ r0 will contain the int value

	ldr	r1, =iNum	@ loading iNum into r0
	str	r0, [r1]	@ [r1] iNum = r0

	ldr	r1, [r1]	@ r1 = *r1

	ldr	r0, =chLF	@ loading address of chLF into r0
	bl	putch		@ branches to putch

	mov	r2, #0		@ r2 <- 0 the # steps

loop:
	cmp	r1, #1		@ compare r1 and 1
	beq	end		@ branch to end if r1 == 1

	and	r3, r1, #1	@ r3 <- r1 & 1 [mask]
	cmp	r3, #0		@ compare r3 and 0
	bne	odd		@ branch to odd if r3 != 0

even:
	mov	r1, r1, ASR #1	@ r1 <- (r1 >> 1) [divided by 2]
	b	end_loop

odd:
	add	r1, r1, r1, LSL #1	@ r1 <- r1 + (r1 << 1) {3n}
	add	r1, r1, #1		@ r1 <- r1 + 1 [3n +1]

end_loop:
	add	r2, r2, #1		@ r2 <- r2 + 1
	b	loop

end:
	ldr	r3, =iStep	@ load iStep into r3
	str	r2, [r3]	@ r3 = r2

	ldr	r0, =szOP	@ load szOP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, [r3]	@ load r3 into r0
	ldr	r1, =szI2	@ load szI into r1

	bl	intasc32	@ converting int to ascii

	ldr	r0, =szI2	@ load szI into r0
	bl	putstring	@ branches to putstring
	
	ldr	r0, =szOP2	@ load szOP2 into r0
	bl	putstring	@ branches to putstring
	
	ldr	r0, =chLF	@ loading address of chLF into r0
	bl	putch		@ branches to putch

	mov	r0, #0
	mov	r7, #1

	svc	0
	.end
		
