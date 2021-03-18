@ Author: Utsav Parajuli
@ Class:  CS3B
@ Lab:	  13

@ Purpose: A program that will get 10 numbers from the user and store them into an array.
@	   Then calculate the sum of the numbers and ouput the contents of array and sum.

	.data

@ Prompt
szIP:	.asciz	"Please enter a number: "
szOS:	.asciz	"The sum is "

@ Input data String
szX:	.skip	12
iX:	.word	0
@ Array
iArr:	.skip	10*4

@ Sum
iSum:	.word	0
szSum:	.skip	12

@ new line
chLF:	.byte	0x0A

@ space
chS:	.byte	0x20


	.text
	
	.global _start

_start:

	mov	r4, #1		@ r4 = 0; counter for the loop for input variables
	ldr	r3, =iArr	@ Loads the base address of iArr into r3
	
	ldr	r0, =szIP	@ load the address of szIP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szX	@ load the address of szX into r0
	mov	r1, #13		@ the largest number that can be input +1
	bl	getstring	@ reads the input from the user stdin
	
	ldr	r0, =szX	@ load the address of szX into r0
	bl	ascint32	@ branches to ascint32 and will convert ascii to int

	str	r0, [r3]	@ r3[iArr[0]] = r0

input_loop:
	cmp	r4, #9		@ compares r4 and 9
	bgt	sum		@ branches to next loop that will calculate sum

	ldr	r0, =szIP	@ load the address of szIP into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szX	@ load the address of szX into r0
	mov	r1, #13		@ the largest number that can be input +1
	bl	getstring	@ reads the input from the user stdin

	ldr	r0, =szX	@ loads the address of szX into r0
	bl	ascint32	@ branches to ascint32 and will convert ascii to int

	str	r0, [r3, #4]!	@ r3[iArr[previous address + 4]] = r0

	add	r4, r4, #1	@ incrementing r4 +1; counter++

	b	input_loop	@ repeat the loop

sum:
	ldr	r1, =iSum	@ r1 contains the address of iSum
	mov	r5, #1		@ r5 = 1
	ldr	r3, =iArr	@ loads the base address of iArr into r3
	
	ldr	r4, [r3]	@ r4 = *r3
	
sum_loop:
	cmp	r5, #9		@ compare r5 and 9
	bgt	display_array	@ branch to display array if r5 > 9

	ldr	r2, [r3, #4]!	@ r2 contains the contents of the array

	add	r4, r4, r2	@ add the contents at next address
	
	str	r4, [r1]	@ r1[iSum] = r4
	add	r5, r5, #1	@ incerement counter

	b	sum_loop	@ repeat loop

display_array:
	
	ldr	r0, =chLF	@ load the address of chLF into r0
	bl	putch		@ branches to function putch

	ldr	r0, =szOS	@ load the address of szOS into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =iSum	@ load the address of iSum into r0
	ldr	r0, [r0]	@ r0 = *r0
	
	ldr	r1, =szSum	@ load the address of szSum into r1
	bl	intasc32	@ branches to intasc32

	ldr	r0, =szSum	@ load the address of szSum into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ load the address of chLf into r0
	bl	putch		@ braches to function putch

	ldr	r0, =chLF	@ load address of chLF into r0
	bl	putch		@ branches to putch

	ldr	r3, =iArr	@ load the address of iArr into r3
	ldr	r0, [r3]	@ r0 = *r3
	
	ldr	r1, =szX	@ load the address of szX into r1
	bl	intasc32	@ convert int to ascii

	ldr	r0, =szX	@ load the address of szX into r0
	bl	putstring	@ branch to putstring

	ldr	r0, =chS	@ load the adddress of chS into r0
	bl	putch		@ branch to putch

	mov	r4, #1		@ r4 = 1

display_loop:
	cmp	r4, #9		@ compares r4 and 9
	bgt	end_		@ branches to end if r4 > 9

	ldr	r0, [r3, #4]!	@ loads the contents at the address +4

	ldr	r1, =szX	@ load the address of szX into r1
	bl	intasc32	@ convert int to ascii

	ldr	r0, =szX	@ load the address of szX into r0
	bl	putstring	@ branch to putstring

	ldr	r0, =chS	@ load the adddress of chS into r0
	bl	putch		@ branch to putch

	add	r4, r4, #1	@ r4++
	
	b	display_loop	@ branches to the loop

end_:
	ldr	r0, =chLF	@ load address of chLF into r0
	bl	putch		@ branches to putch

	mov	r0, #0		@ set program exit status code to 0
	mov	r7, #1		@ service command code of 1 to terminate program

	svc	0		@ Performs service call to Linux
	.end
	
	
