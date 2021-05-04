@+String_indexOf_1(string1:String,ch:char):int  Returns the index of first occurrence of the 
@specified character ch in the string.
@R0 contains the address of the string to be searched
@R1 contains the character literal to be found in the string
@Result is returned in R0 and -1 is returned if nothing is found.

		.data

pTemp:		.word 0

		.text

		.global string_index_of_1

string_index_of_1:
	push 	{r4-r11}		@saves these registers
	push	{sp}			@saves stack pointer
	push	{lr}			@saves return to main

	@R0 = string address, R1 = character literal

	mov	r3, r0			@moves address in r0 into r3
	mov	r4, r1			@moves character stored in r1 to r4
	mov	r5, #0			@begins position counter

	@begin search

searchSIO1:

	ldrb	r0, [r3]		@loads the byte into r0
	cmp	r0, r4			@checks to see if read in byte == char
	beq	end			@jumps if cmp passes
	cmp	r0, #0			@checks to see if reached end of string
	moveq	r5, #-1			@moves -1 into r5 denoting search failed.
	beq	end			@jumps if cmp passes
	add	r5, #1			@adds 1 to counter if fails
	add	r3, #1			@moves pointer to grab next character
	b	searchSIO1		@continues loop

end:

	mov	r0, r5			@moves position counter to r0
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@stores r4-r11
	bx	lr			@jumps back to main pgm

	@string_index_of_2
@String_indexOf_2(string1:String,ch:char,fromIndex:int):int  
@Same as indexOf method however it starts searching in the string from the specified fromIndex.
@R0 contains the address of the string to be searched
@R1 contains the character literal to be found in the string
@R2 contains the index to start at
@Result is returned in R0 and -1 is returned if nothing is found.

		.global string_index_of_2

string_index_of_2:

	push 	{r4-r11}		@saves these registers
	push	{sp}			@saves stack pointer
	push	{lr}			@saves return to main

	@R0 = string address, R1 = character literal, R2 = index start

	mov	r3, r0			@moves address in r0 into r3
	mov	r4, r1			@moves character stored in r1 to r4
	mov	r5, r2			@begins position counter
	add	r3, r2			@adds start index starting point

searchSIO2:

	ldrb	r0, [r3]		@loads the byte into r0
	cmp	r0, r4			@checks to see if read in byte == char
	beq	end			@jumps if cmp passes
	cmp	r0, #0			@checks to see if reached end of string
	moveq	r5, #-1			@moves -1 into r5 denoting search failed.
	beq	endIO2			@jumps if cmp passes
	add	r5, #1			@adds 1 to counter if fails
	add	r3, #1			@moves pointer to grab next character
	b	searchSIO2		@loops back to the top

endIO2:

	mov	r0, r5			@moves position counter to r0
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@stores r4-r11
	bx	lr			@jumps back to main pgm


	@string_index_of_3
@+String_indexOf_3(string1:String, str:String):int
@This method returns the index of first occurrence of specified substring str.
@R0 contains the address of the string to be searched
@R1 contains the address of the substring to be found
@Returns index of first occurrence in R0. Returns -1 if not found


	.global string_index_of_3

string_index_of_3:
	push 	{r4-r11}		@saves these registers
	push	{sp}			@saves stack pointer
	push	{lr}			@saves return to main

	@R0 = string address, R1 = sub string address
	mov	r8, r0			@stores base address of string
	mov	r9, r1			@stores base address of substring
	mov	r3, r0			@moves base address of string 
	mov	r4, r1			@moves base address of substring
	mov	r0, r1			@moves substring to r0
	bl	String_Length		@grabbing length of substring
	mov	r2, r0			@moves string length to r2
	mov	r5, #0			@begins position counter
	mov	r6, #0			@begins last known match counter

findE:

	ldrb	r0, [r3]		@loads byte of string into r0
	ldrb	r1, [r4]		@loads byte of substring into r1
	cmp	r0, r1			@compares characters
	moveq	r6, r5			@updates last known position of character match
	moveq	r7, #1			@starts match case counter
	beq	cmpRest			@jumps to check rest of string for substring
	cmp	r0, #0			@compares to see if reached end of string
	moveq	r6, #-1			@failed to find substring
	beq	endIO3			@jumps out of loop
	add	r5, #1			@updates position counter
	add	r3, #1			@loads next byte of string
	b	findE			@loops back up


