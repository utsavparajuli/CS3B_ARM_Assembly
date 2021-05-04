@ Author: Utsav Parajuli

	.data

szNum:	.skip	12
index:	.word	0
	
chLF:	.byte 	0x0A
chB:	.byte	0x29
chS:	.byte	0x20

	.global	DisplayList

	.text

@ =========== Displaying the Full list =========
@ Displays the contents of the linked list
@ ==============================================
.balign 4

DisplayList:
	push	{r4-r11, lr}

	mov	r4, r0		@ Get the contents of the pointer and move to r0

	ldr	r0, =chLF
	bl	putch		@ print the endline

	mov	r0, #0
	ldr	r1, =index
	str	r0, [r1]

	mov	r0, r4		@ Print the list
	bl	list_print

	ldr	r0, =chLF
	bl	putch		@ print the endline

	pop	{r4-r11, pc}

@=========== void list_print(r0) ===============
list_print:
	push	{lr}
	
	
	ldr	r0, =print_string_and_nl	@ print each string and a newline
	bl	list_foreach

	pop	{pc}

@========== void print_string_and_nl(r1) ==========
print_string_and_nl:
	push	{lr}

	bl	putstring		@ Displays the passed in string

	ldr	r0, =chLF
	bl	putch			@ prints new line

	pop	{pc}

@ ========= void list_foreach (r0, r1) =============
list_foreach:
	push	{r4-r11, lr}

	mov	r5, r0			@ move the address that was in r0 into r5
	mov	r0, r4			@ get the original pointer back into r0

	ldr	r6, [r4]		@ r6 is the start of the pointer at the head
	
	lforeach_while_current_not_null:
	cmp	r6, #0			@ compare the current node with null
	beq	lforeach_end

	bl	update_index
	bl	index_num

	ldr	r1, =szNum
	bl	intasc32

	ldr	r0, =szNum
	bl	putstring
	
	ldr	r0, =chB
	bl	putch
	
	ldr	r0, =chS
	bl	putch

	ldr	r0, [r6]		@ Load r0 with the data pointer of the current node
	blx	r5			@ branch to the routine
	
	ldr	r6, [r6, #4]				@ Load current node pointer with the next pointer
	bal	lforeach_while_current_not_null

	lforeach_end:
	pop	{r4-r11,pc}


update_index:

	ldr	r0, =index
	ldr	r0, [r0]

	add	r0, r0, #1

	ldr	r1, =index
	str	r0, [r1]

	bx	lr

	
index_num:
	ldr	r0, =index
	ldr	r0, [r0]
	bx	lr
