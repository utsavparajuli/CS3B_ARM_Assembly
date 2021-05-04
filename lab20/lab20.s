@ Author:  Utsav Parajuli
@ Class:   CS3B
@ Lab:	   20
@ Purpose: We will write the string "cat in the hat" to a text file "output.txt"
@ 0755
@ Owner Group Everyone Else
@ rwx rwx rwx
@ --- 010 000
	.equ W, 0101
	.equ _W_, 0600

	.data

szMsg1:		.asciz "cat in the hat\n"
szOutput: 	.asciz "output.txt"

	.text

	.global _start		@ Provide program starting address to linker

_start:
	mov	r7, #5		@ SVC Code of opening the file
	ldr	r0, =szOutput	@ Name of the file to open

	mov	r1, #W		@ open for Writing
	mov	r2, #_W_	@ Set permissions to W for user only
	svc	0		@ create the file
	push	{r0}		@ Save File Handle

	mov	r7, #4		@ SVC code for writing to a file
	ldr	r1, =szMsg1	@ Address of string (char*)
	mov	r0, r1		@ Move the address of message into r0
	bl	String_Length	@ get the length of string
	mov	r2, r0		@ save the string length into r2

	pop	{r0}		@ get the contents of r0 back
	svc	0

	mov	r7, #6		@ SVC code of closing the file
	svc	0		@ Create the file

	mov	r0, #0		@ Set program Exit status code to 0
	mov	r7, #1		@ Service command code of 1 to terminate program

	svc	0		@ Perform Service Call to Linux
	.end
	