cmpRest:

	cmp	r7, r2			@compares match case counter to substring length
	beq	endIO3			@jumps out of loop if r8 == substring length
	add	r3, #1			@loads next byte of string
	add	r4, #1			@loads next byte of substring
	ldrb	r0, [r3]		@loads string byte into r0
	ldrb	r1, [r4]		@loads substring byte into r1
	cmp	r0, r1			@compares to see if characters match
	addeq	r7, #1			@adds 1 to match case counter if r0 == r1
	beq	cmpRest			@loops back up
	mov	r3, r8			@restores base address of string
	mov	r4, r9			@restores base address of substring
	add	r5, #1			@updates position counter
	add	r3, r5			@next byte = position counter + 1
	b	findE			@breaks back out to main loop



endIO3:

	mov	r0, r6			@moves match case counter to r0
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@stores r4-r11
	bx	lr			@jumps back to main pgm

	@string_lastIndex_of_1

@+String_lastIndexOf_1(string1:String, ch:char):int
@It returns the last occurrence of the character ch in the string.
@R0 contains the address of the string to be searched
@R1 contains the character literal to be found in the string

		.global string_lastIndex_of_1

string_lastIndex_of_1:

	push 	{r4-r11}		@saves these registers
	push	{sp}			@saves stack pointer
	push	{lr}			@saves return to main

	@R0 = string address, R1 = character literal

	mov	r3, r0			@moves address in r0 into r3
	mov	r4, r1			@moves character stored in r1 to r4
	bl	String_Length		@finds length of string
	mov	r2, r0			@stores length of string in r2
	mov	r5, #0			@begins position counter
	mov	r6, #-1			@begins last match counter

	@begin search

searchSLIO1:

	ldrb	r0, [r3]		@loads the byte into r0
	cmp	r0, r4			@checks to see if read in byte == char
	moveq	r6, r5			@updates last known counter
	cmp	r0, #0			@checks to see if reached end of string
	beq	endSLIO1		@jumps if cmp passes
	add	r5, #1			@adds 1 to counter if fails
	add	r3, #1			@moves pointer to grab next character
	b	searchSLIO1		@continues loop

endSLIO1:

	cmp	r6, #-1			@checks to see if any matches were found
	moveq	r0, #-1			@returns 1 if r6 == -1
	movne	r0, r6			@returns r6 in r0 if r6 != -1
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@stores r4-r11
	bx	lr			@jumps back to main pgm
	

	@string_lastIndex_of_2
@+String_lastIndexOf_2(string1:String,ch:char,fromIndex:int):int 
@Same as lastIndexOf_1 method, but it starts search from fromIndex.
@R0 contains the address of the string to be searched
@R1 contains the character literal to be found in the string
@R2 contains the index to start at
@Result is returned in R0 and -1 is returned if nothing is found.


		.global string_lastIndex_of_2

string_lastIndex_of_2:

	push 	{r4-r11}		@saves these registers
	push	{sp}			@saves stack pointer
	push	{lr}			@saves return to main

	@R0 = string address, R1 = character literal, R2 = index start

	mov	r3, r0			@moves address in r0 into r3
	mov	r4, r1			@moves character stored in r1 to r4
	mov	r5, r2			@begins position counter
	mov	r6, #-1			@begins last known match counter
	add	r3, r2			@adds start index starting point

searchSLIO2:

	ldrb	r0, [r3]		@loads the byte into r0
	cmp	r0, r4			@checks to see if read in byte == char
	moveq	r6, r5			@updates last known match counter
	cmp	r0, #0			@checks to see if reached end of string
	beq	endSLIO2			@jumps if cmp passes
	add	r5, #1			@adds 1 to counter if fails
	add	r3, #1			@moves pointer to grab next character
	b	searchSLIO2		@loops back to the top

endSLIO2:

	cmp	r6, #-1			@checks to see if any matches were found
	moveq	r0, #-1			@returns 1 if r6 == -1
	movne	r0, r6			@returns r6 in r0 if r6 != -1
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@stores r4-r11
	bx	lr			@jumps back to main pgm

@+String_lastIndex_of_3(string1:String, str:String):int
@This method returns the index of the last occurrence of specified substring str.
@R0 contains the address of the string to be searched
@R1 contains the address of the substring to be found
@Returns the index of last occurrence in R0. Returns -1 if nothing found

		.global string_lastIndex_of_3

