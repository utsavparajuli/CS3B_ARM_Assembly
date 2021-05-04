@ Subroutine String_Length accepts the address of a string and counts the characters in the string, 
@ excluding the NULL character and returns that value as an int (word) in the R0 register, will
@ read a string of characters terminated by a null.
@	R0: Points to first byte of string to count
@	LR: Contains the return address

@ Returned register contents
@	R0: Number of characters in the string (does not include null)
@ All registers are preserved as per AAPCS


	.global String_Length		@ Subroutine

String_Length:

	push	{r4-r11, lr}		@ preserves the contents of those registers

	mov	r1, #0			@ counter for counting the length

loop:
	ldrb	r2, [r0, r1]		@ loads the first byte r0[r1] intro r2
	cmp	r2, #0			@ Compares if r2 == NULL
	beq	end			@ if == 0, branch to end
	add	r1, r1, #1		@ increments the index
	b	loop			@ branches to top of loop
end:
	mov	r0, r1			@ r0 = r1

	pop	{r4-r11, lr}
	
	bx	lr			@ return to the calling program

	.end
