@ Author: Utsav Parajuli
@ Class:  CS3B

@ Subroutine: Bubble Sort
@ R0: Pointer to the first element of the array
@ R1: Length of array

	.global aBubbleSort
	.type	aBubbleSort,%function

array		.req	r0
i		.req	r2
j		.req	r3
length		.req	r1
sentinel	.req	r8
nextElem	.req	r5
currentElem	.req	r4
nextPtr		.req	r7
currentPtr	.req	r6
temp		.req	r10

aBubbleSort:
	.fnstart
	push	{r4-r11, lr}

	sub	i, length, #1		@ i = length - 1

firstLoop:
	mov	j, #0

	secondLoop:
		//getting a[j]
		add	currentPtr, array, j, lsl #2	@ currentPtr = &a[j]
		ldr	currentElem, [currentPtr]	@ currentElem = a[j]

		//getting a[j+1]
		add	j, j, #1			@ j = j+1
		add	nextPtr, array, j, lsl #2	@ nextPtr = &a[j+1]
		ldr	nextElem, [nextPtr]		@ nextElem = a[j+1]

		if:
			cmp	nextElem, currentElem
			bgt	endGTEarlier

			str	currentElem, [nextPtr]	@ a[j+1] = a[j]
			str	nextElem, [currentPtr]	@ a[j] = a[j+1]

		endGTEarlier:
			cmp	j, i				@ if j < i
			blt	secondLoop			@ branch to the second loop

	end_secondLoop:
		sub	i, i, #1			@ incrementing i
		cmp	i, #2
		bge	firstLoop			@ branch to firstLoop

end:
	pop	{r4-r11, pc}				@ pop registers
	.fnend