string_lastIndex_of_3:

	push 	{r4-r11}		@saves these registers
	push	{sp}			@saves stack pointer
	push	{lr}			@saves return to main

	@R0 = string address, R1 = sub string address
	mov	r8, r0			@stores base address of string
	mov	r9, r1			@stores base address of substring
	bl	String_Length		@grabbing length of substring
	mov	r10, r0			@moves string length into r10
	mov	r0, r9			@moves base address of substring
	bl	String_Length		@finds string length of base string
	mov	r2, r0			@stores the substring length in r2
	mov	r3, r8			@loads string address
	mov	r4, r9			@loads substring address
	mov	r5, #0			@begins position counter
	mov	r6, #-1			@begins last known match counter

findELI:

	ldrb	r0, [r3]		@loads byte of string into r0
	ldrb	r1, [r4]		@loads byte of substring into r1
	cmp	r0, r1			@compares characters
	moveq	r6, r5			@updates last known position of character match
	moveq	r7, #1			@starts match case counter
	beq	cmpRestLI		@jumps to check rest of string for substring
	cmp	r0, #0			@compares to see if reached end of string
	beq	endLIO3			@jumps out of loop
	add	r5, #1			@updates position counter
	add	r3, #1			@loads next byte of string
	b	findE			@loops back up


cmpRestLI:

	cmp	r7, r2			@compares match case counter to substring length
	beq	endLIO3			@jumps out of loop if r8 == substring length
	add	r3, #1			@loads next byte of string
	add	r4, #1			@loads next byte of substring
	ldrb	r0, [r3]		@loads string byte into r0
	ldrb	r1, [r4]		@loads substring byte into r1
	cmp	r0, r1			@compares to see if characters match
	addeq	r7, #1			@adds 1 to match case counter if r0 == r1
	beq	cmpRestLI		@loops back up
	mov	r3, r8			@restores base address of string
	mov	r4, r9			@restores base address of substring
	add	r5, #1			@updates position counter
	add	r3, r5			@next byte = position counter + 1
	b	findELI			@breaks back out to main loop



endLIO3:
	cmp	r5, r10			@compares program counter with string length
	movne	r3, r8			@restores base address of string
	movne	r4, r9			@restores base address of substring
	addne	r5, #1			@updates position counter
	addne	r3, r5			@next byte = position counter + 1
	bne	findELI			@if r5 != r2 branch back
	cmp	r6, #-1			@does r6 == -1?
	moveq	r0, #-1			@R0 = -1
	movne	r0, r6			@moves match case counter to r0
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@stores r4-r11
	bx	lr			@jumps back to main pgm

	@string_concat
@+String_concat(string1:String,str:String):String 
@Concatenates the specified string “str” at the end of the string.
@R0 contains the address of the first string
@R1 contains the address of the second string
@Returns the address of the new string to R0.

		.global string_concat

string_concat:

	push	{r4-r8,r10,r11}		@pushes registers r4-r48, r10, r11 onto stack
	push	{sp}			@pushes sp onto the stack
	push	{lr}			@pushes the lr onto the stack

	ldr	r5, =pTemp		@loads pTemp for storage
	mov	r7, r0			@moves first string address to r0
	mov	r8, r1			@moves second string address to r0
	bl	String_Length		@finds the length of the first string
	mov	r6, r0			@moves length to r6
	mov	r0, r8			@moves second string address to r0
	bl	String_Length		@finds the length of second string
	add	r6, r0			@adds both lengths together to get total
	add	r6, #1			@adds 1 for null
	mov	r0, r6			@moves number of bytes needed
	bl	malloc			@calls malloc to allocate space on heap
	str	r0, [r5]		@stores address to pointer pTemp
	mov	r5, r0			@loads address of heap memory
	
firstString:

	ldrb	r0, [r7]		@loads byte into r0
	cmp	r0, #0			@checks for null
	beq	secondString		@jumps to second string
	str	r0, [r5]		@stores byte
	add	r5, #1			@moves to next byte location
	add	r7, #1			@moves to next byte to grab
	b	firstString		@loops back up
	
secondString:
	ldrb	r0, [r8]		@loads byte into r0
	cmp	r0, #0			@checks for null
	beq	endConcat		@jumps to end
	str	r0, [r5]		@stores byte
	add	r5, #1			@moves to next byte location
	add	r8, #1			@moves to next byte to grab
	b	secondString		@loops back up

