@Author: Utsav Parajuli
@Class: CS3B

.global	aInsertionSort
.type	aInsertionSort,%function

array	.req	r0
length	.req	r1
i	.req	r2
j	.req	r3
next	.req	r8
current	.req	r9
temp	.req	r10

aInsertionSort:
	.fnstart
	
	push	{r4-r11, lr}		@ preserve the contents
	
	mov	i, #1			@ i = 1

	iloop: @for-loop as while loop
		cmp	i, length		@ i - n
		bge	iloopend		@ i >= n => loopend

		add	temp, array, i, lsl #2	@ temp = &array[4*i]
		ldr	temp, [temp]		@ temp = array[i]
		sub	j, i, #1		@ j = i - 1
	
		jloop:
			cmp	j, #0			@ j >= 0?
			blt	jloopend
			add	current, array, j, lsl #2
			ldr	current, [current]
			cmp	temp, current		@ temp < array[4*j]?
			bge	jloopend

			add	next, array, j, lsl #2
			add	next, next, #4		@ next <- &array[4*(j+1)]
			str	current, [next]
			sub	j, j, #1		@ decrementing j
			b	jloop

		jloopend:
			add	j, j, #1		@ incrementing j
			add	next, array, j, lsl #2
			str	temp, [next]

			add	i, i, #1		@ incrementing i
			b	iloop

iloopend:
	pop	{r4-r11, pc}
	.fnend
	
	
