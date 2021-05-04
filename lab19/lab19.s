@ Author:  Utsav Parajuli
@ Lab:     19
@ Purpose: This lab we will concatenate two strings and create one single string by mallocing memory from the heap

	.data

szX:		.asciz	"Cat"
szY:		.asciz	" in the hat."
	
szO:		.asciz "The concatenated string is "
szO2:		.asciz "Testing the pointer, before malloc: "

ptrString:	.word	0

strSize:	.word	15

chLF:		.byte	0x0A
chS:		.byte	0x20

	.text
	
	.global _start		@ provide program start address to the Linker
	.extern	malloc		@ include the external malloc macro
	.extern	free		@ include the external free macro

_start:
	ldr	r0, =chLF	@ loads address of chLF into r0
	bl	putch		@ branches to putch
	
	ldr	r0, =szO2	@ loads the address of szO2 into r0
	bl	putstring	@ branches to putstring

	ldr	r1, =ptrString	@ r1 contains the address of ptrString
	ldr	r0, =szX	@ r0 contains the address of szX
	
	ldr	r0, [r0]	@ r0 = *r0
	str	r0, [r1]	@ r1[ptrString] = r0

	ldr	r0, =ptrString	@ r0 contains the address of ptrString
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ loads address of chLF into r0
	bl	putch		@ branches to putch
	
	ldr	r3, =strSize	@ load address of strSize into r3
	ldr	r3, [r3]	@ r3 = *r3

	mov	r0, r3		@ move length of concatenated string into r0
	
	bl	malloc		@ allocate memory equal to the length of concatenated string

	ldr	r1, =ptrString	@ r1 contains the address of ptrString
	str	r0, [r1]	@ ptrString -> memory allocated for the concatenated string

	@ looping through the first string and copying each character into ptrString
	ldr	r2, =szX	@ r2 contains the address of szX
	ldr	r4, =ptrString	@ r4 contains the address of ptrString

	ldr	r4, [r4]	@ derefrecing to get address of malloc

	mov	r5, #3		@ size of the first string

loop1:
	cmp	r5, #0		@ base case: r5 = 0
	beq	endloop1	@ end loop of r5 == 0

	ldrb	r6, [r2], #1	@ loading the character of first string into r5, szX++
	strb	r6, [r4] ,#1	@ store the character into ptrString, ptrString++

	sub	r5, #1		@ r5 = r5 -1
	b	loop1		@ loop until all string characters are put into ptrString

endloop1:
	@ looping through second string and copying all characters into ptrString
	ldr	r2, =szY	@ load address of szY into szY

	mov	r5, #12		@ size of szY
	add	r5, #1		@ adding 1 soo that null character is read in

loop2:
	cmp	r5, #0		@ base case: r5 = 0
	beq	endloop2	@ end loop of r5 == 0

	ldrb	r6, [r2], #1	@ loading the character of first string into r5, szY++
	strb	r6, [r4] ,#1	@ store the character into ptrString, ptrString++

	sub	r5, #1		@ r5 = r5 -1
	b	loop2		@ loop until all string characters are put into ptrString

endloop2:
	ldr	r0, =szO	@ load into r0 the address of szO
	bl	putstring	@ branches to putstring

	ldr	r0, =ptrString	@ load into r0 the address of ptString
	ldr	r0, [r0]	@ dereferencing to get the contents pointerd by ptrString
	bl	putstring	@ branches to putstrign

	ldr	r0, =chLF	@ loads address of chLF into r0
	bl	putch		@ branches to putch

	ldr	r0, =ptrString	@ loads address of ptrString into r0
	ldr	r0, [r0]	@ dereferencing to get contents
	bl	free		@ free dynamic memory

	mov	r0, #0
	mov	r7, #1
	svc	0

	.end
