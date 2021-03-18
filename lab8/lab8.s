/* --- Lab8 --- */
@ Purpose: We are creating C++ like arrays in our data segment
@	   and copy one array data into another.

	.data

iSrcArray:	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
iDestArray:	.skip 16*4

	.text

	.global _start

_start:

	mov	r4, #0		@ r4 = 0; i = 0
	ldr 	r0, =iSrcArray	@ load the base address of iSrcArray into r0
	ldr 	r2, [r0]	@ r2 = *r0

	ldr 	r1, =iDestArray	@ load the address of iDestArray into r1
	str 	r2, [r1]	@ r1[iDestArray] = r2

/* Loop to copy all 15 elements starts here */
loop:	cmp r4, #15		@ perform comparison; i < 15
	bgt  endloop		@ end loop if i > 15
	
	ldr r2, [r0, #4]!	@ r2 = *address of the second element in iSrcArray

	ldr r3, [r1, #4]!	@ r3 = *address of the second element in iDestArray

	str r2, [r1]		@ r1[iDestArray] = r2

	add r4, r4, #1		@ incrementing r4 by +1; i++
	
	b   loop		@ repeat loop test
/* After we exit from loop */
endloop:
	mov	r0, #0		@ Set program Exit Status code to 0
	mov	r7, #1		@ Service command code of 1 to terminate program

	svc	0		@ Performs service call to Linux
	.end
