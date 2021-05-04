@ Author:  Utsav Parajuli
@ Class:   CS3B
@ Lab:	   21
@ Purpose: We will read the contents of  a text file "output.txt"
@ 0755
@ Owner Group Everyone Else
@ rwx rwx rwx
@ --- 010 000
	.equ R, 00
	.equ _W_, 0600

	.data
szBuffer:	.skip	512
szInput: 	.asciz	"input.txt"
chLF:		.byte	0x0A

	.text

	.global _start		@ Provide program starting address to linker

_start:
	mov	r7, #5		@ SVC Code of opening the file
	ldr	r0, =szInput	@ Name of the file to open

	mov	r1, #R		@ open for Reading
	mov	r2, #_W_	@ Set permissions to W for user only
	svc	0		@ create the file
	mov	r3, r0		@ Save file handle to r3

	mov	r7, #3		@ SVC code for reading from a file
	ldr	r1, =szBuffer	@ Address of string (char*)
	mov	r2, #1		@ number of bytes to attempt to read

	mov	r4, #0		@ counter

top:
	mov	r0, r3		@ Move the file handle back to r0
	svc	0		@ Attempt to read in the byte

	cmp	r0, #0		@ Compare if r0 is at end of line
	beq	bot		@ branch to bottom

	ldrb	r5, [r1]	@ load the conent of r1 into r5
	cmp	r5, #10		@ Comparing r5 to 10
	
	bne	skip		@ branch to skip

	ldr	r0, =szBuffer	@ load address of szBuffer into r0
	bl	putstring

skip:
	add	r1, #1		@ add 1 to the index of r1
	b	top

bot:
	mov	r7, #6		@ SVC code of closing the file
	svc	0		@ Create the file

	mov	r0, #0		@ Set program Exit status code to 0
	mov	r7, #1		@ Service command code of 1 to terminate program

	svc	0		@ Perform Service Call to Linux
	.end
	