endConcat:

	mov	r0, #0			@moves null into r0
	str	r0, [r5]		@inserts null at end of string
	ldr	r5, =pTemp		@loads pointer
	ldr	r0, [r5]		@loads heap memory address
	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@restores r4-r11
	bx	lr			@jumps back to main pgm

	@string_replace
@+String_replace(string1:String,oldChar:char,newChar:char):String
@It returns the new updated string after changing all the occurrences of oldChar with the newChar.
@R0 contains the string address
@R1 contains character to be replaced
@R2 contains character that will replace old character
@Returns the address of the new string in R0.

		.global string_replace

string_replace:

	push	{r4-r8,r10,r11}		@pushes registers r4-r48, r10, r11 onto stack
	push	{sp}			@pushes sp onto the stack
	push	{lr}			@pushes the lr onto the stack

	mov	r4, r0			@moves string address to r4

searchingToReplace:

	ldrb	r7, [r4]		@loads byte of string
	cmp	r7, r1			@compares string char with old char
	beq	replace			@jumps to loop to replace character
	cmp	r7, #0			@compares byte with null
	beq	endReplace		@breaks out of loop
	add	r4, #1			@moves to next byte
	b	searchingToReplace	@jumps back to top of loop

replace:

	strb	r2, [r4], #1		@stores new character then increments string address
	b	searchingToReplace	@jumps back to main loop


endReplace:

	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@restores r4-r11
	bx	lr			@jumps back to main pgm


	@string_toLowerCase

@+String_toLowerCase(string1:String):String
@converts the string to all lower case
@R0 contains the string to be changed
@Returns address of string in R0

		.global string_toLowerCase

string_toLowerCase:

	push	{r4-r8,r10,r11}		@pushes registers r4-r48, r10, r11 onto stack
	push	{sp}			@pushes sp onto the stack
	push	{lr}			@pushes the lr onto the stack

	mov	r4, r0			@moves address of string to r4
	mov	r5, #32			@offset to make uppercase
	mov	r7, #91			@ascii value past Z
	mov	r9, #32			@ascii value for space
	mov	r10, #46		@ascii value for period
lowerCase:

	ldrb	r8, [r4]		@loads byte
	cmp	r8, r9			@checks for space
	addeq	r4, #1			@moves past space
	beq	lowerCase		@jumps back to top of loop
	cmp	r8, r10			@checks for period
	addeq	r4, #1			@moves past space
	beq	lowerCase		@jumps back to top of loop
	cmp	r8, #0			@checks for null
	beq	endLC			@breaks out of loop
	cmp	r8, r7			@compares upper boundary of lower letters
	blt	storeLower		@jumps to loop thatll convert and store
	add	r4, #1			@loads next byte
	b	lowerCase		@loops back up

storeLower:

	add	r8, r5, r8		@adds the offset to make lowercase
	strb	r8, [r4], #1		@stores byte into memory and increments
	b	lowerCase		@jumps back to main loop

endLC:

	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@restores r4-r11
	bx	lr			@jumps back to main pgm


	@string_toUpperCase
@+String_toUpperCase(string1:String):String
@It converts the string to upper case string
@R0 contains the address of the string
@Returns the the address of the string in R0

		.global string_toUpperCase

string_toUpperCase:

	push	{r4-r8,r10,r11}		@pushes registers r4-r48, r10, r11 onto stack
	push	{sp}			@pushes sp onto the stack
	push	{lr}			@pushes the lr onto the stack

	mov	r4, r0			@moves address of string to r4
	mov	r5, #-32		@offset to make lowercase
	mov	r7, #96			@ascii value past Z

UpperCase:

	ldrb	r8, [r4]		@loads byte
	cmp	r8, r7			@compares upper boundary of lower letters
	bgt	storeUpper		@jumps to loop thatll convert and store
	cmp	r8, #0			@checks for null
	beq	endUC			@breaks out of loop
	add	r4, #1			@next byte
	b	UpperCase		@loops back up

storeUpper:

	add	r8, r5, r8		@adds the offset to make lowercase
	strb	r8, [r4], #1		@stores byte into memory and increments
	b	UpperCase		@jumps back to main loop

endUC:

	pop	{lr}			@restores link register
	pop	{sp}			@restores stack pointer
	pop	{r4-r11}		@restores r4-r11
	bx	lr			@jumps back to main pgm
	











	
