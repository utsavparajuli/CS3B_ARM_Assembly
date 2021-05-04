@ Author:  Utsav Parajuli
@ Class:   CS3B
@ Lab:     22
@ Purpose: This program will read in the integer values in the input.txt file and store them into an integer array.

@ 0755
@ Owner Group Everyone Else
@ rwx rwx rwx
@ --- 010 000
	.equ R, 00
	.equ _W_, 0600

	.data
szBuffer:	.skip	512
szNum:		.skip	512
szInput:	.asciz 	"input.txt"

iArray:		.skip	4*6
iNum:		.word	0

	.text
	
	.global _start

_start:
	mov	r7, #5		@ SVC Code of opening the file
	ldr	r0, =szInput	@ Name of the file to open

	mov	r1, #R		@ open for Reading
	mov	r2, #_W_	@ Set permissions to W for user only
	svc	0		@ create the file
	mov	r3, r0		@ save file handle to r3

	mov	r7, #3		@ SVC Code for reading from file
	ldr	r1, =szBuffer	@ Address of string (char*)

	mov	r2, #1		@ number of bytes to attempt to read

top:
	mov	r0, r3		@ Move the file handle back to r0
	svc	0		@ Attempt to read in the word

	cmp	r0, #0		@ Compare if r0 is at end of line
	beq	bot		@ branch to bottom

	ldrb	r5, [r1]	@ load the conent of r1 into r5	

	mov	r0, r3		@ load the contents of r3 into r0

	add	r1, #1
	
	b	top

bot:
	mov	r7, #6		@ SVC Code of closing the file
	svc	0		@ Create the file

	ldr	r1, =szBuffer	@ load the address of szBuffer into r1

	ldr	r6, =iArray	@ Load address of iArray into r6

	ldr	r8, =szNum	@ address of szNum into r8

	mov	r4, #0		@ Counter for szBuffer

	mov	r5, #0		@ Counter for szNum
	
	mov	r10, #0		@ Counter for iArray

store:
	ldrb	r0, [r1, r4]	@ load the first byte of szBuffer into r0
	
	cmp	r0, #0		@ compare r0 to 0
	beq	end		@ branch to end
	
	cmp	r0, #10		@ compare r0 to 10
	beq	num		@ branch to num

	strb	r0, [r8, r5]	@ store the content of r0 into address pointed by r8

	add	r4, #1		@ incerement counter
	add	r5, #1		@ increment counter
	
	b	store		@ branch to store

num:
	ldr	r0, =szNum	@ load address of szNum into r0
	bl	ascint32	@ branch to ascint32

	strb	r0, [r6, r10]	@ store the data into iArray
	add	r10, #4		@ increment the counter for array

	ldr	r0, =szNum	@ loads the address of szNum into r0
	mov	r2, #0		@ r2 = 0
	str	r2, [r0, #0]	@ store 0 into r0[0]
	
	mov	r5, #0		@ move 0 into r5

	add	r4, #1		@ add 1 ro r4
	
	b	store		@ branch back to store

end:
	ldr	r0, =iArray	@ Load address of iArray into r0
	mov	r0, #0		@ Set program Exit Status code to 0
	mov	r7, #1		@ Service command code of 1 to terminate pgm
	
	svc	0		@ Perform service call to linux
	.end

