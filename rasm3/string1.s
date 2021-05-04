@ String Part 1 RASM3
@ Author: Utsav Parajuli



@ Subroutine String_Length: accepts the address of a string and counts the characters in the string, 
@ 			    excluding the NULL character and returns that value as an int (word) 
@			    in the R0 register, will read a string of characters terminated by a null.
@	R0: Points to first byte of string to count
@	LR: Contains the return address

@ Returned register contents
@	R0: Number of characters in the string (does not include null)
@ All registers are preserved as per AAPCS


	.global String_Length		@ Subroutine

String_Length:

	push	{r4-r11, lr}		@ preserves the contents of those registers

	mov	r4, #0			@ counter for counting the length

lenLoop:
	ldrb	r5, [r0, r4]		@ loads the first byte r0[r4] intro r5
	cmp	r5, #0			@ Compares if r5 == NULL
	beq	lenEnd			@ if == 0, branch to lenEnd
	add	r4, r4, #1		@ increments the index
	b	lenLoop			@ branches to top of loop

lenEnd:
	mov	r0, r4			@ r0 = r4

	pop	{r4-r11, lr}
	
	bx	lr			@ return to the calling program


@ Subroutine String_Equals: accepts the address of a string and will make an exact comparison(case sensitive)
@			    of individual characters in two strings. If any character is different it
@			    will return false '0' or else a true '1'

@	R1: Points to first byte of string to check for
@	R2: Contains the string to be compared with
@	LR: Contains the return address

@ Returned register contents
@	R0: The result of comparison
@ All registers are preserved as per AAPCS


	.global	String_Equals		@ Subroutine string_equals

String_Equals:
	push	{r4-r11, lr}
	mov	r0, #1			@ Setting r0 to true
	
equLoop:
	ldrb	r4, [r1], #1		@ Load a single character of s1 into r4
	ldrb	r5, [r2], #1		@ Load a single character of s2 into r5

	cmp	r4, r5			@ Comparing the characters
	movne	r0, #0			@ If characters are not equal, set r0 to false
	bne	equEnd			@ branch to equEnd if !=

	cmp	r4, #0			@ comparing if r4 is null
	beq	equEnd			@ branch to end

	b	equLoop			@ branch to the top

equEnd:
	pop	{r4-r11, lr}
	bx	lr

	
@ Subroutine String_EqualsIgnoreCase: accepts the address of a string and will make an comparison(case-insensitive)
@			    	      of individual characters in two strings. If any character is different it
@			    	      will return false '0' or else a true '1'

@	R1: Points to first byte of string to check for
@	R2: Contains the string to be compared with
@	LR: Contains the return address

@ Returned register contents
@	R0: The result of comparison
@ All registers are preserved as per AAPCS

	.global String_EqualsIgnoreCase

String_EqualsIgnoreCase:
	push 	{r4-r11, lr}

	mov	r4, r1			@ copy first string into r4
	mov	r5, r2			@ copy second string into r5

	mov	r8, #0			@ intialize r8 = 0
	mov	r0, #1			@ intiializing result to true

step_1:
	ldrb	r6, [r2, r8]		@ r6 = firstString[i]
	ldrb	r7, [r4, r8]		@ r7 = firstString[i]

	cmp	r6, #'Z'		@ comparing r6 to Z
	bgt	step_2			@ branching to step 2 if r6 > 'Z'
	add	r6, r6, #32		@ converting the char to lowercase
	
step_2:
	cmp	r7, #'Z'		@ comparing r7 to Z
	bgt	step_3			@ branching to step 3 if r7 > 'Z'
	add	r7, r7, #32		@ converting the char to lowecase

step_3:
	cmp	r6, r7			@ comparing the 2 characters
	movne	r0, #0			@ if not equal the result will be 0
	bne	icEqualEnd		@ branch to end	if not equal
	add	r8, r8, #1		@ incrementing counter

	cmp	r6, #32			@ comparong if r6 == 32
	beq	icEqualEnd		@ branch if reached null

	b 	step_1			@ branch to step_1


icEqualEnd:		
	pop	{r4-r11, lr}
	bx	lr


	
@ Subroutine String_Copy: accepts the address of a string to copy. Will dynamically allocate memory and will
@			  return the address of new string.
@	R1: Contains the string to copy
@	LR: Contains the return address

@ Returned register contents
@	R0: The address of new string
@ All registers are preserved as per AAPCS

	
	.global String_Copy
	.extern malloc
	.extern free

