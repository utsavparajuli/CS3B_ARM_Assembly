@ Author: Utsav Parajuli
@ EXAM: 2

	.equ R, 00
	.equ W, 0101
	.equ _W_, 0600

	.data
szBuffer:	.skip	20
szInput:	.asciz	"input.txt"

szOutput:	.asciz	"output.txt"
chLF:		.byte	0x0A
str1Ptr:	.word	0
str2Ptr:	.word	0
szMsg:		.asciz	"\nIN UPPERCASE\n"

	.text
	.global _start
	.extern malloc
	.extern free

_start:
	mov	r7, #5
	ldr	r0, =szInput
	
	mov	r1, #R
	mov	r2, #_W_
	svc	0

	
	mov	r3, r0
	
	mov	r7, #3
	ldr	r1, =szBuffer
	mov	r2, #1

	mov	r4, #0

top:
	mov	r0, r3
	svc	0

	cmp	r0, #0
	beq	fileEnd

@	pop	{R1}

	ldrb	r5, [r1]
	cmp	r5, #10
	beq	makeString

	add	r1, #1
	b	top
	

makeString:
	add	r1, #1
	mov	r5, r1
	
	cmp	r4, #0
	beq	firstString

	cmp	r4, #1
	beq	secondString

	bgt	fileEnd

firstString:
	ldr	r6, =str1Ptr
	ldr	r0, =szBuffer
	bl	String_Length

	mov	r10, r0		@ contains the length
	bl	malloc

	ldr	r6, =str1Ptr
	str	r0, [r6]

	ldr	r0, =szBuffer

	ldr	r6, [r6]

	mov	r11, #0
	ldrb	r9, [r0]
	strb	r9, [r6]

loop1:
	cmp	r10, r11
	beq	exitLoop1

	add	r11, #1

	ldrb	r9, [r0, r11]
	strb	r9, [r6, r11]

	b	loop1

exitLoop1:
	ldr	r6, =szBuffer
	mov	r8, #0
	str	r8, [r6, #0]

	add	r4, #1

	ldr	r1, =szBuffer
	b	top

secondString:
	@ldr	r6, =str2
	@ldr	r1, =szBuffer
	@ldr	r1, [r1]
	@str	r1, [r6]

	ldr	r6, =str2Ptr
	ldr	r0, =szBuffer
	bl	String_Length

	mov	r10, r0		@ contains the length
	bl	malloc

	ldr	r6, =str2Ptr
	str	r0, [r6]

	ldr	r0, =szBuffer
	ldr	r6, [r6]

	mov	r11, #0
	ldrb	r9, [r0]
	strb	r9, [r6]

loop:
	cmp	r10, r11
	beq	exitLoop

	add	r11, #1

	ldrb	r9, [r0, r11]
	strb	r9, [r6, r11]

	b	loop

exitLoop:
	ldr	r6, =szBuffer
	mov	r8, #0
	str	r8, [r6, #0]

	add	r4, #1

	mov	r1, r5

	b	top


fileEnd:
	ldr	r0, =str1Ptr
	ldr	r0, [r0]
	bl	putstring
	
	ldr	r0, =str2Ptr
	ldr	r0, [r0]
	bl	putstring


	ldr	r0, =szMsg
	bl	putstring

	ldr	r0, =str1Ptr
	ldr	r0, [r0]
	bl	string_toUpperCase

	bl	putstring
	
	ldr	r1, =str1Ptr
	ldr	r1, [r1]
	str	r0, [r1]	
	
write:	
	mov	r7, #5
	ldr	r0, =szOutput

	mov	r1, #W
	mov	r2, #_W_
	svc	0

	push	{r0}
	
	mov	r7, #4
	ldr	r1, =str1Ptr
	ldr	r1, [r1]
	mov	r0, r1
	bl	String_Length
	mov	r2, r0
	svc	0

	ldr	r1, =str2Ptr
	ldr	r1, [r1]
	mov	r0, r1
	bl	String_Length
	mov	r2, r0

	pop	{r0}
	svc	0

end:
	mov	r7, #6
	svc	0

	bl	free
	mov	r0, #0
	mov	r7, #1

	svc	0
	.end
		