String_Copy:
	push {r4-r11, lr}
	
	mov	r0, r1		@ move the contents of r1 into r0
	mov	r5, r1		@ store the contents of r1 into r5
	
	bl	String_Length	@ r0 contains the length of string
	bl	malloc		@ branch to malloc

	push	{r0}		@ save the new address
	
	mov	r1, r5		@ move back the contents into r1
	ldrb	r4, [r1]	@ load the first byte of string in r1
	strb	r4, [r0]	@ store the first byte in r0

copyLoop:
	cmp	r4, #0		@ comparing r4 to 0
	beq	copyEnd		@ branch to copyEnd

	ldrb	r4, [r1, #1]!	@ load the contents of next character
	strb	r4, [r0, #1]!	@ store the content into the memory

	b	copyLoop	@ branch to copyLoop	

copyEnd:	
	pop	{r0}
	pop	{r4-r11, lr}
	bx	lr


@ Subroutine String_Substring_1: This method will create a new string consisting
@				 of characters from a substring of the passed string
@				 starting with the beginIndex and ending with endIndex 
@	R0: Points to first byte of string to make a substring for
@	R1: Contains the address of string that will have the new substring
@	R2: Start index
@	R3: End index
@	LR: Contains the return address

@ Returned register contents
@	R1: The new substring
@ All registers are preserved as per AAPCS
	
	.global String_Substring_1

String_Substring_1:
	push {r4-r11, lr}
	
	sub	r4, r3, r2	@ r4 contains the number of characters to be used for substring
	mov	r5, #0		@ counter

sub1Loop:
	ldrb	r6, [r0, r2]	@ loads character at r0[r2]

	cmp	r6, #0		@ compares r6 and 0
	beq	sub1End		@ branch to sub1Loop

	strb	r6, [r1, r5]	@ stores the character in new string

	add	r2, r2, #1	@ adds +1 to the next index
	add	r5, r5, #1	@ add +1 to the counter

	cmp	r5, r4		@ compare r5 and r4
	ble	sub1Loop	@ branch to top

	b	sub1End		@ branch to end

sub1End:	
	pop	{r4-r11, lr}
	bx	lr

@ Subroutine String_Substring_2: This method will create a new string consisting
@				 of characters from a substring of the passed string
@				 starting with the beginIndex to the end of original string
@	R0: Points to first byte of string to make a substring for
@	R1: Contains the address of string that will have the new substring
@	R2: Start index
@	LR: Contains the return address

@ Returned register contents
@	R1: The new substring
@ All registers are preserved as per AAPCS
	
	.global String_Substring_2

String_Substring_2:
	push 	{r4-r11, lr}
	
	mov	r7, r0		@ move contents of r0 into r7
	mov	r8, r1		@ move contents of r1 into r8
	mov	r9, r2		@ mvoe contents of r2 to r9

	bl	String_Length	@ branches to string length to get size of string (r0 = length)

	mov	r10, r0		@ r10 will contain the length of string

	mov	r0, r7		@ r0 will contain the original string again
	mov	r1, r8		@ r1 will contain the original string again
	mov	r2, r9		@ r2 will contain the original contents again
	
	sub	r4, r10, r2	@ r4 contains the number of characters to be used for substring
	mov	r5, #0		@ counter

sub2Loop:
	ldrb	r6, [r0, r2]	@ loads character at r0[r2]

	cmp	r6, #0		@ compares r6 and 0
	beq	sub2End		@ branch to sub1Loop

	strb	r6, [r1, r5]	@ stores the character in new string

	add	r2, r2, #1	@ adds +1 to the next index
	add	r5, r5, #1	@ add +1 to the counter

	cmp	r5, r4		@ compare r5 and r4
	ble	sub2Loop	@ branch to top

	b	sub2End		@ branch to end

sub2End:	
	pop	{r4-r11, lr}
	bx	lr


@ Subroutine String_CharAt: This method will return the character in the indicated
@			    position. 
@	R0: Points to first byte of string
@	R1: Contains the index to look for
@	LR: Contains the return address

@ Returned register contents
@	R0: The character in the index specified
@ All registers are preserved as per AAPCS

	.global String_CharAt

String_CharAt:
	push	{r4-r11, lr}
	
	mov	r4, #0		@ mov 0 into r0 for counter

charAtLoop:
	ldrb	r5, [r0, r4]	@ load the first byte of string r0
	
	cmp	r4, r1		@ compare r4 and r1
	beq	endCharAt	@ if == branch to end

	add	r4, r4, #1	@ increment the counter

	b	charAtLoop	@ branch to top of loop

endCharAt:
	mov	r0, r5		@ move the content of r5 into r0
	pop	{r4-r11, lr}
	bx	lr



@ Subroutine String_StartsWith_1: This method will check whether the substring
@				  exists within the string or not.

@	R0: Points to first byte of string
@	R1: Contains the index to look start looking from
@	R2: String to look for
@	LR: Contains the return address

@ Returned register contents
@	R0: The value '0' or '1' for true and false.
@ All registers are preserved as per AAPCS

	.global String_StartsWith_1

String_StartsWith_1:
	push	{r4-r11, lr}
	

	mov	r4, #0		@ mov 0 into r0 for counter
	mov	r8, #1		@ set r8 to 1

startsWithLoop1:
	ldrb	r5, [r0, r1]	@ load the first byte of string 1 into r5
	ldrb	r6, [r2, r4]	@ load the first byte of substring to look for
	
	cmp	r5, #0		@ comparing r5 to 0
	beq	endStartsWith1	@ branch to end

	cmp	r5, r6		@ compare r5 and r6
	movne	r8, #0		@ move 0 to r8 if r5 != r6
	bne	endStartsWith1	@ if r5 != r6

	add	r1, r1, #1	@ increment r1
	add	r4, r4, #1	@ increment the counter

	b	startsWithLoop1	@ branch to top of loop

endStartsWith1:
	mov	r0, r8		@ move the content of r8 into r0
	pop	{r4-r11, lr}
	bx	lr


@ Subroutine String_StartsWith_2: This method will check whether the string begins
@				  with a specified prefix. If yes returns true or else false

@	R0: Points to first byte of string
@	R1: Contains the string prefix to look for
@	LR: Contains the return address

@ Returned register contents
@	R0: The value '0' or '1' for true and false.
@ All registers are preserved as per AAPCS

	.global String_StartsWith_2

String_StartsWith_2:
	push	{r4-r11, lr}
	

	mov	r4, #0		@ mov 0 into r0 for counter
	mov	r8, #1		@ set r8 to 1

startsWithLoop2:
	ldrb	r5, [r0, r4]	@ load the first byte of string 1 into r5
	ldrb	r6, [r1, r4]	@ load the first byte of substring to look for
	
	cmp	r6, #0		@ comparing r5 to 0
	beq	endStartsWith2	@ branch to end

	cmp	r5, r6		@ compare r5 and r6	
	movne	r8, #0		@ move 0 to r8 if r5 != r6
	bne	endStartsWith2	@ if r5 != r6


	add	r4, r4, #1	@ increment the counter

	b	startsWithLoop2	@ branch to top of loop

endStartsWith2:
	mov	r0, r8		@ move the content of r8 into r0
	pop	{r4-r11, lr}
	bx	lr



@ Subroutine String_EndsWith: This method will check whether the string ends with the specified suffix

@	R0: Points to first byte of string
@	R1: Contains the string suffix to look for
@	LR: Contains the return address

@ Returned register contents
@	R0: The value '0' or '1' for true and false.
@ All registers are preserved as per AAPCS

	.global String_EndsWith

String_EndsWith:
	push	{r4-r11, lr}
	
	mov	r4, r0		@ moving r0 into r4; preserving the contents
	mov	r5, r1		@ moving r1 into r5

	bl	String_Length	@ r0 will contain the result
	
	mov	r6, r0		@ moving the string length into r6
	
	mov	r0, r5		@ moving back the value into r0
	bl	String_Length	@ r0 will contain the result for second string

	mov	r7, r0		@ moving the value of r0 into r7
	sub	r10, r6, r7	@ this is the start index to count for end
	
	mov	r0, r4		@ moving the original value of r0 into r0
	mov	r1, r5		@ moving back the original value

	mov	r4, #0		@ mov 0 into r0 for counter
	mov	r8, #1		@ set r8 to 1

endsWithLoop:
	ldrb	r5, [r0, r10]	@ load the first byte of string 1 into r5
	ldrb	r6, [r1, r4]	@ load the first byte of substring to look for
	
	cmp	r5, #0		@ comparing r5 to 0
	beq	endEndsWith	@ branch to end

	cmp	r5, r6		@ compare r5 and r6
	movne	r8, #0		@ move 0 to r8 if r5 != r6
	bne	endEndsWith	@ if r5 != r6

	add	r10, r10, #1
	add	r4, r4, #1	@ increment the counter

	b	endsWithLoop	@ branch to top of loop

endEndsWith:
	mov	r0, r8		@ move the content of r8 into r0
	pop	{r4-r11, lr}
	bx	lr

end:
	.end
